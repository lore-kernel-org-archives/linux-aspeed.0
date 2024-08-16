From: Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 16 Aug 2024 10:47:14 -0600
Subject: [PATCH v2] ARM: dts: Fix undocumented LM75 compatible nodes
Message-ID: <20240816164717.1585629-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"lm75" without any vendor is undocumented. It works with the Linux
kernel since the I2C subsystem will do matches of the compatible string
without a vendor prefix to the i2c_device_id and/or driver name.

Mostly replace "lm75" with "national,lm75" as that's the original part
vendor and the compatible which matches what "lm75" matched with. In a
couple of cases the node name or compatible gives a clue to the actual
part and vendor and a more specific compatible can be used. In these
cases, it does change the variant the kernel picks.

"nct75" is an OnSemi part which is compatible with TI TMP75C based on
a comparison of the OnSemi NCT75 datasheet and configuration the Linux
driver uses. Adding an OnSemi compatible would be an ABI change.

"nxp,lm75" is most likely an NXP part. Alexander Stein says the i.MX53
boards are a NXP LM75A as well. NXP makes a LM75A and LM75B. Both are
11-bit resolution and 100ms sample time. The "national,lm75a" is
9-bit, so "national,lm75b" is the closest match for both NXP variants.

While we're here, fix the node names to use the generic name
"temperature-sensor".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com> # am335x-nano.dts
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
SoC maintainers, Please take this directly for v6.12.

v2:
 - Also use "national,lm75b" on i.MX53 boards.
