From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:58 +0930
Subject: [RFC PATCH 16/17] ARM: dts: aspeed-g5: Change KCS nodes to v2 binding
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <20190726053959.2003-17-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:388.19-393.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unit_address_vs_reg): /ahb/apb/lpc at 1e789000/lpc-host at 80/kcs4 at 0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs1 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs2 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-bmc at 0/kcs3 at 0)
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-host at 80/kcs4 at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-host at 80/lpc-ctrl at 0)

Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 92c659c50b4c..50ba58dc5093 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -373,22 +373,22 @@
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
@@ -402,10 +402,10 @@
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
 
-- 
2.20.1

