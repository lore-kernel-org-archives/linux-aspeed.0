From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 23 Sep 2024 10:39:06 +0930
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
In-Reply-To: <TYZPR04MB5853BD9CD0774B40BAEF7BDFD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-3-Delphine_CC_Chiu@wiwynn.com>
	 <bf5258b8-a5a1-4cf3-9bd0-1fa44696c3b0@roeck-us.net>
	 <355b19a62e54aa979451d796c3ebe1e294a0cf45.camel@codeconstruct.com.au>
	 <TYZPR04MB5853BD9CD0774B40BAEF7BDFD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <516706cb77ac88ff1b9d94a69b0e1ed54e184ec9.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-20 at 01:54 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> 
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Thursday, September 19, 2024 9:24 AM
> > To: Guenter Roeck <linux@roeck-us.net>; Delphine_CC_Chiu/WYHQ/Wiwynn
> > <Delphine_CC_Chiu@wiwynn.com>; patrick at stwcx.xyz; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>; Joel Stanley
> > <joel@jms.id.au>; Peter Yin <peteryin.openbmc@gmail.com>; Noah Wang
> > <noahwang.wang@outlook.com>; Javier Carrasco
> > <javier.carrasco.cruz@gmail.com>; Fabio Estevam <festevam@gmail.com>;
> > Lukas Wunner <lukas@wunner.de>; Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>; devicetree at vger.kernel.org;
> > linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-aspeed at lists.ozlabs.org
> > Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
> > 
> >  [External Sender]
> > 
> >  [External Sender]
> > 
> > On Wed, 2024-09-18 at 10:00 -0700, Guenter Roeck wrote:
> > > On 9/18/24 02:54, Delphine CC Chiu wrote:
> > > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > > 
> > > > Add support for hot-swap controller MPS MP5023.
> > > > 
> > > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > > > --
> > > 
> > > The hardware monitoring mailing list was not copied, so I assume that
> > > the expectation is that it will be applied through some other tree.
> > 
> > We can take it through the BMC tree, but I'd prefer that the hardware
> > monitoring list were copied regardless.
> > 
> > Ricky: Please do so for v3 onwards.
> > 
> > Andrew
> Hi Guenter & Andrew,
> 
> Would like to ask how to copy the hardware monitoring mailing list?

Not sure how best to answer this, but add it in the To: line for your
patches? 

> Should I just send the v3 patch with only this dt-bindings patch for MP5023
> and it will be added in the mail automatically?

Well, if whatever process you're already using isn't adding it
automatically, I doubt it's going to start doing so now.

You can add it using the `--to` option to `b4 send` or `git send-
email`, for instance.

The details for the hwmon list are here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?h=v6.11#n9836

Andrew
