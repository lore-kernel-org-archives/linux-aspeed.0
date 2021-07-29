From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 29 Jul 2021 10:08:38 +0930
Subject: [RFC PATCH 0/6] leds: Fix pca955x GPIO pin mappings
In-Reply-To: <CAHp75Vc2W+WmwNj1AvH6EiT_80c+5gADV9QzK+asHxpd1Ucppw@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
 <d019990e-a725-4ef5-bb54-aadee9d18b86@www.fastmail.com>
 <CAHp75Vc2W+WmwNj1AvH6EiT_80c+5gADV9QzK+asHxpd1Ucppw@mail.gmail.com>
Message-ID: <6cc64039-f82a-4c1e-ad2c-16fad7aa3178@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 28 Jul 2021, at 18:43, Andy Shevchenko wrote:
> On Wed, Jul 28, 2021 at 8:43 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Fri, 23 Jul 2021, at 17:45, Andy Shevchenko wrote:
> >
> > > I was briefly looking into patches 1-4 and suddenly
> > > realized that the fix can be similar as in PCA9685 (PWM), I.e. we
> > > always have chips for the entire pin space and one may map them
> > > accordingly, requested in one realm (LED) in the other (GPIO)
> > > automatically is BUSY. Or I missed the point?
> >
> > No, you haven't missed the point. I will look at the PCA9685 driver.
> >
> > That said, my goal was to implement the behaviour intended by the
> > existing binding (i.e. fix a bug).
> 
> Okay, so it implies that this used to work at some point. 

I don't think this is true. It only "works" if the lines specified as 
GPIO in the devicetree are contiguous from line 0. That way the pin and 
GPIO number spaces align. I suspect that's all that's been tested up 
until this point.

We now have a board with a PCA9552 where the first 8 pins are LED and 
the last 8 pins are GPIO, and if you specify this in the devicetree 
according to the binding you hit the failure to map between the two 
number spaces.

> What has
> changed from that point? Why can't we simply fix the culprit commit?

As such nothing has changed, I think it's always been broken, just we 
haven't had hardware configurations that demonstrated the failure.

> 
> > However, userspace would never have
> > got the results it expected with the existing driver implementation, so
> > I guess you could argue that no such (useful) userspace exists. Given
> > that, we could adopt the strategy of always defining a gpiochip
> > covering the whole pin space, and parts of the devicetree binding just
> > become redundant.
> 
> I'm lost now. GPIO has its own userspace ABI, how does it work right
> now in application to this chip?

As above, it "works" if the GPIOs specified in the devicetree are 
contiguous from line 0. It's broken if they're not.

Andrew
