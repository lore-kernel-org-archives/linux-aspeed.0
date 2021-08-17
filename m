From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 17 Aug 2021 10:58:48 +0800
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add mailbox to device tree
In-Reply-To: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
References: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210817025848.19914-3-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add mailbox to the device tree for Aspeed AST24xx/AST25xx/AST26xx SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 8 +++++++-
 arch/arm/boot/dts/aspeed-g6.dtsi | 7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..6298d69df415 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -383,6 +383,13 @@
 					interrupts = <8>;
 					status = "disabled";
 				};
+
+				mbox: mbox at 200 {
+					compatible = "aspeed,ast2500-mbox";
+					reg = <0x200 0x30>;
+					interrupts = <46>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial at 1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 329eaeef66fb..ab9453d7803c 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -497,13 +497,19 @@
 					reg = <0xa0 0x24 0xc8 0x8>;
 				};
 
-
 				ibt: ibt at 140 {
 					compatible = "aspeed,ast2500-ibt-bmc";
 					reg = <0x140 0x18>;
 					interrupts = <8>;
 					status = "disabled";
 				};
+
+				mbox: mbox at 200 {
+					compatible = "aspeed,ast2500-mbox";
+					reg = <0x200 0x30>;
+					interrupts = <46>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial at 1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..09b286f2ece2 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -529,6 +529,13 @@
 					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
 				};
+
+				mbox: mbox at 200 {
+					compatible = "aspeed,ast2600-mbox";
+					reg = <0x200 0xc0>;
+					interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
 			};
 
 			sdc: sdc at 1e740000 {
-- 
2.17.1

