From: Yangtao Li <frank.li@vivo.com>
Date: Thu, 27 Jul 2023 15:00:21 +0800
Subject: [PATCH v3 32/62] mmc: sdhci-of-aspeed: remove unneeded variables
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Message-ID: <20230727070051.17778-32-frank.li@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The variable 'dead' is redundant, let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 25b4073f698b..b4867bb4a564 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -454,12 +454,11 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	int dead = 0;
 
 	host = platform_get_drvdata(pdev);
 	pltfm_host = sdhci_priv(host);
 
-	sdhci_remove_host(host, dead);
+	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(pltfm_host->clk);
 
-- 
2.39.0

