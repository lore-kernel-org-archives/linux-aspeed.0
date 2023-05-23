From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 23 May 2023 17:55:12 +0200
Subject: [PATCH v2 3/3] arm64: dts: marvell: Fix pca954x i2c-mux node
 names
In-Reply-To: <fed5b15691283ce72ceb9fb074f953c5da0f6852.1684856632.git.geert+renesas@glider.be>
References: <cover.1684856632.git.geert+renesas@glider.be>
 <fed5b15691283ce72ceb9fb074f953c5da0f6852.1684856632.git.geert+renesas@glider.be>
Message-ID: <685e7539-0a2b-4bf3-9725-a7a4780c82cb@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 23, 2023 at 05:50:21PM +0200, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: i2c-switch at 70: $nodename:0: 'i2c-switch at 70' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: i2c-switch at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2' were unexpected)
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     ...
> 
> Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Philippe Mathieu-Daud? <philmd@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
