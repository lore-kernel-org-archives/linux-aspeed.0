From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:45:01 +0930
Subject: [PATCH 1/3] ARM: dts: aspeed: Describe SD controller in DTSIs
In-Reply-To: <20190710141503.21026-1-andrew@aj.id.au>
References: <20190710141503.21026-1-andrew@aj.id.au>
Message-ID: <20190710141503.21026-2-andrew@aj.id.au>
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
 arch/arm/boot/dts/aspeed-g4.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 30 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5d7050d00874..4bfda5d91dbe 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -188,6 +188,36 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			sdc: sdc at 1e740000 {
+				compatible = "aspeed,ast2400-sdc";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci at 1e740100 {
+					compatible = "aspeed,ast2400-sdhci", "sdhci";
+					reg = <0x1e740100 0x100>;
+					aspeed,sdhci-slot = <0>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci at 1e740200 {
+					compatible = "aspeed,ast2400-sdhci", "sdhci";
+					reg = <0x1e740200 0x100>;
+					aspeed,sdhci-slot = <1>;
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
index 4345c3153ca7..8d6404311652 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,36 @@
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
 
+			sdc: sdc at 1e740000 {
+				compatible = "aspeed,ast2500-sdc";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci at 1e740100 {
+					compatible = "aspeed,ast2500-sdhci", "sdhci";
+					reg = <0x1e740100 0x100>;
+					slot = <0>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci at 1e740200 {
+					compatible = "aspeed,ast2500-sdhci", "sdhci";
+					reg = <0x1e740200 0x100>;
+					slot = <1>;
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

