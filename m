From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue,  6 Aug 2024 07:18:04 +0000
Subject: [PATCH v2 3/5] ARM: dts: aspeed: mtmitchell: Add Riser cards
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Message-ID: <20240806071806.1666550-4-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Define the I2C alias ports for the riser cards.

Add the i2c muxes to switch to the i2c alias ports and
the eeprom nodes to read the FRU contents on riser cards.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
 - Add eeprom nodes to the riser cards and update commit message  [Chanh]
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 1679911e4fd8..4d2f6e5348ce 100644
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
@@ -551,6 +563,58 @@ ocpslot_1_temp: temperature-sensor at 1f {
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
+
+					eeprom at 50 {
+						compatible = "atmel,24c02";
+						reg = <0x50>;
+						pagesize = <16>;
+					};
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
+
+					eeprom at 50 {
+						compatible = "atmel,24c02";
+						reg = <0x50>;
+						pagesize = <16>;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.43.0

