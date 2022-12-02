From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:21 +0100
Subject: [PATCH 06/11] ARM: dts: vf610: Fix pca9548 i2c-mux node names
In-Reply-To: <cover.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
Message-ID: <d1c5038b36d10282f01d8c722f94821b1710d2e0.1669999298.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make dtbs_check":

    arch/arm/boot/dts/vf610-zii-dev-rev-b.dtb: tca9548 at 70: $nodename:0: 'tca9548 at 70' does not match '^(i2c-?)?mux'
	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    arch/arm/boot/dts/vf610-zii-dev-rev-b.dtb: tca9548 at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4' were unexpected)
	    From schema: /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
    ...

Fix this by renaming PCA9548 nodes to "i2c-mux", to match the I2C bus
multiplexer/switch DT bindings and the Generic Names Recommendation in
the Devicetree Specification.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 42ed4a04a12e250b..6280c5e86a124e2f 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -345,7 +345,7 @@ gpio6: io-expander at 22 {
 };
 
 &i2c2 {
-	tca9548 at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index f892977da9e4e031..c00d39562a10bb94 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -340,7 +340,7 @@ eeprom at 50 {
 };
 
 &i2c2 {
-	tca9548 at 70 {
+	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
 		pinctrl-names = "default";
-- 
2.25.1

