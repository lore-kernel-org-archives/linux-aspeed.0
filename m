From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 16 Feb 2023 15:41:54 +0800
Subject: [PATCH 3/4] i3c: dw: Add AST2600 platform ops
In-Reply-To: <cover.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <5d27e16ea3eea8c88f448a3f540e6d2eebf78d2c.1676532146.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that we have platform-specific hooks for the dw i3c driver, add
platform support for the ASPEED AST2600 SoC.

The AST2600 has a small set of "i3c global" registers, providing
platform-level i3c configuration outside of the i3c core.

For the ast2600, we need a couple of extra setup operations:

 - on probe: find the i3c global register set and parse the SDA pullup
   resistor values

 - on init: set the pullups accordingly, and set the i3c instance IDs

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/i3c/master/dw-i3c-master.c | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 49b891449222..9be3348cba0e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -16,8 +16,10 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -201,6 +203,28 @@
 
 #define XFER_TIMEOUT (msecs_to_jiffies(1000))
 
+/* AST2600-specific global register set */
+#define AST2600_I3CG_REG0(idx)	(((idx) * 4 * 4) + 0x10)
+#define AST2600_I3CG_REG1(idx)	(((idx) * 4 * 4) + 0x14)
+
+#define AST2600_I3CG_REG0_SDA_PULLUP_EN_MASK	GENMASK(29, 28)
+#define AST2600_I3CG_REG0_SDA_PULLUP_EN_2K	(0x0 << 28)
+#define AST2600_I3CG_REG0_SDA_PULLUP_EN_750	(0x2 << 28)
+
+#define AST2600_I3CG_REG1_I2C_MODE		BIT(0)
+#define AST2600_I3CG_REG1_TEST_MODE		BIT(1)
+#define AST2600_I3CG_REG1_ACT_MODE_MASK		GENMASK(3, 2)
+#define AST2600_I3CG_REG1_ACT_MODE(x)		(((x) << 2) & AST2600_I3CG_REG1_ACT_MODE_MASK)
+#define AST2600_I3CG_REG1_PENDING_INT_MASK	GENMASK(7, 4)
+#define AST2600_I3CG_REG1_PENDING_INT(x)	(((x) << 4) & AST2600_I3CG_REG1_PENDING_INT_MASK)
+#define AST2600_I3CG_REG1_SA_MASK		GENMASK(14, 8)
+#define AST2600_I3CG_REG1_SA(x)			(((x) << 8) & AST2600_I3CG_REG1_SA_MASK)
+#define AST2600_I3CG_REG1_SA_EN			BIT(15)
+#define AST2600_I3CG_REG1_INST_ID_MASK		GENMASK(19, 16)
+#define AST2600_I3CG_REG1_INST_ID(x)		(((x) << 16) & AST2600_I3CG_REG1_INST_ID_MASK)
+
+#define AST2600_DEFAULT_SDA_PULLUP_OHMS		2000
+
 struct dw_i3c_master_caps {
 	u8 cmdfifodepth;
 	u8 datafifodepth;
@@ -224,6 +248,12 @@ struct dw_i3c_xfer {
 	struct dw_i3c_cmd cmds[];
 };
 
+struct pdata_ast2600 {
+	struct regmap *global_regs;
+	unsigned int global_idx;
+	unsigned int sda_pullup;
+};
+
 struct dw_i3c_master {
 	struct i3c_master_controller base;
 	u16 maxdevs;
@@ -245,6 +275,7 @@ struct dw_i3c_master {
 	/* platform-specific data */
 	const struct dw_i3c_platform_ops *platform_ops;
 	union {
+		struct pdata_ast2600 ast2600;
 	} pdata;
 
 };
@@ -1145,6 +1176,97 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.i2c_xfers = dw_i3c_master_i2c_xfers,
 };
 
+/* hardware-specific ops */
+
+static int ast2600_i3c_pullup_to_reg(unsigned int ohms, u32 *regp)
+{
+	u32 reg;
+
+	switch (ohms) {
+	case 2000:
+		reg = AST2600_I3CG_REG0_SDA_PULLUP_EN_2K;
+		break;
+	case 750:
+		reg = AST2600_I3CG_REG0_SDA_PULLUP_EN_750;
+		break;
+	case 545:
+		reg = AST2600_I3CG_REG0_SDA_PULLUP_EN_2K |
+			AST2600_I3CG_REG0_SDA_PULLUP_EN_750;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (regp)
+		*regp = reg;
+
+	return 0;
+}
+
+static int ast2600_i3c_probe(struct dw_i3c_master *master,
+			     struct platform_device *pdev)
+{
+	struct pdata_ast2600 *pdata = &master->pdata.ast2600;
+	struct device_node *np = pdev->dev.of_node;
+	struct of_phandle_args gspec;
+	int rc;
+
+	rc = of_parse_phandle_with_fixed_args(np, "aspeed,global-regs", 1, 0,
+					      &gspec);
+	if (rc)
+		return -ENODEV;
+
+	pdata->global_regs = syscon_node_to_regmap(gspec.np);
+	of_node_put(gspec.np);
+
+	if (IS_ERR(pdata->global_regs))
+		return PTR_ERR(pdata->global_regs);
+
+	pdata->global_idx = gspec.args[0];
+
+	rc = of_property_read_u32(np, "sda-pullup-ohms", &pdata->sda_pullup);
+	if (rc)
+		pdata->sda_pullup = AST2600_DEFAULT_SDA_PULLUP_OHMS;
+
+	rc = ast2600_i3c_pullup_to_reg(pdata->sda_pullup, NULL);
+	if (rc)
+		dev_err(&master->base.dev, "invalid sda-pullup value %d\n",
+			pdata->sda_pullup);
+
+	return rc;
+}
+
+static int ast2600_i3c_init(struct dw_i3c_master *master)
+{
+	struct pdata_ast2600 *pdata = &master->pdata.ast2600;
+	u32 reg = 0;
+	int rc;
+
+	/* reg0: set SDA pullup values */
+	rc = ast2600_i3c_pullup_to_reg(pdata->sda_pullup, &reg);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(pdata->global_regs,
+			  AST2600_I3CG_REG0(pdata->global_idx), reg);
+	if (rc)
+		return rc;
+
+	/* reg1: set up the instance id, but leave everything else disabled,
+	 * as it's all for client mode
+	 */
+	reg = AST2600_I3CG_REG1_INST_ID(pdata->global_idx);
+	rc = regmap_write(pdata->global_regs,
+			  AST2600_I3CG_REG1(pdata->global_idx), reg);
+
+	return rc;
+}
+
+static const struct dw_i3c_platform_ops ast2600_platform_ops = {
+	.probe = ast2600_i3c_probe,
+	.init = ast2600_i3c_init,
+};
+
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
 	{},
-- 
2.39.1

