From: Shawn Guo <shawnguo@kernel.org>
Date: Sat, 31 Dec 2022 20:39:17 +0800
Subject: [PATCH 03/11] ARM: dts: imx: Fix pca9547 i2c-mux node name
In-Reply-To: <fb231affc38b4d122c8ce733ea23f6da5c14f812.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
 <fb231affc38b4d122c8ce733ea23f6da5c14f812.1669999298.git.geert+renesas@glider.be>
Message-ID: <20221231123916.GT6112@T480>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 02, 2022 at 05:49:18PM +0100, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm/boot/dts/imx53-ppd.dtb: i2c-switch at 70: $nodename:0: 'i2c-switch at 70' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     arch/arm/boot/dts/imx53-ppd.dtb: i2c-switch at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4', 'i2c at 5', 'i2c at 6', 'i2c at 7' were unexpected)
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> 
> Fix this by renaming the PCA9547 node to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks!
