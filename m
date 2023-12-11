From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 11 Dec 2023 17:22:17 +0700
Subject: [PATCH v4 2/2] i2c: aspeed: Acknowledge Tx done with and without ACK irq late
In-Reply-To: <20231211102217.2436294-1-quan@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
Message-ID: <20231211102217.2436294-3-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
interrupt handler") acknowledges most interrupts early before the slave
irq handler is executed, except for the "Receive Done Interrupt status"
which is acknowledged late in the interrupt.
However, it has been observed that the early acknowledgment of "Transmit
Done Interrupt Status" (with ACK or NACK) often causes the interrupt to
be raised in READ REQUEST state, that shows the
"Unexpected ACK on read request." complaint messages.

Assuming that the "Transmit Done" interrupt should only be acknowledged
once it is truly processed, this commit fixes that issue by acknowledging
interrupts for both ACK and NACK cases late in the interrupt handler.

Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v4:
  + Switch to use define macro instead of variable             [Andrew]
  + Make the early ack conditionally to avoid unnecessary
writel()/readl()                                                 [Quan]

v3:
  + Fix the unconditinal write when ack the irqs               [Andrew]
  + Refactor the code to enhance code readability                [Quan]
  + Fix grammar in commit message                                [Quan]

v2:
  + Split to separate series                                     [Joel]
  + Added the Fixes line                                         [Joel]
  + Fixed multiline comment                                      [Joel]
  + Refactor irq clearing code                          [Joel, Guenter]
  + Revised commit message                                       [Joel]
  + Revised commit message                                       [Quan]
  + About a note to remind why the readl() should immediately follow the
writel() to fix the race condition when clearing irq status from commit
c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
condition"), I think it looks straight forward in this patch and decided
not to add that note.                                            [Joel]

v1:
  + First introduced in
https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
---
 drivers/i2c/busses/i2c-aspeed.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 5511fd46a65e..0f67218cf04a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -93,6 +93,10 @@
 		 ASPEED_I2CD_INTR_RX_DONE |				       \
 		 ASPEED_I2CD_INTR_TX_NAK |				       \
 		 ASPEED_I2CD_INTR_TX_ACK)
+#define ASPEED_I2CD_INTR_ACK_RX_TX					       \
+		(ASPEED_I2CD_INTR_RX_DONE |				       \
+		 ASPEED_I2CD_INTR_TX_ACK |				       \
+		 ASPEED_I2CD_INTR_TX_NAK)
 
 /* 0x14 : I2CD Command/Status Register   */
 #define ASPEED_I2CD_SCL_LINE_STS			BIT(18)
@@ -622,10 +626,19 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupts except for Rx done */
-	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
-	       bus->base + ASPEED_I2C_INTR_STS_REG);
-	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+
+	/*
+	 * Early acking of INTR_RX_DONE and INTR_TX_[ACK|NAK] would indicate HW to
+	 * start receiving or sending new data, and this may cause a race condition
+	 * as the irq handler has not yet handled these irqs but is being acked.
+	 * Let's ack them late at the end of the irq handler when those are truly processed.
+	 */
+	if (irq_received & ~ASPEED_I2CD_INTR_ACK_RX_TX) {
+		writel(irq_received & ~ASPEED_I2CD_INTR_ACK_RX_TX,
+		       bus->base + ASPEED_I2C_INTR_STS_REG);
+		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	}
+
 	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
 	irq_remaining = irq_received;
 
@@ -668,12 +681,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
-		writel(ASPEED_I2CD_INTR_RX_DONE,
+	if (irq_received & ASPEED_I2CD_INTR_ACK_RX_TX) {
+		writel(irq_received & ASPEED_I2CD_INTR_ACK_RX_TX,
 		       bus->base + ASPEED_I2C_INTR_STS_REG);
 		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	}
+
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.35.1

