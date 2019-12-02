From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:30 +1030
Subject: [PATCH 5/7] pinctrl: aspeed: Move aspeed_pin_config_map to separate
 source file
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-6-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

The AST2600 pinconf differs from the 2400 and 2500, aspeed_pin_config_map
should define separately, and add @confmaps and @nconfmaps to
aspeed_pinctrl_data structure for that change.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 10 ++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 10 ++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed.c    | 38 +++-------------------
 drivers/pinctrl/aspeed/pinctrl-aspeed.h    | 19 +++++++++++
 4 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index c56ded0ac57e..62b8aa53b627 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2594,6 +2594,14 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 	return 0;
 }
 
+static const struct aspeed_pin_config_map aspeed_g4_pin_config_map[] = {
+	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1},
+	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0},
+	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1},
+};
+
 static const struct aspeed_pinmux_ops aspeed_g4_ops = {
 	.set = aspeed_g4_sig_expr_set,
 };
@@ -2610,6 +2618,8 @@ static struct aspeed_pinctrl_data aspeed_g4_pinctrl_data = {
 	},
 	.configs = aspeed_g4_configs,
 	.nconfigs = ARRAY_SIZE(aspeed_g4_configs),
+	.confmaps = aspeed_g4_pin_config_map,
+	.nconfmaps = ARRAY_SIZE(aspeed_g4_pin_config_map),
 };
 
 static const struct pinmux_ops aspeed_g4_pinmux_ops = {
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index b2fe47b98fa0..2acbcf3d508a 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2780,6 +2780,14 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 	return 0;
 }
 
+static const struct aspeed_pin_config_map aspeed_g5_pin_config_map[] = {
+	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1},
+	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0},
+	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1},
+};
+
 static const struct aspeed_pinmux_ops aspeed_g5_ops = {
 	.eval = aspeed_g5_sig_expr_eval,
 	.set = aspeed_g5_sig_expr_set,
@@ -2797,6 +2805,8 @@ static struct aspeed_pinctrl_data aspeed_g5_pinctrl_data = {
 	},
 	.configs = aspeed_g5_configs,
 	.nconfigs = ARRAY_SIZE(aspeed_g5_configs),
+	.confmaps = aspeed_g5_pin_config_map,
+	.nconfmaps = ARRAY_SIZE(aspeed_g5_pin_config_map),
 };
 
 static const struct pinmux_ops aspeed_g5_pinmux_ops = {
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 54933665b5f8..fc68aca7b36c 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -411,49 +411,21 @@ static inline const struct aspeed_pin_config *find_pinconf_config(
 	return NULL;
 }
 
-/*
- * Aspeed pin configuration description.
- *
- * @param: pinconf configuration parameter
- * @arg: The supported argument for @param, or -1 if any value is supported
- * @val: The register value to write to configure @arg for @param
- *
- * The map is to be used in conjunction with the configuration array supplied
- * by the driver implementation.
- */
-struct aspeed_pin_config_map {
-	enum pin_config_param param;
-	s32 arg;
-	u32 val;
-};
-
 enum aspeed_pin_config_map_type { MAP_TYPE_ARG, MAP_TYPE_VAL };
 
-/* Aspeed consistently both:
- *
- * 1. Defines "disable bits" for internal pull-downs
- * 2. Uses 8mA or 16mA drive strengths
- */
-static const struct aspeed_pin_config_map pin_config_map[] = {
-	{ PIN_CONFIG_BIAS_PULL_DOWN,  0, 1 },
-	{ PIN_CONFIG_BIAS_PULL_DOWN, -1, 0 },
-	{ PIN_CONFIG_BIAS_DISABLE,   -1, 1 },
-	{ PIN_CONFIG_DRIVE_STRENGTH,  8, 0 },
-	{ PIN_CONFIG_DRIVE_STRENGTH, 16, 1 },
-};
-
 static const struct aspeed_pin_config_map *find_pinconf_map(
+		const struct aspeed_pinctrl_data *pdata,
 		enum pin_config_param param,
 		enum aspeed_pin_config_map_type type,
 		s64 value)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(pin_config_map); i++) {
+	for (i = 0; i < pdata->nconfmaps; i++) {
 		const struct aspeed_pin_config_map *elem;
 		bool match;
 
-		elem = &pin_config_map[i];
+		elem = &pdata->confmaps[i];
 
 		switch (type) {
 		case MAP_TYPE_ARG:
@@ -491,7 +463,7 @@ int aspeed_pin_config_get(struct pinctrl_dev *pctldev, unsigned int offset,
 	if (rc < 0)
 		return rc;
 
-	pmap = find_pinconf_map(param, MAP_TYPE_VAL,
+	pmap = find_pinconf_map(pdata, param, MAP_TYPE_VAL,
 			(val & BIT(pconf->bit)) >> pconf->bit);
 
 	if (!pmap)
@@ -535,7 +507,7 @@ int aspeed_pin_config_set(struct pinctrl_dev *pctldev, unsigned int offset,
 		if (!pconf)
 			return -ENOTSUPP;
 
-		pmap = find_pinconf_map(param, MAP_TYPE_ARG, arg);
+		pmap = find_pinconf_map(pdata, param, MAP_TYPE_ARG, arg);
 
 		if (WARN_ON(!pmap))
 			return -EINVAL;
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
index a7db31202033..27d3929b6aca 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -42,6 +42,22 @@ struct aspeed_pin_config {
 	.bit = bit_ \
 }
 
+/*
+ * Aspeed pin configuration description.
+ *
+ * @param: pinconf configuration parameter
+ * @arg: The supported argument for @param, or -1 if any value is supported
+ * @val: The register value to write to configure @arg for @param
+ *
+ * The map is to be used in conjunction with the configuration array supplied
+ * by the driver implementation.
+ */
+struct aspeed_pin_config_map {
+	enum pin_config_param param;
+	s32 arg;
+	u32 val;
+};
+
 struct aspeed_pinctrl_data {
 	struct regmap *scu;
 
@@ -52,6 +68,9 @@ struct aspeed_pinctrl_data {
 	const unsigned int nconfigs;
 
 	struct aspeed_pinmux_data pinmux;
+
+	const struct aspeed_pin_config_map *confmaps;
+	const unsigned int nconfmaps;
 };
 
 /* Aspeed pinctrl helpers */
-- 
2.20.1

