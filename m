From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:24 +0100
Subject: [PATCH 09/11] arm64: dts: renesas: ulcb-kf: Fix pca9548 i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <3c32f500b99e598f458336dc4c05ffa60656324e.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: i2c-switch at 71: $nodename:0: 'i2c-switch at 71' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: i2c-switch at 71: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 4', 'i2c at 7' were unexpected)
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming all PCA9548 nodes to "i2c-mux", to match the I2C
bus multiplexer/switch DT bindings and the Generic Names Recommendation
in the Devicetree Specification.

While at it, rename the labels too, for uniformity.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-devel for v6.3.
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 8e46acbe3a203759..e95be89e6e9d25b8 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -126,7 +126,7 @@ &hsusb {
 };
 
 &i2c2 {
-	i2cswitch2: i2c-switch at 71 {
+	i2cmux2: i2c-mux at 71 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -316,7 +316,7 @@ gpio_exp_75: gpio at 75 {
 };
 
 &i2c4 {
-	i2cswitch4: i2c-switch at 71 {
+	i2cmux4: i2c-mux at 71 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.25.1

