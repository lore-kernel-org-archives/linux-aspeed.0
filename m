From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 16 Sep 2022 12:56:02 +0100
Subject: [PATCH] mmc: sdhci-of-aspeed: Add dependency on ARCH_ASPEED
Message-ID: <20220916115602.370003-1-pbrobinson@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The MMC_SDHCI_OF_ASPEED is part of the Aspeed silicon so it makes
sense to depend on ARCH_ASPEED and for compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e63608834411..f324daadaf70 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -157,6 +157,7 @@ config MMC_SDHCI_OF_ARASAN
 
 config MMC_SDHCI_OF_ASPEED
 	tristate "SDHCI OF support for the ASPEED SDHCI controller"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	depends on OF && OF_ADDRESS
 	select MMC_SDHCI_IO_ACCESSORS
-- 
2.37.3

