From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 13:07:25 +0930
Subject: [PATCH v2 1/2] ARM: dts: aspeed: Describe SD controllers
In-Reply-To: <20190712033726.25237-1-andrew@aj.id.au>
References: <20190712033726.25237-1-andrew@aj.id.au>
Message-ID: <20190712033726.25237-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2400 and AST2500 both share the same SD controller, at the same
location in the physical address space and the same hardware interrupt,
with the same clock configurations.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Rename sd-controller compatible
* Drop "sdhci" compatible
* Explicit ranges
* Remove slot property

 arch/arm/boot/dts/aspeed-g4.dtsi | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5d7050d00874..6ef2563ce372 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -188,6 +188,34 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			sdc: sdc at 1e740000 {
+				compatible = "aspeed,ast2400-sd-controller";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e740000 0x10000>;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci at 100 {
+					compatible = "aspeed,ast2400-sdhci";
+					reg = <0x100 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci at 200 {
+					compatible = "aspeed,ast2400-sdhci";
+					reg = <0x200 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+			};
+
 			gpio: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4345c3153ca7..c0e71f814fec 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,34 @@
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
 
+			sdc: sdc at 1e740000 {
+				compatible = "aspeed,ast2500-sd-controller";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e740000 0x10000>;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci at 100 {
+					compatible = "aspeed,ast2500-sdhci";
+					reg = <0x100 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci at 200 {
+					compatible = "aspeed,ast2500-sdhci";
+					reg = <0x200 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+			};
+
 			gpio: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.20.1

