From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 30 May 2022 19:40:56 +0800
Subject: [PATCH 1/1] aspeed: i2c: add manual clock setup feature
Message-ID: <20220530114056.8722-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Porin Lai <potin.lai.pt@gmail.com>

Add properties for manual tuning i2c clock timing register.

* aspeed,i2c-manual-clk: Enable aspeed i2c clock manual setup
* aspeed,i2c-base-clk-div: Base Clock divisor (tBaseClk)
* aspeed,i2c-clk-high-cycle: Cycles of clock-high pulse (tClkHigh)
* aspeed,i2c-clk-low-cycle: Cycles of clock-low pulse (tClkLow)

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 55 ++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..1f4b5c4b5bf4 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -898,6 +898,56 @@ static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
 	return 0;
 }
 
+/* precondition: bus.lock has been acquired. */
+static int aspeed_i2c_manual_clk_setup(struct aspeed_i2c_bus *bus)
+{
+	u32 divisor, clk_high, clk_low, clk_reg_val;
+
+	if (device_property_read_u32(bus->dev, "aspeed,i2c-base-clk-div",
+				     &divisor) != 0) {
+		dev_err(bus->dev, "Could not read aspeed,i2c-base-clk-div\n");
+		return -EINVAL;
+	} else if (divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-base-clk-div: %u\n",
+			divisor);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(bus->dev, "aspeed,i2c-clk-high-cycle",
+				     &clk_high) != 0) {
+		dev_err(bus->dev, "Could not read aspeed,i2c-clk-high-cycle\n");
+		return -EINVAL;
+	} else if (clk_high > ASPEED_I2CD_TIME_SCL_REG_MAX) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-clk-high-cycle: %u\n",
+			clk_high);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(bus->dev, "aspeed,i2c-clk-low-cycle",
+				     &clk_low) != 0) {
+		dev_err(bus->dev, "Could not read aspeed,i2c-clk-low-cycle\n");
+		return -EINVAL;
+	} else if (clk_low > ASPEED_I2CD_TIME_SCL_REG_MAX) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-clk-low-cycle: %u\n",
+			clk_low);
+		return -EINVAL;
+	}
+
+	clk_reg_val = readl(bus->base + ASPEED_I2C_AC_TIMING_REG1);
+	clk_reg_val &= (ASPEED_I2CD_TIME_TBUF_MASK |
+			ASPEED_I2CD_TIME_THDSTA_MASK |
+			ASPEED_I2CD_TIME_TACST_MASK);
+	clk_reg_val |= (divisor & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK)
+			| ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
+			   & ASPEED_I2CD_TIME_SCL_HIGH_MASK)
+			| ((clk_low << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
+			   & ASPEED_I2CD_TIME_SCL_LOW_MASK);
+	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
+	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base + ASPEED_I2C_AC_TIMING_REG2);
+
+	return 0;
+}
+
 /* precondition: bus.lock has been acquired. */
 static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 			     struct platform_device *pdev)
@@ -908,7 +958,10 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	/* Disable everything. */
 	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
 
-	ret = aspeed_i2c_init_clk(bus);
+	if (of_property_read_bool(pdev->dev.of_node, "aspeed,i2c-manual-clk"))
+		ret = aspeed_i2c_manual_clk_setup(bus);
+	else
+		ret = aspeed_i2c_init_clk(bus);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

