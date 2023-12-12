From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:58 +0800
Subject: [PATCH 09/11] ARM: dts: aspeed: minerva: Add led-fan-fault gpio
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-10-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add led-fan-fault gpio pin on the PCA9555 on the i2c bus 0.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index c7445c819baf..090fe2f6b1d8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -39,6 +39,16 @@ iio-hwmon {
 			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 			<&adc1 2>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan-fault {
+			label = "led-fan-fault";
+			gpios = <&leds_gpio 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &uart6 {
@@ -118,6 +128,13 @@ power-monitor at 68 {
 		compatible = "adi,ltc2945";
 		reg = <0x68>;
 	};
+
+	leds_gpio: gpio at 19 {
+		compatible = "nxp,pca9555";
+		reg = <0x19>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c1 {
-- 
2.34.1

