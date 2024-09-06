From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri,  6 Sep 2024 17:24:37 +0800
Subject: [PATCH v16 3/3] ARM: dts: aspeed: yosemite4: add fan led config
In-Reply-To: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240906092438.1047225-4-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Set fan led config in yosemite4 DTS so that BMC could set different
color LED according to the status of the Fan.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 177 +++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9ddeccf650cd..6d64d87bf144 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/leds/leds-pca955x.h>
 #include <dt-bindings/i2c/i2c.h>
 
@@ -57,6 +58,178 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan0-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan0-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan1-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan1-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan2-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan2-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan3-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan3-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan4-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan4-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan5-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan5-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan6-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan6-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan7-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan7-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan8-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan8-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan9-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan9-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan10-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan10-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan11-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan11-amber {
+			color = <LED_COLOR_ID_AMBER>;
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart1 {
@@ -822,7 +995,7 @@ eeprom at 52 {
 				reg = <0x52>;
 			};
 
-			gpio at 61 {
+			led_gpio1: gpio at 61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -874,7 +1047,7 @@ eeprom at 52 {
 				reg = <0x52>;
 			};
 
-			gpio at 61 {
+			led_gpio0: gpio at 61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1

