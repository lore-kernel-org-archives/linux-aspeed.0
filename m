From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 04 Aug 2021 14:25:29 +0930
Subject: [RFC PATCH 0/6] leds: Fix pca955x GPIO pin mappings
In-Reply-To: <CAHp75Ve-6zKE9UX+LR022cGAA6xvd8CeLnnKE_fT3snnzmNusA@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
 <d019990e-a725-4ef5-bb54-aadee9d18b86@www.fastmail.com>
 <CAHp75Vc2W+WmwNj1AvH6EiT_80c+5gADV9QzK+asHxpd1Ucppw@mail.gmail.com>
 <6cc64039-f82a-4c1e-ad2c-16fad7aa3178@www.fastmail.com>
 <CAHp75Vdx9QA7dmSWK8GHxBBxP0uYjrz=Gm=75yqaWbBX6k3v=w@mail.gmail.com>
 <50aaf381-8cda-4656-9222-f23fda75d3bc@www.fastmail.com>
 <CAHp75Ve-6zKE9UX+LR022cGAA6xvd8CeLnnKE_fT3snnzmNusA@mail.gmail.com>
Message-ID: <7c20e892-1675-47b6-874f-5e42e7bd73ef@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 3 Aug 2021, at 20:03, Andy Shevchenko wrote:
> On Tue, Aug 3, 2021 at 7:07 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Thu, 29 Jul 2021, at 17:10, Andy Shevchenko wrote:
> > > On Thu, Jul 29, 2021 at 3:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > On Wed, 28 Jul 2021, at 18:43, Andy Shevchenko wrote:
> > > > > On Wed, Jul 28, 2021 at 8:43 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > > However, userspace would never have
> > > > > > got the results it expected with the existing driver implementation, so
> > > > > > I guess you could argue that no such (useful) userspace exists. Given
> > > > > > that, we could adopt the strategy of always defining a gpiochip
> > > > > > covering the whole pin space, and parts of the devicetree binding just
> > > > > > become redundant.
> > > > >
> > > > > I'm lost now. GPIO has its own userspace ABI, how does it work right
> > > > > now in application to this chip?
> > > >
> > > > As above, it "works" if the GPIOs specified in the devicetree are
> > > > contiguous from line 0. It's broken if they're not.
> > >
> > > So, "it never works" means there is no bug. Now, what we need is to
> > > keep the same enumeration scheme, but if you wish to be used half/half
> > > (or any other ratio), the driver should do like the above mentioned
> > > PWM, i.e. register entire space and depending on the requestor either
> > > proceed with a line or mark it as BUSY.
> > >
> > > Ideally, looking into what the chip can do, this should be indeed
> > > converted to some like pin control + PWM + LED + GPIO drivers. Then
> > > the function in pin mux configuration can show what exactly is enabled
> > > on the certain line(s).
> >
> > So just to clarify, you want both solutions here?
> >
> > 1. A gpiochip that covers the entire pin space
> > 2. A pinmux implementation that manages pin allocation to the different drivers
> >
> > In that case we can largely leave this series as is? We only need to
> > adjust how we configure the gpiochip by dropping the pin-mapping
> > implementation?
> 
> Nope. It's far from what I think of. Re-reading again your cover
> letter it points out that pin mux per se does not exist in the
> hardware. In this case things become a bit too complicated, but we
> still may manage to handle them. Before I was thinking about this
> hierarchy
> 
> 1. pinmux driver (which is actually the main driver here)
> 2. LED driver (using regmap API)
> 3. GPIO driver (via gpio-regmap)
> 4. PWM driver.

Okay - I need to look at gpio-regmap, this wasn't something I was aware 
of.

> 
> Now what we need here is some kind of "virtual" pinmux. Do I
> understand correctly?

Possibly. My thoughts went to pinctrl as part of its job is mutual 
exclusion *and* pin mapping, plus we get the nice debugfs interface 
with the pin allocation details. The need for pin mapping came from 
trying to stay true to the intent of the existing devicetree binding. 
If we throw that out and have the gpiochip cover the pin space for the 
chip then using pinctrl only gives us mutual exclusion and the debugfs 
interface. pinctrl seems pretty heavy-weight to use *just* for mutual 
exclusion - with no requirement for pin mapping I feel whether or not 
we go this way hinges on the utility of debugfs.

As outlined earlier, there's no mux hardware, the only thing that 
changes is software's intent.

> 
> To be clear: I do not like putting everything into one driver when the
> logical parts may be separated.

Right, its already a bit unwieldy.

Andrew
