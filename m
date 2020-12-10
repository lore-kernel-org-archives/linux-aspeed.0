From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Thu, 10 Dec 2020 17:29:55 +0800
Subject: [PATCH 2/3] ARM: dts: aspeed: Add uart-routing node
Message-ID: <20201210092955.358-1-wangzhiqiang.bj@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 30bbf7452b90..bf40e8960244 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -523,6 +523,12 @@ sio_regs: regs {
 						compatible = "aspeed,bmc-misc";
 					};
 				};
+
+				uart_routing: uart_routing at 9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
 			};
 
 			peci: bus at 1e78b000 {
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 4b1013870fb1..8b37182e8f36 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -311,6 +311,12 @@ pinctrl: pinctrl {
 					compatible = "aspeed,ast2600-pinctrl";
 				};
 
+				uart_routing: uart_routing at 9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
+
 				smp-memram at 180 {
 					compatible = "aspeed,ast2600-smpmem";
 					reg = <0x180 0x40>;
-- 
2.25.1

