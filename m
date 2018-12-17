From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 17 Dec 2018 12:04:03 -0800
Subject: [PATCH v2 2/4] ARM: dts: aspeed: Add KCS support for LPC BMC
In-Reply-To: <20181217200405.2904551-1-vijaykhemka@fb.com>
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
Message-ID: <20181217200405.2904551-2-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added kcs device support for lpc BMC.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 33 +++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..2743f400aa29 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -330,8 +330,32 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc at 0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs1: kcs1 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <1>;
+						status = "disabled";
+					};
+					kcs2: kcs2 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <2>;
+						status = "disabled";
+					};
+					kcs3: kcs3 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <3>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host at 80 {
@@ -343,6 +367,13 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
+					kcs4: kcs4 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <4>;
+						status = "disabled";
+					};
+
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
 						reg = <0x0 0x80>;
-- 
2.17.1

