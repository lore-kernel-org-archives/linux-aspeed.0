From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 27 Sep 2021 10:30:49 +0800
Subject: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
In-Reply-To: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'reg-io-width' properties are not used by LPC drivers
nor documented as part of bindings. Therefore drop them.

This is in preparation to move aspeed-lpc.txt to YAML schema.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..45a25eb4baa4 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -345,7 +345,6 @@
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 73ca1ec6fc24..8e1d00d8445e 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -436,7 +436,6 @@
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1b47be1704f8..0d1aae6887cd 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -490,7 +490,6 @@
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1

