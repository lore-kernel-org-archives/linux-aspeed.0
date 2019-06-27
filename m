From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 Jun 2019 13:32:30 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_1/8]_dt-bindings:_pinctrl:_aspeed:_Split_bindings_d?=
 =?UTF-8?Q?ocument_in_two?=
In-Reply-To: <CACPK8Xfdd1ReAHr9f6zRbZ-WJRquDJsTdUQeT_JuEBhOzS8tig@mail.gmail.com>
References: <20190626071430.28556-1-andrew@aj.id.au>
 <20190626071430.28556-2-andrew@aj.id.au>
 <CACPK8Xfdd1ReAHr9f6zRbZ-WJRquDJsTdUQeT_JuEBhOzS8tig@mail.gmail.com>
Message-ID: <226afe63-cc86-4920-abc1-025bdda32063@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 27 Jun 2019, at 13:02, Joel Stanley wrote:
> On Wed, 26 Jun 2019 at 07:15, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Have one for each of the AST2400 and AST2500. The only thing that was
> > common was the fact that both support ASPEED BMC SoCs.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  .../pinctrl/aspeed,ast2400-pinctrl.txt        | 80 +++++++++++++++++++
> >  ...-aspeed.txt => aspeed,ast2500-pinctrl.txt} | 63 ++-------------
> >  2 files changed, 85 insertions(+), 58 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> >  rename Documentation/devicetree/bindings/pinctrl/{pinctrl-aspeed.txt => aspeed,ast2500-pinctrl.txt} (66%)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> > new file mode 100644
> > index 000000000000..67e0325ccf2e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> > @@ -0,0 +1,80 @@
> > +=============================
> > +Aspeed AST2400 Pin Controller
> > +=============================
> > +
> > +Required properties for the AST2400:
> > +- compatible :                         Should be one of the following:
> > +                               "aspeed,ast2400-pinctrl"
> > +                               "aspeed,g4-pinctrl"
> > +
> > +The pin controller node should be the child of a syscon node with the required
> > +property:
> > +
> > +- compatible :                 Should be one of the following:
> > +                       "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +                       "aspeed,g4-scu", "syscon", "simple-mfd"
> 
> I think we can use this as an opportunity to drop the unused g4-scu
> compatible from the bindings. Similarly for the g5.

I Wonder if we should eradicate that pattern for all the aspeed compatibles?

> 
> Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Andrew
