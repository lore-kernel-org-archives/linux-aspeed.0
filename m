From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 21 Feb 2023 03:32:39 +0000
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
	 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
	 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
	 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
Message-ID: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jeremy,

> -----Original Message-----
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Monday, February 20, 2023 7:24 PM
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
> > > > +? clock-frequency:
> > > > +??? description:
> > > > +????? Desired I2C bus clock frequency in Hz. default 100khz.
> > > > +
> > > > +? multi-master:
> > > > +??? type: boolean
> > > > +??? description:
> > > > +????? states that there is another master active on this bus
> > >
> > > These are common to all i2c controllers, but I see that
> > > i2c-controller.yaml doesn't include them (while i2c.text does).
> > >
> > > I assume we're OK to include these in the device bindings in the meantime.
> > > But in that case, you may also want to include the common "smbus-alert"
> > > property, which you consume in your driver.
> > >
> > Since i2c.text have multi-master, smbus-alert. I don't need those two right?
> 
> Depends whether the maintainers consider i2c.text as part of the schema, I
> figure. Might be best to get their input on this.


Yes, I will drop this, also integrate into aspeed,i2c.yaml file.

> > > > +? timeout:
> > > > +??? type: boolean
> > > > +??? description: Enable i2c bus timeout for master/slave (35ms)
> > > > +
> > > > +? byte-mode:
> > > > +??? type: boolean
> > > > +??? description: Force i2c driver use byte mode transmit
> > > > +
> > > > +? buff-mode:
> > > > +??? type: boolean
> > > > +??? description: Force i2c driver use buffer mode transmit
> > >
> > > These three aren't really a property of the hardware, more of the
> > > intended driver configuration. Do they really belong in the DT?
> > >
> > Sorry, I am confused.
> > This is hardware controller mode setting for each i2c transfer.
> > So I add it in property for change different i2c transfer mode.
> > Is my mis-understand the property setting?
> 
> It depends what this is configuration is for.
> 
> Would you set the transfer mode based on the design of the board? Is there
> something about the physical i2c bus wiring (or some other hardware design
> choice) that would mean you use one setting over another?
> 
No, it not depend on board design. It is only for register control for controller transfer behave.
The controller support 3 different trigger mode for transfer.
Byte mode: it means step by step to issue transfer.
Example i2c read, each step will issue interrupt then driver need trigger for next step.
Sr (start read) | D | D | D | P
Buffer mode: it means, the data can prepare into buffer register, then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling. 
The DMA mode most like with buffer mode, The differ is data prepare in DRAM, than trigger transfer. 


> On the other hand, if it's just because of OS behaviour, then this doesn't belong
> in the DT.
> 
> Maybe to help us understand: why would you ever *not* want DMA mode?
> Isn't that always preferable?
In AST SOC i2c design is 16 i2c bus share one dma engine. 
It can be switch setting by dts setting. Otherwise driver by default probe is DMA mode.

Ryan
