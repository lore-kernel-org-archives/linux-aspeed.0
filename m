From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 19 Jun 2018 10:36:46 +1000
Subject: [PATCH v2 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <f330ef1074ba7a22ff06cc0dbcddd7455f238905.camel@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-5-benh@kernel.crashing.org>
 <1529331800.1957459.1411835160.214215C7@webmail.messagingengine.com>
 <f330ef1074ba7a22ff06cc0dbcddd7455f238905.camel@kernel.crashing.org>
Message-ID: <f0cf23fe554f2ab75ab07b164cfc6abc3b08fcfc.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2018-06-19 at 00:38 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-18 at 23:53 +0930, Andrew Jeffery wrote:
> > 
> > >   static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
> > > -           struct aspeed_gpio **gpio,
> > > -           const struct aspeed_gpio_bank **bank,
> > > -           u32 *bit)
> > > +                                      struct aspeed_gpio **gpio,
> > > +                                      const struct aspeed_gpio_bank **bank,
> > > +                                      u32 *bit, int *offset)
> > >   {
> > > -   int offset;
> > >      struct aspeed_gpio *internal;
> > >   
> > > -   offset = irqd_to_hwirq(d);
> > > +   *offset = irqd_to_hwirq(d);
> > 
> > Nit: Did you intend to set this out parameter before potentially returning an error? I had tried to avoid that up until now.
> 
> Yeah it's constant-ish, I don't see why not

I mean it's a pure function of the input, it's not like there's any
special side effect that one may want to avoid in case of error.

Cheers,
Ben.
