From: Joel Stanley <joel@jms.id.au>
Date: Sun, 25 Aug 2019 23:48:47 +0930
Subject: [PATCH v2 1/2] clk: aspeed: Move structures to header
In-Reply-To: <20190825141848.17346-1-joel@jms.id.au>
References: <20190825141848.17346-1-joel@jms.id.au>
Message-ID: <20190825141848.17346-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

They will be reused by the ast2600 driver.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 include required headers for structures used by clk-aspeed.h

 drivers/clk/clk-aspeed.c | 67 ++------------------------------
 drivers/clk/clk-aspeed.h | 82 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 64 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 898291501f45..abf06fb6453e 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -1,19 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp
 
 #define pr_fmt(fmt) "clk-aspeed: " fmt
 
-#include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/reset-controller.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 #include <dt-bindings/clock/aspeed-clock.h>
 
+#include "clk-aspeed.h"
+
 #define ASPEED_NUM_CLKS		36
 
 #define ASPEED_RESET2_OFFSET	32
@@ -42,48 +42,6 @@ static struct clk_hw_onecell_data *aspeed_clk_data;
 
 static void __iomem *scu_base;
 
-/**
- * struct aspeed_gate_data - Aspeed gated clocks
- * @clock_idx: bit used to gate this clock in the clock register
- * @reset_idx: bit used to reset this IP in the reset register. -1 if no
- *             reset is required when enabling the clock
- * @name: the clock name
- * @parent_name: the name of the parent clock
- * @flags: standard clock framework flags
- */
-struct aspeed_gate_data {
-	u8		clock_idx;
-	s8		reset_idx;
-	const char	*name;
-	const char	*parent_name;
-	unsigned long	flags;
-};
-
-/**
- * struct aspeed_clk_gate - Aspeed specific clk_gate structure
- * @hw:		handle between common and hardware-specific interfaces
- * @reg:	register controlling gate
- * @clock_idx:	bit used to gate this clock in the clock register
- * @reset_idx:	bit used to reset this IP in the reset register. -1 if no
- *		reset is required when enabling the clock
- * @flags:	hardware-specific flags
- * @lock:	register lock
- *
- * Some of the clocks in the Aspeed SoC must be put in reset before enabling.
- * This modified version of clk_gate allows an optional reset bit to be
- * specified.
- */
-struct aspeed_clk_gate {
-	struct clk_hw	hw;
-	struct regmap	*map;
-	u8		clock_idx;
-	s8		reset_idx;
-	u8		flags;
-	spinlock_t	*lock;
-};
-
-#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
-
 /* TODO: ask Aspeed about the actual parent data */
 static const struct aspeed_gate_data aspeed_gates[] = {
 	/*				 clk rst   name			parent	flags */
@@ -208,13 +166,6 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
 			mult, div);
 }
 
-struct aspeed_clk_soc_data {
-	const struct clk_div_table *div_table;
-	const struct clk_div_table *eclk_div_table;
-	const struct clk_div_table *mac_div_table;
-	struct clk_hw *(*calc_pll)(const char *name, u32 val);
-};
-
 static const struct aspeed_clk_soc_data ast2500_data = {
 	.div_table = ast2500_div_table,
 	.eclk_div_table = ast2500_eclk_div_table,
@@ -315,18 +266,6 @@ static const struct clk_ops aspeed_clk_gate_ops = {
 	.is_enabled = aspeed_clk_is_enabled,
 };
 
-/**
- * struct aspeed_reset - Aspeed reset controller
- * @map: regmap to access the containing system controller
- * @rcdev: reset controller device
- */
-struct aspeed_reset {
-	struct regmap			*map;
-	struct reset_controller_dev	rcdev;
-};
-
-#define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
-
 static const u8 aspeed_resets[] = {
 	/* SCU04 resets */
 	[ASPEED_RESET_XDMA]	= 25,
diff --git a/drivers/clk/clk-aspeed.h b/drivers/clk/clk-aspeed.h
new file mode 100644
index 000000000000..5296b15b1c88
--- /dev/null
+++ b/drivers/clk/clk-aspeed.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Structures used by ASPEED clock drivers
+ *
+ * Copyright 2019 IBM Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+struct clk_div_table;
+struct regmap;
+
+/**
+ * struct aspeed_gate_data - Aspeed gated clocks
+ * @clock_idx: bit used to gate this clock in the clock register
+ * @reset_idx: bit used to reset this IP in the reset register. -1 if no
+ *             reset is required when enabling the clock
+ * @name: the clock name
+ * @parent_name: the name of the parent clock
+ * @flags: standard clock framework flags
+ */
+struct aspeed_gate_data {
+	u8		clock_idx;
+	s8		reset_idx;
+	const char	*name;
+	const char	*parent_name;
+	unsigned long	flags;
+};
+
+/**
+ * struct aspeed_clk_gate - Aspeed specific clk_gate structure
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register controlling gate
+ * @clock_idx:	bit used to gate this clock in the clock register
+ * @reset_idx:	bit used to reset this IP in the reset register. -1 if no
+ *		reset is required when enabling the clock
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ *
+ * Some of the clocks in the Aspeed SoC must be put in reset before enabling.
+ * This modified version of clk_gate allows an optional reset bit to be
+ * specified.
+ */
+struct aspeed_clk_gate {
+	struct clk_hw	hw;
+	struct regmap	*map;
+	u8		clock_idx;
+	s8		reset_idx;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
+
+/**
+ * struct aspeed_reset - Aspeed reset controller
+ * @map: regmap to access the containing system controller
+ * @rcdev: reset controller device
+ */
+struct aspeed_reset {
+	struct regmap			*map;
+	struct reset_controller_dev	rcdev;
+};
+
+#define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
+
+/**
+ * struct aspeed_clk_soc_data - Aspeed SoC specific divisor information
+ * @div_table: Common divider lookup table
+ * @eclk_div_table: Divider lookup table for ECLK
+ * @mac_div_table: Divider lookup table for MAC (Ethernet) clocks
+ * @calc_pll: Callback to maculate common PLL settings
+ */
+struct aspeed_clk_soc_data {
+	const struct clk_div_table *div_table;
+	const struct clk_div_table *eclk_div_table;
+	const struct clk_div_table *mac_div_table;
+	struct clk_hw *(*calc_pll)(const char *name, u32 val);
+};
-- 
2.23.0.rc1

