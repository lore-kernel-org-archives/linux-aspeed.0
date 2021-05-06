From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu,  6 May 2021 15:54:19 -0500
Subject: [PATCH v2] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
Message-ID: <20210506205419.26294-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ast25xx and ast26xx have, respectively, two and three configurable
slave device addresses to the ast24xx's one.  We only support using
one at a time, but the others may come up in an indeterminate state
depending on hardware/bootloader behavior, so we need to make sure we
disable them so as to avoid ending up with phantom devices on the bus.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Changes since v1 [0]:
 - reduced to simplified approach suggested by Joel

[0] https://lore.kernel.org/linux-arm-kernel/20200915184525.29665-1-zev at bewilderbeest.net/

 drivers/i2c/busses/i2c-aspeed.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 724bf30600d6..67e8b97c0c95 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -727,10 +727,14 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 {
 	u32 addr_reg_val, func_ctrl_reg_val;
 
-	/* Set slave addr. */
-	addr_reg_val = readl(bus->base + ASPEED_I2C_DEV_ADDR_REG);
-	addr_reg_val &= ~ASPEED_I2CD_DEV_ADDR_MASK;
-	addr_reg_val |= slave_addr & ASPEED_I2CD_DEV_ADDR_MASK;
+	/*
+	 * Set slave addr.  Reserved bits can all safely be written with zeros
+	 * on all of ast2[456]00, so zero everything else to ensure we only
+	 * enable a single slave address (ast2500 has two, ast2600 has three,
+	 * the enable bits for which are also in this register) so that we don't
+	 * end up with additional phantom devices responding on the bus.
+	 */
+	addr_reg_val = slave_addr & ASPEED_I2CD_DEV_ADDR_MASK;
 	writel(addr_reg_val, bus->base + ASPEED_I2C_DEV_ADDR_REG);
 
 	/* Turn on slave mode. */
-- 
2.31.1

