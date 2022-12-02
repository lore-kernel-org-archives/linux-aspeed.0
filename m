From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:25 +0100
Subject: [PATCH 10/11] MIPS: mscc: jaguar2: Fix pca9545 i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <5eb01c348c5dd90887b33e866555df8f1067e9df.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/mips/boot/dts/mscc/jaguar2_pcb110.dtb: pca9545 at 70: $nodename:0: 'pca9545 at 70' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/mips/boot/dts/mscc/jaguar2_pcb110.dtb: pca9545 at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3' were unexpected)
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA9545 nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts b/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
index 0ea7bc5b5746842f..1813f4e32e55fadb 100644
--- a/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
+++ b/arch/mips/boot/dts/mscc/jaguar2_pcb110.dts
@@ -208,7 +208,7 @@ i2cmux_3: i2cmux-3-pins {
 };
 
 &i2c0 {
-	pca9545 at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9545";
 		reg = <0x70>;
 		#address-cells = <1>;
@@ -236,7 +236,7 @@ i2c127: i2c at 3 {
 			reg = <3>;
 		};
 	};
-	pca9545 at 71 {
+	i2c-mux at 71 {
 		compatible = "nxp,pca9545";
 		reg = <0x71>;
 		#address-cells = <1>;
-- 
2.25.1

