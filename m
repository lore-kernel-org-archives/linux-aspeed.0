From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Sep 2020 17:57:15 +0200
Subject: [PATCH v3 15/15] ARM: dts: imx6q: align GPIO hog names with dtschema
In-Reply-To: <20200916155715.21009-1-krzk@kernel.org>
References: <20200916155715.21009-1-krzk@kernel.org>
Message-ID: <20200916155715.21009-16-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

dtschema for pca95xx expects GPIO hogs to end with 'hog' prefix.  While
touching the hogs, fix indentation (spaces -> tabs).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6q-b450v3.dts  | 14 +++++++-------
 arch/arm/boot/dts/imx6q-b650v3.dts  | 12 ++++++------
 arch/arm/boot/dts/imx6q-b850v3.dts  |  4 ++--
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 12 ++++++------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index fb0980190aa0..604f2420370f 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -84,19 +84,19 @@
 };
 
 &pca9539 {
-	P04 {
+	P04-hog {
 		gpio-hog;
 		gpios = <4 0>;
 		output-low;
 		line-name = "PCA9539-P04";
 	};
 
-        P07 {
-                gpio-hog;
-                gpios = <7 0>;
-                output-low;
-                line-name = "PCA9539-P07";
-        };
+	P07-hog {
+		gpio-hog;
+		gpios = <7 0>;
+		output-low;
+		line-name = "PCA9539-P07";
+	};
 };
 
 &pci_root {
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 8f762d9c5ae9..56d2aeb1900c 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -84,12 +84,12 @@
 };
 
 &pca9539 {
-        P07 {
-                gpio-hog;
-                gpios = <7 0>;
-                output-low;
-                line-name = "PCA9539-P07";
-        };
+	P07-hog {
+		gpio-hog;
+		gpios = <7 0>;
+		output-low;
+		line-name = "PCA9539-P07";
+	};
 };
 
 &usbphy1 {
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 1ea64ecf4291..3d6b757bf325 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -199,14 +199,14 @@
 };
 
 &pca9539 {
-	P10 {
+	P10-hog {
 		gpio-hog;
 		gpios = <8 0>;
 		output-low;
 		line-name = "PCA9539-P10";
 	};
 
-	P11 {
+	P11-hog {
 		gpio-hog;
 		gpios = <9 0>;
 		output-low;
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 02812e6cb302..2a98cc657595 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -248,42 +248,42 @@
 				interrupt-parent = <&gpio2>;
 				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
-				P12 {
+				P12-hog {
 					gpio-hog;
 					gpios = <10 0>;
 					output-low;
 					line-name = "PCA9539-P12";
 				};
 
-				P13 {
+				P13-hog {
 					gpio-hog;
 					gpios = <11 0>;
 					output-low;
 					line-name = "PCA9539-P13";
 				};
 
-				P14 {
+				P14-hog {
 					gpio-hog;
 					gpios = <12 0>;
 					output-low;
 					line-name = "PCA9539-P14";
 				};
 
-				P15 {
+				P15-hog {
 					gpio-hog;
 					gpios = <13 0>;
 					output-low;
 					line-name = "PCA9539-P15";
 				};
 
-				P16 {
+				P16-hog {
 					gpio-hog;
 					gpios = <14 0>;
 					output-low;
 					line-name = "PCA9539-P16";
 				};
 
-				P17 {
+				P17-hog {
 					gpio-hog;
 					gpios = <15 0>;
 					output-low;
-- 
2.17.1

