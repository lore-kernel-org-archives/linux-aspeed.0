From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:16 +0100
Subject: [PATCH 01/11] ARM: dts: ti: Fix pca954x i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <bc964109db8a5f29124580165e925bd3bfe36661.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm/boot/dts/am3874-iceboard.dtb: pca9548 at 70: $nodename:0: 'pca9548 at 70' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/arm/boot/dts/am3874-iceboard.dtb: pca9548 at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4', 'i2c at 5', 'i2c at 6', 'i2c at 7' were unexpected)
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/am3874-iceboard.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index d039af87936761a3..791478e81c5ad5b3 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -106,7 +106,7 @@ &i2c1 {
 	 * "i2c-mux-idle-disconnect" is important.
 	 */
 
-	pca9548 at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		reg = <0x70>;
 		#address-cells = <1>;
@@ -256,7 +256,7 @@ u59: pca9575 at 23 {
 };
 
 &i2c2 {
-	pca9548 at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
-- 
2.25.1

