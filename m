From: Brandon Wyman <bjwyman@gmail.com>
Date: Wed, 23 Jun 2021 23:04:01 +0000
Subject: [PATCH] ARM: dts: aspeed: Rainier remove PSU gpio-keys
Message-ID: <20210623230401.3050076-1-bjwyman@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: "B. J. Wyman" <bjwyman@gmail.com>

Remove the gpio-keys entries for the power supply presence lines from
the Rainier device tree. The user space applications are going to change
from using libevdev to libgpiod.

Signed-off-by: B. J. Wyman <bjwyman@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 28 --------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 941c0489479a..d6ed583cfb1b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -116,34 +116,6 @@ vga_memory: region at bf000000 {
 		};
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		ps0-presence {
-			label = "ps0-presence";
-			gpios = <&gpio0 ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(S, 0)>;
-		};
-
-		ps1-presence {
-			label = "ps1-presence";
-			gpios = <&gpio0 ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(S, 1)>;
-		};
-
-		ps2-presence {
-			label = "ps2-presence";
-			gpios = <&gpio0 ASPEED_GPIO(S, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(S, 2)>;
-		};
-
-		ps3-presence {
-			label = "ps3-presence";
-			gpios = <&gpio0 ASPEED_GPIO(S, 3) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(S, 3)>;
-		};
-	};
-
 	i2c2mux: i2cmux {
 		compatible = "i2c-mux-gpio";
 		#address-cells = <1>;
-- 
2.25.1

