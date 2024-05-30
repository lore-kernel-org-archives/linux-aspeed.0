From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 30 May 2024 10:18:10 +0930
Subject: [PATCH 1/4] dt-bindings: gpio: aspeed,sgpio: Order properties
 by DTS style
In-Reply-To: <080c4c05-e795-49d8-a547-d39d10ed8333@kernel.org>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
	 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-1-91c42976833b@codeconstruct.com.au>
	 <080c4c05-e795-49d8-a547-d39d10ed8333@kernel.org>
Message-ID: <1bcaba5063820df7fd87d887835c42e2faad9d86.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-29 at 09:26 +0200, Krzysztof Kozlowski wrote:
> On 29/05/2024 07:13, Andrew Jeffery wrote:
> > Tidy up the list of required properties and the example node by ordering
> > the properties in terms of the DTS coding style.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > index 46bb121360dc..6b15a3a3fb66 100644
> > --- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > @@ -51,12 +51,12 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - gpio-controller
> > -  - '#gpio-cells'
> > +  - clocks
> >    - interrupts
> >    - interrupt-controller
> > +  - gpio-controller
> > +  - '#gpio-cells'
> >    - ngpios
> > -  - clocks
> >    - bus-frequency
> 
> No, this should have the same order as properties are listed.
> 
> Don't change it.

Ack.

> 
> >  
> >  additionalProperties: false
> > @@ -65,13 +65,13 @@ examples:
> >    - |
> >      #include <dt-bindings/clock/aspeed-clock.h>
> >      sgpio: sgpio at 1e780200 {
> > -        #gpio-cells = <2>;
> >          compatible = "aspeed,ast2500-sgpio";
> > -        gpio-controller;
> > -        interrupts = <40>;
> >          reg = <0x1e780200 0x0100>;
> >          clocks = <&syscon ASPEED_CLK_APB>;
> > +        interrupts = <40>;
> >          interrupt-controller;
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> 
> That's just example. I don't find this change useful but churn.

Sure, I'll drop the patch.

Thanks,

Andrew
