From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:27 +0800
Subject: [PATCH 09/17] ARM: dts: aspeed: minerva: Add adc sensors for fan board
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-10-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Add ina238 support to read the sensors in front of fans.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index bea389d1e90b..60beda2737a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -228,6 +228,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux17: i2c at 1 {
@@ -246,6 +270,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux18: i2c at 2 {
@@ -264,6 +312,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux19: i2c at 3 {
@@ -282,6 +354,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux20: i2c at 4 {
@@ -300,6 +396,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux21: i2c at 5 {
@@ -318,6 +438,30 @@ pwm at 5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor at 40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor at 45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 	};
 };
-- 
2.34.1

