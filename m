From: Jian Zhang <zhangjian.3032@bytedance.com>
Date: Wed, 27 Sep 2023 23:42:43 +0800
Subject: [PATCH v2] i2c: aspeed: Fix i2c bus hang in slave read
Message-ID: <20230927154244.3774670-1-zhangjian.3032@bytedance.com>
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

In this case, the i2c bus will be reset, but the slave_state reset is
missing.

Fixes: fee465150b45 ("i2c: aspeed: Reset the i2c controller when timeout occurs")
Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 5a416b39b818..18f618625472 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -933,6 +933,7 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	/* If slave has already been registered, re-enable it. */
 	if (bus->slave)
 		__aspeed_i2c_reg_slave(bus, bus->slave->addr);
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 #endif /* CONFIG_I2C_SLAVE */

 	/* Set interrupt generation of I2C controller */
--
2.30.2

