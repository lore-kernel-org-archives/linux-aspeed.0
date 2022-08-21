From: Igor Kononenko <i.kononenko@yadro.com>
Date: Sun, 21 Aug 2022 18:54:10 +0300
Subject: [PATCH 2/3] drivers/misc: (aspeed-lpc-snoop): Add regmap cleanup on a shutdown.
In-Reply-To: <cover.1661094034.git.i.kononenko@yadro.com>
References: <cover.1661094034.git.i.kononenko@yadro.com>
Message-ID: <f9814f62fe2d6b6c21400ee3c83e46e61e0c72d1.1661094034.git.i.kononenko@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bmc might be rebooted while the host is still reachable and the host
might send requests through configured lpc-kcs channels in same time.
That leads to raise lpc-snoop interrupts that haven't adjusted IRQ
handlers on next early kernel boot, because on the aspeed-chip reboot
might keep registers on a unclean state that is configured on the last
boot.

The patch brings an way to masking lpc-snoop interrupts all through
a bmc-rebooting time.

Tested on a YADRO VEGMAN N110 stand.

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..6ec47bf1dc6b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -235,6 +235,41 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	return rc;
 }
 
+static void aspeed_lpc_reset_regmap(struct aspeed_lpc_snoop *lpc_snoop)
+{
+	u8 index;
+	struct lpc_regman_cleanup {
+		u32 offset;
+		u32 mask;
+		u8 val;
+	};
+	static struct lpc_regman_cleanup cleanup_list[] = {
+		// Prevent handling ENINIT_SNPxW
+		{ .offset = HICR5,
+		  .mask = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
+		  .val = 0 },
+		{ .offset = HICR5,
+		  .mask = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
+		  .val = 0 },
+		{ .offset = HICRB,
+		  .mask = HICRB_ENSNP0D | HICRB_ENSNP1D,
+		  .val = 0 },
+		// Reset SNOOP channel IRQ status
+		{ .offset = HICR6,
+		  .mask = HICR6_STR_SNP0W | HICR6_STR_SNP1W,
+		  .val = 1 },
+	};
+	for (index = 0; index < ARRAY_SIZE(cleanup_list); index++) {
+		u32 val = 0;
+
+		if (cleanup_list[index].val)
+			val = cleanup_list[index].mask;
+		regmap_update_bits(lpc_snoop->regmap,
+				   cleanup_list[index].offset,
+				   cleanup_list[index].mask, val);
+	}
+}
+
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
@@ -285,6 +320,7 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	aspeed_lpc_reset_regmap(lpc_snoop);
 	dev_set_drvdata(&pdev->dev, lpc_snoop);
 
 	rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0, &port);
@@ -345,6 +381,13 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void aspeed_lpc_snoop_shutdown(struct platform_device *pdev)
+{
+	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
+
+	aspeed_lpc_reset_regmap(lpc_snoop);
+}
+
 static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {
 	.has_hicrb_ensnp = 0,
 };
@@ -370,6 +413,7 @@ static struct platform_driver aspeed_lpc_snoop_driver = {
 	},
 	.probe = aspeed_lpc_snoop_probe,
 	.remove = aspeed_lpc_snoop_remove,
+	.shutdown = aspeed_lpc_snoop_shutdown,
 };
 
 module_platform_driver(aspeed_lpc_snoop_driver);
-- 
2.25.1

