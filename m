From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Wed, 24 Mar 2021 15:50:13 +0800
Subject: [PATCH] mmc: sdhci: replace mmc->parent with mmc_dev() for consistency
Message-ID: <20210324155013.1e5faa3c@xhacker.debian>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As pointed out by Ulf, "both "mmc->parent" and mmc_dev(mmc) are being
used in the entire c-file". Convert all the mmc->parent usage in all
sdhci host driver to mmc_dev() for consistency.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c |  8 +++----
 drivers/mmc/host/sdhci-of-aspeed.c |  2 +-
 drivers/mmc/host/sdhci-tegra.c     | 34 +++++++++++++++---------------
 drivers/mmc/host/sdhci.c           | 24 ++++++++++-----------
 drivers/mmc/host/sdhci_am654.c     |  2 +-
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index ca7a1690b2a8..05926bf5ecf9 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -367,14 +367,14 @@ static int esdhc_mcf_plat_init(struct sdhci_host *host,
 			       struct pltfm_mcf_data *mcf_data)
 {
 	struct mcf_esdhc_platform_data *plat_data;
+	struct device *dev = mmc_dev(host->mmc);
 
-	if (!host->mmc->parent->platform_data) {
-		dev_err(mmc_dev(host->mmc), "no platform data!\n");
+	if (!dev->platform_data) {
+		dev_err(dev, "no platform data!\n");
 		return -EINVAL;
 	}
 
-	plat_data = (struct mcf_esdhc_platform_data *)
-			host->mmc->parent->platform_data;
+	plat_data = (struct mcf_esdhc_platform_data *)dev->platform_data;
 
 	/* Card_detect */
 	switch (plat_data->cd_type) {
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 7d8692e90996..d001c51074a0 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -181,7 +181,7 @@ aspeed_sdhci_configure_phase(struct sdhci_host *host, unsigned long rate)
 	struct aspeed_sdhci *sdhci;
 	struct device *dev;
 
-	dev = host->mmc->parent;
+	dev = mmc_dev(host->mmc);
 	sdhci = sdhci_pltfm_priv(sdhci_priv(host));
 
 	if (!sdhci->phase_desc)
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 41d193fa77bb..c61f797a853f 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -596,49 +596,49 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 			&tegra_host->autocal_offsets;
 	int err;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-3v3",
 			&autocal->pull_up_3v3);
 	if (err)
 		autocal->pull_up_3v3 = 0;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-3v3",
 			&autocal->pull_down_3v3);
 	if (err)
 		autocal->pull_down_3v3 = 0;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-1v8",
 			&autocal->pull_up_1v8);
 	if (err)
 		autocal->pull_up_1v8 = 0;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-1v8",
 			&autocal->pull_down_1v8);
 	if (err)
 		autocal->pull_down_1v8 = 0;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-sdr104",
 			&autocal->pull_up_sdr104);
 	if (err)
 		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-sdr104",
 			&autocal->pull_down_sdr104);
 	if (err)
 		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-hs400",
 			&autocal->pull_up_hs400);
 	if (err)
 		autocal->pull_up_hs400 = autocal->pull_up_1v8;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-hs400",
 			&autocal->pull_down_hs400);
 	if (err)
@@ -653,7 +653,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
 		return;
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
 			&autocal->pull_up_3v3_timeout);
 	if (err) {
@@ -664,7 +664,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_up_3v3_timeout = 0;
 	}
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-3v3-timeout",
 			&autocal->pull_down_3v3_timeout);
 	if (err) {
@@ -675,7 +675,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_down_3v3_timeout = 0;
 	}
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-up-offset-1v8-timeout",
 			&autocal->pull_up_1v8_timeout);
 	if (err) {
@@ -686,7 +686,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_up_1v8_timeout = 0;
 	}
 
