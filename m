From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 19 May 2021 14:49:32 +0700
Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
In-Reply-To: <20210519074934.20712-1-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
Message-ID: <20210519074934.20712-6-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Slave i2c device on AST2500 received a lot of slave irq while it is
busy processing the response. To handle this case, adds and exports
aspeed_set_slave_busy() for controller to temporary stop slave irq
while slave is handling the response, and re-enable them again when
the response is ready.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v3:
  + First introduce in v3 [Quan]

 drivers/i2c/busses/i2c-aspeed.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index b2e9c8f0ddf7..9926d04831a2 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -944,6 +944,26 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+void aspeed_set_slave_busy(struct i2c_adapter *adap, bool busy)
+{
+	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
+	unsigned long current_mask, flags;
+
+	spin_lock_irqsave(&bus->lock, flags);
+
+	current_mask = readl(bus->base + ASPEED_I2C_INTR_CTRL_REG);
+	if (busy)
+		current_mask &= ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_SLAVE_MATCH);
+	else
+		current_mask |= ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_SLAVE_MATCH;
+	writel(current_mask, bus->base + ASPEED_I2C_INTR_CTRL_REG);
+
+	spin_unlock_irqrestore(&bus->lock, flags);
+}
+EXPORT_SYMBOL_GPL(aspeed_set_slave_busy);
+#endif
+
 static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
 {
 	struct platform_device *pdev = to_platform_device(bus->dev);
-- 
2.28.0

