From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:31 +1030
Subject: [PATCH 6/7] pinctrl: aspeed: Use masks to describe pinconf bitfields
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-7-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

Since some of the AST2600 pinconf setting are not just single bit, modified
aspeed_pin_config @bit to @mask and add @mask to aspeed_pin_config_map to
support configuring multiple bits.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
[AJ: Tweak commit message]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 10 +++++-----
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 10 +++++-----
 drivers/pinctrl/aspeed/pinctrl-aspeed.c    | 12 ++++++------
 drivers/pinctrl/aspeed/pinctrl-aspeed.h    |  7 ++++---
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index 62b8aa53b627..bfed0e274643 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2595,11 +2595,11 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 }
 
 static const struct aspeed_pin_config_map aspeed_g4_pin_config_map[] = {
-	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1},
-	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0},
-	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1},
-	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0},
-	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1},
+	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1, BIT_MASK(0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0, BIT_MASK(0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1, BIT_MASK(0)},
 };
 
 static const struct aspeed_pinmux_ops aspeed_g4_ops = {
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 2acbcf3d508a..0cab4c2576e2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2781,11 +2781,11 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 }
 
 static const struct aspeed_pin_config_map aspeed_g5_pin_config_map[] = {
-	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1},
-	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0},
-	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1},
-	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0},
-	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1},
+	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1, BIT_MASK(0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0, BIT_MASK(0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1, BIT_MASK(0)},
 };
 
 static const struct aspeed_pinmux_ops aspeed_g5_ops = {
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index fc68aca7b36c..b625a657171e 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -464,7 +464,7 @@ int aspeed_pin_config_get(struct pinctrl_dev *pctldev, unsigned int offset,
 		return rc;
 
 	pmap = find_pinconf_map(pdata, param, MAP_TYPE_VAL,
-			(val & BIT(pconf->bit)) >> pconf->bit);
+			(val & pconf->mask) >> __ffs(pconf->mask));
 
 	if (!pmap)
 		return -EINVAL;
@@ -512,17 +512,17 @@ int aspeed_pin_config_set(struct pinctrl_dev *pctldev, unsigned int offset,
 		if (WARN_ON(!pmap))
 			return -EINVAL;
 
-		val = pmap->val << pconf->bit;
+		val = pmap->val << __ffs(pconf->mask);
 
 		rc = regmap_update_bits(pdata->scu, pconf->reg,
-					BIT(pconf->bit), val);
+					pmap->mask, val);
 
 		if (rc < 0)
 			return rc;
 
-		pr_debug("%s: Set SCU%02X[%d]=%d for param %d(=%d) on pin %d\n",
-				__func__, pconf->reg, pconf->bit, pmap->val,
-				param, arg, offset);
+		pr_debug("%s: Set SCU%02X[%lu]=%d for param %d(=%d) on pin %d\n",
+				__func__, pconf->reg, __ffs(pconf->mask),
+				pmap->val, param, arg, offset);
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
index 27d3929b6aca..6f0f03395617 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -24,8 +24,7 @@ struct aspeed_pin_config {
 	enum pin_config_param param;
 	unsigned int pins[2];
 	unsigned int reg;
-	u8 bit;
-	u8 value;
+	u32 mask;
 };
 
 #define ASPEED_PINCTRL_PIN(name_) \
@@ -39,7 +38,7 @@ struct aspeed_pin_config {
 	.param = param_, \
 	.pins = {pin0_, pin1_}, \
 	.reg = reg_, \
-	.bit = bit_ \
+	.mask = BIT_MASK(bit_) \
 }
 
 /*
@@ -48,6 +47,7 @@ struct aspeed_pin_config {
  * @param: pinconf configuration parameter
  * @arg: The supported argument for @param, or -1 if any value is supported
  * @val: The register value to write to configure @arg for @param
+ * @mask: The bitfield mask for @val
  *
  * The map is to be used in conjunction with the configuration array supplied
  * by the driver implementation.
@@ -56,6 +56,7 @@ struct aspeed_pin_config_map {
 	enum pin_config_param param;
 	s32 arg;
 	u32 val;
+	u32 mask;
 };
 
 struct aspeed_pinctrl_data {
-- 
2.20.1

