From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed,  1 Jun 2022 12:15:11 +0800
Subject: [PATCH v2 1/2] aspeed: i2c: add manual clock setting feature
In-Reply-To: <20220601041512.21484-1-potin.lai.pt@gmail.com>
References: <20220601041512.21484-1-potin.lai.pt@gmail.com>
Message-ID: <20220601041512.21484-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add manual tuning i2c clock timing register support by reading
following properties.

* aspeed,i2c-manual-clk: Enable aspeed i2c clock manual setting
* aspeed,i2c-base-clk-div: Base Clock divisor (tBaseClk)
* aspeed,i2c-clk-high-cycle: Cycles of clock-high pulse (tClkHigh)
* aspeed,i2c-clk-low-cycle: Cycles of clock-low pulse (tClkLow)

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 57 ++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..64424f377f27 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -60,6 +60,7 @@
 #define ASPEED_I2CD_TIME_SCL_LOW_MASK			GENMASK(15, 12)
 #define ASPEED_I2CD_TIME_BASE_DIVISOR_MASK		GENMASK(3, 0)
 #define ASPEED_I2CD_TIME_SCL_REG_MAX			GENMASK(3, 0)
+#define ASPEED_I2CD_TIME_BASE_DIVISOR_MAX		32768
 /* 0x08 : I2CD Clock and AC Timing Control Register #2 */
 #define ASPEED_NO_TIMEOUT_CTRL				0
 
@@ -898,6 +899,57 @@ static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
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
+	} else if (!divisor || divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MAX ||
+		   BIT(__fls(divisor)) != divisor) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-base-clk-div: %u\n",
+			divisor);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(bus->dev, "aspeed,i2c-clk-high-cycle",
+				     &clk_high) != 0) {
+		dev_err(bus->dev, "Could not read aspeed,i2c-clk-high-cycle\n");
+		return -EINVAL;
+	} else if ((clk_high-1) > ASPEED_I2CD_TIME_SCL_REG_MAX) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-clk-high-cycle: %u\n",
+			clk_high);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(bus->dev, "aspeed,i2c-clk-low-cycle",
+				     &clk_low) != 0) {
+		dev_err(bus->dev, "Could not read aspeed,i2c-clk-low-cycle\n");
+		return -EINVAL;
+	} else if ((clk_low-1) > ASPEED_I2CD_TIME_SCL_REG_MAX) {
+		dev_err(bus->dev, "Invalid aspeed,i2c-clk-low-cycle: %u\n",
+			clk_low);
+		return -EINVAL;
+	}
+
+	clk_reg_val = readl(bus->base + ASPEED_I2C_AC_TIMING_REG1);
+	clk_reg_val &= (ASPEED_I2CD_TIME_TBUF_MASK |
+			ASPEED_I2CD_TIME_THDSTA_MASK |
+			ASPEED_I2CD_TIME_TACST_MASK);
+	clk_reg_val |= (ilog2(divisor) & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK)
+			| (((clk_high-1) << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
+			   & ASPEED_I2CD_TIME_SCL_HIGH_MASK)
+			| (((clk_low-1) << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
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
@@ -908,7 +960,10 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
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

