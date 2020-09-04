From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri,  4 Sep 2020 18:43:15 +0200
Subject: [PATCH v2 2/2] mmc: host: Enable compile testing of multiple drivers
In-Reply-To: <20200904164315.24618-1-krzk@kernel.org>
References: <20200904164315.24618-1-krzk@kernel.org>
Message-ID: <20200904164315.24618-2-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Multiple MMC host controller driver can be compile tested as they do not
depend on architecture specific headers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add COMMON_CLK dependency to MESON_GX to fix errors like:
   ERROR: modpost: "devm_clk_register" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
---
 drivers/mmc/host/Kconfig | 41 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index eea01fde0591..93db789cf8ec 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -178,7 +178,7 @@ config MMC_SDHCI_OF_AT91
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
+	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
 	select MMC_SDHCI_IO_ACCESSORS
 	select FSL_GUTS
 	help
@@ -216,7 +216,7 @@ config MMC_SDHCI_OF_DWCMSHC
 config MMC_SDHCI_OF_SPARX5
 	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
 	depends on MMC_SDHCI_PLTFM
-	depends on ARCH_SPARX5
+	depends on ARCH_SPARX5 || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  found in the MCHP Sparx5 SoC.
@@ -238,7 +238,7 @@ config MMC_SDHCI_CADENCE
 
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
-	depends on ARCH_CNS3XXX
+	depends on ARCH_CNS3XXX || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
@@ -262,7 +262,7 @@ config MMC_SDHCI_ESDHC_MCF
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
@@ -276,7 +276,7 @@ config MMC_SDHCI_ESDHC_IMX
 
 config MMC_SDHCI_DOVE
 	tristate "SDHCI support on Marvell's Dove SoC"
-	depends on ARCH_DOVE || MACH_DOVE
+	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -289,7 +289,7 @@ config MMC_SDHCI_DOVE
 
 config MMC_SDHCI_TEGRA
 	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
@@ -301,7 +301,8 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS)
+	depends on MMC_SDHCI
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
@@ -313,7 +314,7 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_SIRF
 	tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -351,7 +352,8 @@ config MMC_SDHCI_PXAV2
 
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
-	depends on MMC_SDHCI && PLAT_SPEAR
+	depends on MMC_SDHCI
+	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
@@ -374,7 +376,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
@@ -422,7 +424,8 @@ config MMC_SDHCI_IPROC
 
 config MMC_MESON_GX
 	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  This selects support for the Amlogic SD/MMC Host Controller
 	  found on the S905/GX*/AXG family of SoCs.  This controller is
@@ -458,7 +461,7 @@ config MMC_MESON_MX_SDIO
 
 config MMC_MOXART
 	tristate "MOXART SD/MMC Host Controller support"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	help
 	  This selects support for the MOXART SD/MMC Host Controller.
 	  MOXA provides one multi-functional card reader which can
@@ -467,7 +470,7 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI || FSP2
+	depends on ARCH_STI || FSP2 || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -587,7 +590,7 @@ config MMC_TIFM_SD
 
 config MMC_MVSDIO
 	tristate "Marvell MMC/SD/SDIO host driver"
-	depends on PLAT_ORION
+	depends on PLAT_ORION || (COMPILE_TEST && ARM)
 	depends on OF
 	help
 	  This selects the Marvell SDIO host driver.
@@ -599,7 +602,7 @@ config MMC_MVSDIO
 
 config MMC_DAVINCI
 	tristate "TI DAVINCI Multimedia Card Interface support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	help
 	  This selects the TI DAVINCI Multimedia card Interface.
 	  If you have an DAVINCI board with a Multimedia Card slot,
@@ -628,7 +631,7 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX || COMPILE_TEST
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
@@ -681,7 +684,7 @@ config MMC_SDRICOH_CS
 
 config MMC_SDHCI_SPRD
 	tristate "Spreadtrum SDIO host Controller"
-	depends on ARCH_SPRD
+	depends on ARCH_SPRD || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_HSQ
@@ -698,7 +701,7 @@ config MMC_TMIO_CORE
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3
+	depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
@@ -971,7 +974,7 @@ config MMC_REALTEK_USB
 
 config MMC_SUNXI
 	tristate "Allwinner sunxi SD/MMC Host Controller support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Allwinner sunxi SoCs.
-- 
2.17.1

