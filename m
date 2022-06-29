From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 29 Jun 2022 08:06:32 +0200
Subject: [PATCH-next] usb: gadget: dereference before null check
In-Reply-To: <20220629055605.102425-1-mailmesebin00@gmail.com>
References: <20220629055605.102425-1-mailmesebin00@gmail.com>
Message-ID: <Yrvr6A8YgyZuWQUz@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 29, 2022 at 11:26:05AM +0530, SebinSebastian wrote:
> From: Sebin Sebastian <mailmesebin00@gmail.com>
> 
> Fix coverity warning dereferencing before null check. _ep and desc is
> deferenced on all paths until the check for null. Move the
> initilizations after the check for null.
> Coverity issue: 1518209
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..4f158030e2cc 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
>  static int ast_udc_ep_enable(struct usb_ep *_ep,
>  			     const struct usb_endpoint_descriptor *desc)
>  {
> -	u16 maxpacket = usb_endpoint_maxp(desc);
> -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> -	struct ast_udc_dev *udc = ep->udc;
> -	u8 epnum = usb_endpoint_num(desc);
>  	unsigned long flags;
>  	u32 ep_conf = 0;
>  	u8 dir_in;
> @@ -355,6 +351,12 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
>  		EP_DBG(ep, "Failed, invalid EP enable param\n");
>  		return -EINVAL;
>  	}
> +
> +	u16 maxpacket = usb_endpoint_maxp(desc);
> +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> +	struct ast_udc_dev *udc = ep->udc;
> +	u8 epnum = usb_endpoint_num(desc);
> +
>  
>  	if (!udc->driver) {
>  		EP_DBG(ep, "bogus device state\n");
> -- 
> 2.34.1
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

- Your patch breaks the build.

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
