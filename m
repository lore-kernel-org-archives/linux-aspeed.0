From: Igor Kononenko <i.kononenko@yadro.com>
Date: Mon, 22 Aug 2022 09:35:57 +0300
Subject: [PATCH v2 1/3] ipmi:kcs_bmc: Add cleanup regmap(interrupt-regs) on a shutdown.
In-Reply-To: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
References: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
Message-ID: <ad3cd046c4dcb9169aaff6c0b739b23d0a06014d.1661149313.git.i.kononenko@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The previos v1 [PATCH 1/3] have error of getting `struct kcs_bmc_device` 
pointer from `struct platform_device *`. Replaced to retriveing pointer by 
`platform_get_drvdata()`

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index cdc88cde1e9a..8437f3cfe3f4 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -636,6 +636,14 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void aspeed_kcs_shutdown(struct platform_device *pdev)
+{
+	struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
+	struct kcs_bmc_device *kcs_bmc = &priv->kcs_bmc;
+
+	aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
+}
+
 static const struct of_device_id ast_kcs_bmc_match[] = {
 	{ .compatible = "aspeed,ast2400-kcs-bmc-v2" },
 	{ .compatible = "aspeed,ast2500-kcs-bmc-v2" },
@@ -651,6 +659,7 @@ static struct platform_driver ast_kcs_bmc_driver = {
 	},
 	.probe  = aspeed_kcs_probe,
 	.remove = aspeed_kcs_remove,
+	.shutdown = aspeed_kcs_shutdown,
 };
 module_platform_driver(ast_kcs_bmc_driver);
 
-- 
2.25.1

