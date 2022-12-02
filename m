From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:23 +0100
Subject: [PATCH 08/11] arm64: dts: marvell: Fix pca954x i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <8fef7bb60e820cf961eb57e9be47a5f36f3f4916.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: i2c-switch at 70: $nodename:0: 'i2c-switch at 70' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: i2c-switch at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2' were unexpected)
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi      | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index ca1aeb69a8929931..c864df9ec84d1b6f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -135,7 +135,7 @@ &cp0_i2c1 {
 	pinctrl-0 = <&cp0_i2c1_pins>;
 	status = "okay";
 
-	i2c-switch at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index eb04735039362373..42a60f3dd5d142fc 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -285,7 +285,7 @@ &cp0_i2c1 {
 	pinctrl-0 = <&cp0_i2c1_pins>;
 	status = "okay";
 
-	i2c-switch at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.25.1

