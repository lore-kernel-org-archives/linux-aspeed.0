From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 11 Mar 2020 17:09:31 -0700
Subject: [PATCH v2] usb: gadget: aspeed: improve vhub port irq handling
In-Reply-To: <481e9b7d40c51505518a34ddc2515d3200dbf158.camel@kernel.crashing.org>
References: <20200305234746.1002-1-rentao.bupt@gmail.com>
 <481e9b7d40c51505518a34ddc2515d3200dbf158.camel@kernel.crashing.org>
Message-ID: <20200312000930.GA3956@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

On Wed, Mar 11, 2020 at 12:31:22PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-03-05 at 15:47 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch evaluates vhub ports' irq mask before going through per-port
> > irq handling one by one, which helps to speed up irq handling in case
> > there is no port interrupt.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  Changes in v2:
> >    - use "for_each_set_bit" to speed up port irq handling.
> > 
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++++---
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index f8d35dd60c34..af2dbd405361 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -134,11 +134,14 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  	}
> >  
> >  	/* Handle device interrupts */
> > -	for (i = 0; i < vhub->max_ports; i++) {
> > -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > +	if (istat & vhub->port_irq_mask) {
> > +		int offset = VHUB_IRQ_DEV1_BIT;
> > +		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> >  
> > -		if (istat & dev_mask)
> > +		for_each_set_bit_from(offset, (unsigned long *)&istat, size) 
> 
> That type cast is very bad. It will not work on big endian for example
> (yes this driver isn't used on big endian today but still).
> 
> Please assign istat to an unsigned long (or make it unsigned long to
> begin with).

Thanks for pointing it out. Will fix it in v3.

Cheers,

Tao
