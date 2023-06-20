From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Jun 2023 13:52:57 +0930
Subject: [PATCH] ARM: dts: aspeed: Add AST2600 VUARs
Message-ID: <20230620042257.73665-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 has two more vuarts, placed between the existing two in the
memory map.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index cc2f8b785917..d1da756690d9 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -716,6 +716,16 @@ vuart1: serial at 1e787000 {
 				status = "disabled";
 			};
 
+			vuart3: serial at 1e787800 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e787800 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
 			vuart2: serial at 1e788000 {
 				compatible = "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
@@ -726,6 +736,16 @@ vuart2: serial at 1e788000 {
 				status = "disabled";
 			};
 
+			vuart4: serial at 1e788800 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e788800 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
-- 
2.39.2

