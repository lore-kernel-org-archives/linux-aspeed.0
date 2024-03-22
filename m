From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Fri, 22 Mar 2024 14:24:58 +0100
Subject: [PATCH 05/64] i2c: aspeed: reword according to newest specification
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Message-ID: <20240322132619.6389-6-wsa+renesas@sang-engineering.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index ce8c4846b7fa..4e6ea4a5cab9 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -159,7 +159,7 @@ struct aspeed_i2c_bus {
 	bool				send_stop;
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
-	int				master_xfer_result;
+	int				xfer_result;
 	/* Multi-master */
 	bool				multi_master;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -608,9 +608,9 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 out_complete:
 	bus->msgs = NULL;
 	if (bus->cmd_err)
-		bus->master_xfer_result = bus->cmd_err;
+		bus->xfer_result = bus->cmd_err;
 	else
-		bus->master_xfer_result = bus->msgs_index + 1;
+		bus->xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
 	return irq_handled;
@@ -679,7 +679,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
-static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
+static int aspeed_i2c_xfer(struct i2c_adapter *adap,
 				  struct i2c_msg *msgs, int num)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
@@ -738,7 +738,7 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 		return -ETIMEDOUT;
 	}
 
-	return bus->master_xfer_result;
+	return bus->xfer_result;
 }
 
 static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
@@ -748,7 +748,7 @@ static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 /* precondition: bus.lock has been acquired. */
-static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
+static void __aspeed_i2c_reg_target(struct aspeed_i2c_bus *bus, u16 slave_addr)
 {
 	u32 addr_reg_val, func_ctrl_reg_val;
 
@@ -770,7 +770,7 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
-static int aspeed_i2c_reg_slave(struct i2c_client *client)
+static int aspeed_i2c_reg_target(struct i2c_client *client)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(client->adapter);
 	unsigned long flags;
@@ -781,7 +781,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	__aspeed_i2c_reg_slave(bus, client->addr);
+	__aspeed_i2c_reg_target(bus, client->addr);
 
 	bus->slave = client;
 	spin_unlock_irqrestore(&bus->lock, flags);
@@ -789,7 +789,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	return 0;
 }
 
-static int aspeed_i2c_unreg_slave(struct i2c_client *client)
+static int aspeed_i2c_unreg_target(struct i2c_client *client)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(client->adapter);
 	u32 func_ctrl_reg_val;
@@ -814,11 +814,11 @@ static int aspeed_i2c_unreg_slave(struct i2c_client *client)
 #endif /* CONFIG_I2C_SLAVE */
 
 static const struct i2c_algorithm aspeed_i2c_algo = {
-	.master_xfer	= aspeed_i2c_master_xfer,
+	.xfer	= aspeed_i2c_xfer,
 	.functionality	= aspeed_i2c_functionality,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	.reg_slave	= aspeed_i2c_reg_slave,
-	.unreg_slave	= aspeed_i2c_unreg_slave,
+	.reg_target	= aspeed_i2c_reg_target,
+	.unreg_target	= aspeed_i2c_unreg_target,
 #endif /* CONFIG_I2C_SLAVE */
 };
 
@@ -950,7 +950,7 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	/* If slave has already been registered, re-enable it. */
 	if (bus->slave)
-		__aspeed_i2c_reg_slave(bus, bus->slave->addr);
+		__aspeed_i2c_reg_target(bus, bus->slave->addr);
 #endif /* CONFIG_I2C_SLAVE */
 
 	/* Set interrupt generation of I2C controller */
-- 
2.43.0

