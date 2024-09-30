From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 30 Sep 2024 01:47:52 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
In-Reply-To: <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Monday, September 30, 2024 7:44 AM
> To: Patrick Williams <patrick@stwcx.xyz>; Delphine_CC_Chiu/WYHQ/Wiwynn
> <Delphine_CC_Chiu@wiwynn.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Ricky CX
> Wu <ricky.cx.wu.wiwynn@gmail.com>; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
> IOE on Spider Board
> 
>  [External Sender]
> 
>  [External Sender]
> 
> Hi Ricky, Patrick,
> 
> On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> > On Fri, Sep 27, 2024 at 09:24:11AM +0000,
> Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> >
> > > Would like to ask should I base on the openbmc/linux repo to create
> > > the remaining patches that have context dependencies and add the
> > > lore link of the those patches that I've sent in the cover letter?
> >
> > I believe you're trying to get the patches applied onto the upstream
> > tree, so no you should not base on the openbmc/linux repo.  That repo
> > is a 6.6 branch.  You need to base the commits on torvalds/linux.
> >
> 
> In my previous email[1] I requested:
> 
> > Please assess the remaining yosemite4 devicetree patches (those you
> > haven't received a thank-you email for) and send an appropriately
> > constructed series so they can all be applied together, based on the
> > tree here:
> >
> > https://urldefense.com/v3/__https://github.com/amboar/linux/tree/for/b
> >
> mc/dt__;!!J63qqgXj!N56Dq0KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_Ozc
> SGVPC
> > SBOJk6u28AWPfgDRWsLE1B__-_ZNVKYv-zhc_6PY$
> 
> So I'm not sure why there's confusion and speculation as to which tree should
> be used :( Note that the for/bmc/dt branch above is currently based on
> v6.12-rc1.
> 
> [1]:
> https://urldefense.com/v3/__https://lore.kernel.org/all/fbdc9efe87a1bed9fea7
> d0abaf955aa1a3dc24ac.camel at codeconstruct.com.au/__;!!J63qqgXj!N56Dq0
> KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_OzcSGVPCSBOJk6u28AWPfgDRW
> sLE1B__-_ZNVKYv-uNCc7qE$
> 
> Anyway, I asked that because I have already applied one of the
> Yosemite4 patches there, and developing the remaining patches against any
> other tree will again cause conflicts (due to the lack of that patch).
> 
> More broadly though, Patrick is right: If you're sending your patches upstream,
> it is required that you develop and test your patches against an appropriate
> upstream tree. Usually this is the most recent -rc1 tag, unless there are reasons
> otherwise (such as conflicts). The OpenBMC kernel fork is not an appropriate
> tree on which to base work you intend to send upstream.
> 
> Thanks,
> 
> Andrew

Hi Andrew,

Sorry for my misunderstanding.
So I should combine the remaining yosemite4 device tree patches as a single serial based on torvalds/linux and test on openbmc/linux then send the serial patches to torvalds/linux.
And you will help to fix the conflicts when you apply the serial patches to openbmc/linux.
Do I understand it correctly?
