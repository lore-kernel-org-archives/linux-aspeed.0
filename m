From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 20 Feb 2023 19:24:08 +0800
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
	 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
	 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
	 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> > > +? clock-frequency:
> > > +??? description:
> > > +????? Desired I2C bus clock frequency in Hz. default 100khz.
> > > +
> > > +? multi-master:
> > > +??? type: boolean
> > > +??? description:
> > > +????? states that there is another master active on this bus
> > 
> > These are common to all i2c controllers, but I see that i2c-controller.yaml
> > doesn't include them (while i2c.text does).
> > 
> > I assume we're OK to include these in the device bindings in the meantime.
> > But in that case, you may also want to include the common "smbus-alert"
> > property, which you consume in your driver.
> > 
> Since i2c.text have multi-master, smbus-alert. I don't need those two right?

Depends whether the maintainers consider i2c.text as part of the
schema, I figure. Might be best to get their input on this.


> > > +? timeout:
> > > +??? type: boolean
> > > +??? description: Enable i2c bus timeout for master/slave (35ms)
> > > +
> > > +? byte-mode:
> > > +??? type: boolean
> > > +??? description: Force i2c driver use byte mode transmit
> > > +
> > > +? buff-mode:
> > > +??? type: boolean
> > > +??? description: Force i2c driver use buffer mode transmit
> > 
> > These three aren't really a property of the hardware, more of the intended
> > driver configuration. Do they really belong in the DT?
> > 
> Sorry, I am confused. 
> This is hardware controller mode setting for each i2c transfer. 
> So I add it in property for change different i2c transfer mode.
> Is my mis-understand the property setting?

It depends what this is configuration is for.

Would you set the transfer mode based on the design of the board? Is
there something about the physical i2c bus wiring (or some other
hardware design choice) that would mean you use one setting over
another?

On the other hand, if it's just because of OS behaviour, then this
doesn't belong in the DT.

Maybe to help us understand: why would you ever *not* want DMA mode?
Isn't that always preferable?

Cheers,


Jeremy
