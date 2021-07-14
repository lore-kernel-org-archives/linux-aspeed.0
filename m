From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 14 Jul 2021 10:38:31 +0700
Subject: [PATCH v5 1/3] i2c: aspeed: Add slave_enable() to toggle slave mode
In-Reply-To: <20210714033833.11640-1-quan@os.amperecomputing.com>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
Message-ID: <20210714033833.11640-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Slave needs time to prepare the response data before Master could
enquiry via read transaction. However, there is no mechanism for
i2c-aspeed Slave to notify Master that it needs more time to process
and this make Master side to time out when trying to get the response.

This commit introduces the slave_enable() callback in struct
i2c_algorithm for Slave to temporary stop the Slave mode while working
on the response and re-enable the Slave when response data ready.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v5:
  + None

v4:
  + First introduced follow Ryan's suggestion               [Ryan]
  + Fix recursive spinlock issue in v3 (aspeed_set_slave_busy())
  and apply in this patch                                 [Graeme]

 drivers/i2c/busses/i2c-aspeed.c | 20 ++++++++++++++++++++
 include/linux/i2c.h             |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..a6a19dc8a501 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -785,6 +785,25 @@ static int aspeed_i2c_unreg_slave(struct i2c_client *client)
 
 	return 0;
 }
+
+static int aspeed_i2c_slave_enable(struct i2c_client *client, bool enable)
+{
+	struct aspeed_i2c_bus *bus = i2c_get_adapdata(client->adapter);
+	u32 func_ctrl_reg_val;
+
+	if (!bus->slave)
+		return -EINVAL;
+
+	/* Toggle slave mode. */
+	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
+	if (enable)
+		func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
+	else
+		func_ctrl_reg_val &= ~ASPEED_I2CD_SLAVE_EN;
+	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	return 0;
+}
 #endif /* CONFIG_I2C_SLAVE */
 
 static const struct i2c_algorithm aspeed_i2c_algo = {
@@ -793,6 +812,7 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	.reg_slave	= aspeed_i2c_reg_slave,
 	.unreg_slave	= aspeed_i2c_unreg_slave,
+	.slave_enable	= aspeed_i2c_slave_enable,
 #endif /* CONFIG_I2C_SLAVE */
 };
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 3eb60a2e9e61..8c1765aa7e3f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -520,6 +520,7 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  *   from the ``I2C_FUNC_*`` flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
  * @unreg_slave: Unregister given client from I2C slave mode of this adapter
+ * @slave_enable: Toggle enable slave mode for given client of this adapter
  *
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can
@@ -557,6 +558,7 @@ struct i2c_algorithm {
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	int (*reg_slave)(struct i2c_client *client);
 	int (*unreg_slave)(struct i2c_client *client);
+	int (*slave_enable)(struct i2c_client *client, bool enable);
 #endif
 };
 
-- 
2.28.0

