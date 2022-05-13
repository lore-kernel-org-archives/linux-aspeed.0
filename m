From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 13 May 2022 14:57:27 +0800
Subject: [PATCH 2/3] ARM: dts: aspeed: Add USB2.0 device controller node
In-Reply-To: <20220513065728.857722-1-neal_liu@aspeedtech.com>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
Message-ID: <20220513065728.857722-3-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add USB2.0 device controller(udc) node to device tree
for AST2600.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 3d5ce9da42c3..5517313eb2b5 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -298,6 +298,16 @@ vhub: usb-vhub at 1e6a0000 {
 			status = "disabled";
 		};
 
+		udc: udc at 1e6a2000 {
+			compatible = "aspeed,ast2600-udc";
+			reg = <0x1e6a2000 0x300>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2bd_default>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.25.1

