From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 29 Jul 2019 09:49:31 +0930
Subject: [v5 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <CACRpkdZxsF9gQj0VicVLsPKXg6rKA1mLwbywmazOf0w8PLnOfA@mail.gmail.com>
References: <1563564291-9692-1-git-send-email-hongweiz@ami.com>
 <1563564291-9692-2-git-send-email-hongweiz@ami.com>
 <CACRpkdYhVoP75ZDfASW+DH5yf-a5diitiXsh7eLsJx5hsTC9sQ@mail.gmail.com>
 <ef9d9c17-6e2d-4a4e-ac44-f8da4bb3b8eb@www.fastmail.com>
 <CACRpkdZxsF9gQj0VicVLsPKXg6rKA1mLwbywmazOf0w8PLnOfA@mail.gmail.com>
Message-ID: <f2875111-9ba9-43b7-b2a4-d00c8725f5a0@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 29 Jul 2019, at 09:04, Linus Walleij wrote:
> On Mon, Jul 22, 2019 at 3:42 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > If the clock driver owns the control register, it also needs to know how
> > many GPIOs we want to emit on the bus. This seems like an awkward
> > configuration parameter for a clock driver.
> >
> > To avoid the weird parameter we could protect the control register
> > with a lock shared between the clock driver and the SGPIO driver. This
> > way the SGPIO driver could have the ngpios parameter, and request
> > the clock after its written the ngpios value to the control register. A
> > regmap would be useful here to avoid the resource clash and it also
> > provides the required lock.
> 
> Nah. Too complicated.
> 
> What about using the clock API locally (in the singleton driver,
> much as it is today) though, to give the right abstraction?
> 
> See
> drivers/gpu/drm/pl111/pl111_display.c
> pl111_init_clock_divider() for an example of a local
> clock.

Thanks, I'll take a look at that.

> 
> > However, that aside, we can't simply enable the bus in the clock
> > enable callback if enable is called per-bank, as it is called once on
> > the first request with further requests simply refcounted as you
> > mentioned. This is exactly the behaviour we can't tolerate with the
> > bus: it must only be enabled after the last GPIO bank is registered,
> > when we know the total number of GPIOs to emit.
> 
> So the bus needs to know the total number of GPIOs or
> everything breaks, and that is the blocker for this
> divide-and-conquer approach.
> 
> Why does the bus need to know the total number of GPIOs?
> 
> (Maybe the answer is elsewhere in the thread...)

I didn't answer it explicitly, my apologies.

The behaviour is to periodically emit the state of all enabled GPIOs
(i.e. the ngpios value), one per bus clock cycle. There's no explicit
addressing scheme, the protocol encodes the value for a given GPIO
by its position in the data stream relative to a pulse on the "load data"
(LD) line, whose envelope covers the clock cycle for the last GPIO in
the sequence. Similar to SPI the bus has both out and in lines, which
cater to output/input GPIOs.

A rough timing diagram for a 16-GPIO configuration looks like what
I've pasted here:

https://gist.github.com/amboar/c9543af1957854474b8c05ab357f0675

Hope that helps.

Andrew