---
 .../aspeed/aspeed-bmc-facebook-greatlakes.dts |  2 +-
 .../socfpga/socfpga_cyclone5_vining_fpga.dts  |  4 +--
 .../dts/marvell/armada-385-clearfog-gtr.dtsi  |  8 ++---
 .../boot/dts/nuvoton/nuvoton-npcm730-kudo.dts | 32 +++++++++----------
 .../boot/dts/nuvoton/nuvoton-npcm750-evb.dts  |  6 ++--
 arch/arm/boot/dts/nxp/imx/imx53-mba53.dts     |  4 +--
 arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi   |  4 +--
 .../dts/nxp/lpc/lpc4357-ea4357-devkit.dts     |  4 +--
 .../boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts  |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  2 +-
 .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  4 +--
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 998598c15fd0..49914a4a179f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -201,7 +201,7 @@ eeprom at 54 {
 &i2c12 {
 	status = "okay";
 	temperature-sensor at 4f {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x4f>;
 	};
 };
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
index 65f390bf8975..84f39dec3c42 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
@@ -130,8 +130,8 @@ gpio: pca9557 at 1f {
 		#gpio-cells = <2>;
 	};
 
-	temp: lm75 at 48 {
-		compatible = "lm75";
+	temp: temperature-sensor at 48 {
+		compatible = "national,lm75";
 		reg = <0x48>;
 	};
 
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
index f3a3cb6ac311..8208c6a9627a 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
@@ -423,14 +423,14 @@ &i2c0 {
 	status = "okay";
 
 	/* U26 temperature sensor placed near SoC */
-	temp1: nct75 at 4c {
-		compatible = "lm75";
+	temp1: temperature-sensor at 4c {
+		compatible = "ti,tmp75c";
 		reg = <0x4c>;
 	};
 
 	/* U27 temperature sensor placed near RTC battery */
-	temp2: nct75 at 4d {
-		compatible = "lm75";
+	temp2: temperature-sensor at 4d {
+		compatible = "ti,tmp75c";
 		reg = <0x4d>;
 	};
 
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
index 1f07ba382910..886a87dfcd0d 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
@@ -531,8 +531,8 @@ i2c at 4 {
 			reg = <4>;
 
 			// INLET1_T
-			lm75 at 5c {
-				compatible = "ti,lm75";
+			temperature-sensor at 5c {
+				compatible = "national,lm75";
 				reg = <0x5c>;
 			};
 		};
@@ -543,8 +543,8 @@ i2c at 5 {
 			reg = <5>;
 
 			// OUTLET1_T
-			lm75 at 5c {
-				compatible = "ti,lm75";
+			temperature-sensor at 5c {
+				compatible = "national,lm75";
 				reg = <0x5c>;
 			};
 		};
@@ -555,8 +555,8 @@ i2c at 6 {
 			reg = <6>;
 
 			// OUTLET2_T
-			lm75 at 5c {
-				compatible = "ti,lm75";
+			temperature-sensor at 5c {
+				compatible = "national,lm75";
 				reg = <0x5c>;
 			};
 		};
@@ -567,8 +567,8 @@ i2c at 7 {
 			reg = <7>;
 
 			// OUTLET3_T
-			lm75 at 5c {
-				compatible = "ti,lm75";
+			temperature-sensor at 5c {
+				compatible = "national,lm75";
 				reg = <0x5c>;
 			};
 		};
@@ -697,8 +697,8 @@ i2c at 3 {
 			reg = <3>;
 
 			// M2_ZONE_T
-			lm75 at 28 {
-				compatible = "ti,lm75";
+			temperature-sensor at 28 {
+				compatible = "national,lm75";
 				reg = <0x28>;
 			};
 		};
@@ -709,8 +709,8 @@ i2c at 4 {
 			reg = <4>;
 
 			// BATT_ZONE_T
-			lm75 at 29 {
-				compatible = "ti,lm75";
+			temperature-sensor at 29 {
+				compatible = "national,lm75";
 				reg = <0x29>;
 			};
 		};
@@ -721,8 +721,8 @@ i2c at 5 {
 			reg = <5>;
 
 			// NBM1_ZONE_T
-			lm75 at 28 {
-				compatible = "ti,lm75";
+			temperature-sensor at 28 {
+				compatible = "national,lm75";
 				reg = <0x28>;
 			};
 		};
@@ -732,8 +732,8 @@ i2c at 6 {
 			reg = <6>;
 
 			// NBM2_ZONE_T
-			lm75 at 29 {
-				compatible = "ti,lm75";
+			temperature-sensor at 29 {
+				compatible = "national,lm75";
 				reg = <0x29>;
 			};
 		};
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts
index f53d45fa1de8..bcdcb30c7bf6 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dts
@@ -198,7 +198,7 @@ &i2c0 {
 	clock-frequency = <100000>;
 	status = "okay";
 	lm75 at 48 {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x48>;
 		status = "okay";
 	};
@@ -208,8 +208,8 @@ lm75 at 48 {
 &i2c1 {
 	clock-frequency = <100000>;
 	status = "okay";
-	lm75 at 48 {
-		compatible = "lm75";
+	temperature-sensor at 48 {
+		compatible = "national,lm75";
 		reg = <0x48>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
index 2117de872703..0d336cbdb451 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
@@ -175,8 +175,8 @@ expander: pca9554 at 20 {
 		gpio-controller;
 	};
 
-	sensor2: lm75 at 49 {
-		compatible = "lm75";
+	sensor2: temperature-sensor at 49 {
+		compatible = "national,lm75b";
 		reg = <0x49>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
index b2d7271d1d24..c34ee84bd716 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
@@ -254,8 +254,8 @@ pmic: mc34708 at 8 {
 		interrupts = <6 4>; /* PATA_DATA6, active high */
 	};
 
-	sensor1: lm75 at 48 {
-		compatible = "lm75";
+	sensor1: temperature-sensor at 48 {
+		compatible = "national,lm75b";
 		reg = <0x48>;
 	};
 
diff --git a/arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
index 224f80a4a31d..4aefbc01dfc0 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
@@ -482,8 +482,8 @@ mma7455 at 1d {
 		reg = <0x1d>;
 	};
 
-	lm75 at 48 {
-		compatible = "nxp,lm75";
+	temperature-sensor at 48 {
+		compatible = "national,lm75b";
 		reg = <0x48>;
 	};
 
diff --git a/arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts b/arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
index 1f84654df50c..846afb8ccbf1 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
+++ b/arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
@@ -511,7 +511,7 @@ &i2c1 {
 	clock-frequency = <400000>;
 
 	sensor at 49 {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x49>;
 	};
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-nano.dts b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
index 26b5510cb3d1..56929059f5af 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
@@ -231,7 +231,7 @@ tps: tps at 24 {
 	};
 
 	temperature-sensor at 48 {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x48>;
 	};
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
index dfb1fbafe3aa..33b02e05ce82 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
@@ -97,9 +97,9 @@ &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	stlm75 at 49 {
+	temperature-sensor at 49 {
 		status = "okay";
-		compatible = "lm75";
+		compatible = "st,stlm75";
 		reg = <0x49>;
 	};
 
-- 
2.43.0

