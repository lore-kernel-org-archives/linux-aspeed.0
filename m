From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 15:32:01 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
In-Reply-To: <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
	 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <81b9916f299bbf29583aba610c0147c8b8afd092.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-09-30 at 05:55 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> 
> I have one more question that if I need to add the DTS based on the patches that
> have been applied but haven't been merged in torvalds/linux.
> Should I also based on the branch "for/bmc/dt" from amboar/linux to create the
> patch?
> 

You can do that, yes. We can at least then be sure your work won't
generate conflicts when I try to apply it (unless you've
inappropriately split your series).

Cheers,

Andrew

