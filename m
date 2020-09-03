From: Douglas Anderson <dianders@chromium.org>
Date: Thu,  3 Sep 2020 16:24:40 -0700
Subject: [PATCH 5/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
 existed in v5.4
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
Message-ID: <20200903162412.5.I2b630c4d40ff4ea61d5b30b8ccfe95890e257100@changeid>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe") but applied to a whole pile of drivers.  This batch converts
the drivers that appeared to be around in the v5.4 timeframe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/alcor.c           | 1 +
 drivers/mmc/host/sdhci-of-aspeed.c | 2 ++
 drivers/mmc/host/sdhci-sprd.c      | 1 +
 drivers/mmc/host/sdhci_am654.c     | 1 +
 drivers/mmc/host/uniphier-sd.c     | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 026ca9194ce5..bfb8efeb7eb8 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1178,6 +1178,7 @@ static struct platform_driver alcor_pci_sdmmc_driver = {
 	.id_table	= alcor_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_ALCOR_PCI_SDMMC,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &alcor_mmc_pm_ops
 	},
 };
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index a1bcc0f4ba9e..4f008ba3280e 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -240,6 +240,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {
 		.name	= "sdhci-aspeed",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = aspeed_sdhci_of_match,
 	},
 	.probe		= aspeed_sdhci_probe,
@@ -318,6 +319,7 @@ MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
 static struct platform_driver aspeed_sdc_driver = {
 	.driver		= {
 		.name	= "sd-controller-aspeed",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = aspeed_sdc_of_match,
 	},
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index a910cb461ed7..f88d38e34a23 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -787,6 +787,7 @@ static struct platform_driver sdhci_sprd_driver = {
 	.remove = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(sdhci_sprd_of_match),
 		.pm = &sdhci_sprd_pm_ops,
 	},
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index c5f47197d177..a4c6d9d80e88 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -745,6 +745,7 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 static struct platform_driver sdhci_am654_driver = {
 	.driver = {
 		.name = "sdhci-am654",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 55efd5c53249..3092466a99ab 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -685,6 +685,7 @@ static struct platform_driver uniphier_sd_driver = {
 	.remove = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = uniphier_sd_match,
 	},
 };
-- 
2.28.0.526.ge36021eeef-goog

