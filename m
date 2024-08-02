From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:22 +0930
Subject: [PATCH 5/7] ARM: dts: aspeed: Clean up AST2500 pinctrl properties
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-5-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Many platforms were specifying the `aspeed,external-nodes` property
required by the AST2500 pinctrl. However, its been specified in the
pinctrl node directly in aspeed-g5.dtsi for quite a long time now.

Remove the unnecessary override from all relevant platform dts files.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts           | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts          | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts           | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts             | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts              | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts             | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts               | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts               | 2 --
 arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts       | 4 ----
 13 files changed, 50 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
index 8ab5f301f926..e77f8192902d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
@@ -672,10 +672,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
index 7c6af7f226e7..29c68c37e7f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -200,10 +200,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_c7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 8dee4faa9e07..0943e0bf1305 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -254,10 +254,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &vhub {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
index 0dea014e4f30..78a5656ef75d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
@@ -814,10 +814,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
index 5a98a19f445e..7a78c34cff40 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
@@ -123,10 +123,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
index d5b7d28cda88..da55e7b29fac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
@@ -118,10 +118,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
index c0847636f20b..370738572a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
@@ -263,10 +263,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_b0 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
index ac0d666ca10e..b1d0ff85d397 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
@@ -284,10 +284,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &ibt {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
index 893e621ecab1..24df24ad9c80 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
@@ -289,10 +289,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
index bbf864f84d37..a0e8c97e944a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
@@ -938,10 +938,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index 7820bc829dff..8b1e82c8cdfe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -661,10 +661,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
index 3d2d8db73ca6..9904f0a58cfa 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
@@ -466,8 +466,6 @@ &i2c13 {
 };
 
 &pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-
 	pinctrl_gpioh_unbiased: gpioi_unbiased {
 		pins = "A8", "C7", "B7", "A7", "D7", "B6", "A6", "E7";
 		bias-disable;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
index 50f3c6a5c0c8..b961dff388d1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
@@ -123,10 +123,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";

-- 
2.39.2

