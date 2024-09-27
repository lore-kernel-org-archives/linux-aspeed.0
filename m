From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 27 Sep 2024 07:23:34 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
In-Reply-To: <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
	 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
	 <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB58530838D96722E046092C76D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Friday, September 27, 2024 2:29 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
> string of adm1272
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Fri, 2024-09-27 at 06:21 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> >
> > > -----Original Message-----
> > > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Sent: Friday, September 27, 2024 2:01 PM
> > > To: Delphine_CC_Chiu/WYHQ/Wiwynn
> <Delphine_CC_Chiu@wiwynn.com>;
> > > patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof
> > > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > > Joel Stanley <joel@jms.id.au>
> > > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > > linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> > > Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the
> > > compatible string of adm1272
> > >
> > >  [External Sender]
> > >
> > >  [External Sender]
> > >
> > > On Thu, 2024-09-26 at 09:34 +0800, Delphine CC Chiu wrote:
> > > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > >
> > > > Remove the redundant space in the compatible string of adm1272.
> > >
> > > In this case the space is not redundant, it's just incorrect, the
> > > compatible string doesn't match any specified. Do you mind fixing the
> wording?
> > >
> > Sure, I'll fixing the wording in v2.
> 
> Thanks.
> 
> >
> > > >
> > > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > >
> > > Can you please add an appropriate Fixes: tag?
> > >
> > > Thanks,
> > >
> > > Andrew
> > >
> > Would like to ask where should I add the Fixes: tag?
> > Should I add in the patch title like:
> > Fixes: ARM: dts: aspeed: yosemite4: correct the compatible string of
> > adm1272
> >
> > Or should I add in the commit message?
> 
> It goes in the trailer block above your Signed-off-by tag. It will be worth your
> time to review the following documentation:
> 
> -
> https://urldefense.com/v3/__https://docs.kernel.org/process/5.Posting.html*p
> atch-formatting-and-changelogs__;Iw!!J63qqgXj!LdpKTr36YV5e4cCRly5lII5iCF
> m9zsnavi_vRueNWvNHGQ8SimCf-YfL14fxXTRL3Fxnkmid4VLDlGSY_GxdXBhSTrA
> $
> -
> https://urldefense.com/v3/__https://docs.kernel.org/process/submitting-patch
> es.html*describe-your-changes__;Iw!!J63qqgXj!LdpKTr36YV5e4cCRly5lII5iCFm
> 9zsnavi_vRueNWvNHGQ8SimCf-YfL14fxXTRL3Fxnkmid4VLDlGSY_Gxd0pKAYmU
> $
> 
> The expected format and other details are described there.
> 
> Thanks,
> 
> Andrew
Hi Andrew,

Thanks for your information!
I'll follow the format described in the document and send the v2 patch.

Ricky
