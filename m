From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 11:46:09 +0930
Subject: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
References: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
Message-ID: <9c998f5f-42ef-43bd-b024-839ee00126de@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 4 Jul 2019, at 05:31, Hongwei Zhang wrote:
> Add bindings to support SGPIO on AST2400 or AST2500.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt 
> b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> new file mode 100644
> index 0000000..f5fc6ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> @@ -0,0 +1,36 @@
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
> +- interrupt-controller	: Mark the GPIO controller as an 
> interrupt-controller

As this is a serial GPIO controller, a critical piece of configuration
information is how many GPIOs we wish to serialise. This is done
in multiples of 8, up to 80 pins.

The bindings need to describe the "ngpios" property from the
generic GPIO bindings and how this affects the behaviour of
the controller.

We also need to add the "bus-frequency" property here to control
the rate of SGPMCK.

> +
> +Optional properties:
> +
> +- clocks                : A phandle to the clock to use for debounce 
> timings

We need this, but not for the reason specified, and it should be a
required property. We need PCLK (the APB clock) to derive the SGPIO
bus frequency. Despite what the datasheet blurb says, there's no
debounce control for the SGPIO master (this is a copy/paste mistake
from the description of the parallel GPIO master).

> +
> +The sgpio and interrupt properties are further described in their 
> respective
> +bindings documentation:
> +
> +- Documentation/devicetree/bindings/sgpio/gpio.txt
> +- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +  Example:
> +	sgpio at 1e780200 {
> +		#gpio-cells = <2>;
> +		compatible = "aspeed,ast2500-sgpio";
> +		gpio-controller;
> +		interrupts = <40>;
> +		reg = <0x1e780200 0x0100>;
> +		interrupt-controller;
> +	};

You'll need to fix up the example after making the changes mentioned
above.

Andrew

> -- 
> 2.7.4
> 
>
