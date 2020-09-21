From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Sep 2020 01:56:40 +0000
Subject: [PATCH 1/3] dt-bindings: aspeed: Add silicon id node to SCU
In-Reply-To: <644a9acb-e1a6-4077-ac15-15dad58144dc@www.fastmail.com>
References: <20200916084703.778386-1-joel@jms.id.au>
 <20200916084703.778386-2-joel@jms.id.au>
 <644a9acb-e1a6-4077-ac15-15dad58144dc@www.fastmail.com>
Message-ID: <CACPK8Xc1wjjH1ki1hwhT3L=s8rrPyzcxZNfOQy72UwDM-SvbSQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2020 at 23:45, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 16 Sep 2020, at 18:17, Joel Stanley wrote:
> > Different Aspeed families have various unique hardware silicon
> > identifiers within the SoC.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-scu.txt    | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > index 4d92c0bb6687..fff3151f06ee 100644
> > --- a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > @@ -20,3 +20,26 @@ syscon: syscon at 1e6e2000 {
> >       #clock-cells = <1>;
> >       #reset-cells = <1>;
> >  };
> > +
> > +Silicon ID
> > +-----------------
> > +
> > +Families have unique hardware silicon identifiers within the SoC.
> > +
> > +Required properties:
> > +
> > + - compatible:               "aspeed,silicon-id" or:
> > +                     "aspeed,ast2400-silicon-id" or
> > +                     "aspeed,ast2501-silicon-id" or
>
> aspeed,ast2510-silicon-id

It was supposed to be 2500. Good catch.

>
> > +                     "aspeed,ast2600-silicon-id"
> > +
> > + - reg:                      offset and length of the silicon id information
> > +                     optionally, a second offset and length describes the unique chip id
>
> What about chips with multiple silicon ID regs? I guess we just pick a sensible
> one, though given recent events maybe we should make an explicit note for the
> 2600?

I will add a note saying the 2600 should be the unique one, not
useless backwards compatible one.

Cheers,

Joel
