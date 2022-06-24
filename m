From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 24 Jun 2022 02:01:18 +0000
Subject: [PATCH v2] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <YrRj38cU1nV4gsUX@kili>
References: <YrRj38cU1nV4gsUX@kili>
Message-ID: <HK0PR06MB3202A24ACAA94B6525ECA7DF80B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The bug is that we should still enter this loop if "tx_len" is zero.
> 
> Reported-by: Neal Liu <neal_liu@aspeedtech.com>
> Fixes: c09b1f372e74 ("usb: gadget: aspeed_udc: cleanup loop in
> ast_dma_descriptor_setup()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Remove the unnecessary "chunk >= 0" condition

I mean v1 looks good to me.
Sorry if you are misunderstanding.

> 
>  drivers/usb/gadget/udc/aspeed_udc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..6ff02acc5662 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -476,6 +476,7 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep
> *ep, u32 dma_buf,  {
>  	struct ast_udc_dev *udc = ep->udc;
>  	struct device *dev = &udc->pdev->dev;
> +	bool last = false;
>  	int chunk, count;
>  	u32 offset;
> 
> @@ -493,14 +494,16 @@ static int ast_dma_descriptor_setup(struct
> ast_udc_ep *ep, u32 dma_buf,
>  	       "tx_len", tx_len);
> 
>  	/* Create Descriptor Lists */
> -	while (chunk > 0 && count < AST_UDC_DESCS_COUNT) {
> +	while (!last && count < AST_UDC_DESCS_COUNT) {
> 
>  		ep->descs[ep->descs_wptr].des_0 = dma_buf + offset;
> 
> -		if (chunk > ep->chunk_max)
> +		if (chunk > ep->chunk_max) {
>  			ep->descs[ep->descs_wptr].des_1 = ep->chunk_max;
> -		else
> +		} else {
>  			ep->descs[ep->descs_wptr].des_1 = chunk;
> +			last = true;
> +		}
> 
>  		chunk -= ep->chunk_max;
> 
> --
> 2.35.1

