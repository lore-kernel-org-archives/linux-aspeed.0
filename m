From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:26 +0100
Subject: [PATCH 11/11] powerpc: dts: fsl: Fix pca954x i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <6c5d86c49ac170e9d56ab121ea0602f3873849ca.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb: pca9546 at 77: $nodename:0: 'pca9546 at 77' does not match '^(i2c-?)?mux'
           From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/powerpc/boot/dts/fsl/t1024qds.dtb: pca9547 at 77: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 2', 'i2c at 3' were unexpected)
           From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming pca954x nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/boot/dts/fsl/t1024qds.dts  | 2 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts  | 2 +-
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1024qds.dts b/arch/powerpc/boot/dts/fsl/t1024qds.dts
index d6858b7cd93fb5d5..9ea7942f914e14ee 100644
--- a/arch/powerpc/boot/dts/fsl/t1024qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024qds.dts
@@ -151,7 +151,7 @@ slic at 3 {
 		};
 
 		i2c at 118000 {
-			pca9547 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9547";
 				reg = <0x77>;
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index dbcd31cc35dcd2bb..270aaf631f2ab0fa 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -165,7 +165,7 @@ rtc at 68 {
 		};
 
 		i2c at 118100 {
-			pca9546 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9546";
 				reg = <0x77>;
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
index 615479732252404f..1c329f076f64f2dc 100644
--- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
@@ -268,7 +268,7 @@ flash at 0 {
 		};
 
 		i2c at 118000 {
-			pca9547 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9547";
 				reg = <0x77>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index bfe1ed5be337492e..fc7bec5dcb90fc2d 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -128,7 +128,7 @@ adt7461 at 4c {
 		};
 
 		i2c at 118100 {
-			pca9546 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9546";
 				reg = <0x77>;
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
index db4139999b28ebf4..962c99941645b965 100644
--- a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
@@ -135,7 +135,7 @@ flash at 2 {
 		};
 
 		i2c at 118000 {
-			pca9547 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9547";
 				reg = <0x77>;
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
index ff87e67c70da4a29..ecc3e8c7394cad20 100644
--- a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
@@ -138,7 +138,7 @@ eeprom at 50 {
 		};
 
 		i2c at 118100 {
-			pca9546 at 77 {
+			i2c-mux at 77 {
 				compatible = "nxp,pca9546";
 				reg = <0x77>;
 			};
-- 
2.25.1

