From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  1 Aug 2024 09:12:11 +0000
Subject: [PATCH 1/6] ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
In-Reply-To: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
References: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
Message-ID: <20240801091217.1408809-2-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Define I2C alias ports from I2C Switch 0x70 at BMC I2C5.

Add the tmp421 sensors via the I2C alias ports as OCP device
temperature sensors.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 16 +++++++++++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 28 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
index 8ab5f301f926..8102f41d1d15 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
@@ -49,6 +49,11 @@ aliases {
 		 */
 		i2c80 = &nvme_m2_0;
 		i2c81 = &nvme_m2_1;
+
+		/*
+		 *  i2c bus 82 assigned to OCP slot
+		 */
+		i2c82 = &ocpslot;
 	};
 
 	chosen {
@@ -420,6 +425,17 @@ i2c-mux at 70 {
 		reg = <0x70>;
 		i2c-mux-idle-disconnect;
 
+		ocpslot: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			ocpslot_temp: temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
 		nvmeslot_0_7: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 3c8925034a8c..3a97e88278d5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -15,6 +15,12 @@ aliases {
 		serial7 = &uart8;
 		serial8 = &uart9;
 
+		/*
+		 *  i2c bus 30-31 assigned to OCP slot 0-1
+		 */
+		i2c30 = &ocpslot_0;
+		i2c31 = &ocpslot_1;
+
 		/*
 		 *  I2C NVMe alias port
 		 */
@@ -515,6 +521,28 @@ i2c-mux at 70 {
 		#size-cells = <0>;
 		reg = <0x70>;
 		i2c-mux-idle-disconnect;
+
+		ocpslot_0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			ocpslot_0_temp: temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		ocpslot_1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			ocpslot_1_temp: temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.43.0

