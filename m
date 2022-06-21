From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 21 Jun 2022 09:24:30 +0000
Subject: [PATCH 2/2] usb: gadget: aspeed_udc: unlock on error in
 ast_udc_ep_queue()
In-Reply-To: <Yq2S3aF0MPChLD/e@kili>
References: <Yq2SvM2bbrtSd1H9@kili> <Yq2S3aF0MPChLD/e@kili>
Message-ID: <HK0PR06MB32026961C00960BE3789D92180B39@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Call spin_unlock_irqrestore(&udc->lock, flags); before returning an error code.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index 77376ae04224..4dead40895dd 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -663,7 +663,8 @@ static int ast_udc_ep_queue(struct usb_ep *_ep, struct
> usb_request *_req,
>  	if (ep->ep.desc == NULL) {
>  		if ((req->req.dma % 4) != 0) {
>  			dev_warn(dev, "EP0 req dma alignment error\n");
> -			return -ESHUTDOWN;
> +			rc = -ESHUTDOWN;
> +			goto end;
>  		}

One step late, thanks for the patch anyway.
https://lore.kernel.org/lkml/HK0PR06MB3202958ED74CD706458B85CE80AF9 at HK0PR06MB3202.apcprd06.prod.outlook.com/

> 
>  		ast_udc_ep0_queue(ep, req);
> --
> 2.35.1

