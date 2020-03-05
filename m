From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 05 Mar 2020 14:35:08 +1100
Subject: [PATCH] usb: gadget: aspeed: improve vhub port irq handling
In-Reply-To: <20200305023859.21057-1-rentao.bupt@gmail.com>
References: <20200305023859.21057-1-rentao.bupt@gmail.com>
Message-ID: <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-03-04 at 18:38 -0800, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> This patch evaluates vhub ports' irq mask before going through per-
> port
> irq handling one by one, which helps to speed up irq handling in case
> there is no port interrupt.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Looks reasonable, but did you try a find_next_bit() loop and whether
that's faster ?

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++-----
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 ++++----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index f8d35dd60c34..a03e4e4ea401 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -134,11 +134,11 @@ static irqreturn_t ast_vhub_irq(int irq, void
> *data)
>  	}
>  
>  	/* Handle device interrupts */
> -	for (i = 0; i < vhub->max_ports; i++) {
> -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> -
> -		if (istat & dev_mask)
> -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> +	if (istat & vhub->port_irq_mask) {
> +		for (i = 0; i < vhub->max_ports; i++) {
> +			if (istat & VHUB_DEV_IRQ(i))
> +				ast_vhub_dev_irq(&vhub->ports[i].dev);
> +		}
>  	}
>  
>  	/* Handle top-level vHub EP0 interrupts */
> @@ -332,6 +332,7 @@ static int ast_vhub_probe(struct platform_device
> *pdev)
>  
>  	spin_lock_init(&vhub->lock);
>  	vhub->pdev = pdev;
> +	vhub->port_irq_mask = GENMASK(vhub->max_ports + 8, 9);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> index fac79ef6d669..e49924ec7e58 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> @@ -54,10 +54,6 @@
>  #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
>  #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
>  #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
> -#define VHUB_IRQ_DEVICE5			(1 << 13)
> -#define VHUB_IRQ_DEVICE4			(1 << 12)
> -#define VHUB_IRQ_DEVICE3			(1 << 11)
> -#define VHUB_IRQ_DEVICE2			(1 << 10)
>  #define VHUB_IRQ_DEVICE1			(1 << 9)
>  #define VHUB_IRQ_BUS_RESUME			(1 << 8)
>  #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
> @@ -70,6 +66,9 @@
>  #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
>  #define VHUB_IRQ_ACK_ALL			0x1ff
>  
> +/* Downstream device IRQ mask. */
> +#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVIC
> E1 << (n))
> +
>  /* SW reset reg */
>  #define VHUB_SW_RESET_EP_POOL			(1 << 9)
>  #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
> @@ -402,6 +401,7 @@ struct ast_vhub {
>  	/* Per-port info */
>  	struct ast_vhub_port		*ports;
>  	u32				max_ports;
> +	u32				port_irq_mask;
>  
>  	/* Generic EP data structures */
>  	struct ast_vhub_ep		*epns;

