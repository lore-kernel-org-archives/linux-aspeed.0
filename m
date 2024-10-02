From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 02 Oct 2024 11:17:49 +0930
Subject: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 four NICs
In-Reply-To: <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
	 <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
	 <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <ac786013183162b78181de85fd72b1eb7df81e3d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-10-01 at 07:52 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> 
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Tuesday, October 1, 2024 8:37 AM
> > To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > <joel@jms.id.au>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four
> > NICs
> > 
> >  [External Sender]
> > 
> >  [External Sender]
> > 
> > On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > 
> > > Add i2c-mux on Spider board for four NICs and add the temperature
> > > sensor and EEPROM for the NICs.
> > > 
> > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > > ---
> > >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75
> > > ++++++++++++++++++-
> > >  1 file changed, 72 insertions(+), 3 deletions(-)
> > > 
> > > diff --git
> > > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > index dbc992a625b7..b813140b3c5b 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > @@ -26,6 +26,10 @@ aliases {
> > >               i2c21 = &imux21;
> > >               i2c22 = &imux22;
> > >               i2c23 = &imux23;
> > > +             i2c24 = &imux24;
> > > +             i2c25 = &imux25;
> > > +             i2c26 = &imux26;
> > > +             i2c27 = &imux27;
> > >               i2c34 = &imux34;
> > >               i2c35 = &imux35;
> > >       };
> > > @@ -1196,8 +1200,9 @@ adc at 35 {
> > >  };
> > > 
> > >  &i2c15 {
> > > +     #address-cells = <1>;
> > > +     #size-cells = <0>;
> > >       status = "okay";
> > > -     mctp-controller;
> > 
> > Why are you deleting this if you're not also deleting the MCTP endpoint node?
> > 
> > Unless there's some reason this is related to the NICs, this should be its own
> > patch with its own justification.
> > 
> > Andrew
> Hi Andrew,
> 
> We have discussed with Jeremy from Code Construct about removing the
> mctp-controller on bus 15 before.
> 
> He thought it would be better to add the mctp-controller on each i2c mux port
> so the MCTP driver would ensure that the mux was configured properly before
> communicating with the device.
> 
> I'll split a patch to remove the mctp-controller on bus 15 in next serial of patches.

Ah, so having looked through v2, I can see what you're trying to
achieve. I don't think it's necessary to split this out from the NIC
mux patch, they are related.

Andrew
