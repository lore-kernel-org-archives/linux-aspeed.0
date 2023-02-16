From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 16 Feb 2023 15:41:53 +0800
Subject: [PATCH 2/4] i3c: dw: Add platform operations
In-Reply-To: <cover.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <eb90bc9ee9f72efc2012abce3e4e50186552e194.1676532146.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The dw i3c core can be integrated into various SoC devices. Platforms
that use this core may need a little configuration that is specific to
that platform.

Add a little infrastructure to allow platform-specific behaviour: a bit
of data on struct dw_i3c_master, and two hooks to the probe and init
calls to enable this.

A future change will add new platform support that uses these hooks.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/i3c/master/dw-i3c-master.c | 42 +++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index d73d57362b3b..49b891449222 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -241,6 +241,17 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+
+	/* platform-specific data */
+	const struct dw_i3c_platform_ops *platform_ops;
+	union {
+	} pdata;
+
+};
+
+struct dw_i3c_platform_ops {
+	int (*probe)(struct dw_i3c_master *i3c, struct platform_device *pdev);
+	int (*init)(struct dw_i3c_master *i3c);
 };
 
 struct dw_i3c_i2c_dev_data {
@@ -612,6 +623,12 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	if (master->platform_ops && master->platform_ops->init) {
+		ret = master->platform_ops->init(master);
+		if (ret)
+			return ret;
+	}
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -1128,8 +1145,15 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.i2c_xfers = dw_i3c_master_i2c_xfers,
 };
 
+static const struct of_device_id dw_i3c_master_of_match[] = {
+	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
+
 static int dw_i3c_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct dw_i3c_master *master;
 	int ret, irq;
 
@@ -1181,6 +1205,18 @@ static int dw_i3c_probe(struct platform_device *pdev)
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
+	/* match any platform-specific ops */
+	match = of_match_node(dw_i3c_master_of_match, pdev->dev.of_node);
+	if (match && match->data)
+		master->platform_ops = match->data;
+
+	/* platform-specific probe */
+	if (master->platform_ops && master->platform_ops->probe) {
+		ret = master->platform_ops->probe(master, pdev);
+		if (ret)
+			goto err_assert_rst;
+	}
+
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
 	if (ret)
@@ -1213,12 +1249,6 @@ static int dw_i3c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id dw_i3c_master_of_match[] = {
-	{ .compatible = "snps,dw-i3c-master-1.00a", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-
 static struct platform_driver dw_i3c_driver = {
 	.probe = dw_i3c_probe,
 	.remove = dw_i3c_remove,
-- 
2.39.1

