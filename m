From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 27 May 2020 18:20:11 -0700
Subject: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <20200528011154.30355-1-rentao.bupt@gmail.com>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
Message-ID: <20200528012010.GA30405@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

I sent out the follow-on patch per Greg's suggestion, and the purpose is
to include the latest version (v4) of the original commit. As v4 was
already Acked-by you, can I add the tag for this patch? Or are you
willing to Ack it again?


Cheers,

Tao

On Wed, May 27, 2020 at 06:11:54PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
> improve vhub port irq handling"): for_each_set_bit() is replaced with
> simple for() loop because for() loop runs faster on ASPEED BMC.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index cdf96911e4b1..be7bb64e3594 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
>  
>  	/* Handle device interrupts */
>  	if (istat & vhub->port_irq_mask) {
> -		unsigned long bitmap = istat;
> -		int offset = VHUB_IRQ_DEV1_BIT;
> -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> -
> -		for_each_set_bit_from(offset, &bitmap, size) {
> -			i = offset - VHUB_IRQ_DEV1_BIT;
> -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> +		for (i = 0; i < vhub->max_ports; i++) {
> +			if (istat & VHUB_DEV_IRQ(i))
> +				ast_vhub_dev_irq(&vhub->ports[i].dev);
>  		}
>  	}
>  
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> index 2e5a1ef14a75..87a5dea12d3c 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
> @@ -67,6 +67,9 @@
>  #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
>  #define VHUB_IRQ_ACK_ALL			0x1ff
>  
> +/* Downstream device IRQ mask. */
> +#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVICE1 << (n))
> +
>  /* SW reset reg */
>  #define VHUB_SW_RESET_EP_POOL			(1 << 9)
>  #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
> -- 
> 2.17.1
> 
