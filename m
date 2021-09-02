From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 2 Sep 2021 10:18:17 +0800
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Add uart routing to device tree
In-Reply-To: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210902021817.17506-5-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add LPC uart routing to the device tree for Aspeed AST25xx/AST26xx SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 329eaeef66fb..d3da5c948165 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -492,6 +492,12 @@
 					#reset-cells = <1>;
 				};
 
+				uart_routing: uart-routing at 98 {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x98 0x8>;
+					status = "disabled";
+				};
+
 				lhc: lhc at a0 {
 					compatible = "aspeed,ast2500-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..c287d9dba118 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -523,6 +523,12 @@
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

