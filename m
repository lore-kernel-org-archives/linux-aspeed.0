From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 06:48:20 +0000
Subject: [PATCH v4 5/5] dt-bindings: clock: ast2600: Add reset config for I3C
In-Reply-To: <cbbb99ce6125048667e4c41412710a61dc4d686f.camel@codeconstruct.com.au>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
 <20230228091638.206569-6-jk@codeconstruct.com.au> <CACPK8XcA_SES=Wo7vuWEJ4U5kTizM5brmb=6ELXD-taCFJQwgA@mail.gmail.com>
 <cbbb99ce6125048667e4c41412710a61dc4d686f.camel@codeconstruct.com.au>
Message-ID: <CACPK8XfRg9vHYjC0rco4dr9pNY03vXTrmXaopOGBgdCq09LybQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 1 Mar 2023 at 06:29, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi Joel,
>
> > > diff --git a/include/dt-bindings/clock/ast2600-clock.h
> > > b/include/dt-bindings/clock/ast2600-clock.h
> > > index b4d69103d722..b1c129977910 100644
> > > --- a/include/dt-bindings/clock/ast2600-clock.h
> > > +++ b/include/dt-bindings/clock/ast2600-clock.h
> > > @@ -90,6 +90,12 @@
> > >  /* Only list resets here that are not part of a gate */
> >
> > These definitions are part of a gate, yeah?
>
> Well, no more "part of a gate" than all of the other definitions :)
>
> All the defines in this section are references to individual bits in
> the reset register banks in SCU040 & SCU050; the i3c set are the same
> as the others there.
>
> So I'm not sure what that comment is supposed to signify as to what
> qualifies as a "gate" in the context of a reset...

This is poor documentation from the author of the clock driver, which is me.

We only expose the reset lines in the device tree for resets that are
not associated with a clock line.

This is done because the aspeed docs specify we do a dance when enabling an IP:

 1. Place IP in reset
 2. Enable clock
 3. Delay
 4. Release reset

So we do this with the aspeed_g6_gates array. The rule is: any gate
with a number in the rst column doesn't have that reset line exposed.
That's what this cryptic comment in the header is warning about.

This was documented to some extent in the original commit message for
the 2400/2500 driver:

 https://git.kernel.org/torvalds/c/15ed8ce5f84e2b

We could hoist that out and put it in the source file(s).

Cheers,

Joel
