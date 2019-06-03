From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 3 Jun 2019 18:43:09 -0400
Subject: [PATCH linux dev-5.1 v1] ARM: dts: aspeed: Add SGPM pinmux
Message-ID: <1559601789-27121-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
supporting SGPIO in AST2500 SoC.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                             | 5 +++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
index 3b7266c..8f1c5c4 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
@@ -84,7 +84,7 @@ NDCD2 NDCD3 NDCD4 NDSR1 NDSR2 NDSR3 NDSR4 NDTR1 NDTR2 NDTR3 NDTR4 NRI1 NRI2
 NRI3 NRI4 NRTS1 NRTS2 NRTS3 NRTS4 OSCCLK PEWAKE PNOR PWM0 PWM1 PWM2 PWM3 PWM4
 PWM5 PWM6 PWM7 RGMII1 RGMII2 RMII1 RMII2 RXD1 RXD2 RXD3 RXD4 SALT1 SALT10
 SALT11 SALT12 SALT13 SALT14 SALT2 SALT3 SALT4 SALT5 SALT6 SALT7 SALT8 SALT9
-SCL1 SCL2 SD1 SD2 SDA1 SDA2 SGPS1 SGPS2 SIOONCTRL SIOPBI SIOPBO SIOPWREQ
+SCL1 SCL2 SD1 SD2 SDA1 SDA2 SGPM SGPS1 SGPS2 SIOONCTRL SIOPBI SIOPBO SIOPWREQ
 SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1CS1 SPI1DEBUG SPI1PASSTHRU SPI2CK SPI2CS0
 SPI2CS1 SPI2MISO SPI2MOSI TIMER3 TIMER4 TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2
 TXD3 TXD4 UART6 USB11BHID USB2AD USB2AH USB2BD USB2BH USBCKI VGABIOSROM VGAHS
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 383510d..d10c3ea 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1394,6 +1394,11 @@
 		groups = "SDA2";
 	};
 
+	pinctrl_sgpm_default: sgpm_default {
+		function = "SGPM";
+		groups = "SGPM";
+	};
+
 	pinctrl_sgps1_default: sgps1_default {
 		function = "SGPS1";
 		groups = "SGPS1";
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 187abd7..0c89647 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -577,6 +577,8 @@ SS_PIN_DECL(N3, GPIOJ2, SGPMO);
 SIG_EXPR_LIST_DECL_SINGLE(SGPMI, SGPM, SIG_DESC_SET(SCU84, 11));
 SS_PIN_DECL(N4, GPIOJ3, SGPMI);
 
+FUNC_GROUP_DECL(SGPM, R2, L2, N3, N4);
+
 #define N5 76
 SIG_EXPR_LIST_DECL_SINGLE(VGAHS, VGAHS, SIG_DESC_SET(SCU84, 12));
 SIG_EXPR_LIST_DECL_SINGLE(DASHN5, DASHN5, SIG_DESC_SET(SCU94, 8));
@@ -2127,6 +2129,7 @@ static const struct aspeed_pin_group aspeed_g5_groups[] = {
 	ASPEED_PINCTRL_GROUP(SD2),
 	ASPEED_PINCTRL_GROUP(SDA1),
 	ASPEED_PINCTRL_GROUP(SDA2),
+	ASPEED_PINCTRL_GROUP(SGPM),
 	ASPEED_PINCTRL_GROUP(SGPS1),
 	ASPEED_PINCTRL_GROUP(SGPS2),
 	ASPEED_PINCTRL_GROUP(SIOONCTRL),
@@ -2296,6 +2299,7 @@ static const struct aspeed_pin_function aspeed_g5_functions[] = {
 	ASPEED_PINCTRL_FUNC(SD2),
 	ASPEED_PINCTRL_FUNC(SDA1),
 	ASPEED_PINCTRL_FUNC(SDA2),
+	ASPEED_PINCTRL_FUNC(SGPM),
 	ASPEED_PINCTRL_FUNC(SGPS1),
 	ASPEED_PINCTRL_FUNC(SGPS2),
 	ASPEED_PINCTRL_FUNC(SIOONCTRL),
-- 
2.7.4

