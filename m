From: Tao Ren <taoren@fb.com>
Date: Wed, 19 Jun 2019 13:50:09 -0700
Subject: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
Message-ID: <20190619205009.4176588-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some intermittent I2C transaction failures are observed on Facebook CMM and
Minipack (ast2500) BMC platforms, because slave devices (such as CPLD, BIC
and etc.) NACK the address byte sometimes. The issue can be resolved by
increasing base clock divisor which affects ASPEED I2C Controller's base
clock and other AC timing parameters.

This patch allows to customize ASPEED I2C Controller's base clock divisor
in device tree.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 48 ++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 6c8b38fd6e64..e4b1c4c71b62 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -145,7 +145,8 @@ struct aspeed_i2c_bus {
 	spinlock_t			lock;
 	struct completion		cmd_complete;
 	u32				(*get_clk_reg_val)(struct device *dev,
-							   u32 divisor);
+							   u32 divisor,
+							   u32 base_clk_div);
 	unsigned long			parent_clk_frequency;
 	u32				bus_frequency;
 	/* Transaction state. */
@@ -778,9 +779,10 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
 
 static u32 aspeed_i2c_get_clk_reg_val(struct device *dev,
 				      u32 clk_high_low_mask,
-				      u32 divisor)
+				      u32 divisor,
+				      u32 base_clk_divisor)
 {
-	u32 base_clk_divisor, clk_high_low_max, clk_high, clk_low, tmp;
+	u32 clk_high_low_max, clk_high, clk_low, tmp;
 
 	/*
 	 * SCL_high and SCL_low represent a value 1 greater than what is stored
@@ -809,10 +811,12 @@ static u32 aspeed_i2c_get_clk_reg_val(struct device *dev,
 	 *		((1 << base_clk_divisor) * (clk_high + 1 + clk_low + 1))
 	 * The documentation recommends clk_high >= clk_high_max / 2 and
 	 * clk_low >= clk_low_max / 2 - 1 when possible; this last constraint
-	 * gives us the following solution:
+	 * gives us the following solution (unless base_clk_divisor is manually
+	 * configured in device tree):
 	 */
-	base_clk_divisor = divisor > clk_high_low_max ?
-			ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
+	if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK)
+		base_clk_divisor = divisor > clk_high_low_max ?
+				ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
 
 	if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
 		base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
@@ -843,35 +847,49 @@ static u32 aspeed_i2c_get_clk_reg_val(struct device *dev,
 			   & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
 }
 
-static u32 aspeed_i2c_24xx_get_clk_reg_val(struct device *dev, u32 divisor)
+static u32 aspeed_i2c_24xx_get_clk_reg_val(struct device *dev,
+					   u32 divisor,
+					   u32 base_clk_divisor)
 {
 	/*
 	 * clk_high and clk_low are each 3 bits wide, so each can hold a max
 	 * value of 8 giving a clk_high_low_max of 16.
 	 */
-	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(2, 0), divisor);
+	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(2, 0), divisor,
+					  base_clk_divisor);
 }
 
-static u32 aspeed_i2c_25xx_get_clk_reg_val(struct device *dev, u32 divisor)
+static u32 aspeed_i2c_25xx_get_clk_reg_val(struct device *dev,
+					   u32 divisor,
+					   u32 base_clk_divisor)
 {
 	/*
 	 * clk_high and clk_low are each 4 bits wide, so each can hold a max
 	 * value of 16 giving a clk_high_low_max of 32.
 	 */
-	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(3, 0), divisor);
+	return aspeed_i2c_get_clk_reg_val(dev, GENMASK(3, 0), divisor,
+					  base_clk_divisor);
 }
 
 /* precondition: bus.lock has been acquired. */
-static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
+static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
+			       struct platform_device *pdev)
 {
-	u32 divisor, clk_reg_val;
+	int ret;
+	u32 divisor, clk_reg_val, base_clk_divisor;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "base-clock-divisor",
+				   &base_clk_divisor);
+	if (ret < 0)
+		base_clk_divisor = (u32)-1;
 
 	divisor = DIV_ROUND_UP(bus->parent_clk_frequency, bus->bus_frequency);
 	clk_reg_val = readl(bus->base + ASPEED_I2C_AC_TIMING_REG1);
 	clk_reg_val &= (ASPEED_I2CD_TIME_TBUF_MASK |
 			ASPEED_I2CD_TIME_THDSTA_MASK |
 			ASPEED_I2CD_TIME_TACST_MASK);
-	clk_reg_val |= bus->get_clk_reg_val(bus->dev, divisor);
+	clk_reg_val |= bus->get_clk_reg_val(bus->dev, divisor,
+					    base_clk_divisor);
 	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
 	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base + ASPEED_I2C_AC_TIMING_REG2);
 
@@ -888,7 +906,7 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	/* Disable everything. */
 	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
 
-	ret = aspeed_i2c_init_clk(bus);
+	ret = aspeed_i2c_init_clk(bus, pdev);
 	if (ret < 0)
 		return ret;
 
@@ -989,7 +1007,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!match)
 		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
 	else
-		bus->get_clk_reg_val = (u32 (*)(struct device *, u32))
+		bus->get_clk_reg_val = (u32 (*)(struct device *, u32, u32))
 				match->data;
 
 	/* Initialize the I2C adapter */
-- 
2.17.1

