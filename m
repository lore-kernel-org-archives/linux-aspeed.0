From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:13 +0800
Subject: [PATCH 07/10] arm: dts: aspeed: Adjust clock phase parameter
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-8-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change clock phase degree for AST2600 EVB.
These parameter has been verified with 100MHz
clock frequency for eMMC and SD controllers.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 8 ++++++++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts    | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
index dd7148060c4a..2d83617dc436 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -13,3 +13,11 @@
 };
 
 /delete-node/ &sdc;
+
+&emmc_controller {
+	max-tap-delay = <706>;
+};
+
+&emmc {
+	clk-phase-mmc-hs200 = <0 13>, <1 103>;
+};
diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 4551dba499c2..f728b9d9b4cf 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -143,13 +143,15 @@
 
 &emmc_controller {
 	status = "okay";
+	/* Measured value with *handwave* environmentals and static loading */
+	max-tap-delay = <736>;
 };
 
 &emmc {
 	non-removable;
 	bus-width = <4>;
 	max-frequency = <100000000>;
-	clk-phase-mmc-hs200 = <9>, <225>;
+	clk-phase-mmc-hs200 = <0 27>, <1 95>;
 };
 
 &rtc {
@@ -260,6 +262,7 @@
 
 &sdc {
 	status = "okay";
+	max-tap-delay = <9000>;
 };
 
 /*
@@ -287,7 +290,7 @@
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci0>;
 	vqmmc-supply = <&vccq_sdhci0>;
-	clk-phase-sd-hs = <7>, <200>;
+	clk-phase-uhs-sdr50 = <0 130>, <0 238>;
 };
 
 &sdhci1 {
@@ -300,5 +303,5 @@
 	sdhci,wp-inverted;
 	vmmc-supply = <&vcc_sdhci1>;
 	vqmmc-supply = <&vccq_sdhci1>;
-	clk-phase-sd-hs = <7>, <200>;
+	clk-phase-uhs-sdr50 = <0 130>, <0 130>;
 };
-- 
2.17.1

