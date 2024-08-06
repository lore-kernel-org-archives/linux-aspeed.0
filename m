From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue,  6 Aug 2024 07:18:06 +0000
Subject: [PATCH v2 5/5] ARM: dts: aspeed: mtmitchell: Add LEDs
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Message-ID: <20240806071806.1666550-6-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add LED nodes as the gpio-leds devices. They are led-bmc-ready,
led-sw-heartbeat, led-identify, led-fault, led-fan-fault, led-psu-fault

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - None
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 3111f23e56dc..0295f5adcfbc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -113,6 +113,37 @@ vga_memory: region at bf000000 {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		/*
+		 * Use gpio-leds to configure GPIOW5 (bmc-ready) pin to be reseted when
+		 * watchdog timeout.
+		 */
+		led-bmc-ready {
+			gpios = <&gpio0 ASPEED_GPIO(W, 5) (GPIO_ACTIVE_HIGH | GPIO_TRANSITORY)>;
+		};
+
+		led-sw-heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-identify {
+			gpios = <&gpio0 ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fault {
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan-fault {
+			gpios = <&gpio_expander1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-psu-fault {
+			gpios = <&gpio_expander1 1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	voltage_mon_reg: voltage-mon-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "ltc2497_reg";
-- 
2.43.0

