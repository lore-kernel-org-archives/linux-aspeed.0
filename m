From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 27 Feb 2020 14:29:32 -0800
Subject: [PATCH v4 2/7] usb: gadget: aspeed: read vhub properties from
 device tree
In-Reply-To: <b9b8977ae185ca944e703721d93b8d8464d1475f.camel@kernel.crashing.org>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-3-rentao.bupt@gmail.com>
 <b9b8977ae185ca944e703721d93b8d8464d1475f.camel@kernel.crashing.org>
Message-ID: <20200227222931.GA29420@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

On Thu, Feb 27, 2020 at 03:09:01PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > The patch introduces 2 DT properties ("aspeed,vhub-downstream-ports" and
> > "aspeed,vhub-generic-endpoints") which replaces hardcoded port/endpoint
> > number. It is to make it more convenient to add support for newer vhub
> > revisions with different number of ports and endpoints.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> With one minor nit that can be addressed in a subsequent patch (see
> below)
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for the help on the patch series.

> > -		if (istat & VHUB_IRQ_DEVICE3)
> > -			ast_vhub_dev_irq(&vhub->ports[2].dev);
> > -		if (istat & VHUB_IRQ_DEVICE4)
> > -			ast_vhub_dev_irq(&vhub->ports[3].dev);
> > -		if (istat & VHUB_IRQ_DEVICE5)
> > -			ast_vhub_dev_irq(&vhub->ports[4].dev);
> > +	for (i = 0; i < vhub->max_ports; i++) {
> > +		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > +
> > +		if (istat & dev_mask)
> > +			ast_vhub_dev_irq(&vhub->ports[i].dev);
> >  	}
> 
> The 2400 and 2500 have very slow cores and every cycle counts in that
> interrupt handler from my experience. I would sugggest you generate a
> "mask" of all the device interrupts for enabled ports in struct vhub
> and AND istat with that mask before going through the loop. Either that
> or use find_next_zero_bit...
> 
> I wouldn't gate merging this patch on this, it can be a subsequent
> refinement.

Got it. I will take care of the improvement in a follow-up patch.

Cheers,

Tao
