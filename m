From: Mark Walton <mark.walton@serialtek.com>
Date: Fri, 14 Dec 2018 12:07:07 +0000
Subject: [PATCH] ARM: dts: aspeed: Add #interrupt-cells property to gpio
 controllers
Message-ID: <20181214120423.3363-1-mark.walton@serialtek.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Allows the GPIO controller to be used as an interrupt parent.

of_irq_find_parent() skips interrupt controller nodes that do
not have the #interrupt-cells property.

Signed-off-by: Mark Walton <mark.walton@serialtek.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 69f6b9d2e7e7..9549f867aa1e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -197,6 +197,7 @@
 				gpio-ranges = <&pinctrl 0 0 220>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			timer: timer at 1e782000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..a1999f3fe330 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -250,6 +250,7 @@
 				gpio-ranges = <&pinctrl 0 0 220>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			timer: timer at 1e782000 {
-- 
2.20.0

