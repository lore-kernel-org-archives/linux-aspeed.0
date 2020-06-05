From: Ben Pai <Ben_Pai@wistron.com>
Date: Fri, 5 Jun 2020 18:06:14 +0800
Subject: [PATCH v1 1/2] ARM: dts: aspeed: mihawk: IO expander uses TCA9554
 driver
Message-ID: <20200605100614.14726-1-Ben_Pai@wistron.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set smbus_en of IO expander to 1 in order to be able to read sensor.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 112 ++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index eac6ed2bbc67..25ffe65fbdc0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -820,12 +820,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus0 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus0";
+				};
+			};
 		};
 
 		bus9_mux232: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus1 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus1";
+				};
+			};
 		};
 
 		bus9_mux233: i2c at 2 {
@@ -855,12 +883,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus2 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus2";
+				};
+			};
 		};
 
 		bus9_mux236: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus3 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus3";
+				};
+			};
 		};
 
 		bus9_mux237: i2c at 2 {
@@ -909,12 +965,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus4 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus4";
+				};
+			};
 		};
 
 		bus10_mux240: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus5 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus5";
+				};
+			};
 		};
 
 		bus10_mux241: i2c at 2 {
@@ -944,12 +1028,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus6 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus6";
+				};
+			};
 		};
 
 		bus10_mux244: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554 at 39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus7 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus7";
+				};
+			};
 		};
 
 		bus10_mux245: i2c at 2 {
-- 
2.17.1


---------------------------------------------------------------------------------------------------------------------------------------------------------------
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. 
Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
---------------------------------------------------------------------------------------------------------------------------------------------------------------
