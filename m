From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Nov 2019 16:58:57 +1030
Subject: [PATCH 5/5] ARM: config: multi_v5: ASPEED SDHCI, SGPIO
In-Reply-To: <20191112062857.32638-1-joel@jms.id.au>
References: <20191112062857.32638-1-joel@jms.id.au>
Message-ID: <20191112062857.32638-6-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable drivers used by the ASPEED AST2400 SoC so the multi v5 defconfig
can run on those boards.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/multi_v5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index bd018873e47a..56315e1f81ff 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -165,6 +165,7 @@ CONFIG_SPI_ATMEL=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_ASPEED=m
+CONFIG_GPIO_ASPEED_SGPIO=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_QNAP=y
@@ -241,6 +242,9 @@ CONFIG_USB_ASPEED_VHUB=m
 CONFIG_USB_CONFIGFS=m
 CONFIG_MMC=y
 CONFIG_SDIO_UART=y
+CONFIG_MMC_SDHCI=m
+CONFIG_MMC_SDHCI_PLTFM=m
+CONFIG_MMC_SDHCI_OF_ASPEED=m
 CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
-- 
2.24.0

