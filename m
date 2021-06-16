From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 16 Jun 2021 10:10:46 +0700
Subject: [PATCH v2 2/2] i2c: aspeed: Acknowledge Tx done with and without ACK
 irq late
In-Reply-To: <20210616031046.2317-1-quan@os.amperecomputing.com>
References: <20210616031046.2317-1-quan@os.amperecomputing.com>
Message-ID: <20210616031046.2317-3-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
interrupt handler") acknowledges most interrupts early before the slave
irq handler is executed, except for the "Receive Done Interrupt status"
which is acknowledged late in the interrupt.
However, it is observed that the early acknowledgment of "Transmit Done
Interrupt Status" (with ACK or NACK) often causes the interrupt to be
raised in READ REQUEST state, resulting in "Unexpected ACK on read
request." complaint messages.

Assuming that the "Transmit Done" interrupt should only be acknowledged
once it is truly processed, this commit fixes this issue by acknowledging
this interrupt for both ACK and NACK cases late in the interrupt handler
also.

Fixes: 2be6b47211e1 (i2c: aspeed: Acknowledge most interrupts early in interrupt handler)
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v2:
  + Split to separate series [Joel]
  + Added the Fixes line [Joel]
  + Fixed multiline comment [Joel]
  + Refactor irq clearing code [Joel, Guenter]
  + Revised commit message [Joel]
  + Revised commit message [Quan]
  + About a note to remind why the readl() should immediately follow the
  writel() to fix the race condition when clearing irq status from
  commit c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
  condition"), I think it looks straight forward in this patch and decided
  not to add that note. [Joel]

v1:
  + First introduced in https://lkml.org/lkml/2021/5/19/205

 drivers/i2c/busses/i2c-aspeed.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 3fb37c3f23d4..0f82b46866a8 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -606,8 +606,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupts except for Rx done */
-	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
+	/* Ack all interrupts except for Rx done and Tx done with/without ACK */
+	writel(irq_received &
+	       ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
 	       bus->base + ASPEED_I2C_INTR_STS_REG);
 	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
@@ -652,12 +653,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
-		writel(ASPEED_I2CD_INTR_RX_DONE,
-		       bus->base + ASPEED_I2C_INTR_STS_REG);
-		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	}
+	/* Ack Rx done and Tx done with/without ACK */
+	writel(irq_received &
+	       (ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
+	       bus->base + ASPEED_I2C_INTR_STS_REG);
+	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.28.0

