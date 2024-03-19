From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Tue, 19 Mar 2024 09:35:40 -0000
Subject: [PATCH v2 3/4] ARM: dts: aspeed: Add eSPI node
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Message-ID: <20240319093405.39833-4-manojkiran.eda@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds eSPI to the device tree for aspeed 5/6th
generation SoCs.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..eaf7d82b6f46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -343,6 +343,25 @@ sdhci1: sdhci at 200 {
 					status = "disabled";
 				};
 			};
+			espi: espi at 1e6ee000 {
+				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl at 0 {
+					compatible = "aspeed,ast2500-espi-ctrl";
+					reg = <0x0 0x800>,<0x0 0x4000000>;
+					reg-names = "espi_ctrl","espi_flash";
+					interrupts = <23>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_espi_default>;
+				};
+			};
 
 			gpio: gpio at 1e780000 {
 				#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c4d1faade8be..094e14442101 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -454,6 +454,26 @@ video: video at 1e700000 {
 				status = "disabled";
 			};
 
+			espi: espi at 1e6ee000 {
+				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl at 0 {
+					compatible = "aspeed,ast2500-espi-ctrl";
+					reg = <0x0 0x800>,<0x0 0x4000000>;
+					reg-names = "espi_ctrl","espi_flash";
+					interrupts = <23>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_espi_default>;
+				};
+			};
+
 			gpio0: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.40.1

