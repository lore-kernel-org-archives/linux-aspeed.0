From: Shawn Guo <shawnguo@kernel.org>
Date: Sat, 31 Dec 2022 20:40:26 +0800
Subject: [PATCH 07/11] arm64: dts: freescale: Fix pca954x i2c-mux node
 names
In-Reply-To: <3755a821121c472c9a9fd26a735c87ebb79484a5.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
 <3755a821121c472c9a9fd26a735c87ebb79484a5.1669999298.git.geert+renesas@glider.be>
Message-ID: <20221231124025.GV6112@T480>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 02, 2022 at 05:49:22PM +0100, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: pca9547 at 77: $nodename:0: 'pca9547 at 77' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: pca9547 at 77: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 4' were unexpected)
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     ...
> 
> Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks!
