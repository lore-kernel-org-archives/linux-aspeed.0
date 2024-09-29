From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 09:14:17 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
In-Reply-To: <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
Message-ID: <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ricky, Patrick,

On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> On Fri, Sep 27, 2024 at 09:24:11AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> 
> > Would like to ask should I base on the openbmc/linux repo to create the
> > remaining patches that have context dependencies and add the lore link
> > of the those patches that I've sent in the cover letter?
> 
> I believe you're trying to get the patches applied onto the upstream
> tree, so no you should not base on the openbmc/linux repo.  That repo is
> a 6.6 branch.  You need to base the commits on torvalds/linux.
> 

In my previous email[1] I requested:

> Please assess the remaining yosemite4 devicetree patches (those you
> haven't received a thank-you email for) and send an appropriately
> constructed series so they can all be applied together, based on the
> tree here:
> 
> https://github.com/amboar/linux/tree/for/bmc/dt

So I'm not sure why there's confusion and speculation as to which tree
should be used :( Note that the for/bmc/dt branch above is currently
based on v6.12-rc1.

[1]: https://lore.kernel.org/all/fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel at codeconstruct.com.au/

Anyway, I asked that because I have already applied one of the
Yosemite4 patches there, and developing the remaining patches against
any other tree will again cause conflicts (due to the lack of that
patch).

More broadly though, Patrick is right: If you're sending your patches
upstream, it is required that you develop and test your patches against
an appropriate upstream tree. Usually this is the most recent -rc1 tag,
unless there are reasons otherwise (such as conflicts). The OpenBMC
kernel fork is not an appropriate tree on which to base work you intend
to send upstream.

Thanks,

Andrew
