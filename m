From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 2 Sep 2024 08:23:39 +0000
Subject: [PATCH v1 1/2] dt-bindings: gpio: aspeed,ast2400-gpio: Support
 ast2700
In-Reply-To: <20240821070740.2378602-2-billy_tsai@aspeedtech.com>
References: <20240821070740.2378602-1-billy_tsai@aspeedtech.com>
 <20240821070740.2378602-2-billy_tsai@aspeedtech.com>
Message-ID: <OSQPR06MB72523232F3596E3479D2785F8B922@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

I'm sorry for missing your comment.

I will remove the example in the next version of the patch.

Thanks

Best Regards,
Billy Tsai

> > The AST2700 is the 7th generation SoC from Aspeed, featuring two GPIO
> > controllers: one with 12 GPIO pins and another with 216 GPIO pins.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 46 ++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/> aspeed,ast2400-gpio.yaml
> > index cf11aa7ec8c7..4d439972c14b 100644
> > --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > @@ -15,6 +15,7 @@ properties:
> >        - aspeed,ast2400-gpio
> >        - aspeed,ast2500-gpio
> >        - aspeed,ast2600-gpio
> > +      - aspeed,ast2700-gpio
> >  
> >    reg:
> >      maxItems: 1
> > @@ -42,7 +43,7 @@ properties:
> >      const: 2
> >  
> >    ngpios:
> > -    minimum: 36
> > +    minimum: 12
> >      maximum: 232
> >  
> >  required:
> > @@ -93,6 +94,20 @@ allOf:
> >            enum: [ 36, 208 ]
> >        required:
> >          - ngpios
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: aspeed,ast2700-gpio
> > +    then:
> > +      properties:
> > +        gpio-line-names:
> > +          minItems: 12
> > +          maxItems: 216
> > +        ngpios:
> > +          enum: [ 12, 216 ]
> > +      required:
> > +        - ngpios
> >  
> >  additionalProperties: false
> >  
> > @@ -146,3 +161,32 @@ examples:
> >          gpio-ranges = <&pinctrl 0 208 36>;
> >          ngpios = <36>;
> >      };
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +        gpio2: gpio at 14c0b000 {
> > +            compatible = "aspeed,ast2700-gpio";

> No need for new example, no relavant/important differences here.


> +            reg = <0x0 0x14c0b000 0x0 0x1000>;
> +            interrupts-extended = <&soc1_intc2 18>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            #gpio-cells = <2>;
> +            gpio-controller;
> +            gpio-ranges = <&pinctrl1 0 0 216>;
> +            ngpios = <216>;
> +        };
> +
> +        gpio3: gpio at 12c11000 {
> +            compatible = "aspeed,ast2700-gpio";

> Especially for two the same examples...
