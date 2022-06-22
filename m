From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 22 Jun 2022 05:25:20 +0000
Subject: [PATCH 1/2] usb: gadget: aspeed_udc: cleanup loop in
 ast_dma_descriptor_setup()
In-Reply-To: <Yq2SvM2bbrtSd1H9@kili>
References: <Yq2SvM2bbrtSd1H9@kili>
Message-ID: <HK0PR06MB3202376E1119C0CF1658656580B29@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The "chunk >= 0" condition does not work because count is a u32.
> Also, really we shouldn't enter the loop when "chunk" is zero.
> 
> Once that condition is fixed then there is no need for the "last"
> variable.  I reversed the "if (chunk <= ep->chunk_max)" as well.
> The new loop is much simpler.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index 1fc15228ff15..77376ae04224 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -476,8 +476,8 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep
> *ep, u32 dma_buf,  {
>  	struct ast_udc_dev *udc = ep->udc;
>  	struct device *dev = &udc->pdev->dev;
> -	u32 offset, chunk;
> -	int count, last;
> +	int chunk, count;
> +	u32 offset;
> 
>  	if (!ep->descs) {
>  		dev_warn(dev, "%s: Empty DMA descs list failure\n", @@ -486,30
> +486,28 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32
> dma_buf,
>  	}
> 
>  	chunk = tx_len;
> -	offset = count = last = 0;
> +	offset = count = 0;
> 
>  	EP_DBG(ep, "req @%p, %s:%d, %s:0x%x, %s:0x%x\n", req,
>  	       "wptr", ep->descs_wptr, "dma_buf", dma_buf,
>  	       "tx_len", tx_len);
> 
>  	/* Create Descriptor Lists */
> -	while (chunk >= 0 && !last && count < AST_UDC_DESCS_COUNT) {
> +	while (chunk > 0 && count < AST_UDC_DESCS_COUNT) {
> 

Simpler loop looks good to me. But short packet need to be considered also. (chunk == 0)

>  		ep->descs[ep->descs_wptr].des_0 = dma_buf + offset;
> 
> -		if (chunk <= ep->chunk_max) {
> -			ep->descs[ep->descs_wptr].des_1 = chunk;
> -			last = 1;
> -		} else {
> +		if (chunk > ep->chunk_max)
>  			ep->descs[ep->descs_wptr].des_1 = ep->chunk_max;
> -			chunk -= ep->chunk_max;
> -		}
> +		else
> +			ep->descs[ep->descs_wptr].des_1 = chunk;
> +
> +		chunk -= ep->chunk_max;
> 
> -		EP_DBG(ep, "descs[%d]: 0x%x 0x%x, last:%d\n",
> +		EP_DBG(ep, "descs[%d]: 0x%x 0x%x\n",
>  		       ep->descs_wptr,
>  		       ep->descs[ep->descs_wptr].des_0,
> -		       ep->descs[ep->descs_wptr].des_1,
> -		       last);
> +		       ep->descs[ep->descs_wptr].des_1);
> 
>  		if (count == 0)
>  			req->saved_dma_wptr = ep->descs_wptr;
> --
> 2.35.1

