From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 23 Sep 2024 15:50:10 +0800
Subject: [PATCH v4 1/3] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <20240923075012.2264573-1-ryan_chen@aspeedtech.com>
References: <20240923075012.2264573-1-ryan_chen@aspeedtech.com>
Message-ID: <20240923075012.2264573-2-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add reset, clk dt bindings headers, and update compatible
support for AST2700 clk, silicon-id in yaml.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   8 +-
 .../dt-bindings/clock/aspeed,ast2700-scu.h    | 163 ++++++++++++++++++
 .../dt-bindings/reset/aspeed,ast2700-scu.h    | 124 +++++++++++++
 3 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-scu.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-scu.h

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..c800d5e53b65 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -9,6 +9,8 @@ title: Aspeed System Control Unit
 description:
   The Aspeed System Control Unit manages the global behaviour of the SoC,
   configuring elements such as clocks, pinmux, and reset.
+  In AST2700 SOC which has two soc connection, each soc have its own scu
+  register control, ast2700-scu0 for soc0, ast2700-scu1 for soc1.
 
 maintainers:
   - Joel Stanley <joel@jms.id.au>
@@ -21,6 +23,8 @@ properties:
           - aspeed,ast2400-scu
           - aspeed,ast2500-scu
           - aspeed,ast2600-scu
+          - aspeed,ast2700-scu0
+          - aspeed,ast2700-scu1
       - const: syscon
       - const: simple-mfd
 
@@ -30,7 +34,8 @@ properties:
   ranges: true
 
   '#address-cells':
-    const: 1
+    minimum: 1
+    maximum: 2
 
   '#size-cells':
     const: 1
