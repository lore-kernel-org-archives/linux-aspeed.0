From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 16 Feb 2021 10:27:33 -0800
Subject: [PATCH v3 2/4] ARM: dts: aspeed: modify I2C node to support buffer
 mode
In-Reply-To: <20210216182735.11639-1-jae.hyun.yoo@linux.intel.com>
References: <20210216182735.11639-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20210216182735.11639-3-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This driver uses byte mode that makes lots of interrupt calls
so it's not good for performance. Also, it makes the driver very
timing sensitive. To improve performance of the driver, this commit
modifies I2C node to support buffer mode which uses I2C SRAM buffer
instead of using a single byte buffer.

AST2400:
It has 2 KBytes (256 Bytes x 8 pages) of I2C SRAM buffer pool from
0x1e78a800 to 0x1e78afff that can be used for all busses with
buffer pool manipulation. To simplify implementation for supporting
both AST2400 and AST2500, it assigns each 128 Bytes per bus without
using buffer pool manipulation so total 1792 Bytes of I2C SRAM
buffer will be used.

AST2500:
It has 16 Bytes of individual I2C SRAM buffer per each bus and its
range is from 0x1e78a200 to 0x1e78a2df, so it doesn't have 'buffer
page selection' bit field in the Function control register, and
neither 'base address pointer' bit field in the Pool buffer control
register it has. To simplify implementation for supporting both
AST2400 and AST2500, it writes zeros on those register bit fields
but it's okay because it does nothing in AST2500.

AST2600:
It has 32 Bytes of individual I2C SRAM buffer per each bus and its
range is from 0x1e78ac00 to 0x1e78adff. Works just like AST2500
does.

See Documentation/devicetree/bindings/i2c/i2c-aspeed.txt for
enabling buffer mode details.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: C?dric Le Goater <clg@kaod.org>
---
Changes since v2:
- Added SRAM resources back to default dtsi.

