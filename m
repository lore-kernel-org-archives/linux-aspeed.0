From: Sasha Levin <sashal@kernel.org>
Date: Wed, 17 Jun 2020 21:04:22 -0400
Subject: [PATCH AUTOSEL 5.7 165/388] ARM: dts: aspeed: Change KCS nodes to v2
 binding
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
Message-ID: <20200618010805.600873-165-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>

[ Upstream commit fa4c8ec6feaa3237f5d44cb8c6d0aa0dff6e1bcc ]

Fixes the following warnings for both g5 and g6 SoCs:

    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning
    (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: node
    has a unit name, but no reg property

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     |  4 ++--
 arch/arm/boot/dts/aspeed-g5.dtsi              | 24 +++++++++----------
 arch/arm/boot/dts/aspeed-g6.dtsi              | 23 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 5d7cbd9164d4..669980c690f9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -112,13 +112,13 @@ &uart5 {
 &kcs2 {
 	// BMC KCS channel 2
 	status = "okay";
-	kcs_addr = <0xca8>;
+	aspeed,lpc-io-reg = <0xca8>;
 };
 
 &kcs3 {
 	// BMC KCS channel 3
 	status = "okay";
-	kcs_addr = <0xca2>;
+	aspeed,lpc-io-reg = <0xca2>;
 };
 
 &mac0 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index f12ec04d3cbc..bc92d3db7b78 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -426,22 +426,22 @@ lpc_bmc: lpc-bmc at 0 {
 					#size-cells = <1>;
 					ranges = <0x0 0x0 0x80>;
 
-					kcs1: kcs1 at 0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs1: kcs at 24 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <1>;
 						status = "disabled";
 					};
-					kcs2: kcs2 at 0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs2: kcs at 28 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 						interrupts = <8>;
-						kcs_chan = <2>;
 						status = "disabled";
 					};
-					kcs3: kcs3 at 0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs3: kcs at 2c {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 						interrupts = <8>;
-						kcs_chan = <3>;
 						status = "disabled";
 					};
 				};
@@ -455,10 +455,10 @@ lpc_host: lpc-host at 80 {
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
-					kcs4: kcs4 at 0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs4: kcs at 94 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <4>;
 						status = "disabled";
 					};
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index fd0e483737a0..a2d2ac720a51 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -435,22 +435,23 @@ lpc_bmc: lpc-bmc at 0 {
 					#size-cells = <1>;
 					ranges = <0x0 0x0 0x80>;
 
-					kcs1: kcs1 at 0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs1: kcs at 24 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 						interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 						kcs_chan = <1>;
 						status = "disabled";
 					};
-					kcs2: kcs2 at 0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs2: kcs at 28 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 						interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <2>;
 						status = "disabled";
 					};
-					kcs3: kcs3 at 0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs3: kcs at 2c {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 						interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <3>;
 						status = "disabled";
 					};
 				};
@@ -464,10 +465,10 @@ lpc_host: lpc-host at 80 {
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
-					kcs4: kcs4 at 0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs4: kcs at 94 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
 						interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <4>;
 						status = "disabled";
 					};
 
-- 
2.25.1

