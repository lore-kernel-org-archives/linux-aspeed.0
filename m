From: Steven Lee <steven_lee@aspeedtech.com>
Date: Wed, 26 May 2021 17:46:06 +0800
Subject: [PATCH v1 2/4] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <20210526094609.14068-1-steven_lee@aspeedtech.com>
References: <20210526094609.14068-1-steven_lee@aspeedtech.com>
Message-ID: <20210526094609.14068-3-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
with 80 pins.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..556ce9535c22 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -377,6 +377,38 @@
 				#interrupt-cells = <2>;
 			};
 
+			sgpiom0: sgpiom at 1e780500 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780500 0x100>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				max-ngpios = <128>;
+				ngpios = <128>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm1_default>;
+				status = "disabled";
+			};
+
+			sgpiom1: sgpiom at 1e780600 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780600 0x100>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				max-ngpios = <80>;
+				ngpios = <80>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm2_default>;
+				status = "disabled";
+			};
+
 			gpio1: gpio at 1e780800 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.17.1

