From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 17 Feb 2020 19:18:56 -0800
Subject: [PATCH v2 1/5] usb: gadget: aspeed: read vhub properties from
 device tree
In-Reply-To: <88f74fcd-537d-497d-bb39-346e56da34e2@www.fastmail.com>
References: <20200212215717.9474-1-rentao.bupt@gmail.com>
 <20200212215717.9474-2-rentao.bupt@gmail.com>
 <88f74fcd-537d-497d-bb39-346e56da34e2@www.fastmail.com>
Message-ID: <20200218031855.GA646@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Mon, Feb 17, 2020 at 10:18:11AM +1030, Andrew Jeffery wrote:
> 
> 
> On Thu, 13 Feb 2020, at 08:27, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > The patch introduces 2 DT properties ("aspeed,vhub-downstream-ports" and
> > "aspeed,vhub-generic-endpoints") which replaces hardcoded port/endpoint
> > number. It is to make it more convenient to add support for newer vhub
> > revisions with different number of ports and endpoints.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  Changes in v2:
> >    - removed ast_vhub_config structure and moved vhub port/endpoint
> >      number into device tree.
> > 
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 68 ++++++++++++++---------
> >  drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 30 +++++++---
> >  drivers/usb/gadget/udc/aspeed-vhub/epn.c  |  4 +-
> >  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 26 ++++++---
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 23 +++-----
> >  5 files changed, 91 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c 
> > b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index 90b134d5dca9..d6f737fac4e2 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -99,7 +99,7 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  {
> >  	struct ast_vhub *vhub = data;
> >  	irqreturn_t iret = IRQ_NONE;
> > -	u32 istat;
> > +	u32 i, istat;
> >  
> >  	/* Stale interrupt while tearing down */
> >  	if (!vhub->ep0_bufs)
> > @@ -121,10 +121,10 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  
> >  	/* Handle generic EPs first */
> >  	if (istat & VHUB_IRQ_EP_POOL_ACK_STALL) {
> > -		u32 i, ep_acks = readl(vhub->regs + AST_VHUB_EP_ACK_ISR);
> > +		u32 ep_acks = readl(vhub->regs + AST_VHUB_EP_ACK_ISR);
> >  		writel(ep_acks, vhub->regs + AST_VHUB_EP_ACK_ISR);
> >  
> > -		for (i = 0; ep_acks && i < AST_VHUB_NUM_GEN_EPs; i++) {
> > +		for (i = 0; ep_acks && i < vhub->max_epns; i++) {
> >  			u32 mask = VHUB_EP_IRQ(i);
> >  			if (ep_acks & mask) {
> >  				ast_vhub_epn_ack_irq(&vhub->epns[i]);
> > @@ -134,21 +134,11 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  	}
> >  
> >  	/* Handle device interrupts */
> > -	if (istat & (VHUB_IRQ_DEVICE1 |
> > -		     VHUB_IRQ_DEVICE2 |
> > -		     VHUB_IRQ_DEVICE3 |
> > -		     VHUB_IRQ_DEVICE4 |
> > -		     VHUB_IRQ_DEVICE5)) {
> > -		if (istat & VHUB_IRQ_DEVICE1)
> > -			ast_vhub_dev_irq(&vhub->ports[0].dev);
> > -		if (istat & VHUB_IRQ_DEVICE2)
> > -			ast_vhub_dev_irq(&vhub->ports[1].dev);
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
> >  
> >  	/* Handle top-level vHub EP0 interrupts */
> > @@ -182,7 +172,7 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  
> >  void ast_vhub_init_hw(struct ast_vhub *vhub)
> >  {
> > -	u32 ctrl;
> > +	u32 ctrl, port_mask, epn_mask;
> >  
> >  	UDCDBG(vhub,"(Re)Starting HW ...\n");
> >  
> > @@ -222,15 +212,20 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
> >  	}
> >  
> >  	/* Reset all devices */
> > -	writel(VHUB_SW_RESET_ALL, vhub->regs + AST_VHUB_SW_RESET);
> > +	port_mask = GENMASK(vhub->max_ports, 1);
> > +	writel(VHUB_SW_RESET_ROOT_HUB |
> > +	       VHUB_SW_RESET_DMA_CONTROLLER |
> > +	       VHUB_SW_RESET_EP_POOL |
> > +	       port_mask, vhub->regs + AST_VHUB_SW_RESET);
> >  	udelay(1);
> >  	writel(0, vhub->regs + AST_VHUB_SW_RESET);
> >  
> >  	/* Disable and cleanup EP ACK/NACK interrupts */
> > +	epn_mask = GENMASK(vhub->max_epns - 1, 0);
> >  	writel(0, vhub->regs + AST_VHUB_EP_ACK_IER);
> >  	writel(0, vhub->regs + AST_VHUB_EP_NACK_IER);
> > -	writel(VHUB_EP_IRQ_ALL, vhub->regs + AST_VHUB_EP_ACK_ISR);
> > -	writel(VHUB_EP_IRQ_ALL, vhub->regs + AST_VHUB_EP_NACK_ISR);
> > +	writel(epn_mask, vhub->regs + AST_VHUB_EP_ACK_ISR);
> > +	writel(epn_mask, vhub->regs + AST_VHUB_EP_NACK_ISR);
> >  
> >  	/* Default settings for EP0, enable HW hub EP1 */
> >  	writel(0, vhub->regs + AST_VHUB_EP0_CTRL);
> > @@ -273,7 +268,7 @@ static int ast_vhub_remove(struct platform_device *pdev)
> >  		return 0;
> >  
> >  	/* Remove devices */
> > -	for (i = 0; i < AST_VHUB_NUM_PORTS; i++)
> > +	for (i = 0; i < vhub->max_ports; i++)
> >  		ast_vhub_del_dev(&vhub->ports[i].dev);
> >  
> >  	spin_lock_irqsave(&vhub->lock, flags);
> > @@ -295,7 +290,7 @@ static int ast_vhub_remove(struct platform_device *pdev)
> >  	if (vhub->ep0_bufs)
> >  		dma_free_coherent(&pdev->dev,
> >  				  AST_VHUB_EP0_MAX_PACKET *
> > -				  (AST_VHUB_NUM_PORTS + 1),
> > +				  (vhub->max_ports + 1),
> >  				  vhub->ep0_bufs,
> >  				  vhub->ep0_bufs_dma);
> >  	vhub->ep0_bufs = NULL;
> > @@ -309,11 +304,32 @@ static int ast_vhub_probe(struct platform_device *pdev)
> >  	struct ast_vhub *vhub;
> >  	struct resource *res;
> >  	int i, rc = 0;
> > +	const struct device_node *np = pdev->dev.of_node;
> >  
> >  	vhub = devm_kzalloc(&pdev->dev, sizeof(*vhub), GFP_KERNEL);
> >  	if (!vhub)
> >  		return -ENOMEM;
> >  
> > +	rc = of_property_read_u32(np, "aspeed,vhub-downstream-ports",
> > +				  &vhub->max_ports);
> > +	if (rc < 0)
> > +		return -ENODEV;
> 
> This breaks the driver for old devicetrees, or at the very least,
> devicetrees without your subsequent two patches in the series.
> 
> I feel we shouldn't drop the built-in values for the 2400 and 2500, that
> way we can fall back to them if the devicetree properties aren't present.
> 
> For the 2600 we can have a clean break and require the properties be
> present (i.e. not hardcode the values in the driver for fallback) as there
> aren't yet any devicetrees describing the device.
> 
> Andrew

I understand it. I was also hesitating whether we should make the DT
properties mandatory.. I've sent out patch v3 which falls back to
"default" number of ports and endpoints in case the DT properties are
not present.


Cheers,

Tao
