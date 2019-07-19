From: Hongwei Zhang <hongweiz@ami.com>
Date: Fri, 19 Jul 2019 16:37:24 -0400
Subject: dt-bindings: gpio: aspeed: Add SGPIO support 
In-Reply-To: <1563394325-15941-1-git-send-email-hongweiz@ami.com>
References: <1563394325-15941-1-git-send-email-hongweiz@ami.com>
Message-ID: <1563568644-10392-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew,

Thanks for reviewing and please see my inline comments.

--Hongwei

> From:	Andrew Jeffery <andrew@aj.id.au>
> Sent:	Wednesday, July 17, 2019 9:48 PM
> To:	Hongwei Zhang; Joel Stanley; Linus Walleij; devicetree at vger.kernel.org
> Cc:	Rob Herring; Mark Rutland; Bartosz Golaszewski; linux-aspeed at lists.ozlabs.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-gpio at vger.kernel.org
> Subject:	Re: [PATCH 2/3 v4] dt-bindings: gpio: aspeed: Add SGPIO support
> 
> The subject is largely correct, but please see the discussion on the driver patch about how to clean up 
> the [PATCH ...] prefix.
> 
> On Thu, 18 Jul 2019, at 05:42, Hongwei Zhang wrote:
> > Add bindings to support SGPIO on AST2400 or AST2500.
> > 
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > ---
> >  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 55 ++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 
> > Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > new file mode 100644
> > index 0000000..2d6305e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > @@ -0,0 +1,55 @@
> > +Aspeed SGPIO controller Device Tree Bindings
> > +-------------------------------------------
> > +
> > +This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80
> > full
> > +featured Serial GPIOs. Each of the Serial GPIO pins can be programmed
> > to
> > +support the following options:
> > +- Support interrupt option for each input port and various interrupt
> > +  sensitivity option (level-high, level-low, edge-high, edge-low)
> > +- Support reset tolerance option for each output port
> > +- Directly connected to APB bus and its shift clock is from APB bus
> > clock
> > +  divided by a programmable value.
> > +- Co-work with external signal-chained TTL components 
> > +(74LV165/74LV595)
> > +
> > +
> > +Required properties:
> > +
> > +- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
> > +
> > +- #gpio-cells 		: Should be two
> > +			  - First cell is the GPIO line number
> > +			  - Second cell is used to specify optional
> > +			    parameters (unused)
> > +
> > +- reg			: Address and length of the register set for the device
> > +- gpio-controller	: Marks the device node as a GPIO controller
> > +- interrupts		: Interrupt specifier (see interrupt bindings for
> > +			  details)
> > +
> > +- interrupt-controller	: Mark the GPIO controller as an 
> > interrupt-controller
> > +
> > +- nr-gpios		: number of GPIO pins to serialise. 
> > +			  (should be multiple of 8, up to 80 pins)
> 
> Please change the property name to "ngpios", as per the generic GPIO bindings[1].
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindi
> ngs/gpio/gpio.txt?h=v5.2#n141

done

> 
> Cheers,
> 
> Andrew
> 
> > +
> > +- clocks                : A phandle to the APB clock for SGPM clock 
> > division
> > +
> > +- bus-frequency		: SGPM CLK frequency
> > +
> > +
> > +The sgpio and interrupt properties are further described in their
> > respective bindings documentation:
> > +
> > +- Documentation/devicetree/bindings/sgpio/gpio.txt
> > +- 
> > +Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > +
> > +  Example:
> > +	sgpio: sgpio at 1e780200 {
> > +		#gpio-cells = <2>;
> > +		compatible = "aspeed,ast2500-sgpio";
> > +		gpio-controller;
> > +		interrupts = <40>;
> > +		reg = <0x1e780200 0x0100>;
> > +		clocks = <&syscon ASPEED_CLK_APB>;
> > +		interrupt-controller;
> > +		nr-gpios = <8>;
> > +		bus-frequency = <12000000>;
> > +	};
> > --
> > 2.7.4
> > 
> >
