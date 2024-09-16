From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Sep 2024 12:35:22 +0930
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506
 for CPLD IOE
In-Reply-To: <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
	 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <a18eff1095e1ddffa8eb44fb4a76a0b458213a62.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-13 at 03:26 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> 
> > -----Original Message-----
> > From: Delphine_CC_Chiu/WYHQ/Wiwynn
> > Sent: Friday, September 13, 2024 10:08 AM
> > To: Andrew Jeffery <andrew@codeconstruct.com.au>;
> > Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > <joel@jms.id.au>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> > Subject: RE: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506
> > for CPLD IOE
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Sent: Thursday, September 12, 2024 10:11 AM
> > > To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > > patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > > <joel@jms.id.au>
> > > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > > linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> > > Subject: Re: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio
> > > pca9506 for CPLD IOE
> > > 
> > >  [External Sender]
> > > 
> > >  [External Sender]
> > > 
> > > On Tue, 2024-09-10 at 13:47 +0800, Delphine CC Chiu wrote:
> > > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > > 
> > > > We use CPLD to emulate gpio pca9506 I/O expander on each server
> > > > boards.
> > > > Therefore, add pca9506 to probe driver for the CPLD I/O expander.
> > > 
> > > I think it might be best if you add your own compatible to the list in
> > > the gpio-pca95xx binding just in case there are some behavioural
> > > quirks of your CPLD implementation? Not sure if this should be
> > > "facebook,pca9506" or "wywinn,pca9506", but assuming facebook, from
> > > there you can specify
> > > 
> > >     compatible = "facebook,pca9506", "nxp,pca9506";
> > > 
> > > This allows you to add the quirks to the driver as required in the
> > > future through the more-specific compatible.
> > > 
> > > Andrew
> > 
> > Hi Andrew,
> > 
> > Thanks for the review.
> > I'll add the "facebook,pca9506" in gpio-pca95xx binding in next version of
> > patches.
> 
> Hi Andrew,
> 
> I tried to add "facebook,pca9506" in the compatible list of gpio-pca95xx binding
> and add compatible = "facebook,pca9506", "nxp,pca9506" but got following failed
> messages:
>     gpio at 21: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['facebook,pca9506', 'nxp,pca9506'] is too long
>         'diodes,pi4ioe5v6534q' was expected
>         'nxp,pcal6534' was expected
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> Would like to ask do you have any suggestions? Thanks.

Mmm, maybe it's best if we leave the compatible as just 'nxp,pca9506'
for now, but if you do discover quirks then we can consider this again.

Andrew
