From: Joel Stanley <joel@jms.id.au>
Date: Tue, 30 Mar 2021 23:26:56 +0000
Subject: [PATCH 2/3] dt-bindings: serial: 8250: update for aspeed,
 sirq-active-high
In-Reply-To: <20210330223902.GA837825@robh.at.kernel.org>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-3-zev@bewilderbeest.net>
 <20210330223902.GA837825@robh.at.kernel.org>
Message-ID: <CACPK8Xcfcsz7KCdfLuweGGbaxVKczhMb7+nxA9TMbsAbAbhi3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 30 Mar 2021 at 22:39, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 07:23:37PM -0500, Zev Weiss wrote:
> > Update DT bindings documentation for the new incarnation of the
> > aspeed,sirq-polarity-sense property.
>
> Why?
>
> This isn't a compatible change.

We want to depreciate support for this property. It should have never
been added to the bindings; in it's current form it describes a
relationship that afaict doesn't exist ("This unrelated register over
here dictates the polarity of your virtual serial port IRQ"). See
https://lore.kernel.org/lkml/20200812112400.2406734-1-joel at jms.id.au/

The intent is to remove it from both the bindings and the code.
There's already no users of it in any device tree.

How would you like Zev to go about doing this?

Cheers,

Joel

>
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index f54cae9ff7b2..0bbb7121f720 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -13,7 +13,7 @@ allOf:
> >    - $ref: /schemas/serial.yaml#
> >    - if:
> >        required:
> > -        - aspeed,sirq-polarity-sense
> > +        - aspeed,sirq-active-high
> >      then:
> >        properties:
> >          compatible:
> > @@ -181,13 +181,11 @@ properties:
> >    rng-gpios: true
> >    dcd-gpios: true
> >
> > -  aspeed,sirq-polarity-sense:
> > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +  aspeed,sirq-active-high:
> > +    type: boolean
> >      description: |
> > -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> > -      offset and bit number to identify how the SIRQ polarity should be
> > -      configured. One possible data source is the LPC/eSPI mode bit. Only
> > -      applicable to aspeed,ast2500-vuart.
> > +      Set to indicate that the SIRQ polarity is active-high (default
> > +      is active-low).  Only applicable to aspeed,ast2500-vuart.
> >
> >  required:
> >    - reg
> > @@ -227,7 +225,7 @@ examples:
> >          interrupts = <8>;
> >          clocks = <&syscon ASPEED_CLK_APB>;
> >          no-loopback-test;
> > -        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> > +        aspeed,sirq-active-high;
> >      };
> >
> >  ...
> > --
> > 2.31.1
> >
