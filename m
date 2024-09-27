From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 27 Sep 2024 09:24:11 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
In-Reply-To: <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Friday, September 27, 2024 1:57 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
> IOE on Spider Board
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Thu, 2024-09-26 at 10:41 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Add I2C mux for CPLD IOE on Spider Board.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 67
> > +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git
> > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98477792aa00..ea1a9c765483 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -17,6 +17,9 @@ aliases {
> >               serial6 = &uart7;
> >               serial7 = &uart8;
> >               serial8 = &uart9;
> > +
> > +             i2c28 = &imux28;
> > +             i2c29 = &imux29;
> >       };
> >
> 
> Have you tried to apply all of your individual yosemite4 patches together in
> one branch? I have, and unfortunately I can't apply them all, because they
> generate conflicts with each other.
> 
> If your patches have context dependencies you need to send them as a single
> series and not separate patches that cannot be properly combined.
> 
> Please assess the remaining yosemite4 devicetree patches (those you haven't
> received a thank-you email for) and send an appropriately constructed series
> so they can all be applied together, based on the tree here:
> 
> https://urldefense.com/v3/__https://github.com/amboar/linux/tree/for/bmc/d
> t__;!!J63qqgXj!KnZT-wO8ksK53BvGiFMdhhNgCnQ98FQLMdHeyYOSGsPw2KG1
> MNeJjvsZz4zuX7YegeuLfSsa9q9ZEBriDYsTTu8LjuM$
> 
> Please also indicate in the cover letter (with links to lore) which remaining
> patches are truly independent that still need to be applied.
> 
> Thanks,
> 
> Andrew
Hi Andrew

Would like to ask should I base on the openbmc/linux repo to create the
remaining patches that have context dependencies and add the lore link
of the those patches that I've sent in the cover letter?

Ricky

