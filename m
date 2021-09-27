From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 27 Sep 2021 10:30:53 +0800
Subject: [PATCH v7 5/5] ARM: dts: aspeed: Add uart routing to device tree
In-Reply-To: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210927023053.6728-6-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add LPC uart routing to the device tree for Aspeed SoCs.

Signed-off-by: Oskar Senft <osk@google.com>
Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Tested-by: Lei YU <yulei.sh@bytedance.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 45a25eb4baa4..f0eb599e90f1 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -382,6 +382,12 @@
 					interrupts = <8>;
 					status = "disabled";
 				};
+
+				uart_routing: uart-routing at 9c {
+					compatible = "aspeed,ast2400-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial at 1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 8e1d00d8445e..c72f9aa13cea 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -490,6 +490,12 @@
 					#reset-cells = <1>;
 				};
 
+				uart_routing: uart-routing at 9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
+
 				lhc: lhc at a0 {
 					compatible = "aspeed,ast2500-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 0d1aae6887cd..136273984b5e 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -550,6 +550,12 @@
 					#reset-cells = <1>;
 				};
 
+				uart_routing: uart-routing at 98 {
+					compatible = "aspeed,ast2600-uart-routing";
+					reg = <0x98 0x8>;
+					status = "disabled";
+				};
+
 				ibt: ibt at 140 {
 					compatible = "aspeed,ast2600-ibt-bmc";
 					reg = <0x140 0x18>;
-- 
2.17.1