-	err = device_property_read_u32(host->mmc->parent,
+	err = device_property_read_u32(mmc_dev(host->mmc),
 			"nvidia,pad-autocal-pull-down-offset-1v8-timeout",
 			&autocal->pull_down_1v8_timeout);
 	if (err) {
@@ -720,17 +720,17 @@ static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	int err;
 
-	err = device_property_read_u32(host->mmc->parent, "nvidia,default-tap",
+	err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,default-tap",
 				       &tegra_host->default_tap);
 	if (err)
 		tegra_host->default_tap = 0;
 
-	err = device_property_read_u32(host->mmc->parent, "nvidia,default-trim",
+	err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,default-trim",
 				       &tegra_host->default_trim);
 	if (err)
 		tegra_host->default_trim = 0;
 
-	err = device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
+	err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,dqs-trim",
 				       &tegra_host->dqs_trim);
 	if (err)
 		tegra_host->dqs_trim = 0x11;
@@ -741,7 +741,7 @@ static void tegra_sdhci_parse_dt(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 
-	if (device_property_read_bool(host->mmc->parent, "supports-cqe"))
+	if (device_property_read_bool(mmc_dev(host->mmc), "supports-cqe"))
 		tegra_host->enable_hwcq = true;
 	else
 		tegra_host->enable_hwcq = false;
@@ -1529,7 +1529,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 
 	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
 
-	cq_host = devm_kzalloc(host->mmc->parent,
+	cq_host = devm_kzalloc(mmc_dev(host->mmc),
 				sizeof(*cq_host), GFP_KERNEL);
 	if (!cq_host) {
 		ret = -ENOMEM;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aefd0441658c..bf238ade1602 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -188,7 +188,7 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	if (host->bus_on)
 		return;
 	host->bus_on = true;
-	pm_runtime_get_noresume(host->mmc->parent);
+	pm_runtime_get_noresume(mmc_dev(host->mmc));
 }
 
 static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
@@ -196,7 +196,7 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
-	pm_runtime_put_noidle(host->mmc->parent);
+	pm_runtime_put_noidle(mmc_dev(host->mmc));
 }
 
 void sdhci_reset(struct sdhci_host *host, u8 mask)
@@ -648,7 +648,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 			}
 		}
 		/* Switch ownership to the DMA */
-		dma_sync_single_for_device(host->mmc->parent,
+		dma_sync_single_for_device(mmc_dev(host->mmc),
 					   host->bounce_addr,
 					   host->bounce_buffer_size,
 					   mmc_get_dma_dir(data));
@@ -1176,7 +1176,7 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
 	int ret = 0;
 	struct mmc_host *mmc = host->mmc;
 
-	host->tx_chan = dma_request_chan(mmc->parent, "tx");
+	host->tx_chan = dma_request_chan(mmc_dev(mmc), "tx");
 	if (IS_ERR(host->tx_chan)) {
 		ret = PTR_ERR(host->tx_chan);
 		if (ret != -EPROBE_DEFER)
@@ -1185,7 +1185,7 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
 		return ret;
 	}
 
-	host->rx_chan = dma_request_chan(mmc->parent, "rx");
+	host->rx_chan = dma_request_chan(mmc_dev(mmc), "rx");
 	if (IS_ERR(host->rx_chan)) {
 		if (host->tx_chan) {
 			dma_release_channel(host->tx_chan);
@@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	unsigned long flags;
 
 	if (enable)
-		pm_runtime_get_noresume(mmc->parent);
+		pm_runtime_get_noresume(mmc_dev(mmc));
 
 	spin_lock_irqsave(&host->lock, flags);
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (!enable)
-		pm_runtime_put_noidle(mmc->parent);
+		pm_runtime_put_noidle(mmc_dev(mmc));
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
 
@@ -3063,7 +3063,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 						length = host->bounce_buffer_size;
 					}
 					dma_sync_single_for_cpu(
-						host->mmc->parent,
+						mmc_dev(host->mmc),
 						host->bounce_addr,
 						host->bounce_buffer_size,
 						DMA_FROM_DEVICE);
@@ -3074,7 +3074,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 				} else {
 					/* No copying, just switch ownership */
 					dma_sync_single_for_cpu(
-						host->mmc->parent,
+						mmc_dev(host->mmc),
 						host->bounce_addr,
 						host->bounce_buffer_size,
 						mmc_get_dma_dir(data));
@@ -4053,7 +4053,7 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	 * speedups by the help of a bounce buffer to group scattered
 	 * reads/writes together.
 	 */
-	host->bounce_buffer = devm_kmalloc(mmc->parent,
+	host->bounce_buffer = devm_kmalloc(mmc_dev(mmc),
 					   bounce_size,
 					   GFP_KERNEL);
 	if (!host->bounce_buffer) {
@@ -4067,11 +4067,11 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 		return;
 	}
 
-	host->bounce_addr = dma_map_single(mmc->parent,
+	host->bounce_addr = dma_map_single(mmc_dev(mmc),
 					   host->bounce_buffer,
 					   bounce_size,
 					   DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(mmc->parent, host->bounce_addr);
+	ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
 	if (ret)
 		/* Again fall back to max_segs == 1 */
 		return;
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7a34649b0754..1fad6e442688 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -558,7 +558,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
 	struct cqhci_host *cq_host;
 	int ret;
 
-	cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
+	cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
 			       GFP_KERNEL);
 	if (!cq_host)
 		return -ENOMEM;
-- 
2.31.0

