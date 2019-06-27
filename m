From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Jun 2019 04:07:03 +0000
Subject: [PATCH 1/8] dt-bindings: pinctrl: aspeed: Split bindings document
 in two
In-Reply-To: <226afe63-cc86-4920-abc1-025bdda32063@www.fastmail.com>
References: <20190626071430.28556-1-andrew@aj.id.au>
 <20190626071430.28556-2-andrew@aj.id.au>
 <CACPK8Xfdd1ReAHr9f6zRbZ-WJRquDJsTdUQeT_JuEBhOzS8tig@mail.gmail.com>
 <226afe63-cc86-4920-abc1-025bdda32063@www.fastmail.com>
Message-ID: <CACPK8Xd3Cf8zRSTLVbcTQTu+4aEp1qhmkaFAF4AcfJMkky3gYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2019 at 04:02, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 27 Jun 2019, at 13:02, Joel Stanley wrote:
> > On Wed, 26 Jun 2019 at 07:15, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Have one for each of the AST2400 and AST2500. The only thing that was
> > > common was the fact that both support ASPEED BMC SoCs.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  .../pinctrl/aspeed,ast2400-pinctrl.txt        | 80 +++++++++++++++++++
> > >  ...-aspeed.txt => aspeed,ast2500-pinctrl.txt} | 63 ++-------------
> > >  2 files changed, 85 insertions(+), 58 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> > >  rename Documentation/devicetree/bindings/pinctrl/{pinctrl-aspeed.txt => aspeed,ast2500-pinctrl.txt} (66%)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> > > new file mode 100644
> > > index 000000000000..67e0325ccf2e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
> > > @@ -0,0 +1,80 @@
> > > +=============================
> > > +Aspeed AST2400 Pin Controller
> > > +=============================
> > > +
> > > +Required properties for the AST2400:
> > > +- compatible :                         Should be one of the following:
> > > +                               "aspeed,ast2400-pinctrl"
> > > +                               "aspeed,g4-pinctrl"
> > > +
> > > +The pin controller node should be the child of a syscon node with the required
> > > +property:
> > > +
> > > +- compatible :                 Should be one of the following:
> > > +                       "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > > +                       "aspeed,g4-scu", "syscon", "simple-mfd"
> >
> > I think we can use this as an opportunity to drop the unused g4-scu
> > compatible from the bindings. Similarly for the g5.
>
> I Wonder if we should eradicate that pattern for all the aspeed compatibles?

Yes. We've settled on ast2x00,aspeed-<foo> for most of them. If you're
aware of others we should remove them from the bindings.

I think we've stopped any new users of the gx style from getting merged.
