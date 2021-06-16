From: Rob Herring <robh@kernel.org>
Date: Wed, 16 Jun 2021 09:20:44 -0600
Subject: [PATCH v5 02/10] dt-bindings: aspeed-sgpio: Add ast2600 sgpio
 compatibles.
In-Reply-To: <f639f1bb-fe53-4c15-a6dd-91b45ea7eef1@www.fastmail.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <20210608102547.4880-3-steven_lee@aspeedtech.com>
 <20210610162320.GA1910317@robh.at.kernel.org>
 <f639f1bb-fe53-4c15-a6dd-91b45ea7eef1@www.fastmail.com>
Message-ID: <CAL_JsqJ_nwwyCBDg9p+AnriKw=9dC0WmLCw7dcz6qA87hRAu5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 10, 2021 at 5:27 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 11 Jun 2021, at 01:53, Rob Herring wrote:
> > On Tue, Jun 08, 2021 at 06:25:37PM +0800, Steven Lee wrote:
> > > AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> > > with 80 pins. Add ast2600-sgpiom0-80 and ast2600-sgpiom-128 compatibles
> > > and update descriptions to introduce the max number of available gpio
> > > pins that AST2600 supported.
> > >
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > > index b2ae211411ff..0e42eded3c1e 100644
> > > --- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > > +++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> > > @@ -10,9 +10,10 @@ maintainers:
> > >    - Andrew Jeffery <andrew@aj.id.au>
> > >
> > >  description:
> > > -  This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80 full
> > > -  featured Serial GPIOs. Each of the Serial GPIO pins can be programmed to
> > > -  support the following options
> > > +  This SGPIO controller is for ASPEED AST2400, AST2500 and AST2600 SoC,
> > > +  AST2600 have two sgpio master one with 128 pins another one with 80 pins,
> > > +  AST2500/AST2400 have one sgpio master with 80 pins. Each of the Serial
> > > +  GPIO pins can be programmed to support the following options
> > >    - Support interrupt option for each input port and various interrupt
> > >      sensitivity option (level-high, level-low, edge-high, edge-low)
> > >    - Support reset tolerance option for each output port
> > > @@ -25,6 +26,8 @@ properties:
> > >      enum:
> > >        - aspeed,ast2400-sgpio
> > >        - aspeed,ast2500-sgpio
> > > +      - aspeed,ast2600-sgpiom-80
> > > +      - aspeed,ast2600-sgpiom-128
> >
> > If the number of GPIOs is the only difference, then I don't think you
> > should get rid of ngpios. It's one thing if it varies from one SoC to
> > the next, but if something is per instance we should have a property.
> >
>
> There are two issues:
>
> 1. The maximum number of GPIOs supported by the controller
> 2. The maximum number of GPIOs supported by the platform
>
> These are different because of what the controller does - here's some previous discussion on the topic:
>
> https://lore.kernel.org/linux-gpio/f2875111-9ba9-43b7-b2a4-d00c8725f5a0 at www.fastmail.com/
>
> We've used ngpios to describe 2; this decision was made prior to the 2600 design - the SGPIO controller for both the 2400 and 2500 supported a maximum of 80 GPIOs. With the 2600 we have to differentiate between the two SGPIO controllers because they support a different maximum number of GPIOs. The proposed approach of different compatibles keeps the behaviour of ngpios the same across all controller implementations.

Okay, that makes sense.

Reviewed-by: Rob Herring <robh@kernel.org>
