From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 11 Apr 2020 11:44:58 +0930
Subject: [PATCH v2] ARM: dts: aspeed: Change KCS nodes to v2 binding
Message-ID: <20200411021458.8837-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixes the following warnings for both g5 and g6 SoCs:

    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:388.19-393.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-host at 80/kcs4 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-host at 80/kcs4 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-host at 80/lpc-ctrl at 0)

Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Cc: Vijay Khemka <vijaykhemka@fb.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v1[1] was an out-of-date patch that used the old slave-reg property to define
the device address in the LPC IO space. In v2 of the driver series[2] we agreed
to make the property aspeed-specific on the back some quirks of the hardware.

v2 of this patch updates the tiogapass dts to use the upstream
'aspeed,lpc-io-reg' property instead of 'slave-reg'. I discovered the mismatch
when I started to tidy up the various branches I have lying around for the
ASPEED DT cleanups.

[1] https://lore.kernel.org/linux-arm-kernel/20200411013514.15950-1-andrew at aj.id.au/
[2] https://lore.kernel.org/linux-arm-kernel/8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew at aj.id.au/

 .../dts/aspeed-bmc-facebook-tiogapass.dts     |  4 ++--
 arch/arm/boot/dts/aspeed-g5.dtsi              | 24 +++++++++----------
 arch/arm/boot/dts/aspeed-g6.dtsi              | 23 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 6b88c7f26bf7..2d44d9ad4e40 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -113,13 +113,13 @@
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
 
 &gpio {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 284face7de2c..de7fd80b022a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -445,22 +445,22 @@
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
@@ -474,10 +474,10 @@
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
index 1ffc15177b79..f4113275a7f9 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -471,22 +471,23 @@
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
@@ -500,10 +501,10 @@
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
2.20.1

