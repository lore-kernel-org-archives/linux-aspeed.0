From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:22 +0100
Subject: [PATCH 07/11] arm64: dts: freescale: Fix pca954x i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <3755a821121c472c9a9fd26a735c87ebb79484a5.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: pca9547 at 77: $nodename:0: 'pca9547 at 77' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: pca9547 at 77: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 4' were unexpected)
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi   | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi   | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts        | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index 5a8d85a7d1612d44..bbdf989058ff7795 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -110,7 +110,7 @@ &esdhc1 {
 &i2c0 {
 	status = "okay";
 
-	pca9547 at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 9b726c2a4842671a..dda27ed7aaf2b15c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -89,7 +89,7 @@ fpga: board-control at 2,0 {
 &i2c0 {
 	status = "okay";
 
-	pca9547 at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index b2fcbba60d3accdf..3b0ed9305f2bd455 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -88,7 +88,7 @@ &duart1 {
 &i2c0 {
 	status = "okay";
 
-	pca9547 at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 41d8b15f25a540ba..aa52ff73ff9e0272 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -53,7 +53,7 @@ flash at 2 {
 &i2c0 {
 	status = "okay";
 
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 1bfbce69cc8b77bb..ee8e932628d17f19 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -136,7 +136,7 @@ mdio2_aquantia_phy: ethernet-phy at 0 {
 &i2c0 {
 	status = "okay";
 
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index ef6c8967533efa45..d4867d6cf47cdc79 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -245,7 +245,7 @@ rx8035: rtc at 32 {
 &i2c3 {
 	status = "okay";
 
-	i2c-switch at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9540";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index f598669e742fc940..52c5a43b30a0fb22 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -103,7 +103,7 @@ mdio0_phy15: mdio-phy3 at 1f {
 
 &i2c0 {
 	status = "okay";
-	pca9547 at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 3d9647b3da147314..537cecb13dd08a0f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -44,7 +44,7 @@ cpld at 3,0 {
 
 &i2c0 {
 	status = "okay";
-	pca9547 at 75 {
+	i2c-mux at 75 {
 		compatible = "nxp,pca9547";
 		reg = <0x75>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index afb455210bd07ed6..d32a52ab00a42a28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -54,7 +54,7 @@ &esdhc1 {
 &i2c0 {
 	status = "okay";
 
-	i2c-switch at 77 {
+	i2c-mux at 77 {
 		compatible = "nxp,pca9547";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 74c09891600f2525..6357078185eddb44 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -214,7 +214,7 @@ &i2c3 {
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	i2cmux at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9540";
 		reg = <0x70>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 9dda2a1554c32848..8614c18b5998c242 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -133,7 +133,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	i2cmux at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9546";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c1_pca9546>;
@@ -216,7 +216,7 @@ &i2c4 {
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
 
-	pca9546: i2cmux at 70 {
+	pca9546: i2c-mux at 70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 07d8dd8160f68169..afa883389456ce77 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -61,7 +61,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_lpi2c1 &pinctrl_ioexp_rst>;
 	status = "okay";
 
-	i2c-switch at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9646", "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.25.1

