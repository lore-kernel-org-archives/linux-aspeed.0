From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Sep 2020 11:36:41 +0930
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Add silicon id node
In-Reply-To: <20200921020641.48733-1-joel@jms.id.au>
References: <20200921020641.48733-1-joel@jms.id.au>
Message-ID: <20200921020641.48733-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This register describes the silicon id and chip unique id. It varies
between CPU revisions, but is always part of the SCU.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix whitespace
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 5 +++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 82f0213e3a3c..b3dafbc8caca 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -192,6 +192,11 @@ p2a: p2a-control at 2c {
 					status = "disabled";
 				};
 
+				silicon-id at 7c {
+					compatible = "aspeed,ast2400-silicon-id", "aspeed,silicon-id";
+					reg = <0x7c 0x4>;
+				};
+
 				pinctrl: pinctrl at 80 {
 					reg = <0x80 0x18>, <0xa0 0x10>;
 					compatible = "aspeed,ast2400-pinctrl";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 9c91afb2b404..c6862182313a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -239,6 +239,11 @@ p2a: p2a-control at 2c {
 					status = "disabled";
 				};
 
+				silicon-id at 7c {
+					compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
+					reg = <0x7c 0x4 0x150 0x8>;
+				};
+
 				pinctrl: pinctrl at 80 {
 					compatible = "aspeed,ast2500-pinctrl";
 					reg = <0x80 0x18>, <0xa0 0x10>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index b58220a49cbd..1ce3a1f06f7f 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -311,6 +311,11 @@ pinctrl: pinctrl {
 					compatible = "aspeed,ast2600-pinctrl";
 				};
 
+				silicon-id at 14 {
+					compatible = "aspeed,ast2600-silicon-id", "aspeed,silicon-id";
+					reg = <0x14 0x4 0x5b0 0x8>;
+				};
+
 				smp-memram at 180 {
 					compatible = "aspeed,ast2600-smpmem";
 					reg = <0x180 0x40>;
-- 
2.28.0

