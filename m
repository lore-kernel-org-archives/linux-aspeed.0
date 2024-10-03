From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 3 Oct 2024 07:19:25 +0000
Subject: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
 compatible string for max31790
In-Reply-To: <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
	 <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
 <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853B90D170DA7069BDA31D8D6712@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Wednesday, October 2, 2024 9:46 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
> compatible string for max31790
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Tue, 2024-10-01 at 16:20 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Fix the compatible string for max31790 to match the binding document.
> >
> > Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook
> > Yosemite 4 BMC")
> 
> Can you please order this change to patch 06/10? That way the fixes tag is
> meaningful. Otherwise the fix is disrupted by the code motion in 06/10.
> 
> Andrew
Sure, I will order this patch to 06/10 in the next version of patches.

Regards,
Ricky
