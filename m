From: Iwona Winiarska <iwona.winiarska@intel.com>
Date: Tue, 13 Jul 2021 00:04:38 +0200
Subject: [PATCH 05/14] ARM: dts: aspeed: Add PECI controller nodes
In-Reply-To: <20210712220447.957418-1-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
Message-ID: <20210712220447.957418-6-iwona.winiarska@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add PECI controller nodes with all required information.

Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 14 ++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..de733c03ec18 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -385,6 +385,20 @@ ibt: ibt at 140 {
 				};
 			};
 
+			peci0: peci-controller at 1e78b000 {
+				compatible = "aspeed,ast2400-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 329eaeef66fb..e7db9cf56114 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -506,6 +506,20 @@ ibt: ibt at 140 {
 				};
 			};
 
+			peci0: peci-controller at 1e78b000 {
+				compatible = "aspeed,ast2500-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..1e951bb7ff65 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -459,6 +459,20 @@ wdt4: watchdog at 1e7850c0 {
 				status = "disabled";
 			};
 
+			peci0: peci-controller at 1e78b000 {
+				compatible = "aspeed,ast2600-peci";
+				reg = <0x1e78b000 0x100>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-- 
2.31.1

