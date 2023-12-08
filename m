From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri,  8 Dec 2023 10:31:42 +0700
Subject: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and without ACK irq late
In-Reply-To: <20231208033142.1673232-1-quan@os.amperecomputing.com>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
Message-ID: <20231208033142.1673232-3-quan@os.amperecomputing.com>
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
 drivers/i2c/busses/i2c-aspeed.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 1c2a4f4c4e1b..967a26dd4ffa 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -617,13 +617,19 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	u32 irq_received, irq_remaining, irq_handled;
+	u32 irq_received, irq_remaining, irq_handled, irq_ack_last;
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupts except for Rx done */
-	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
-	       bus->base + ASPEED_I2C_INTR_STS_REG);
+
+	/*
+	 * Early acking of INTR_RX_DONE and INTR_TX_[ACK|NAK] would indicate HW to
+	 * start receiving or sending new data, and this may cause a race condition
+	 * as the irq handler has not yet handled these irqs but is being acked.
+	 * Let's ack them late at the end of the irq handler when those are truly processed.
+	 */
+	irq_ack_last = ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK;
+	writel(irq_received & ~irq_ack_last, bus->base + ASPEED_I2C_INTR_STS_REG);
 	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
 	irq_remaining = irq_received;
@@ -667,12 +673,11 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
-		writel(ASPEED_I2CD_INTR_RX_DONE,
-		       bus->base + ASPEED_I2C_INTR_STS_REG);
+	if (irq_received & irq_ack_last) {
+		writel(irq_received & irq_ack_last, bus->base + ASPEED_I2C_INTR_STS_REG);
 		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	}
+
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.35.1

