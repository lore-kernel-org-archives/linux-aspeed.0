From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 30 Sep 2024 05:55:25 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
In-Reply-To: <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
	 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Monday, September 30, 2024 10:37 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> Patrick Williams <patrick@stwcx.xyz>
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
> On Mon, 2024-09-30 at 01:47 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn
> wrote:
> >
> > > -----Original Message-----
> > > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Sent: Monday, September 30, 2024 7:44 AM
> > > To: Patrick Williams <patrick@stwcx.xyz>;
> > > Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
> > > Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel
> > > Stanley <joel@jms.id.au>; Ricky CX Wu
> > > <ricky.cx.wu.wiwynn@gmail.com>; devicetree at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> > > linux-kernel at vger.kernel.org
> > > Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for
> > > CPLD IOE on Spider Board
> > >
> > >  [External Sender]
> > >
> > >  [External Sender]
> > >
> > > Hi Ricky, Patrick,
> > >
> > > On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> > > > On Fri, Sep 27, 2024 at 09:24:11AM +0000,
> > > Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> > > >
> > > > > Would like to ask should I base on the openbmc/linux repo to
> > > > > create the remaining patches that have context dependencies and
> > > > > add the lore link of the those patches that I've sent in the cover letter?
> > > >
> > > > I believe you're trying to get the patches applied onto the
> > > > upstream tree, so no you should not base on the openbmc/linux
> > > > repo.  That repo is a 6.6 branch.  You need to base the commits on
> torvalds/linux.
> > > >
> > >
> > > In my previous email[1] I requested:
> > >
> > > > Please assess the remaining yosemite4 devicetree patches (those
> > > > you haven't received a thank-you email for) and send an
> > > > appropriately constructed series so they can all be applied
> > > > together, based on the tree here:
> > > >
> > > > https://urldefense.com/v3/__https://github.com/amboar/linux/tree/f
> > > > or/b
> > > >
> > >
> mc/dt__;!!J63qqgXj!N56Dq0KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_Ozc
> > > SGVPC
> > > > SBOJk6u28AWPfgDRWsLE1B__-_ZNVKYv-zhc_6PY$
> > >
> > > So I'm not sure why there's confusion and speculation as to which
> > > tree should be used :( Note that the for/bmc/dt branch above is
> > > currently based on v6.12-rc1.
> > >
> > > [1]:
> > > https://urldefense.com/v3/__https://lore.kernel.org/all/fbdc9efe87a1
> > > bed9fea7
> > >
> d0abaf955aa1a3dc24ac.camel at codeconstruct.com.au/__;!!J63qqgXj!N56Dq0
> > >
> KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_OzcSGVPCSBOJk6u28AWPfgDRW
> > > sLE1B__-_ZNVKYv-uNCc7qE$
> > >
> > > Anyway, I asked that because I have already applied one of the
> > > Yosemite4 patches there, and developing the remaining patches
> > > against any other tree will again cause conflicts (due to the lack of that
> patch).
> > >
> > > More broadly though, Patrick is right: If you're sending your
> > > patches upstream, it is required that you develop and test your
> > > patches against an appropriate upstream tree. Usually this is the
> > > most recent -rc1 tag, unless there are reasons otherwise (such as
> > > conflicts). The OpenBMC kernel fork is not an appropriate tree on which to
> base work you intend to send upstream.
> > >
> > > Thanks,
> > >
> > > Andrew
> >
> > Hi Andrew,
> >
> > Sorry for my misunderstanding.
> 
> No worries, hopefully we can get it sorted out. I realise the sentiment of my
> responses below is quite direct, but I'm trying to cut through the confusion.
> Please bear with me.
> 
Sure. Thank you for all your help!

> > So I should combine the remaining yosemite4 device tree patches as a
> > single serial
> >
> 
> Specifically, any patches that have dependencies on each other. In this case,
> patches that share diff context need to be in a single series so they don't
> generate conflicts when I try to apply them.
> 
Understood.

> >  based on torvalds/linux
> >
> 
> No. In _this specific instance_, please base the series on
> 
> https://urldefense.com/v3/__https://github.com/amboar/linux/tree/for/bmc/d
> t__;!!J63qqgXj!O6de7qi9vrhod1xS-7osXngZvytCR3QfbV1zDPM2oUFbQxqCxG1y
> BlrbsSwJkNvPFcovNQzmHtHtCo41H529xCRTe7w$
> 
> If you look, you will find this is itself already based on v6.12-rc1, and contains
> ASPEED devicetree patches both yourself and others have sent that are
> intended to appear in v6.13.
> 
> I need you to do this because I've _already_ applied one yosemite4 patch there
> which is generating conflicts with your other yosemite4 patches.
> 
> _However_, in almost all other cases, you should base your series on the latest
> -rc1.
> 
Understood, I'll provide the serial of patches to torvalds/linux base on the repo you provided.
> >  and test on openbmc/linux
> >
> 
> No. If you're sending the patches upstream you must test them as applied to
> the relevant upstream tree. In _this_ case, it's the for/bmc/dt branch I've
> linked above.
> 
Understood.
> >  then send the serial patches to torvalds/linux.
> 
> You send them to the lists as you have done here, yes.
> 
> > And you will help to fix the conflicts
> >
> 
> No. I'm asking you to fix the conflicts that your patches are generating. I don't
> want to be in the business of resolving other people's conflicts and risking
> incorrect results. The conflict resolutions should be tested to the usual
> expectations.
> 
> >  when you apply the serial patches to openbmc/linux.
> 
> I'm doing two separate-but-related roles:
> 
> 1. Upstream patch collector for BMC-related devicetrees 2. OpenBMC kernel
> janitor
> 
> The first role is how I'm interacting with you in this thread. At the moment I'm
> helping Joel out: recently he's been taking the patches I've collected in the
> for/bmc/dt branch I linked above and has sent a PR to Arnd for integration into
> torvalds/linux via the SoC tree.
> 
> However, in the process of collecting your patches in role 1 I also happen to
> switch to role 2, where I backport your upstream patches to OpenBMC's
> v6.6-based (LTS) tree _if_ applying the patch/series directly to that tree does
> not cause conflicts. If there are conflicts, then I expect you to also send a
> backport patch that accounts for the conflicts to _only_ the openbmc list (and
> not the upstream lists and maintainers also on Cc here).
> 
> So in neither case should you expect me to be resolving conflicts for you. The
> resolution still needs testing as noted above, and I'm rarely in a position to do
> that myself.
> 
> I hope that helps.
> 
> Andrew

Thanks for your information.
I really appreciate for your help!
I wasn't sure which linux repo should I base to send the patches before so that
I had some questions about the conflicts fixing.

I understand the rule now after reading the information you provided, and I will
provide the serial patches later.

I have one more question that if I need to add the DTS based on the patches that
have been applied but haven't been merged in torvalds/linux.
Should I also based on the branch "for/bmc/dt" from amboar/linux to create the
patch?

Regards,
Ricky
