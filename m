From: Haiyue Wang <haiyue.wang@linux.intel.com>
Date: Fri,  8 Dec 2017 22:31:39 +0800
Subject: [PATCH linux dev-4.10 2/2] ipmi: add the KCS nodes into ASt2500
 device tree
In-Reply-To: <1512743499-26590-1-git-send-email-haiyue.wang@linux.intel.com>
References: <1512743499-26590-1-git-send-email-haiyue.wang@linux.intel.com>
Message-ID: <1512743499-26590-2-git-send-email-haiyue.wang@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add kcs1, kcs2, kcs3 into mfd node 'lpc-bmc at 0', and
add kcs4 into mfd node 'lpc-host at 80'.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ba3607c..f428491 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -135,8 +135,39 @@
 			ranges = <0x0 0x1e789000 0x1000>;
 
 			lpc_bmc: lpc-bmc at 0 {
-				compatible = "aspeed,ast2500-lpc-bmc";
+				compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
 				reg = <0x0 0x80>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x0 0x80>;
+
+				kcs1: kcs1 at 0 {
+					compatible = "aspeed,ast2500-kcs-bmc";
+					reg = <0x0 0x80>;
+					interrupts = <8>;
+					kcs_chan = <1>;
+					kcs_addr = <0x0>;
+					status = "disabled";
+				};
+
+				kcs2: kcs2 at 0 {
+					compatible = "aspeed,ast2500-kcs-bmc";
+					reg = <0x0 0x80>;
+					interrupts = <8>;
+					kcs_chan = <2>;
+					kcs_addr = <0x0>;
+					status = "disabled";
+				};
+
+				kcs3: kcs3 at 0 {
+					compatible = "aspeed,ast2500-kcs-bmc";
+					reg = <0x0 0x80>;
+					interrupts = <8>;
+					kcs_chan = <3>;
+					kcs_addr = <0x0>;
+					status = "disabled";
+				};
 			};
 
 			lpc_host: lpc-host at 80 {
@@ -148,6 +179,15 @@
 				#size-cells = <1>;
 				ranges = <0x0 0x80 0x1e0>;
 
+				kcs4: kcs4 at 0 {
+					compatible = "aspeed,ast2500-kcs-bmc";
+					reg = <0x0 0xa0>;
+					interrupts = <8>;
+					kcs_chan = <4>;
+					kcs_addr = <0x0>;
+					status = "disabled";
+				};
+
 				lpc_ctrl: lpc-ctrl at 0 {
 					compatible = "aspeed,ast2500-lpc-ctrl";
 					reg = <0x0 0x80>;
-- 
2.7.4

