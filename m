From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 17 Jan 2024 08:56:18 +0100
Subject: [PATCH 3/3] arm64: dts: intel: agilex5: drop "master" I3C node name suffix
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Following change in the I3C bindings, the "master" suffix in I3C
controller node name is discouraged (it is "controller" now) and not
accurate (if device supports also target mode).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The change can be applied through independent trees, if the I3C bindings
change is applied.  Therefore please take it once I3C bindings is
applied.
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index d66d425e45b7..1162978329c1 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -202,7 +202,7 @@ i2c4: i2c at 10c02c00 {
 			status = "disabled";
 		};
 
-		i3c0: i3c-master at 10da0000 {
+		i3c0: i3c at 10da0000 {
 			compatible = "snps,dw-i3c-master-1.00a";
 			reg = <0x10da0000 0x1000>;
 			#address-cells = <3>;
@@ -212,7 +212,7 @@ i3c0: i3c-master at 10da0000 {
 			status = "disabled";
 		};
 
-		i3c1: i3c-master at 10da1000 {
+		i3c1: i3c at 10da1000 {
 			compatible = "snps,dw-i3c-master-1.00a";
 			reg = <0x10da1000 0x1000>;
 			#address-cells = <3>;
-- 
2.34.1

