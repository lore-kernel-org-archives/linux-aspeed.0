From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 07 Jul 2018 11:50:11 +1000
Subject: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
In-Reply-To: <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org>
 <20180703223046.GA20184@rob-hp-laptop>
 <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
 <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
Message-ID: <88292b993583020fc28bf0d23177cbd06732d7fc.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-07-05 at 10:08 -0600, Rob Herring wrote:
> 
> > It's not really a SOC block from a vendor, it's a pseudo-device in a
> > way. The current one that doesn't use the coldfire offload is just
> > compatible "fsi-master-gpio".
> > 
> > I can add a vendor but what should it be ? aspeed because it runs on
> > the aspeed SoCs only ? ibm because we wrote it and FSI is an IBM
> > protocol ?
> 
> I would say aspeed as it is tied to their chip.
> 
> > 
> > <soc>-<block> doesn't make sense here though.
> 
> But you do already have <soc> in the compatible, but in a slightly
> different form and position. And "cf" is the block.
>
> So I'd propose: aspeed,ast2500-cf-fsi-master

Ok, I'll do that.

> > 
> > > > +
> > > > + - clock-gpios = <gpio-descriptor>;        : GPIO for FSI clock
> > > > + - data-gpios = <gpio-descriptor>; : GPIO for FSI data signal
> > > > + - enable-gpios = <gpio-descriptor>;       : GPIO for enable signal
> > > > + - trans-gpios = <gpio-descriptor>;        : GPIO for voltage translator enable
> > > > + - mux-gpios = <gpio-descriptor>;  : GPIO for pin multiplexing with other
> > > 
> > > So the gpio info is pased to the CF? Otherwise, what's the point of
> > > having these in DT?
> > 
> > In the original version you are looking at, they are not passed to the
> > CF per-se but the driver does use aspeed GPIO specific APIs to
> > configure them to be owned by the CF, so we need the references.
> 
> Okay.
> 
> > However, I've just reworked the ucode with a few tricks to avoid losing
> > singificant performance, so that we can indeed pass them to the CF,
> > thus avoiding the need for a per-system image, so the above are here to
> > stay.
> > 
> > > > +                                          functions (eg, external FSI masters)
> > > > + - memory-region = <phandle>;              : Reference to the reserved memory for
> > > > +                                          the ColdFire. Must be 2M aligned on
> > > > +                                     AST2400 and 1M aligned on AST2500
> > > > + - sram = <phandle>;                       : Reference to the SRAM node.
> > > > + - cvic = <phandle>;                       : Reference to the CVIC node.
> > > 
> > > Vendor prefixes.
> > 
> > On what ? Why would an "sram" pointer have a vendor prefix ? Or a
> > memory region pointer ?
> 
> memory-region is a standard property. sram and cvic are not, so should
> have vendor prefixes. However, perhaps we should add a common "sram"
> property to sram/sram.txt.

Hrm... originally vendor prefix on properties were for things that
didn't have a binding afaik. IE a way for an f-code driver to stash
things in the DT that were vendor specific and retrieve them from the
OS driver for example.

Here with well defined bindings it's rather bloaty don't you think ? I
don't strongly object to doing it, it's just a bit ... odd.

Cheers,
Ben.

