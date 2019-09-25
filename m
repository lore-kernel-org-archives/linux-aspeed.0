From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 25 Sep 2019 15:22:16 -0400
Subject: [v2, 1/2] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569439337-10482-1-git-send-email-hongweiz@ami.com>
References: <1569439337-10482-1-git-send-email-hongweiz@ami.com>
Message-ID: <1569439337-10482-2-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add SGPIO driver support for Aspeed AST2500 SoC.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 arch/arm/Kconfig                 |  2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 16 +++++++++++++++-

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2436021..c9f08ab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1460,6 +1460,8 @@ config ARCH_NR_GPIO
 	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
+	default 312 if MACH_ASPEED_G5
+	default 304 if MACH_ASPEED_G4
 	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
 	default 0
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 00f05bd..85da7ea 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -311,7 +311,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				compatible = "aspeed,ast2500-gpio";
-				reg = <0x1e780000 0x1000>;
+				reg = <0x1e780000 0x200>;
 				interrupts = <20>;
 				gpio-ranges = <&pinctrl 0 0 232>;
 				clocks = <&syscon ASPEED_CLK_APB>;
@@ -319,6 +319,20 @@
 				#interrupt-cells = <2>;
 			};
 
+			sgpio: sgpio at 1e780200 {
+				#gpio-cells = <2>;
+				compatible = "aspeed,ast2500-sgpio";
+				gpio-controller;
+				interrupts = <40>;
+				reg = <0x1e780200 0x0100>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				interrupt-controller;
+				ngpios = <8>;
+				bus-frequency = <12000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm_default>;
+			};
+
 			rtc: rtc at 1e781000 {
 				compatible = "aspeed,ast2500-rtc";
 				reg = <0x1e781000 0x18>;
-- 
2.7.4

