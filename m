From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:26 +0800
Subject: [PATCH 08/17] ARM: dts: aspeed: minerva: Define the LEDs node name
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-9-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Define the LEDs node name.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index a80c46c1962d..bea389d1e90b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -46,11 +46,35 @@ iio-hwmon {
 	leds {
 		compatible = "gpio-leds";
 
-		led-fan-fault {
-			label = "led-fan-fault";
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			label = "fan_status_led";
 			gpios = <&leds_gpio 9 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
+
+		led-4 {
+			label = "fan_fault_led_n";
+			gpios = <&leds_gpio 10 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 	};
 
 	spi_gpio: spi-gpio {
-- 
2.34.1

