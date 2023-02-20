From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 20 Feb 2023 09:50:39 +0000
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
	 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
Message-ID: <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jeremy,
	Thanks your review.


> -----Original Message-----
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Monday, February 20, 2023 4:29 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
> 
> Hi Ryan,
> 
> > AST2600 support new register set for I2Cv2 controller, add bindings
> > document to support driver of i2cv2 new register mode controller.
> 
> Some comments inline:
> 
> > +? clock-frequency:
> > +??? description:
> > +????? Desired I2C bus clock frequency in Hz. default 100khz.
> > +
> > +? multi-master:
> > +??? type: boolean
> > +??? description:
> > +????? states that there is another master active on this bus
> 
> These are common to all i2c controllers, but I see that i2c-controller.yaml
> doesn't include them (while i2c.text does).
> 
> I assume we're OK to include these in the device bindings in the meantime.
> But in that case, you may also want to include the common "smbus-alert"
> property, which you consume in your driver.
> 
Since i2c.text have multi-master, smbus-alert. I don't need those two right?

> > +? timeout:
> > +??? type: boolean
> > +??? description: Enable i2c bus timeout for master/slave (35ms)
> > +
> > +? byte-mode:
> > +??? type: boolean
> > +??? description: Force i2c driver use byte mode transmit
> > +
> > +? buff-mode:
> > +??? type: boolean
> > +??? description: Force i2c driver use buffer mode transmit
> 
> These three aren't really a property of the hardware, more of the intended
> driver configuration. Do they really belong in the DT?
> 
Sorry, I am confused. 
This is hardware controller mode setting for each i2c transfer. 
So I add it in property for change different i2c transfer mode.
Is my mis-understand the property setting?

> [and how would a DT author know which modes to choose?]
> 
> > +? aspeed,gr:
> > +??? $ref: /schemas/types.yaml#/definitions/phandle
> > +??? description: The phandle of i2c global register node.
> 
> We'll probably want this to be consistent with other instances of aspeed global
> register references. I've used "aspeed,global-regs" in the proposed i3c binding:
> 
> 
> https://lore.kernel.org/linux-devicetree/cover.1676532146.git.jk at codeconstruc
> t.com.au/T/#mda2d005f77ca0c481b1f1edadb58fc1b007a5cc3
> 
> I'd argue that "global-regs" is a little more clear, but I'm okay with either way -
> that change has been Acked but not been merged yet.
> Whichever we choose though, it should be consistent.
> 
Got it, will rename to aspeed,global-regs

Best Regards, 
Ryan
