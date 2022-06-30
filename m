From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 30 Jun 2022 08:54:04 +0200
Subject: [PATCH v2 -next] usb: gadget: dereference before null check
In-Reply-To: <20220630044706.10772-1-mailmesebin00@gmail.com>
References: <20220630044706.10772-1-mailmesebin00@gmail.com>
Message-ID: <Yr1IjFBe6JjrDq8n@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 30, 2022 at 10:17:06AM +0530, Sebin Sebastian wrote:
> Fix coverity warning dereferencing before null check. _ep and desc is
> dereferenced on all paths until the check for null. Move the
> initializations after the check for null.

How can those values ever be NULL?

> Coverity issue: 1518209
> 
> Reported-by: kernel test robot <lkp@intel.com>

kernel test robot did not find this issue.

> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>

What commit id does this change fix?

> ---
>  Changes since v1: Fix the build errors and warnings due to first patch.
>  Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.
> 
>  drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..a43cf8dde2a8 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
>  static int ast_udc_ep_enable(struct usb_ep *_ep,
>  			     const struct usb_endpoint_descriptor *desc)
>  {
> -	u16 maxpacket = usb_endpoint_maxp(desc);
> -	struct ast_udc_ep *ep = to_ast_ep(_ep);

checking that ep is NULL here is an impossible thing on its own.  You
did change this so that you didn't check this anymore, which is odd as
you did not mention that in the changelog text :(

> -	struct ast_udc_dev *udc = ep->udc;
> -	u8 epnum = usb_endpoint_num(desc);
>  	unsigned long flags;
>  	u32 ep_conf = 0;
>  	u8 dir_in;
>  	u8 type;
> +	u16 maxpacket;
> +	struct ast_udc_ep *ep;
> +	struct ast_udc_dev *udc;
> +	u8 epnum;

Why did you reorder these?

>  
> -	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
> -	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
> +	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
>  		EP_DBG(ep, "Failed, invalid EP enable param\n");
>  		return -EINVAL;
>  	}
> -

Why did you remove this line?

Also, your To: line is messed up somehow, please fix your email
client...

thanks,

gre gk-h
