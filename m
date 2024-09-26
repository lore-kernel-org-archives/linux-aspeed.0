From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 01:42:56 +0000
Subject: [PATCH v19 1/2] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
In-Reply-To: <59baad7d486637f7f82f2730181734eca047efd7.camel@codeconstruct.com.au>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240920070449.3871705-2-Delphine_CC_Chiu@wiwynn.com>
 <59baad7d486637f7f82f2730181734eca047efd7.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853D45F7E64EBF3042E044BD66A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Monday, September 23, 2024 9:02 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v19 1/2] ARM: dts: aspeed: yosemite4: Revise i2c-mux
> devices
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Fri, 2024-09-20 at 15:04 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Revise Yosemite 4 devicetree for devices behind i2c-mux
> > - Add gpio and eeprom behind i2c-mux
> > - Remove redundant idle-state setting for i2c-mux
> > - Revise address of max31790 devices after i2c-mux.
> > - Fix warnings reporting by dts checking tool.
> 
> Can you be more specific here? If you've had to fix existing warnings that the
> devicetree produces you should split those out into commits separate from
> adding further nodes. Instead, if you're just fixing warnings that this patch
> itself introduced then you should drop this comment as it's just a process issue.
> Process issues are better described in the patch notes or series cover letter, not
> in the commit message.
> 
> Generally if you feel you have to list the changes you're making in the commit
> message for a single patch, it's a sign that you patch should be split into
> multiple commits anyway.
> 
Hi Andrew,
I'll split the patch to multiple patches according to the I2C bus.

> > - Remove led_gpio pca9552 since there is no binding document.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 539
> > +++++++++++++++---
> >  1 file changed, 466 insertions(+), 73 deletions(-)
> >
> > diff --git
> > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98477792aa00..6b4efb5fbd83 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> >
> 
> ...
> 
> >
> >  &i2c11 {
> >       status = "okay";
> >       power-sensor at 10 {
> > -             compatible = "adi, adm1272";
> > +             compatible = "adi,adm1272";
> >               reg = <0x10>;
> >       };
> >
> >       power-sensor at 12 {
> > -             compatible = "adi, adm1272";
> > +             compatible = "adi,adm1272";
> >               reg = <0x12>;
> >       };
> 
> Can you please split the adm1272 compatible changes out to a separate patch
> and include an appropriate Fixes: tag?
> 
> Andrew
Sure, I sent another patch to correct the compatible string of adm1272.
