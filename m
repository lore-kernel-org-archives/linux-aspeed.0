From: Tony Lindgren <tony@atomide.com>
Date: Thu, 19 Jan 2023 10:18:29 +0200
Subject: [PATCH 01/11] ARM: dts: ti: Fix pca954x i2c-mux node names
In-Reply-To: <bc964109db8a5f29124580165e925bd3bfe36661.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
 <bc964109db8a5f29124580165e925bd3bfe36661.1669999298.git.geert+renesas@glider.be>
Message-ID: <Y8j81dFnDQjpAorw@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Geert Uytterhoeven <geert+renesas@glider.be> [221202 18:50]:
> "make dtbs_check":
> 
>     arch/arm/boot/dts/am3874-iceboard.dtb: pca9548 at 70: $nodename:0: 'pca9548 at 70' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     arch/arm/boot/dts/am3874-iceboard.dtb: pca9548 at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4', 'i2c at 5', 'i2c at 6', 'i2c at 7' were unexpected)
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>     ...
> 
> Fix this by renaming PCA954x nodes to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.

Applying this patch into omap-for-v6.3/dt thanks.

Tony
