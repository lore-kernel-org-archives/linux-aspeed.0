From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Jul 2018 10:08:16 -0600
Subject: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
In-Reply-To: <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org>
 <20180703223046.GA20184@rob-hp-laptop>
 <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
Message-ID: <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 3, 2018 at 7:16 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2018-07-03 at 16:30 -0600, Rob Herring wrote:
> > On Wed, Jun 27, 2018 at 09:26:02AM +1000, Benjamin Herrenschmidt wrote:
> > > This isn't per-se a real device, it's a pseudo-device that
> > > represents the use of the Aspeed built-in ColdFire to
> > > implement the FSI protocol by bitbanging the GPIOs instead
> > > of doing it from the ARM core.
> > >
> > > Thus it's a drop-in replacement for the existing
> > > fsi-master-gpio pseudo-device for use on systems for which
> > > a corresponding firmware file exists. It has most of the
> > > same properties, plus some more needed to operate the
> > > coprocessor.
> > >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > >  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > > new file mode 100644
> > > index 000000000000..50913ae685cc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > > @@ -0,0 +1,36 @@
> > > +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> > > +------------------------------------------------------------------------
> > > +
> > > +Required properties:
> > > + - compatible =
> > > +                 "fsi-master-ast-2400-cf" for an AST2400 based system
> > > +       or
> > > +         "fsi-master-ast-2500-cf" for an AST2500 based system
> >
> > <vendor>,<soc>-<block>
>
> It's not really a SOC block from a vendor, it's a pseudo-device in a
> way. The current one that doesn't use the coldfire offload is just
> compatible "fsi-master-gpio".
>
> I can add a vendor but what should it be ? aspeed because it runs on
> the aspeed SoCs only ? ibm because we wrote it and FSI is an IBM
> protocol ?

I would say aspeed as it is tied to their chip.

>
> <soc>-<block> doesn't make sense here though.

But you do already have <soc> in the compatible, but in a slightly
different form and position. And "cf" is the block.

So I'd propose: aspeed,ast2500-cf-fsi-master

>
> > > +
> > > + - clock-gpios = <gpio-descriptor>;        : GPIO for FSI clock
> > > + - data-gpios = <gpio-descriptor>; : GPIO for FSI data signal
> > > + - enable-gpios = <gpio-descriptor>;       : GPIO for enable signal
> > > + - trans-gpios = <gpio-descriptor>;        : GPIO for voltage translator enable
> > > + - mux-gpios = <gpio-descriptor>;  : GPIO for pin multiplexing with other
> >
> > So the gpio info is pased to the CF? Otherwise, what's the point of
> > having these in DT?
>
> In the original version you are looking at, they are not passed to the
> CF per-se but the driver does use aspeed GPIO specific APIs to
> configure them to be owned by the CF, so we need the references.

Okay.

> However, I've just reworked the ucode with a few tricks to avoid losing
> singificant performance, so that we can indeed pass them to the CF,
> thus avoiding the need for a per-system image, so the above are here to
> stay.
>
> > > +                                          functions (eg, external FSI masters)
> > > + - memory-region = <phandle>;              : Reference to the reserved memory for
> > > +                                          the ColdFire. Must be 2M aligned on
> > > +                                     AST2400 and 1M aligned on AST2500
> > > + - sram = <phandle>;                       : Reference to the SRAM node.
> > > + - cvic = <phandle>;                       : Reference to the CVIC node.
> >
> > Vendor prefixes.
>
> On what ? Why would an "sram" pointer have a vendor prefix ? Or a
> memory region pointer ?

memory-region is a standard property. sram and cvic are not, so should
have vendor prefixes. However, perhaps we should add a common "sram"
property to sram/sram.txt.

Rob
