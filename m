From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 19 May 2021 14:49:31 +0700
Subject: [PATCH v3 4/7] i2c: aspeed: Acknowledge Tx done w/wo ACK irq late
In-Reply-To: <20210519074934.20712-1-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
Message-ID: <20210519074934.20712-5-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With Tx done w/wo ACK are ack'ed early at beginning of irq handler,
it is observed that, usually, the Tx done with Ack irq raises in the
READ REQUESTED state. This is unexpected and complaint as below appear:
"Unexpected Ack on read request"

Assumed that Tx done should only be ack'ed once it was truly processed,
switch to late ack'ed this two irqs and seen this issue go away through
test with AST2500..

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v3:
  + First introduce in v3 [Quan]

 drivers/i2c/busses/i2c-aspeed.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 3fb37c3f23d4..b2e9c8f0ddf7 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -606,8 +606,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupts except for Rx done */
-	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
+	/*
+	 * Ack all interrupts except for Rx done and
+	 * Tx done with/without ACK
+	 */
+	writel(irq_received &
+	       ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
 	       bus->base + ASPEED_I2C_INTR_STS_REG);
 	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
@@ -652,12 +656,18 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
-		writel(ASPEED_I2CD_INTR_RX_DONE,
-		       bus->base + ASPEED_I2C_INTR_STS_REG);
-		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	}
+	/* Ack Rx done and Tx done with/without ACK */
+	/* Note: Re-use irq_handled variable */
+	irq_handled = 0;
+	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
+		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
+	if (irq_received & ASPEED_I2CD_INTR_TX_ACK)
+		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
+	if (irq_received & ASPEED_I2CD_INTR_TX_NAK)
+		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+	writel(irq_handled, bus->base + ASPEED_I2C_INTR_STS_REG);
+	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.28.0

