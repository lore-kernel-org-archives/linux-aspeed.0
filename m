From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 28 Aug 2024 10:48:10 +0930
Subject: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
In-Reply-To: <OSQPR06MB7252CBAEBF1DBE2C613F24748B8B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240821070740.2378602-1-billy_tsai@aspeedtech.com>
	 <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
	 <cf92b3ab4b171e7c7c07cada066dad6323c5dace.camel@codeconstruct.com.au>
	 <OSQPR06MB7252CBAEBF1DBE2C613F24748B8B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Message-ID: <e629752d8c97a2d14641a7fbc0cbdb1cd01a8ac5.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-08-27 at 02:45 +0000, Billy Tsai wrote:
> Hi Andrew,
> 
> Thanks for your suggestion. As I understand it, you?re suggesting that this driver should share the
> common parts with aspeed-gpio.c, correct?
> However, I don?t think that?s necessary. You can treat it as a new GPIO controller because the
> register layout is quite different from aspeed-gpio.c.

Well, we could, but both share a lot of the same capabilities. aspeed-
gpio.c already has to abstract over the register layout because it's so
haphazard. What I was suggesting was to formalise this a bit more by
converting some of the inline functions and macros to callbacks that
can be implemented for each controller.

I haven't tried it myself, but it feels feasible?

> If I try to make it common, the driver could become too complex, potentially requiring a separate
> gpio-aspeed-common.c and necessitating changes to the existing aspeed-gpio.c

I felt the trade-off between the volume of copy/paste and the
complexity of adding a few callbacks weighed in favour of the latter.

Also, given the volume of copy/paste, I think it would be best to
retain the copyright information from aspeed-gpio.c if the outcome is
these must be separate drivers.

Many of the changes seemed to be dealing with the difference between
`struct aspeed_gpio` and `struct aspeed_gpio_g7`, which might be
addressed by some careful struct design and use of container_of().

> Maybe the discussion of merging aspeed-gpio.c and this driver can be postponed until after this one
> is accepted?

Yeah, but I suspect the discussion just won't happen if this is merged.
Now's the time to get consensus on a way forward, while the driver is
yet to be merged.

> > > +
> > > +static const int debounce_timers[4] = { 0x00, 0x04, 0x00, 0x08 };
> 
> > This is all largely copy/pasted from gpio-aspeed.c. Can we split it out
> > and share the definitions?
> 
> Do you mean moving them into the common header file? 
> The structure is fine, but I?m unsure about the debounce_timers. 
> It?s a static array, so I don?t think it needs to be shared with gpio-aspeed.c.

That can be changed though? An appropriate pointer can be point into
the driver struct.

> > > +static int aspeed_gpio_g7_get(struct gpio_chip *gc, unsigned int offset)
> > > +{
> > > +     struct aspeed_gpio_g7 *gpio = gpiochip_get_data(gc);
> > > +     void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> > > +
> > > +     return !!(field_get(GPIO_G7_IN_DATA, ioread32(addr)));
> > > +}
> > > +
> > > +static void __aspeed_gpio_g7_set(struct gpio_chip *gc, unsigned int offset, int val)
> > > +{
> > > +     struct aspeed_gpio_g7 *gpio = gpiochip_get_data(gc);
> > > +     void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> 
> > The rest of the implementation of this function is broadly the same as
> > in gpio-aspeed.c. The main difference is accounting for the address to
> > access and the bit to whack. If we define some callbacks that replace
> > GPIO_BANK()/to_bank() and GPIO_BIT() that can account for the
> > differences in register layout, perhaps this could be common?
> 
> > The trade-off is some complexity vs copy-paste, but there does seem to
> > be an awful lot of the latter with only minor changes so far.
> 
> Do you mean I need to create a gpio-aspeed-common.c, define the necessary common APIs,
> and have gpio-aspeed.c and this driver hook into those APIs?

Well, you may not have to do that if we can put it all in gpio-
aspeed.c?

My suspicion is the g7 support could largely become some well-chosen
callbacks.

Andrew
