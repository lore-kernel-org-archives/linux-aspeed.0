From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 17 Aug 2020 15:56:04 -0700
Subject: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <875z9hz8k3.fsf@kernel.org>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
Message-ID: <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2020 at 04:49:32PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> rentao.bupt at gmail.com writes:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
> > improve vhub port irq handling"): for_each_set_bit() is replaced with
> > simple for() loop because for() loop runs faster on ASPEED BMC.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index cdf96911e4b1..be7bb64e3594 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  
> >  	/* Handle device interrupts */
> >  	if (istat & vhub->port_irq_mask) {
> > -		unsigned long bitmap = istat;
> > -		int offset = VHUB_IRQ_DEV1_BIT;
> > -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> > -
> > -		for_each_set_bit_from(offset, &bitmap, size) {
> > -			i = offset - VHUB_IRQ_DEV1_BIT;
> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> > +		for (i = 0; i < vhub->max_ports; i++) {
> > +			if (istat & VHUB_DEV_IRQ(i))
> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
> 
> how have you measured your statement above? for_each_set_bit() does
> exactly what you did. Unless your architecture has an instruction which
> helps finds the next set bit (like cls on ARM), which, then, makes it
> much faster.

I did some testing and result shows for() loop runs faster than
for_each_set_bit() loop. Please refer to details below (discussion with
Benjamin in the original patch) and kindly let me know your suggestions.

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


Cheers,

Tao
