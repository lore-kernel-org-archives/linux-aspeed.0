From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 16 Jul 2019 17:48:31 -0400
Subject: [PATCH 2/3 v3] dt-bindings: gpio: aspeed: Add SGPIO support
Message-ID: <1563313711-17961-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add bindings to support SGPIO on AST2400 or AST2500.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
new file mode 100644
index 0000000..8c3a747
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
@@ -0,0 +1,55 @@
+Aspeed SGPIO controller Device Tree Bindings
+-------------------------------------------
+
+This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80 full 
+featured Serial GPIOs. Each of the Serial GPIO pins can be programmed to 
+support the following options:
+- Support interrupt option for each input port and various interrupt 
+  sensitivity option (level-high, level-low, edge-high, edge-low)
+- Support reset tolerance option for each output port
+- Directly connected to APB bus and its shift clock is from APB bus clock
+  divided by a programmable value.
+- Co-work with external signal-chained TTL components (74LV165/74LV595)
+
+
+Required properties:
+
+- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
+
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify optional
+			    parameters (unused)
+
+- reg			: Address and length of the register set for the device
+- gpio-controller	: Marks the device node as a GPIO controller.
+- interrupts		: Interrupt specifier (see interrupt bindings for
+			  details)
+
+- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
+
+- nr-gpios		: number of GPIO pins to serialise. 
+			  (should be multiple of 8, up to 80 pins; 0 if not used)
+
+- clocks               : A phandle to the APB clock for SGPM clock division
+
+- bus-frequency	: SGPM CLK frequency, derived from APB bus clock by a programmable devisor
+
+
+The sgpio and interrupt properties are further described in their respective bindings documentation:
+
+- Documentation/devicetree/bindings/sgpio/gpio.txt
+- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+  Example:
+	sgpio at 1e780200 {
+		#gpio-cells = <2>;
+		compatible = "aspeed,ast2500-sgpio";
+		gpio-controller;
+		interrupts = <40>;
+		reg = <0x1e780200 0x0100>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		interrupt-controller;
+		nr-gpios = <8>;
+		bus-frequency = <12000000>;
+	};
-- 
2.7.4


Thanks Andrew, please see above v3 and inline comments at below.
--Hongwei

> From:	Andrew Jeffery <andrew@aj.id.au>
> Sent:	Sunday, July 14, 2019 10:25 PM
> To:	Hongwei Zhang; Joel Stanley; Linus Walleij; devicetree at vger.kernel.org
> Cc:	Rob Herring; Mark Rutland; Bartosz Golaszewski; linux-aspeed at lists.ozlabs.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-gpio at vger.kernel.org
> Subject:	Re: [PATCH 2/3 v2] dt-bindings: gpio: aspeed: Add SGPIO support
> 
> Hello Hongwei,
> 
> On Sat, 13 Jul 2019, at 05:44, Hongwei Zhang wrote:
> > Add bindings to support SGPIO on AST2400 or AST2500.
> > 
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > ---
> >  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100755 
> > Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > new file mode 100755
> > index 0000000..3ae2b79
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > @@ -0,0 +1,43 @@
> > +Aspeed SGPIO controller Device Tree Bindings
> > +-------------------------------------------
> > +
> > +Required properties:
> > +- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
> > +
> > +- #gpio-cells 		: Should be two
> > +			  - First cell is the GPIO line number
> > +			  - Second cell is used to specify optional
> > +			    parameters (unused)
> > +
> > +- reg			: Address and length of the register set for the device
> > +- gpio-controller	: Marks the device node as a GPIO controller.
> > +- interrupts		: Interrupt specifier (see interrupt bindings for
> > +			  details)
> > +
> > +- interrupt-controller	: Mark the GPIO controller as an 
> > interrupt-controller
> > +
> > +- nr-gpios		: number of GPIO pins to serialise. (should be multiple of 
> > 8, up to 80 pins)
> > +			  if not specified, defaults to 80.
> 
> This appears to be a statement about the driver implementation, but bindings documents are about 
> describing hardware. Reading the datasheet it actually appears the ASPEED SGPIO hardware comes up 
> in what is "technically" a forbidden state (equivalent to `nr-gpios = <0>;`), though the device is also 
> disabled at this point, so it's probably moot. The point is the true default value from a hardware 
> perspective is 0, not 80, so if we're going to talk about default values, 0 would be more appropriate. 
> However:
> 
> You've also listed nr-gpios under the "Required properties" header, but the description suggests it's 
> optional. It's either one or the other, please lets be clear about it. On that front, lets make it nr-gpios 
> *not* optional (i.e. make it
> required) thus force the specification of how many SGPIOs we want to emit on the bus. This value is 
> coupled to the platform design, so I don't think there's ever a scenario where we want nr-gpios to take a 
> default value.
> 

Added some descriptions and updated nr-gpios, please see v3.

> > +
> > +- clocks               : A phandle to the APB clock for SGPM clock 
> > division
> > +
> > +- bus-frequency	: SGPM CLK frequency, if not specified defaults to 1 
> > MHz
> 
> Again here with the default value - SGPM CLK period is derived from PCLK by the expression `period = 
> PCLK * 2 *(GPIO254[31:16] + 1)`, where GPIO254's initialisation state is `GPIO254[31:16] = 0`, which 
> gives a default SGPM bus frequency of PCLK / 2. This is likely not going to be 1MHz (more like ~12MHz).
> 
> Lets just make the property required. That way we avoid any ambiguity about the bus frequency and 
> thus don't need words about defaults that turn out to be about the driver, not about the hardware.
> 

updated, please see v3.

> Finally, when updating patches in response to feedback, please send the full series again, and bump the 
> series version number. That way people can review a coherent set of patches and not have to hunt 
> around and (fail to) collate the correct combination. It makes it easier to say "Reviewed-by:" on your 
> patches :)
> 
> Cheers,
> 
> Andrew
