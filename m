From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 19 Jun 2024 19:24:03 +0800
Subject: [PATCH 1/1] pinctrl: aspeed-g6: Add NCSI pin group config
In-Reply-To: <946f44526e3016f595bfe463cf0a7f5b4eaa084a.camel@codeconstruct.com.au>
References: <20240613080725.2531580-1-potin.lai.pt@gmail.com> <946f44526e3016f595bfe463cf0a7f5b4eaa084a.camel@codeconstruct.com.au>
Message-ID: <CAGfYmwVJvyEJ6sbvr=_OqNkiRSDBXn2uqMr28gN949NZd=5dcA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 17, 2024 at 3:33?PM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2024-06-13 at 16:07 +0800, Potin Lai wrote:
> > In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
> > needed on the management controller side.
> >
> > To optimize pin usage, add new NCSI pin groupis that excludes RMIIXRCLKO,
> > reducing the number of required pins.
>
> Hmm, I'm not convinced this is specific to NCSI (and it's an
> unfortunate mistake on my part), but we do need to call the groups
> something different than RMII[34]. Did you have any other suggestions?
>
I don't have better name for now.
In ast2600 data sheet, it also mentioned "RMII" & "NCSI" together most
of the time, is it ok to use "NCSI" as a new group name?

Best regards,
Potin
> >
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> > ---
> >  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > index 7938741136a2c..31e4e0b342a00 100644
> > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > @@ -249,7 +249,9 @@ PIN_DECL_2(E26, GPIOD3, RGMII3RXD3, RMII3RXER);
> >
> >  FUNC_GROUP_DECL(RGMII3, H24, J22, H22, H23, G22, F22, G23, G24, F23, F26, F25,
> >               E26);
> > -FUNC_GROUP_DECL(RMII3, H24, J22, H22, H23, G23, F23, F26, F25, E26);
> > +GROUP_DECL(RMII3, H24, J22, H22, H23, G23, F23, F26, F25, E26);
> > +GROUP_DECL(NCSI3, J22, H22, H23, G23, F23, F26, F25, E26);
> > +FUNC_DECL_2(RMII3, RMII3, NCSI3);
> >
> >  #define F24 28
> >  SIG_EXPR_LIST_DECL_SESG(F24, NCTS3, NCTS3, SIG_DESC_SET(SCU410, 28));
> > @@ -355,7 +357,9 @@ FUNC_GROUP_DECL(NRTS4, B24);
> >
> >  FUNC_GROUP_DECL(RGMII4, F24, E23, E24, E25, D26, D24, C25, C26, C24, B26, B25,
> >               B24);
> > -FUNC_GROUP_DECL(RMII4, F24, E23, E24, E25, C25, C24, B26, B25, B24);
> > +GROUP_DECL(RMII4, F24, E23, E24, E25, C25, C24, B26, B25, B24);
> > +GROUP_DECL(NCSI4, E23, E24, E25, C25, C24, B26, B25, B24);
> > +FUNC_DECL_2(RMII4, RMII4, NCSI4);
> >
> >  #define D22 40
> >  SIG_EXPR_LIST_DECL_SESG(D22, SD1CLK, SD1, SIG_DESC_SET(SCU414, 8));
> > @@ -1976,6 +1980,8 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
> >       ASPEED_PINCTRL_GROUP(MDIO2),
> >       ASPEED_PINCTRL_GROUP(MDIO3),
> >       ASPEED_PINCTRL_GROUP(MDIO4),
> > +     ASPEED_PINCTRL_GROUP(NCSI3),
> > +     ASPEED_PINCTRL_GROUP(NCSI4),
>
> You will need to update the binding document as well. I've poked Linus
> W about a series I sent that re-formats the binding function and group
> lists - it would be nice if you rework the patch on top of that:
>
> https://lore.kernel.org/lkml/5bf8e1dddd2b958a102e7b1b9f9c080a34f9deff.camel at codeconstruct.com.au/
>
> Cheers,
>
> Andrew
