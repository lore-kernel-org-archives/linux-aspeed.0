From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Jul 2018 13:48:47 +1000
Subject: [PATCH v3 5/5] arm: dts: OpenPower Palmetto system can use
 coprocessor for FSI
In-Reply-To: <20180712034847.12878-1-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
Message-ID: <20180712034847.12878-6-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This switches away from userspace bitbanging to kernel FSI
using the coprocessor.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index e6095f51ecf5..feec377c04d4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -31,6 +31,11 @@
 			no-map;
 			reg = <0x98000000 0x01000000>; /* 16MB */
 		};
+
+		coldfire_memory: codefire_memory at 5ee00000 {
+			reg = <0x5ee00000 0x00200000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -49,6 +54,22 @@
 		};
 	};
 
+	fsi: gpio-fsi {
+		compatible = "aspeed,ast2400-cf-fsi-master", "fsi-master";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		memory-region = <&coldfire_memory>;
+		aspeed,sram = <&sram>;
+		aspeed,cvic = <&cvic>;
+
+		clock-gpios = <&gpio ASPEED_GPIO(A, 4) GPIO_ACTIVE_HIGH>;
+		data-gpios = <&gpio ASPEED_GPIO(A, 5) GPIO_ACTIVE_HIGH>;
+		mux-gpios = <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
+		trans-gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -323,13 +344,6 @@
 		line-name = "SYS_PWROK_BMC";
 	};
 
-	pin_gpio_h6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "SCM1_FSI0_DATA_EN";
-	};
-
 	pin_gpio_h7 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
-- 
2.17.1