Changes since v1:
- Updated commit message.
- Removed buffer reg settings to keep the default transfer mode as byte mode.

 arch/arm/boot/dts/aspeed-g4.dtsi | 47 +++++++++++++++++++-------------
 arch/arm/boot/dts/aspeed-g5.dtsi | 47 +++++++++++++++++++-------------
 arch/arm/boot/dts/aspeed-g6.dtsi | 32 +++++++++++-----------
 3 files changed, 72 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b3dafbc8caca..cfa40dc66a5f 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -442,12 +442,21 @@
 };
 
 &i2c {
-	i2c_ic: interrupt-controller at 0 {
-		#interrupt-cells = <1>;
-		compatible = "aspeed,ast2400-i2c-ic";
+	i2c_gr: i2c-global-regs at 0 {
+		compatible = "aspeed,ast2400-i2c-gr", "syscon";
 		reg = <0x0 0x40>;
-		interrupts = <12>;
-		interrupt-controller;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x40>;
+
+		i2c_ic: interrupt-controller at 0 {
+			#interrupt-cells = <1>;
+			compatible = "aspeed,ast2400-i2c-ic";
+			reg = <0x0 0x4>;
+			interrupts = <12>;
+			interrupt-controller;
+		};
 	};
 
 	i2c0: i2c-bus at 40 {
@@ -455,7 +464,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x40 0x40>;
+		reg = <0x40 0x40>, <0x800 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -471,7 +480,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x80 0x40>;
+		reg = <0x80 0x40>, <0x880 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -487,7 +496,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0xc0 0x40>;
+		reg = <0xc0 0x40>, <0x900 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -504,7 +513,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x100 0x40>;
+		reg = <0x100 0x40>, <0x980 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -521,7 +530,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x140 0x40>;
+		reg = <0x140 0x40>, <0xa00 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -538,7 +547,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x180 0x40>;
+		reg = <0x180 0x40>, <0xa80 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -555,7 +564,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x1c0 0x40>;
+		reg = <0x1c0 0x40>, <0xb00 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -572,7 +581,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x300 0x40>;
+		reg = <0x300 0x40>, <0xb80 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -589,7 +598,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x340 0x40>;
+		reg = <0x340 0x40>, <0xc00 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -606,7 +615,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x380 0x40>;
+		reg = <0x380 0x40>, <0xc80 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -623,7 +632,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x3c0 0x40>;
+		reg = <0x3c0 0x40>, <0xd00 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -640,7 +649,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x400 0x40>;
+		reg = <0x400 0x40>, <0xd80 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -657,7 +666,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x440 0x40>;
+		reg = <0x440 0x40>, <0xe00 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -674,7 +683,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x480 0x40>;
+		reg = <0x480 0x40>, <0xe80 0x80>;
 		compatible = "aspeed,ast2400-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5bc0de0f3365..f2ab94ed6878 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -565,12 +565,21 @@
 };
 
 &i2c {
-	i2c_ic: interrupt-controller at 0 {
-		#interrupt-cells = <1>;
-		compatible = "aspeed,ast2500-i2c-ic";
+	i2c_gr: i2c-global-regs at 0 {
+		compatible = "aspeed,ast2500-i2c-gr", "syscon";
 		reg = <0x0 0x40>;
-		interrupts = <12>;
-		interrupt-controller;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x40>;
+
+		i2c_ic: interrupt-controller at 0 {
+			#interrupt-cells = <1>;
+			compatible = "aspeed,ast2500-i2c-ic";
+			reg = <0x0 0x4>;
+			interrupts = <12>;
+			interrupt-controller;
+		};
 	};
 
 	i2c0: i2c-bus at 40 {
@@ -578,7 +587,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x40 0x40>;
+		reg = <0x40 0x40>, <0x200 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -594,7 +603,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x80 0x40>;
+		reg = <0x80 0x40>, <0x210 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -610,7 +619,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0xc0 0x40>;
+		reg = <0xc0 0x40>, <0x220 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -627,7 +636,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x100 0x40>;
+		reg = <0x100 0x40>, <0x230 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -644,7 +653,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x140 0x40>;
+		reg = <0x140 0x40>, <0x240 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -661,7 +670,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x180 0x40>;
+		reg = <0x180 0x40>, <0x250 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -678,7 +687,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x1c0 0x40>;
+		reg = <0x1c0 0x40>, <0x260 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -695,7 +704,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x300 0x40>;
+		reg = <0x300 0x40>, <0x270 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -712,7 +721,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x340 0x40>;
+		reg = <0x340 0x40>, <0x280 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -729,7 +738,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x380 0x40>;
+		reg = <0x380 0x40>, <0x290 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -746,7 +755,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x3c0 0x40>;
+		reg = <0x3c0 0x40>, <0x2a0 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -763,7 +772,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x400 0x40>;
+		reg = <0x400 0x40>, <0x2b0 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -780,7 +789,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x440 0x40>;
+		reg = <0x440 0x40>, <0x2c0 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -797,7 +806,7 @@
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
 
-		reg = <0x480 0x40>;
+		reg = <0x480 0x40>, <0x2d0 0x10>;
 		compatible = "aspeed,ast2500-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB>;
 		resets = <&syscon ASPEED_RESET_I2C>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 810b0676ab03..2bec3abc6ac9 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -694,7 +694,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x80 0x80>;
+		reg = <0x80 0x80>, <0xc00 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -709,7 +709,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x100 0x80>;
+		reg = <0x100 0x80>, <0xc20 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -724,7 +724,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x180 0x80>;
+		reg = <0x180 0x80>, <0xc40 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -739,7 +739,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x200 0x80>;
+		reg = <0x200 0x80>, <0xc60 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -754,7 +754,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x280 0x80>;
+		reg = <0x280 0x80>, <0xc80 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -769,7 +769,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x300 0x80>;
+		reg = <0x300 0x80>, <0xca0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -784,7 +784,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x380 0x80>;
+		reg = <0x380 0x80>, <0xcc0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -799,7 +799,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x400 0x80>;
+		reg = <0x400 0x80>, <0xce0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -814,7 +814,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x480 0x80>;
+		reg = <0x480 0x80>, <0xd00 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -829,7 +829,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x500 0x80>;
+		reg = <0x500 0x80>, <0xd20 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -844,7 +844,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x580 0x80>;
+		reg = <0x580 0x80>, <0xd40 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -859,7 +859,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x600 0x80>;
+		reg = <0x600 0x80>, <0xd60 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -874,7 +874,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x680 0x80>;
+		reg = <0x680 0x80>, <0xd80 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -889,7 +889,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x700 0x80>;
+		reg = <0x700 0x80>, <0xda0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -904,7 +904,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x780 0x80>;
+		reg = <0x780 0x80>, <0xdc0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
@@ -919,7 +919,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interrupt-cells = <1>;
-		reg = <0x800 0x80>;
+		reg = <0x800 0x80>, <0xde0 0x20>;
 		compatible = "aspeed,ast2600-i2c-bus";
 		clocks = <&syscon ASPEED_CLK_APB2>;
 		resets = <&syscon ASPEED_RESET_I2C>;
-- 
2.17.1

