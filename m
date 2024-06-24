From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 16:21:13 +0200
Subject: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240624015314.2249128-1-make24@iscas.ac.cn>
References: <20240624015314.2249128-1-make24@iscas.ac.cn>
Message-ID: <2024062400-yearning-curfew-3c9d@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 24, 2024 at 09:53:13AM +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
> 
> Found by static analysis.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 3916c8e2ba01..d972ef4644bc 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
>  		break;
>  	case USB_RECIP_ENDPOINT:
>  		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
> +		if (epnum >= AST_UDC_NUM_ENDPOINTS)
> +			goto stall;
>  		status = udc->ep[epnum].stopped;
>  		break;
>  	default:
> -- 
> 2.25.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
