From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 09:59:53 +0200
Subject: [PATCH] usb: gadget: aspeed_udc: fix device address configuration
In-Reply-To: <20240612-aspeed-udc-v1-1-d277b553aecf@codeconstruct.com.au>
References: <20240612-aspeed-udc-v1-1-d277b553aecf@codeconstruct.com.au>
Message-ID: <2024061242-viper-duplicity-7ccb@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 12, 2024 at 10:07:33AM +0800, Jeremy Kerr wrote:
> In the aspeed UDC setup, we configure the UDC hardware with the assigned
> USB device address.
> 
> However, we have an off-by-one in the bitmask, so we're only setting the
> lower 6 bits of the address (USB addresses being 7 bits, and the
> hardware bitmask being bits 0:6).
> 
> This means that device enumeration fails if the assigned address is
> greater than 64:
> 
> [  344.607255] usb 1-1: new high-speed USB device number 63 using ehci-platform
> [  344.808459] usb 1-1: New USB device found, idVendor=cc00, idProduct=cc00, bcdDevice= 6.10
> [  344.817684] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  344.825671] usb 1-1: Product: Test device
> [  344.831075] usb 1-1: Manufacturer: Test vendor
> [  344.836335] usb 1-1: SerialNumber: 00
> [  349.917181] usb 1-1: USB disconnect, device number 63
> [  352.036775] usb 1-1: new high-speed USB device number 64 using ehci-platform
> [  352.249432] usb 1-1: device descriptor read/all, error -71
> [  352.696740] usb 1-1: new high-speed USB device number 65 using ehci-platform
> [  352.909431] usb 1-1: device descriptor read/all, error -71
> 
> Use the correct mask of 0x7f (rather than 0x3f), and generate this
> through the GENMASK macro, so we have numbers that correspond exactly
> to the hardware register definition.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 3916c8e2ba01..821a6ab5da56 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -66,8 +66,8 @@
>  #define USB_UPSTREAM_EN			BIT(0)
>  
>  /* Main config reg */
> -#define UDC_CFG_SET_ADDR(x)		((x) & 0x3f)
> -#define UDC_CFG_ADDR_MASK		(0x3f)
> +#define UDC_CFG_SET_ADDR(x)		((x) & UDC_CFG_ADDR_MASK)
> +#define UDC_CFG_ADDR_MASK		GENMASK(6, 0)
>  
>  /* Interrupt ctrl & status reg */
>  #define UDC_IRQ_EP_POOL_NAK		BIT(17)
> 
> ---
> base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
> change-id: 20240611-aspeed-udc-07dcde062ccf
> 
> Best regards,
> -- 
> Jeremy Kerr <jk@codeconstruct.com.au>
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
