From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:22 +0200
Subject: [PATCH v2 04/15] arm64: dts: mediatek: align GPIO hog names with
 dtschema
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-5-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx requires GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/mediatek/pumpkin-common.dtsi     | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 29d8cf6df46b..351a1905a074 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -63,91 +63,91 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		eint20_mux_sel0 {
+		eint20-mux-sel0-hog {
 			gpio-hog;
 			gpios = <0 0>;
 			input;
 			line-name = "eint20_mux_sel0";
 		};
 
-		expcon_mux_sel1 {
+		expcon-mux-sel1-hog {
 			gpio-hog;
 			gpios = <1 0>;
 			input;
 			line-name = "expcon_mux_sel1";
 		};
 
-		mrg_di_mux_sel2 {
+		mrg-di-mux-sel2-hog {
 			gpio-hog;
 			gpios = <2 0>;
 			input;
 			line-name = "mrg_di_mux_sel2";
 		};
 
-		sd_sdio_mux_sel3 {
+		sd-sdio-mux-sel3-hog {
 			gpio-hog;
 			gpios = <3 0>;
 			input;
 			line-name = "sd_sdio_mux_sel3";
 		};
 
-		sd_sdio_mux_ctrl7 {
+		sd-sdio-mux-ctrl7-hog {
 			gpio-hog;
 			gpios = <7 0>;
 			output-low;
 			line-name = "sd_sdio_mux_ctrl7";
 		};
 
-		hw_id0 {
+		hw-id0-hog {
 			gpio-hog;
 			gpios = <8 0>;
 			input;
 			line-name = "hw_id0";
 		};
 
-		hw_id1 {
+		hw-id1-hog {
 			gpio-hog;
 			gpios = <9 0>;
 			input;
 			line-name = "hw_id1";
 		};
 
-		hw_id2 {
+		hw-id2-hog {
 			gpio-hog;
 			gpios = <10 0>;
 			input;
 			line-name = "hw_id2";
 		};
 
-		fg_int_n {
+		fg-int-n-hog {
 			gpio-hog;
 			gpios = <11 0>;
 			input;
 			line-name = "fg_int_n";
 		};
 
-		usba_pwr_en {
+		usba-pwr-en-hog {
 			gpio-hog;
 			gpios = <12 0>;
 			output-high;
 			line-name = "usba_pwr_en";
 		};
 
-		wifi_3v3_pg {
+		wifi-3v3-pg-hog {
 			gpio-hog;
 			gpios = <13 0>;
 			input;
 			line-name = "wifi_3v3_pg";
 		};
 
-		cam_rst {
+		cam-rst-hog {
 			gpio-hog;
 			gpios = <14 0>;
 			output-low;
 			line-name = "cam_rst";
 		};
 
-		cam_pwdn {
+		cam-pwdn-hog {
 			gpio-hog;
 			gpios = <15 0>;
 			output-low;
-- 
2.17.1

