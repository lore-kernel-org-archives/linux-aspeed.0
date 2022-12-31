From: Shawn Guo <shawnguo@kernel.org>
Date: Sat, 31 Dec 2022 20:39:59 +0800
Subject: [PATCH 06/11] ARM: dts: vf610: Fix pca9548 i2c-mux node names
In-Reply-To: <d1c5038b36d10282f01d8c722f94821b1710d2e0.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
 <d1c5038b36d10282f01d8c722f94821b1710d2e0.1669999298.git.geert+renesas@glider.be>
Message-ID: <20221231123958.GU6112@T480>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 02, 2022 at 05:49:21PM +0100, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm/boot/dts/vf610-zii-dev-rev-b.dtb: tca9548 at 70: $nodename:0: 'tca9548 at 70' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     arch/arm/boot/dts/vf610-zii-dev-rev-b.dtb: tca9548 at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4' were unexpected)
> 	    From schema: /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     ...
> 
> Fix this by renaming PCA9548 nodes to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks!
