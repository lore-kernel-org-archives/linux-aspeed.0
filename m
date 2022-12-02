From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:19 +0100
Subject: [PATCH 04/11] ARM: dts: nuvoton: Fix pca954x i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <9b10ee878f8c54d9d26a92749108304d47f4dbbf.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm/boot/dts/nuvoton-npcm730-gbs.dtb: i2c-switch at 71: $nodename:0: 'i2c-switch at 71' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts        | 16 ++++++++--------
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts        |  2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts       |  8 ++++----
 .../boot/dts/nuvoton-npcm750-runbmc-olympus.dts  |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
index 9e9eba8bad5e424a..9f64c85e1c206494 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
@@ -525,7 +525,7 @@ &i2c0 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -666,7 +666,7 @@ mb_fru at 50 {
 		reg = <0x50>;
 	};
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -727,7 +727,7 @@ &i2c6 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 73 {
+	i2c-mux at 73 {
 		compatible = "nxp,pca9545";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -763,7 +763,7 @@ &i2c7 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 72 {
+	i2c-mux at 72 {
 		compatible = "nxp,pca9545";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -812,7 +812,7 @@ &i2c9 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -866,7 +866,7 @@ &i2c10 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9545";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -902,7 +902,7 @@ &i2c11 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 76 {
+	i2c-mux at 76 {
 		compatible = "nxp,pca9545";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -961,7 +961,7 @@ &i2c14 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	i2c-switch at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9545";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
index 2a394cc15284c55d..9b1cc7f4adf0909d 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
@@ -303,7 +303,7 @@ ucd90160 at 6b {
 &i2c15 {
 	status = "okay";
 
-	i2c-switch at 75 {
+	i2c-mux at 75 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
index f7b38bee039bcab5..58329adbd9186fd7 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
@@ -494,7 +494,7 @@ &adc {
 
 &i2c1 {
 	status = "okay";
-	i2c-switch at 75 {
+	i2c-mux at 75 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -573,7 +573,7 @@ lm75 at 5c {
 			};
 		};
 	};
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -613,7 +613,7 @@ &i2c3 {
 
 &i2c4 {
 	status = "okay";
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -684,7 +684,7 @@ ssif-bmc at 10 {
 
 &i2c13 {
 	status = "okay";
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
index 87359ab05db3ebab..209fa3400317bf19 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
@@ -208,7 +208,7 @@ &gmac0 {
 &i2c1 {
 	status = "okay";
 
-	i2c-switch at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -258,7 +258,7 @@ i2c_slot5: i2c-bus at 6 {
 		};
 	};
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
-- 
2.25.1