@@ -76,6 +81,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
new file mode 100644
index 000000000000..63021af3caf5
--- /dev/null
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Device Tree binding constants for AST2700 clock controller.
+ *
+ * Copyright (c) 2024 Aspeed Technology Inc.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_AST2700_H
+#define __DT_BINDINGS_CLOCK_AST2700_H
+
+/* SOC0 clk */
+#define SCU0_CLKIN		0
+#define SCU0_CLK_24M		1
+#define SCU0_CLK_192M		2
+#define SCU0_CLK_UART		3
+#define SCU0_CLK_UART_DIV13	3
+#define SCU0_CLK_PSP		4
+#define SCU0_CLK_HPLL		5
+#define SCU0_CLK_HPLL_DIV2	6
+#define SCU0_CLK_HPLL_DIV4	7
+#define SCU0_CLK_HPLL_DIV_AHB	8
+#define SCU0_CLK_DPLL		9
+#define SCU0_CLK_MPLL		10
+#define SCU0_CLK_MPLL_DIV2	11
+#define SCU0_CLK_MPLL_DIV4	12
+#define SCU0_CLK_MPLL_DIV8	13
+#define SCU0_CLK_MPLL_DIV_AHB	14
+#define SCU0_CLK_D0		15
+#define SCU0_CLK_D1		16
+#define SCU0_CLK_CRT0		17
+#define SCU0_CLK_CRT1		18
+#define SCU0_CLK_MPHY		19
+#define SCU0_CLK_AXI0		20
+#define SCU0_CLK_AXI1		21
+#define SCU0_CLK_AHB		22
+#define SCU0_CLK_APB		23
+#define SCU0_CLK_UART4		24
+#define SCU0_CLK_EMMCMUX	25
+#define SCU0_CLK_EMMC		26
+#define SCU0_CLK_U2PHY_CLK12M	27
+#define SCU0_CLK_U2PHY_REFCLK	28
+
+/* SOC0 clk-gate */
+#define SCU0_CLK_GATE_MCLK	29
+#define SCU0_CLK_GATE_ECLK	30
+#define SCU0_CLK_GATE_2DCLK	31
+#define SCU0_CLK_GATE_VCLK	32
+#define SCU0_CLK_GATE_BCLK	33
+#define SCU0_CLK_GATE_VGA0CLK	34
+#define SCU0_CLK_GATE_REFCLK	35
+#define SCU0_CLK_GATE_PORTBUSB2CLK	36
+#define SCU0_CLK_GATE_UHCICLK	37
+#define SCU0_CLK_GATE_VGA1CLK	38
+#define SCU0_CLK_GATE_DDRPHYCLK	39
+#define SCU0_CLK_GATE_E2M0CLK	40
+#define SCU0_CLK_GATE_HACCLK	41
+#define SCU0_CLK_GATE_PORTAUSB2CLK	42
+#define SCU0_CLK_GATE_UART4CLK	43
+#define SCU0_CLK_GATE_SLICLK	44
+#define SCU0_CLK_GATE_DACCLK	45
+#define SCU0_CLK_GATE_DP	46
+#define SCU0_CLK_GATE_E2M1CLK	47
+#define SCU0_CLK_GATE_CRT0CLK	48
+#define SCU0_CLK_GATE_CRT1CLK	49
+#define SCU0_CLK_GATE_ECDSACLK	50
+#define SCU0_CLK_GATE_RSACLK	51
+#define SCU0_CLK_GATE_RVAS0CLK	52
+#define SCU0_CLK_GATE_UFSCLK	53
+#define SCU0_CLK_GATE_EMMCCLK	54
+#define SCU0_CLK_GATE_RVAS1CLK	55
+
+/* SOC1 clk */
+#define SCU1_CLKIN		0
+#define SCU1_CLK_HPLL		1
+#define SCU1_CLK_APLL		2
+#define SCU1_CLK_APLL_DIV2	3
+#define SCU1_CLK_APLL_DIV4	4
+#define SCU1_CLK_DPLL		5
+#define SCU1_CLK_UXCLK		6
+#define SCU1_CLK_HUXCLK		7
+#define SCU1_CLK_UARTX		8
+#define SCU1_CLK_HUARTX		9
+#define SCU1_CLK_AHB		10
+#define SCU1_CLK_APB		11
+#define SCU1_CLK_UART0		12
+#define SCU1_CLK_UART1		13
+#define SCU1_CLK_UART2		14
+#define SCU1_CLK_UART3		15
+#define SCU1_CLK_UART5		16
+#define SCU1_CLK_UART6		17
+#define SCU1_CLK_UART7		18
+#define SCU1_CLK_UART8		19
+#define SCU1_CLK_UART9		20
+#define SCU1_CLK_UART10		21
+#define SCU1_CLK_UART11		22
+#define SCU1_CLK_UART12		23
+#define SCU1_CLK_UART13		24
+#define SCU1_CLK_UART14		25
+#define SCU1_CLK_APLL_DIVN	26
+#define SCU1_CLK_SDMUX		27
+#define SCU1_CLK_SDCLK		28
+#define SCU1_CLK_RMII		29
+#define SCU1_CLK_RGMII		30
+#define SCU1_CLK_MACHCLK	31
+#define SCU1_CLK_MAC0RCLK	32
+#define SCU1_CLK_MAC1RCLK	33
+#define SCU1_CLK_CAN		34
+
+/* SOC1 clk gate */
+#define SCU1_CLK_GATE_LCLK0		35
+#define SCU1_CLK_GATE_LCLK1		36
+#define SCU1_CLK_GATE_ESPI0CLK		37
+#define SCU1_CLK_GATE_ESPI1CLK		38
+#define SCU1_CLK_GATE_SDCLK		39
+#define SCU1_CLK_GATE_IPEREFCLK		40
+#define SCU1_CLK_GATE_REFCLK		41
+#define SCU1_CLK_GATE_LPCHCLK		42
+#define SCU1_CLK_GATE_MAC0CLK		43
+#define SCU1_CLK_GATE_MAC1CLK		44
+#define SCU1_CLK_GATE_MAC2CLK		45
+#define SCU1_CLK_GATE_UART0CLK		46
+#define SCU1_CLK_GATE_UART1CLK		47
+#define SCU1_CLK_GATE_UART2CLK		48
+#define SCU1_CLK_GATE_UART3CLK		49
+#define SCU1_CLK_GATE_I2CCLK		50
+#define SCU1_CLK_GATE_I3C0CLK		51
+#define SCU1_CLK_GATE_I3C1CLK		52
+#define SCU1_CLK_GATE_I3C2CLK		53
+#define SCU1_CLK_GATE_I3C3CLK		54
+#define SCU1_CLK_GATE_I3C4CLK		55
+#define SCU1_CLK_GATE_I3C5CLK		56
+#define SCU1_CLK_GATE_I3C6CLK		57
+#define SCU1_CLK_GATE_I3C7CLK		58
+#define SCU1_CLK_GATE_I3C8CLK		59
+#define SCU1_CLK_GATE_I3C9CLK		60
+#define SCU1_CLK_GATE_I3C10CLK		61
+#define SCU1_CLK_GATE_I3C11CLK		62
+#define SCU1_CLK_GATE_I3C12CLK		63
+#define SCU1_CLK_GATE_I3C13CLK		64
+#define SCU1_CLK_GATE_I3C14CLK		65
+#define SCU1_CLK_GATE_I3C15CLK		66
+#define SCU1_CLK_GATE_UART5CLK		67
+#define SCU1_CLK_GATE_UART6CLK		68
+#define SCU1_CLK_GATE_UART7CLK		69
+#define SCU1_CLK_GATE_UART8CLK		70
+#define SCU1_CLK_GATE_UART9CLK		71
+#define SCU1_CLK_GATE_UART10CLK		72
+#define SCU1_CLK_GATE_UART11CLK		73
+#define SCU1_CLK_GATE_UART12CLK		74
+#define SCU1_CLK_GATE_FSICLK		75
+#define SCU1_CLK_GATE_LTPIPHYCLK	76
+#define SCU1_CLK_GATE_LTPICLK		77
+#define SCU1_CLK_GATE_VGALCLK		78
+#define SCU1_CLK_GATE_UHCICLK		79
+#define SCU1_CLK_GATE_CANCLK		80
+#define SCU1_CLK_GATE_PCICLK		81
+#define SCU1_CLK_GATE_SLICLK		82
+#define SCU1_CLK_GATE_E2MCLK		83
+#define SCU1_CLK_GATE_PORTCUSB2CLK	84
+#define SCU1_CLK_GATE_PORTDUSB2CLK	85
+#define SCU1_CLK_GATE_LTPI1TXCLK	86
+
+#endif
diff --git a/include/dt-bindings/reset/aspeed,ast2700-scu.h b/include/dt-bindings/reset/aspeed,ast2700-scu.h
new file mode 100644
index 000000000000..d53c719b7a66
--- /dev/null
+++ b/include/dt-bindings/reset/aspeed,ast2700-scu.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Device Tree binding constants for AST2700 reset controller.
+ *
+ * Copyright (c) 2024 Aspeed Technology Inc.
+ */
+
+#ifndef _MACH_ASPEED_AST2700_RESET_H_
+#define _MACH_ASPEED_AST2700_RESET_H_
+
+/* SOC0 */
+#define SCU0_RESET_SDRAM	0
+#define SCU0_RESET_DDRPHY	1
+#define SCU0_RESET_RSA		2
+#define SCU0_RESET_SHA3		3
+#define SCU0_RESET_HACE		4
+#define SCU0_RESET_SOC		5
+#define SCU0_RESET_VIDEO	6
+#define SCU0_RESET_2D		7
+#define SCU0_RESET_PCIS		8
+#define SCU0_RESET_RVAS0	9
+#define SCU0_RESET_RVAS1	10
+#define SCU0_RESET_SM3		11
+#define SCU0_RESET_SM4		12
+#define SCU0_RESET_CRT0		13
+#define SCU0_RESET_ECC		14
+#define SCU0_RESET_DP_PCI	15
+#define SCU0_RESET_UFS		16
+#define SCU0_RESET_EMMC		17
+#define SCU0_RESET_PCIE1RST	18
+#define SCU0_RESET_PCIE1RSTOE	19
+#define SCU0_RESET_PCIE0RST	20
+#define SCU0_RESET_PCIE0RSTOE	21
+#define SCU0_RESET_JTAG		22
+#define SCU0_RESET_MCTP0	23
+#define SCU0_RESET_MCTP1	24
+#define SCU0_RESET_XDMA0	25
+#define SCU0_RESET_XDMA1	26
+#define SCU0_RESET_H2X1		27
+#define SCU0_RESET_DP		28
+#define SCU0_RESET_DP_MCU	29
+#define SCU0_RESET_SSP		30
+#define SCU0_RESET_H2X0		31
+#define SCU0_RESET_PORTA_VHUB	32
+#define SCU0_RESET_PORTA_PHY3	33
+#define SCU0_RESET_PORTA_XHCI	34
+#define SCU0_RESET_PORTB_VHUB	35
+#define SCU0_RESET_PORTB_PHY3	36
+#define SCU0_RESET_PORTB_XHCI	37
+#define SCU0_RESET_PORTA_VHUB_EHCI	38
+#define SCU0_RESET_PORTB_VHUB_EHCI	39
+#define SCU0_RESET_UHCI		40
+#define SCU0_RESET_TSP		41
+#define SCU0_RESET_E2M0		42
+#define SCU0_RESET_E2M1		43
+#define SCU0_RESET_VLINK	44
+
+/* SOC1 */
+#define SCU1_RESET_LPC0		0
+#define SCU1_RESET_LPC1		1
+#define SCU1_RESET_MII		2
+#define SCU1_RESET_PECI		3
+#define SCU1_RESET_PWM		4
+#define SCU1_RESET_MAC0		5
+#define SCU1_RESET_MAC1		6
+#define SCU1_RESET_MAC2		7
+#define SCU1_RESET_ADC		8
+#define SCU1_RESET_SD		9
+#define SCU1_RESET_ESPI0	10
+#define SCU1_RESET_ESPI1	11
+#define SCU1_RESET_JTAG1	12
+#define SCU1_RESET_SPI0		13
+#define SCU1_RESET_SPI1		14
+#define SCU1_RESET_SPI2		15
+#define SCU1_RESET_I3C0		16
+#define SCU1_RESET_I3C1		17
+#define SCU1_RESET_I3C2		18
+#define SCU1_RESET_I3C3		19
+#define SCU1_RESET_I3C4		20
+#define SCU1_RESET_I3C5		21
+#define SCU1_RESET_I3C6		22
+#define SCU1_RESET_I3C7		23
+#define SCU1_RESET_I3C8		24
+#define SCU1_RESET_I3C9		25
+#define SCU1_RESET_I3C10	26
+#define SCU1_RESET_I3C11	27
+#define SCU1_RESET_I3C12	28
+#define SCU1_RESET_I3C13	29
+#define SCU1_RESET_I3C14	30
+#define SCU1_RESET_I3C15	31
+#define SCU1_RESET_MCU0		32
+#define SCU1_RESET_MCU1		33
+#define SCU1_RESET_H2A_SPI1	34
+#define SCU1_RESET_H2A_SPI2	35
+#define SCU1_RESET_UART0	36
+#define SCU1_RESET_UART1	37
+#define SCU1_RESET_UART2	38
+#define SCU1_RESET_UART3	39
+#define SCU1_RESET_I2C_FILTER	40
+#define SCU1_RESET_CALIPTRA	41
+#define SCU1_RESET_XDMA		42
+#define SCU1_RESET_FSI		43
+#define SCU1_RESET_CAN		44
+#define SCU1_RESET_MCTP		45
+#define SCU1_RESET_I2C		46
+#define SCU1_RESET_UART6	47
+#define SCU1_RESET_UART7	48
+#define SCU1_RESET_UART8	49
+#define SCU1_RESET_UART9	50
+#define SCU1_RESET_LTPI0	51
+#define SCU1_RESET_VGAL		52
+#define SCU1_RESET_LTPI1	53
+#define SCU1_RESET_ACE		54
+#define SCU1_RESET_E2M		55
+#define SCU1_RESET_UHCI		56
+#define SCU1_RESET_PORTC_USB2UART	57
+#define SCU1_RESET_PORTC_VHUB_EHCI	58
+#define SCU1_RESET_PORTD_USB2UART	59
+#define SCU1_RESET_PORTD_VHUB_EHCI	60
+#define SCU1_RESET_H2X		61
+#define SCU1_RESET_I3CDMA	62
+#define SCU1_RESET_PCIE2RST	63
+
+#endif  /* _MACH_ASPEED_AST2700_RESET_H_ */
-- 
2.34.1

