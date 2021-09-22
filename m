From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:12 +0800
Subject: [PATCH 06/10] arm: dts: aspeed: Change eMMC device compatible
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-7-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since the eMMC device's delay parameters are different from
the SD's, a new compatible should be used to distinguish
between eMMC and SD device.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1b47be1704f8..d083de1d6567 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -597,7 +597,7 @@
 				status = "disabled";
 
 				emmc: sdhci at 1e750100 {
-					compatible = "aspeed,ast2600-sdhci";
+					compatible = "aspeed,ast2600-emmc";
 					reg = <0x100 0x100>;
 					sdhci,auto-cmd12;
 					interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

