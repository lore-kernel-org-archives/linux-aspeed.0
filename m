From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 10 May 2021 10:32:28 +0800
Subject: [PATCH v3 1/5] dt-bindings: mmc: sdhci-of-aspeed: Add an example
 for AST2600-A2 EVB
In-Reply-To: <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-2-steven_lee@aspeedtech.com>
 <20210507011324.GA1119409@robh.at.kernel.org>
 <20210507031348.GA23749@aspeedtech.com>
 <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
Message-ID: <20210510023228.GA6883@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/08/2021 01:21, Rob Herring wrote:
> On Thu, May 6, 2021 at 10:14 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > The 05/07/2021 09:13, Rob Herring wrote:
> > > On Thu, May 06, 2021 at 06:03:08PM +0800, Steven Lee wrote:
> > > > AST2600-A2 EVB has the reference design for enabling SD bus
> > > > power and toggling SD bus signal voltage by GPIO pins.
> > > >
> > > > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> > > > power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> > > > connected to a 1.8v and a 3.3v power load switch that providing
> > > > signal voltage to
> > > > SD1 bus.
> > > >
> > > > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > > > disabled.
> > > > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> > > > signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> > > > enabled, SD1 signal voltage becomes 1.8v.
> > > >
> > > > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > > > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> > > > GPIOV3 as power-switch-gpio.
> > > >
> > > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > > ---
> > > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 +++++++++++++++++-
> > > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > index 987b287f3bff..de7e61b3d37a 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > @@ -45,10 +45,16 @@ patternProperties:
> > > >
> > > >      properties:
> > > >        compatible:
> > > > -        enum:
> > > > -          - aspeed,ast2400-sdhci
> > > > -          - aspeed,ast2500-sdhci
> > > > -          - aspeed,ast2600-sdhci
> > > > +        oneOf:
> > > > +          - items:
> > > > +              - enum:
> > > > +                  - aspeed,ast2400-sdhci
> > > > +                  - aspeed,ast2500-sdhci
> > > > +                  - aspeed,ast2600-sdhci
> > > > +          - items:
> > > > +              - enum:
> > > > +                  - aspeed,ast2600-sdhci
> > > > +              - const: sdhci
> > >
> > > Why are you adding 'sdhci'. That's not useful as a compatible given how
> > > many quirks different implementations have.
> > >
> > >
> >
> > It is for passing the dtbs_check of the second example.
> > Without this definition, many device trees have the following
> > error:
> >
> > ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> > Additional items are not allowed ('sdhci' was unexpected)
> 
> I would probably fix the dts files then. Does anything depend on 'sdhci'?
> 

The build error is caused by my second example.
My example is refer to the aspeed-g6.dtsi to append "sdhci" after
"aspeed,ast2600-sdhci"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-g6.dtsi?h=v5.12#n561

As long as the second example is removed, the following error won't show in the dtbs_check result.

```
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml
  CHECK   arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml
  DTC     arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
  CHECK   arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc at 1e740000: sdhci at 1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc at 1e740000: sdhci at 1e740100:compatible: Additional items are not allowed ('sdhci' was unexpected)
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc at 1e740000: sdhci at 1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc at 1e740000: sdhci at 1e740200:compatible: Additional items are not allowed ('sdhci' was unexpected)
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

```

> Rob
