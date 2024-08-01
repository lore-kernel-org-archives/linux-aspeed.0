From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  1 Aug 2024 09:12:13 +0000
Subject: [PATCH 3/6] ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
In-Reply-To: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
References: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
Message-ID: <20240801091217.1408809-4-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Define the I2C alias ports for the riser cards.

Besides that, it also adds the i2c muxes to switch to the i2c alias
ports.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 1679911e4fd8..0703b77e438b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -29,6 +29,18 @@ aliases {
 		i2c30 = &ocpslot_0;
 		i2c31 = &ocpslot_1;
 
+		/*
+		 *  i2c bus 32-33 assigned to Riser slot 0-1
+		 */
+		i2c32 = &i2c_riser0;
+		i2c33 = &i2c_riser1;
+
+		/*
+		 *  i2c bus 38-39 assigned to FRU on Riser slot 0-1
+		 */
+		i2c38 = &i2c_riser0_chn_0;
+		i2c39 = &i2c_riser1_chn_0;
+
 		/*
 		 *  I2C NVMe alias port
 		 */
@@ -551,6 +563,46 @@ ocpslot_1_temp: temperature-sensor at 1f {
 				reg = <0x1f>;
 			};
 		};
+
+		i2c_riser0: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			i2c-mux at 72 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				i2c_riser0_chn_0: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+			};
+		};
+
+		i2c_riser1: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			i2c-mux at 72 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				i2c_riser1_chn_0: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.43.0

