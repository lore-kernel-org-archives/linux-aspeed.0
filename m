From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 03 Aug 2021 13:37:07 +0930
Subject: [RFC PATCH 0/6] leds: Fix pca955x GPIO pin mappings
In-Reply-To: <CAHp75Vdx9QA7dmSWK8GHxBBxP0uYjrz=Gm=75yqaWbBX6k3v=w@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
 <d019990e-a725-4ef5-bb54-aadee9d18b86@www.fastmail.com>
 <CAHp75Vc2W+WmwNj1AvH6EiT_80c+5gADV9QzK+asHxpd1Ucppw@mail.gmail.com>
 <6cc64039-f82a-4c1e-ad2c-16fad7aa3178@www.fastmail.com>
 <CAHp75Vdx9QA7dmSWK8GHxBBxP0uYjrz=Gm=75yqaWbBX6k3v=w@mail.gmail.com>
Message-ID: <50aaf381-8cda-4656-9222-f23fda75d3bc@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 29 Jul 2021, at 17:10, Andy Shevchenko wrote:
> On Thu, Jul 29, 2021 at 3:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Wed, 28 Jul 2021, at 18:43, Andy Shevchenko wrote:
> > > On Wed, Jul 28, 2021 at 8:43 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > However, userspace would never have
> > > > got the results it expected with the existing driver implementation, so
> > > > I guess you could argue that no such (useful) userspace exists. Given
> > > > that, we could adopt the strategy of always defining a gpiochip
> > > > covering the whole pin space, and parts of the devicetree binding just
> > > > become redundant.
> > >
> > > I'm lost now. GPIO has its own userspace ABI, how does it work right
> > > now in application to this chip?
> >
> > As above, it "works" if the GPIOs specified in the devicetree are
> > contiguous from line 0. It's broken if they're not.
> 
> So, "it never works" means there is no bug. Now, what we need is to
> keep the same enumeration scheme, but if you wish to be used half/half
> (or any other ratio), the driver should do like the above mentioned
> PWM, i.e. register entire space and depending on the requestor either
> proceed with a line or mark it as BUSY.
> 
> Ideally, looking into what the chip can do, this should be indeed
> converted to some like pin control + PWM + LED + GPIO drivers. Then
> the function in pin mux configuration can show what exactly is enabled
> on the certain line(s).

So just to clarify, you want both solutions here?

1. A gpiochip that covers the entire pin space
2. A pinmux implementation that manages pin allocation to the different drivers

In that case we can largely leave this series as is? We only need to 
adjust how we configure the gpiochip by dropping the pin-mapping 
implementation?

I don't have a need to implement a PWM driver for it right now but that 
would make sense to do at some point.

Andrew
