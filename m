From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Tue,  2 Nov 2021 13:37:15 -0700
Subject: [PATCH -next v2 4/6] ARM: dts: aspeed: add LCLK setting into LPC KCS
 nodes
In-Reply-To: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
Message-ID: <20211102203717.96794-5-jae.hyun.yoo@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Add LCLK clock setting into LPC KCS nodes to enable the LCLK by
individual LPC sub drivers.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v1 -> v2:
 - No change.

 arch/arm/boot/dts/aspeed-g5.dtsi | 4 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d0cc4be2de59..7495f93c5069 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -446,6 +446,7 @@ kcs1: kcs at 24 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 					interrupts = <8>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
@@ -453,6 +454,7 @@ kcs2: kcs at 28 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 					interrupts = <8>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
@@ -460,6 +462,7 @@ kcs3: kcs at 2c {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 					interrupts = <8>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
@@ -467,6 +470,7 @@ kcs4: kcs at 114 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x114 0x1>, <0x118 0x1>, <0x11c 0x1>;
 					interrupts = <8>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 465c3549fdc3..891b862363a7 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -520,6 +520,7 @@ kcs1: kcs at 24 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					kcs_chan = <1>;
 					status = "disabled";
 				};
@@ -528,6 +529,7 @@ kcs2: kcs at 28 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
@@ -535,6 +537,7 @@ kcs3: kcs at 2c {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
@@ -542,6 +545,7 @@ kcs4: kcs at 114 {
 					compatible = "aspeed,ast2500-kcs-bmc-v2";
 					reg = <0x114 0x1>, <0x118 0x1>, <0x11c 0x1>;
 					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
 
-- 
2.25.1

