From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 15 Jul 2019 11:55:06 +0930
Subject: [PATCH 2/3 v2] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <1562962440-15908-1-git-send-email-hongweiz@ami.com>
References: <1562962440-15908-1-git-send-email-hongweiz@ami.com>
Message-ID: <56d7603a-c1b9-4893-871d-2aee17329e40@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Hongwei,

On Sat, 13 Jul 2019, at 05:44, Hongwei Zhang wrote:
> Add bindings to support SGPIO on AST2400 or AST2500.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt 
> b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> new file mode 100755
> index 0000000..3ae2b79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> @@ -0,0 +1,43 @@
> +Aspeed SGPIO controller Device Tree Bindings
> +-------------------------------------------
> +
> +Required properties:
> +- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
> +
> +- #gpio-cells 		: Should be two
> +			  - First cell is the GPIO line number
> +			  - Second cell is used to specify optional
> +			    parameters (unused)
> +
> +- reg			: Address and length of the register set for the device
> +- gpio-controller	: Marks the device node as a GPIO controller.
> +- interrupts		: Interrupt specifier (see interrupt bindings for
> +			  details)
> +
> +- interrupt-controller	: Mark the GPIO controller as an 
> interrupt-controller
> +
> +- nr-gpios		: number of GPIO pins to serialise. (should be multiple of 
> 8, up to 80 pins)
> +			  if not specified, defaults to 80.

This appears to be a statement about the driver implementation, but bindings
documents are about describing hardware. Reading the datasheet it actually
appears the ASPEED SGPIO hardware comes up in what is "technically" a
forbidden state (equivalent to `nr-gpios = <0>;`), though the device is also
disabled at this point, so it's probably moot. The point is the true default
value from a hardware perspective is 0, not 80, so if we're going to talk about
default values, 0 would be more appropriate. However:

You've also listed nr-gpios under the "Required properties" header, but the
description suggests it's optional. It's either one or the other, please lets be
clear about it. On that front, lets make it nr-gpios *not* optional (i.e. make it
required) thus force the specification of how many SGPIOs we want to emit
on the bus. This value is coupled to the platform design, so I don't think
there's ever a scenario where we want nr-gpios to take a default value.

> +
> +- clocks               : A phandle to the APB clock for SGPM clock 
> division
> +
> +- bus-frequency	: SGPM CLK frequency, if not specified defaults to 1 
> MHz

Again here with the default value - SGPM CLK period is derived from PCLK by
the expression `period = PCLK * 2 *(GPIO254[31:16] + 1)`, where GPIO254's
initialisation state is `GPIO254[31:16] = 0`, which gives a default SGPM bus
frequency of PCLK / 2. This is likely not going to be 1MHz (more like ~12MHz).

Lets just make the property required. That way we avoid any ambiguity about
the bus frequency and thus don't need words about defaults that turn out to
be about the driver, not about the hardware.

Finally, when updating patches in response to feedback, please send the full
series again, and bump the series version number. That way people can review
a coherent set of patches and not have to hunt around and (fail to) collate the
correct combination. It makes it easier to say "Reviewed-by:" on your patches :)

Cheers,

Andrew
