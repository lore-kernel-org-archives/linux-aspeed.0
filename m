From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 03 Apr 2024 10:09:37 +1030
Subject: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
In-Reply-To: <65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
	 <65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net>
Message-ID: <99fa05be32787c88150c6df2f882e31582aebf90.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-04-02 at 16:30 -0700, Zev Weiss wrote:
> On Tue, Apr 02, 2024 at 05:01:18AM PDT, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/watchdog at 1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> > ```
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
> > .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
> > 2 files changed, 130 insertions(+), 73 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> > delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> > new file mode 100644
> > index 000000000000..10fcb50c4051
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> > @@ -0,0 +1,130 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed watchdog timer controllers
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-wdt
> > +      - aspeed,ast2500-wdt
> > +      - aspeed,ast2600-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks: true
> > +
> > +  aspeed,reset-type:
> > +    enum:
> > +      - cpu
> > +      - soc
> > +      - system
> > +      - none
> > +    description: |
> > +      Reset behaviour - The watchdog can be programmed to generate one of three
> > +      different types of reset when a timeout occcurs.
> > +
> > +      Specifying 'cpu' will only reset the processor on a timeout event.
> > +
> > +      Specifying 'soc' will reset a configurable subset of the SoC's controllers
> 
> Might be worth clarifying that it's configurable only on ast2500 & 
> ast2600, and which property (aspeed,reset-mask) configures it?

Good point, will do.

> 
> > +      on a timeout event. Controllers critical to the SoC's operation may remain untouched.
> > +
> > +      Specifying 'system' will reset all controllers on a timeout event, as if EXTRST had been asserted.
> > +      Specifying "none" will cause the timeout event to have no reset effect.
> 
> Tiny nit: quoting (single vs. double) is slightly inconsistent between 
> values here.

Ack.

> 
> > +      Another watchdog engine on the chip must be used for chip reset operations.
> > +
> > +      The default reset type is "system"
> > +
> > +  aspeed,alt-boot:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      Direct the watchdog to configure the SoC to boot from the alternative boot
> > +      region if a timeout occurs.
> > +
> > +  aspeed,external-signal:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      Assert the timeout event on an external signal pin associated with the
> > +      watchdog controller instance. The pin must be muxed appropriately.
> > +
> > +  aspeed,ext-pulse-duration:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The duration, in microseconds, of the pulse emitted on the external signal pin
> > +
> > +  aspeed,ext-push-pull:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      If aspeed,external-signal is specified in the node, set the external
> > +      signal pin's drive type to push-pull. If aspeed,ext-push-pull is not
> > +      specified then the pin is configured as open-drain.
> > +
> > +  aspeed,ext-active-high:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      If both aspeed,external-signal and aspeed,ext-push-pull are specified in
> > +      the node, set the pulse polarity to active-high. If aspeed,ext-active-high
> > +      is not specified then the pin is configured as active-low.
> > +
> > +  aspeed,reset-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      A bitmaks indicating which peripherals will be reset if the watchdog
> 
> Typo: "bitmask"

Good catch.

Thanks,

Andrew
