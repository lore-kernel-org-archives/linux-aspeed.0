From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 26 Oct 2020 12:03:54 +1030
Subject: [PATCH 2/3] Arm: dts: aspeed-g6: Add sgpio node
In-Reply-To: <CACPK8XdYvSmwdAkBzAO3kC8_PYa3CtPkNb0VxcOhmb2UYz5zDA@mail.gmail.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-3-billy_tsai@aspeedtech.com>
 <CACPK8XdYvSmwdAkBzAO3kC8_PYa3CtPkNb0VxcOhmb2UYz5zDA@mail.gmail.com>
Message-ID: <8625b8b4-4b3b-49ce-b35c-5de3920dc5eb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 12 Oct 2020, at 15:05, Joel Stanley wrote:
> On Mon, 12 Oct 2020 at 03:32, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > This patch is used to add sgpiom and sgpios nodes and add compatiable
> > string for sgpiom.
> 
> You also need to add sgpios documentation to the bindings docs.
> 
> Whenever you add new device tree bindings to the kernel tree you
> should add documentation for them.
> 
> When preparing patches for submission, use scripts/checkpatch.pl to
> check for common issues. It will warn you if you are adding strings
> that are not documented.
> 
> Cheers,
> 
> Joel
> 
> >
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/gpio/sgpio-aspeed.txt |  8 +--
> >  arch/arm/boot/dts/aspeed-g6.dtsi              | 52 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > index d4d83916c09d..815d9b5167a5 100644
> > --- a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> > @@ -1,8 +1,10 @@
> >  Aspeed SGPIO controller Device Tree Bindings
> >  --------------------------------------------
> >
> > -This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80 full
> > -featured Serial GPIOs. Each of the Serial GPIO pins can be programmed to
> > +This SGPIO controller is for ASPEED AST2500/AST2600 SoC, it supports 2 master.
> > +One is up to 128 SGPIO input ports and 128 output ports concurrently(after AST2600A1)
> > +and Second one is up to 80.
> > +Each of the Serial GPIO pins can be programmed to
> >  support the following options:
> >  - Support interrupt option for each input port and various interrupt
> >    sensitivity option (level-high, level-low, edge-high, edge-low)
> > @@ -14,7 +16,7 @@ support the following options:
> >  Required properties:
> >
> >  - compatible : Should be one of
> > -  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio"
> > +  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio", "aspeed,ast2600-sgpiom"
> 
> I think we should add sgpiom strings for the ast2500 (and ast2400?)
> too, as this is how they should have been named in the first place:

Can we defer this discussion until someone adds support for the slave 
interface? Maybe the existing compatible could have done with some more 
thought, but it is what it is, and I don't think we need to muddy the waters 
further right now?

Andrew
