From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Mon, 18 Nov 2019 13:46:45 +0300
Subject: [PATCH v3 2/3] mmc: sdhci-of-aspeed: enable
 CONFIG_MMC_SDHCI_IO_ACCESSORS
In-Reply-To: <20191118104646.3838-1-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
Message-ID: <20191118104646.3838-3-i.mikhaylov@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. The read_l
callback is used for inverted card detection.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 49ea02c467bf..c9c1bb722368 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -159,6 +159,7 @@ config MMC_SDHCI_OF_ASPEED
 	tristate "SDHCI OF support for the ASPEED SDHCI controller"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF && OF_ADDRESS
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the ASPEED Secure Digital Host Controller Interface.
 
-- 
2.20.1

