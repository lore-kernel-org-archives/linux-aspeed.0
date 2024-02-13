From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 19:35:19 -0000
Subject: [PATCH 3/6] arm64: dts: Fix dtc interrupt_provider warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The dtc interrupt_provider warning is off by default. Fix all the warnings
so it can be enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi           | 1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi           | 1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                  | 1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi                  | 1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi       | 1 -
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts        | 1 +
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi            | 4 ++++
 9 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index dccbba6e7f98..dbf2dce8d1d6 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -145,7 +145,6 @@ pci at fbc00000 {
 		msix: msix at fbe00000 {
 			compatible = "al,alpine-msix";
 			reg = <0x0 0xfbe00000 0x0 0x100000>;
-			interrupt-controller;
 			msi-controller;
 			al,msi-base-spi = <160>;
 			al,msi-num-spis = <160>;
diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
index 39481d7fd7d4..3ea178acdddf 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -355,7 +355,6 @@ pcie at fbd00000 {
 		msix: msix at fbe00000 {
 			compatible = "al,alpine-msix";
 			reg = <0x0 0xfbe00000 0x0 0x100000>;
-			interrupt-controller;
 			msi-controller;
 			al,msi-base-spi = <336>;
 			al,msi-num-spis = <959>;
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 9dcd25ec2c04..896d1f33b5b6 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -586,6 +586,7 @@ gpio_g: gpio at 660a0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index f049687d6b96..d8516ec0dae7 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -450,6 +450,7 @@ gpio_hsls: gpio at d0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-ranges = <&pinmux 0 0 16>,
 					<&pinmux 16 71 2>,
diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 48ec4ebec0a8..b864ffa74ea8 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -126,7 +126,6 @@ eth0: ethernet at c1b00000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 3869460aa5dc..996fb39bb50c 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -126,7 +126,6 @@ eth0: ethernet at c3700000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 2c920e22cec2..7ec7c789d87e 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -138,7 +138,6 @@ pmu {
 
 			odmi: odmi at 300000 {
 				compatible = "marvell,odmi-controller";
-				interrupt-controller;
 				msi-controller;
 				marvell,odmi-frames = <4>;
 				reg = <0x300000 0x4000>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 69c7f3954ae5..4127cb84eba4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -128,6 +128,7 @@ mt6360: pmic at 34 {
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-names = "IRQB";
 
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 3885ef3454ff..50de17e4fb3f 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -234,6 +234,7 @@ gpio_exp_74: gpio at 74 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
@@ -294,6 +295,7 @@ gpio_exp_75: gpio at 75 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -314,6 +316,7 @@ gpio_exp_76: gpio at 76 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -324,6 +327,7 @@ gpio_exp_77: gpio at 77 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 	};

-- 
2.43.0

