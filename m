From: Jian Zhang <zhangjian.3032@bytedance.com>
Date: Thu, 10 Aug 2023 15:21:55 +0800
Subject: [PATCH] i2c: aspeed: Fix i2c bus hang in slave read
Message-ID: <20230810072155.3726352-1-zhangjian.3032@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
as a slave, a situation arises where the master sends a START signal
without the accompanying STOP signal. This action results in a
persistent I2C bus timeout. The core issue stems from the fact that
the i2c controller remains in a slave read state without a timeout
mechanism. As a consequence, the bus perpetually experiences timeouts.

This proposed patch addresses this problem by introducing a status
check during i2c transmit timeouts. In the event that the controller
is in a slave read state, the i2c controller will be reset to restore
proper functionality and allow the I2C bus to resume normal operation.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index e76befe3f60f..1a95205fc946 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -113,6 +113,7 @@
 		 ASPEED_I2CD_M_RX_CMD |					       \
 		 ASPEED_I2CD_M_TX_CMD |					       \
 		 ASPEED_I2CD_M_START_CMD)
+#define ASPEED_I2CD_SLAVE_CMDS_MASK			GENMASK(31, 29)
 
 /* 0x18 : I2CD Slave Device Address Register   */
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
@@ -706,6 +707,22 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 		     ASPEED_I2CD_BUS_BUSY_STS))
 			aspeed_i2c_recover_bus(bus);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+		/*
+		 * If master timed out and bus is in slave mode.
+		 * reset the slave mode.
+		 */
+		if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_SLAVE_CMDS_MASK) {
+			spin_lock_irqsave(&bus->lock, flags);
+			u32 func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+			writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+			writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+			bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+			spin_unlock_irqrestore(&bus->lock, flags);
+		}
+#endif
+
 		/*
 		 * If timed out and the state is still pending, drop the pending
 		 * master command.
-- 
2.30.2

