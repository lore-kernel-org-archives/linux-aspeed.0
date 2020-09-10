From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:25 +0200
Subject: [PATCH v2 07/15] arm64: dts: xilinx: align GPIO hog names with
 dtschema
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-8-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx requires GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 4f801721564f..f1255f635dfd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -203,25 +203,25 @@
 		gpio-line-names = "PS_GTR_LAN_SEL0", "PS_GTR_LAN_SEL1", "PS_GTR_LAN_SEL2", "PS_GTR_LAN_SEL3",
 				"PCI_CLK_DIR_SEL", "IIC_MUX_RESET_B", "GEM3_EXP_RESET_B",
 				"", "", "", "", "", "", "", "", "";
-		gtr-sel0 {
+		gtr-sel0-hog {
 			gpio-hog;
 			gpios = <0 0>;
 			output-low; /* PCIE = 0, DP = 1 */
 			line-name = "sel0";
 		};
-		gtr-sel1 {
+		gtr-sel1-hog {
 			gpio-hog;
 			gpios = <1 0>;
 			output-high; /* PCIE = 0, DP = 1 */
 			line-name = "sel1";
 		};
-		gtr-sel2 {
+		gtr-sel2-hog {
 			gpio-hog;
 			gpios = <2 0>;
 			output-high; /* PCIE = 0, USB0 = 1 */
 			line-name = "sel2";
 		};
-		gtr-sel3 {
+		gtr-sel3-hog {
 			gpio-hog;
 			gpios = <3 0>;
 			output-high; /* PCIE = 0, SATA = 1 */
-- 
2.17.1

