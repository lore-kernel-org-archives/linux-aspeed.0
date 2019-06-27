From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 Jun 2019 13:27:49 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_5/8]_pinctrl:_aspeed:_Correct_comment_that_is_no_lo?=
 =?UTF-8?Q?nger_true?=
In-Reply-To: <CACPK8XcPxJAOBAnKMKxtiG4Fkz8BPf8KtW1Kc3A9tU_emQviVg@mail.gmail.com>
References: <20190626071430.28556-1-andrew@aj.id.au>
 <20190626071430.28556-6-andrew@aj.id.au>
 <CACPK8XcPxJAOBAnKMKxtiG4Fkz8BPf8KtW1Kc3A9tU_emQviVg@mail.gmail.com>
Message-ID: <835ac4e3-6ee4-4c3f-913b-93629d7e8080@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 27 Jun 2019, at 13:00, Joel Stanley wrote:
> On Wed, 26 Jun 2019 at 07:16, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > We have handled the GFX register case for quite some time now.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/pinctrl/aspeed/pinctrl-aspeed.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
> > index 4b06ddbc6aec..c5918c4a087c 100644
> > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
> > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
> > @@ -240,8 +240,7 @@
> >   * opposed to naming them e.g. PINMUX_CTRL_[0-9]). Further, signal expressions
> >   * reference registers beyond those dedicated to pinmux, such as the system
> >   * reset control and MAC clock configuration registers. The AST2500 goes a step
> 
> AST2600 too?

No mention of the GFX block in the pinctrl table for the 2600, it appears the pinmux
state is entirely determined by SCU registers.

> 
> Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Andrew

> 
> > - * further and references registers in the graphics IP block, but that isn't
> > - * handled yet.
> > + * further and references registers in the graphics IP block.
> >   */
> >  #define SCU2C           0x2C /* Misc. Control Register */
> >  #define SCU3C           0x3C /* System Reset Control/Status Register */
> > --
> > 2.20.1
> >
>
