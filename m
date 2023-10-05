From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Oct 2023 10:55:22 +0700
Subject: [PATCH 4/7] ARM: dts: aspeed: mtmitchell: Add LEDs
In-Reply-To: <20231005035525.19036-1-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com>
Message-ID: <20231005035525.19036-5-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use gpio-leds to configure GPIOW5 to GPIO_ACTIVE_HIGH and
GPIO_TRANSITORY flags as a bmc ready led. The GPIOW5 pin
is reset when watchdog timeout occurs.

Configure the GPIOS3 to GPIO_ACTIVE_HIGH as an identify led.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index b7c4f7cfad07..88693c2b2dbe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -51,6 +51,19 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		bmc-ready {
+			gpios = <&gpio0 ASPEED_GPIO(W, 5) (GPIO_ACTIVE_HIGH |
+			 GPIO_TRANSITORY)>;
+		};
+
+		identify {
+			gpios = <&gpio0 ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	voltage_mon_reg: voltage-mon-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "ltc2497_reg";
-- 
2.17.1

