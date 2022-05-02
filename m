From: Cédric Le Goater <clg@kaod.org>
Date: Mon,  2 May 2022 10:13:31 +0200
Subject: [PATCH v5 01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI
 controllers
In-Reply-To: <20220502081341.203369-1-clg@kaod.org>
References: <20220502081341.203369-1-clg@kaod.org>
Message-ID: <20220502081341.203369-2-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is compatible with the current driver and addresses issues when
running 'make dt_binding_check'.

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++----
 arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++------
 arch/arm/boot/dts/aspeed-g6.dtsi | 9 +++------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index fa8b581c3d6c..3b7b98e787e7 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -54,8 +54,7 @@ ahb {
 		ranges;
 
 		fmc: spi at 1e620000 {
-			reg = < 0x1e620000 0x94
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0x94>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-fmc";
@@ -91,8 +90,7 @@ flash at 4 {
 		};
 
 		spi: spi at 1e630000 {
-			reg = < 0x1e630000 0x18
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0x18>, <0x30000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-spi";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4147b397c883..1e727cbaab14 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -55,8 +55,7 @@ ahb {
 		ranges;
 
 		fmc: spi at 1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-fmc";
@@ -84,8 +83,7 @@ flash at 2 {
 		};
 
 		spi1: spi at 1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x08000000 >;
+			reg = <0x1e630000 0xc4>, <0x30000000 0x08000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
@@ -106,8 +104,7 @@ flash at 1 {
 		};
 
 		spi2: spi at 1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x38000000 0x08000000 >;
+			reg = <0x1e631000 0xc4>, <0x38000000 0x08000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 3d5ce9da42c3..6ae5dfecbdf1 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -95,8 +95,7 @@ gic: interrupt-controller at 40461000 {
 			};
 
 		fmc: spi at 1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-fmc";
@@ -124,8 +123,7 @@ flash at 2 {
 		};
 
 		spi1: spi at 1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
@@ -146,8 +144,7 @@ flash at 1 {
 		};
 
 		spi2: spi at 1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x50000000 0x10000000 >;
+			reg = <0x1e631000 0xc4>, <0x50000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
-- 
2.35.1

