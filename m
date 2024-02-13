From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 19:35:21 -0000
Subject: [PATCH 4/6] arm: dts: Fix dtc interrupt_map warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <20240213-arm-dt-cleanups-v1-4-f2dee1292525@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The dtc interrupt_map warning is off because its dependency,
interrupt_provider, is off by default. Fix all the warnings so it can be
enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts     | 2 ++
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts | 2 ++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                        | 8 ++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
index 4d70f6afd13a..6d5e69035f94 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
@@ -60,6 +60,8 @@ pci at c0000000 {
 			 * We have slots (IDSEL) 1 and 2 with one assigned IRQ
 			 * each handling all IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
index 9ec0169bacf8..5f4c849915db 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
@@ -89,6 +89,8 @@ pci at c0000000 {
 			 * The slots have Ethernet, Ethernet, NEC and MPCI.
 			 * The IDSELs are 11, 12, 13, 14.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 11 - Ethernet A */
 			<0x5800 0 0 1 &gpio0 4 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 11 is irq 4 */
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2045fc779f88..27429d0fedfb 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -340,10 +340,10 @@ pcie_rc: pcie at 1c00000 {
 					  "msi8";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 0 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 0 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 0 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 0 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
 				 <&gcc GCC_PCIE_AUX_CLK>,

-- 
2.43.0

