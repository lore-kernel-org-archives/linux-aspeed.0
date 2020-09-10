From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:32 +0200
Subject: [PATCH v2 14/15] ARM: dts: armada: align GPIO hog names with dtschema
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-15-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx requires GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/armada-388-clearfog.dts  |  4 ++--
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 10 +++++-----
 arch/arm/boot/dts/armada-388-helios4.dts   |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 20f8d4667753..4140a5303b48 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -73,13 +73,13 @@
 	 * 14-SFP_TX_DISABLE
 	 * 15-SFP_MOD_DEF0
 	 */
-	pcie2_0_clkreq {
+	pcie2-0-clkreq-hog {
 		gpio-hog;
 		gpios = <4 GPIO_ACTIVE_LOW>;
 		input;
 		line-name = "pcie2.0-clkreq";
 	};
-	pcie2_0_w_disable {
+	pcie2-0-w-disable-hog {
 		gpio-hog;
 		gpios = <7 GPIO_ACTIVE_LOW>;
 		output-low;
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index a0aa1d188f0c..f8a06ae4a3c9 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -141,31 +141,31 @@
 		#gpio-cells = <2>;
 		reg = <0x20>;
 
-		pcie1_0_clkreq {
+		pcie1-0-clkreq-hog {
 			gpio-hog;
 			gpios = <0 GPIO_ACTIVE_LOW>;
 			input;
 			line-name = "pcie1.0-clkreq";
 		};
-		pcie1_0_w_disable {
+		pcie1-0-w-disable-hog {
 			gpio-hog;
 			gpios = <3 GPIO_ACTIVE_LOW>;
 			output-low;
 			line-name = "pcie1.0-w-disable";
 		};
-		usb3_ilimit {
+		usb3-ilimit-hog {
 			gpio-hog;
 			gpios = <5 GPIO_ACTIVE_LOW>;
 			input;
 			line-name = "usb3-current-limit";
 		};
-		usb3_power {
+		usb3-power-hog {
 			gpio-hog;
 			gpios = <6 GPIO_ACTIVE_HIGH>;
 			output-high;
 			line-name = "usb3-power";
 		};
-		m2_devslp {
+		m2-devslp-hog {
 			gpio-hog;
 			gpios = <11 GPIO_ACTIVE_HIGH>;
 			output-low;
diff --git a/arch/arm/boot/dts/armada-388-helios4.dts b/arch/arm/boot/dts/armada-388-helios4.dts
index fb49df2a3bce..b3728de3bd3f 100644
--- a/arch/arm/boot/dts/armada-388-helios4.dts
+++ b/arch/arm/boot/dts/armada-388-helios4.dts
@@ -166,19 +166,19 @@
 					interrupt-controller;
 					#interrupt-cells = <2>;
 
-					board_rev_bit_0 {
+					board-rev-bit-0-hog {
 						gpio-hog;
 						gpios = <0 GPIO_ACTIVE_LOW>;
 						input;
 						line-name = "board-rev-0";
 					};
-					board_rev_bit_1 {
+					board-rev-bit-1-hog {
 						gpio-hog;
 						gpios = <1 GPIO_ACTIVE_LOW>;
 						input;
 						line-name = "board-rev-1";
 					};
-					usb3_ilimit {
+					usb3-ilimit-hog {
 						gpio-hog;
 						gpios = <5 GPIO_ACTIVE_HIGH>;
 						input;
-- 
2.17.1

