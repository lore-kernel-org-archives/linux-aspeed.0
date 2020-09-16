From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Sep 2020 17:57:05 +0200
Subject: [PATCH v3 05/15] arm64: dts: renesas: align GPIO hog names with
 dtschema
In-Reply-To: <20200916155715.21009-1-krzk@kernel.org>
References: <20200916155715.21009-1-krzk@kernel.org>
Message-ID: <20200916155715.21009-6-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx expects GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/renesas/r8a77951-salvator-xs.dts      |  2 +-
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |  2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
index cef9da4376a3..e5922329a4b8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
@@ -118,7 +118,7 @@
 };
 
 &pca9654 {
-	pcie_sata_switch {
+	pcie-sata-switch-hog {
 		gpio-hog;
 		gpios = <7 GPIO_ACTIVE_HIGH>;
 		output-low; /* enable SATA by default */
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 5cef64605464..d7e621101af7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -55,7 +55,7 @@
 };
 
 &pca9654 {
-	pcie_sata_switch {
+	pcie-sata-switch-hog {
 		gpio-hog;
 		gpios = <7 GPIO_ACTIVE_HIGH>;
 		output-low; /* enable SATA by default */
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 202177706cde..e9ed2597f1c2 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -143,49 +143,49 @@
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
-		audio_out_off {
+		audio-out-off-hog {
 			gpio-hog;
 			gpios = <0 GPIO_ACTIVE_HIGH>; /* P00 */
 			output-high;
 			line-name = "Audio_Out_OFF";
 		};
 
-		hub_pwen {
+		hub-pwen-hog {
 			gpio-hog;
 			gpios = <6 GPIO_ACTIVE_HIGH>;
 			output-high;
 			line-name = "HUB pwen";
 		};
 
-		hub_rst {
+		hub-rst-hog {
 			gpio-hog;
 			gpios = <7 GPIO_ACTIVE_HIGH>;
 			output-high;
 			line-name = "HUB rst";
 		};
 
-		otg_extlpn {
+		otg-extlpn-hog {
 			gpio-hog;
 			gpios = <9 GPIO_ACTIVE_HIGH>;
 			output-high;
 			line-name = "OTG EXTLPn";
 		};
 
-		otg_offvbusn {
+		otg-offvbusn-hog {
 			gpio-hog;
 			gpios = <8 GPIO_ACTIVE_HIGH>;
 			output-low;
 			line-name = "OTG OFFVBUSn";
 		};
 
-		sd-wifi-mux {
+		sd-wifi-mux-hog {
 			gpio-hog;
 			gpios = <5 GPIO_ACTIVE_HIGH>;
 			output-low;	/* Connect WL1837 */
 			line-name = "SD WiFi mux";
 		};
 
-		snd_rst {
+		snd-rst-hog {
 			gpio-hog;
 			gpios = <15 GPIO_ACTIVE_HIGH>; /* P17 */
 			output-high;
-- 
2.17.1

