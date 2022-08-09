From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 9 Aug 2022 00:59:01 +0000
Subject: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600
 i2C driver
In-Reply-To: <cd11b517-ae6c-4a67-9f43-74825812b00b@www.fastmail.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
 <20220516064900.30517-3-ryan_chen@aspeedtech.com>
 <5d863bc1-4f27-48b6-89ab-c3f02bc09057@www.fastmail.com>
 <SEZPR06MB5269DFE2CF762B62846D315EF2999@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <4c4462a6-e950-48cb-b9ba-822909a86867@www.fastmail.com>
 <SEZPR06MB52695BDBE90ECE00DB2D9684F29D9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <cd11b517-ae6c-4a67-9f43-74825812b00b@www.fastmail.com>
Message-ID: <SEZPR06MB5269B2ACF6D765E214FD6DF2F2629@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, August 9, 2022 8:35 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley <joel@jms.id.au>;
> Philipp Zabel <p.zabel@pengutronix.de>; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> openbmc at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600
> i2C driver
> 
> 
> 
> On Tue, 2 Aug 2022, at 18:34, Ryan Chen wrote:
> > Hello,
> >
> >> -----Original Message-----
> >> From: Andrew Jeffery <andrew@aj.id.au>
> >> Sent: Friday, July 29, 2022 11:13 AM
> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley
> >> <joel@jms.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> >> linux-arm-kernel at lists.infradead.org;
> >> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >> openbmc at lists.ozlabs.org
> >> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> >> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings
> >> for AST2600 i2C driver
> >>
> >>
> >>
> >> On Fri, 29 Jul 2022, at 12:33, Ryan Chen wrote:
> >> > Hello Andrew,
> >> >
> >> >> -----Original Message-----
> >> >> From: Andrew Jeffery <andrew@aj.id.au>
> >> >> Sent: Friday, July 29, 2022 10:29 AM
> >> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley
> >> >> <joel@jms.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> >> >> linux-arm-kernel at lists.infradead.org;
> >> >> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >> >> openbmc at lists.ozlabs.org
> >> >> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> >> >> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings
> >> >> for AST2600 i2C driver
> >> >>
> >> >> Hi Ryan,
> >> >>
> >> >> On Mon, 16 May 2022, at 16:18, ryan_chen wrote:
> >> >> > +    i2c0: i2c-bus at 80 {
> >> >> > +      #address-cells = <1>;
> >> >> > +      #size-cells = <0>;
> >> >> > +      #interrupt-cells = <1>;
> >> >> > +      compatible = "aspeed,ast2600-i2c-bus";
> >> >>
> >> >> This isn't quite right with respect to your binding description
> >> >> above
> >> >> :)
> >> > Yes, the compatible need to be " aspeed,ast2600-i2c" is that your point ?
> >>
> >> Yes, but only if we agree that we should have different compatibles
> >> for the different drivers. I'm not convinced about that yet.
> >>
> >> I think it's enough to have different Kconfig symbols, and select the
> >> old driver in aspeed_g4_defconfig, and the new driver in
> >> aspeed_g5_defconfig. Won't that gives us the right outcome without
> requiring a new set of compatibles?
> >>
> > The new driver in aspeed_g5_defconfig.
> 
> Right, behind a new Kconfig option.
> 
> > And different compatible string
> > claim will
> > Load the new or legacy driver,
> 
> I don't think we need this. It's enough to enable the new driver in the defconfig
> (and possibly disable the config option for the old driver).
> 
> > it should ok like the different
> > generation SOC. Have
> > different design.
> > Am I right?
> 
> We have SoC-specific compatibles already, so the new driver can just bind on
> the compatibles for the SoC revisions that have the new register interface. The
> old driver just binds to the device in the SoCs that have the old register
> interface.
> 
> There's an overlap in support between the two drivers, but for people who care
> about which implementation they use they can choose to exclude that driver
> from their kernel config.
> 
> None of this requires more compatibles be added.
> 
> Does that help?

The kernel device tree driver use compatibles string to separate the driver, 
like currently aspeed_g5_defconfig include the ast2500/ast2600.
So use dtsi/dts to separate which driver to loaded. Use can use dts to choice which 
driver to loaded.

So keep the dtsi/dts for user implement to loaded should be good, right?

> 
> Andrew
