From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 22 Feb 2023 09:30:14 +0800
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
	 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
	 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
	 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
	 <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
	 <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <d5d0bbdbfdce06a6e2ad34f2fa8f27d4eaf36207.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> > On the other hand, if it's just because of OS behaviour, then this
> > doesn't belong
> > in the DT.
> > 
> > Maybe to help us understand: why would you ever *not* want DMA
> > mode?
> > Isn't that always preferable?
> In AST SOC i2c design is 16 i2c bus share one dma engine. 

Does this mean that only one i2c controller in the system can be
configured to use DMA? Or is it able to be shared between multiple
controllers?

> It can be switch setting by dts setting. Otherwise driver by default
> probe is DMA mode.

You've explained what the modes do, and how they're switched, and what
the default is. However this doesn't explain *why* someone would want
to choose a particular mode when creating a controller node.

Still with the question above: assuming there are no restrictions on
DMA usage, why wouldn't a driver implementation just enable it always?

Cheers,


Jeremy
