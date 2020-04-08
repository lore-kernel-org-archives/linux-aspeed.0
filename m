From: Tao Ren <rentao.bupt@gmail.com>
Date: Tue, 7 Apr 2020 22:40:23 -0700
Subject: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
In-Reply-To: <93ae433317a82de86ff5e9c8485563b78656b615.camel@kernel.crashing.org>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
 <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
 <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
 <20200403064826.GA10866@taoren-ubuntu-R90MNF91>
 <20200407060242.GA15050@taoren-ubuntu-R90MNF91>
 <93ae433317a82de86ff5e9c8485563b78656b615.camel@kernel.crashing.org>
Message-ID: <20200408054022.GA12469@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 08, 2020 at 09:36:16AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2020-04-06 at 23:02 -0700, Tao Ren wrote:
> > I ran some testing on my ast2400 and ast2500 BMC and looks like the
> > for() loop runs faster than for_each_set_bit_from() loop in my
> > environment. I'm not sure if something needs to be revised in my test
> > code, but please kindly share your suggestions:
> > 
> > I use get_cycles() to calculate execution time of 2 different loops, and
> > ast_vhub_dev_irq() is replaced with barrier() to avoid "noise"; below
> > are the results:
> > 
> >   - when downstream port number is 5 and only 1 irq bit is set, it takes
> >     ~30 cycles to finish for_each_set_bit() loop, and 20-25 cycles to
> >     finish the for() loop.
> > 
> >   - if downstream port number is 5 and all 5 bits are set, then
> >     for_each_set_bit() loop takes ~50 cycles and for() loop takes ~25
> >     cycles.
> > 
> >   - when I increase downsteam port number to 16 and set 1 irq bit, the
> >     for_each_set_bit() loop takes ~30 cycles and for() loop takes 25
> >     cycles. It's a little surprise to me because I thought for() loop
> >     would cost 60+ cycles (3 times of the value when port number is 5).
> > 
> >   - if downstream port number is 16 and all irq status bits are set,
> >     then for_each_set_bit() loop takes 60-70 cycles and for() loop takes
> >     30+ cycles.
> 
> I suspect the CPU doesn't have an efficient find-zero-bit primitive,
> check the generated asm. In that case I would go back to the simple for
> loop.
> 
> Cheers,
> Ben.

_find_next_bit_le() function is defined in arch/arm/lib/findbit.S. I'm
looking at the code: will run more tests and send out patch v4 with
simple for loop later.


Cheers,

Tao
