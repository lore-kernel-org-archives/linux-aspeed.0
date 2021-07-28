From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 28 Jul 2021 15:13:24 +0930
Subject: [RFC PATCH 0/6] leds: Fix pca955x GPIO pin mappings
In-Reply-To: <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
Message-ID: <d019990e-a725-4ef5-bb54-aadee9d18b86@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 23 Jul 2021, at 17:45, Andy Shevchenko wrote:
> 
> 
> On Friday, July 23, 2021, Andrew Jeffery <andrew@aj.id.au> wrote:
> > Hello,
> > 
> > This series does a bunch of crimes, so it's an RFC. I'm cross-posting to the
> > pinctrl/GPIO and LEDs lists because the PCA955x devices impact all of them. What
> > needs fixing is the leds-pca955x driver's failure to map the GPIO numberspace to
> > the pin numberspace of the PCA955x devices. The series solves that by
> > implementing pinctrl and pinmux in the leds-pca955x driver.
> > 
> > Things I'm unsure about:
> > 
> > 1. Patch 1: The pinctrl_gpio_as_pin() API feels a bit dirty, not sure what
> >    others thoughts are on that (Linus?).
> > 
> > 2. Patch 2: I've added a new callback to hook the entirety of the pinctrl map
> >    parsing rather than supplying a subnode-specific callback. This was necessary
> >    to handle the PCA955x devicetree binding in a backwards compatible way.
> > 
> > 3. Patch 4: The PCA955x devices don't actually have any pinmux hardware, but the
> >    properties of the pinctrl/pinmux subsystems in the kernel map nicely onto the
> >    problem we have. But it's quite a bit of code...
> > 
> > 4. Patch 6: I also lost a bunch of time to overlooking the get_group_pins()
> >    callback for pinctrl, and it seems odd to me that it isn't required.
> > 
> > Please review!
> 
> 
> Sounds like a hack.

Yes, possibly. Feedback like this is why I sent the series as an RFC.

> I was briefly looking into patches 1-4 and suddenly 
> realized that the fix can be similar as in PCA9685 (PWM), I.e. we 
> always have chips for the entire pin space and one may map them 
> accordingly, requested in one realm (LED) in the other (GPIO) 
> automatically is BUSY. Or I missed the point?

No, you haven't missed the point. I will look at the PCA9685 driver.

That said, my goal was to implement the behaviour intended by the 
existing binding (i.e. fix a bug). However, userspace would never have 
got the results it expected with the existing driver implementation, so 
I guess you could argue that no such (useful) userspace exists. Given 
that, we could adopt the strategy of always defining a gpiochip 
covering the whole pin space, and parts of the devicetree binding just 
become redundant.

Andrew
