From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 17 Oct 2022 11:16:24 +0200
Subject: [PATCH linux v2 3/3] spi: aspeed: Introduce a "ranges" debugfs file
In-Reply-To: <20221017091624.130227-1-clg@kaod.org>
References: <20221017091624.130227-1-clg@kaod.org>
Message-ID: <20221017091624.130227-4-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This dumps the mapping windows, or decoding ranges, of all devices
possibly attached of the controller. To be noted that a top level
"spi" debugfs directory is created to hold the intermediate directory
of the driver instance.

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 66 +++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 75e1d08bbd00..a79e5cc8ac5b 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -102,6 +103,9 @@ struct aspeed_spi {
 	u32			 clk_freq;
 
 	struct aspeed_spi_chip	 chips[ASPEED_SPI_MAX_NUM_CS];
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry           *debugfs;
+#endif
 };
 
 static u32 aspeed_spi_get_io_mode(const struct spi_mem_op *op)
@@ -716,6 +720,65 @@ static void aspeed_spi_enable(struct aspeed_spi *aspi, bool enable)
 		aspeed_spi_chip_enable(aspi, cs, enable);
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int aspeed_spi_ranges_debug_show(struct seq_file *m, void *private)
+{
+	struct aspeed_spi *aspi = m->private;
+	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
+	u32 cs;
+
+	if (aspi->data == &ast2400_spi_data)
+		return 0;
+
+	aspeed_spi_get_windows(aspi, windows);
+
+	seq_puts(m, "     offset     size       register\n");
+	for (cs = 0; cs < aspi->data->max_cs; cs++) {
+		if (!windows[cs].reg)
+			seq_printf(m, "CE%d: disabled\n", cs);
+		else
+			seq_printf(m, "CE%d: 0x%.8x 0x%.8x 0x%x\n", cs,
+				   windows[cs].offset, windows[cs].size,
+				   windows[cs].reg);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(aspeed_spi_ranges_debug);
+
+static int aspeed_spi_debugfs_init(struct spi_controller *ctlr)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
+	struct dentry *rootdir = NULL;
+
+	rootdir = debugfs_lookup("spi", NULL);
+	if (!rootdir)
+		rootdir = debugfs_create_dir("spi", NULL);
+
+	aspi->debugfs = debugfs_create_dir(dev_name(&ctlr->dev), rootdir);
+	if (!aspi->debugfs)
+		return -ENOMEM;
+
+	debugfs_create_file("ranges", 0444, aspi->debugfs, (void *)aspi,
+			    &aspeed_spi_ranges_debug_fops);
+	return 0;
+}
+
+static void aspeed_spi_debugfs_remove(struct aspeed_spi *aspi)
+{
+	debugfs_remove_recursive(aspi->debugfs);
+}
+
+#else
+static inline int aspeed_spi_debugfs_init(struct spi_controller *ctlr)
+{
+	return 0;
+}
+
+static inline void aspeed_spi_debugfs_remove(struct aspeed_spi *aspi)
+{
+}
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 static int aspeed_spi_chip_read_ranges(struct device_node *node, struct aspeed_spi *aspi)
 {
 	const char *range_prop = "ranges";
@@ -845,7 +908,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		goto disable_clk;
 	}
-	return 0;
+	return aspeed_spi_debugfs_init(ctlr);
 
 disable_clk:
 	clk_disable_unprepare(aspi->clk);
@@ -856,6 +919,7 @@ static int aspeed_spi_remove(struct platform_device *pdev)
 {
 	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
 
+	aspeed_spi_debugfs_remove(aspi);
 	aspeed_spi_enable(aspi, false);
 	clk_disable_unprepare(aspi->clk);
 	return 0;
-- 
2.37.3

