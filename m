From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 13 Dec 2022 07:14:25 +0100
Subject: [PATCH] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
In-Reply-To: <20221213025120.23149-1-jiasheng@iscas.ac.cn>
References: <20221213025120.23149-1-jiasheng@iscas.ac.cn>
Message-ID: <Y5gYQZ3iA/k9EPJn@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 13, 2022 at 10:51:19AM +0800, Jiasheng Jiang wrote:
> Add the check for the return value of dma_alloc_coherent
> in order to avoid NULL pointer dereference.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 01968e2167f9..6cf46562bb25 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1516,6 +1516,8 @@ static int ast_udc_probe(struct platform_device *pdev)
>  					  AST_UDC_EP_DMA_SIZE *
>  					  AST_UDC_NUM_ENDPOINTS,
>  					  &udc->ep0_buf_dma, GFP_KERNEL);
> +	if (!udc->ep0_buf)
> +		return -ENOMEM;

How did you test this?  I ask as it is obviously not correct.  Please
always test your patches before submitting them as adding new bugs when
claiming that you are fixing a problem is not good.

And how did you find this potential problem?  What tool did you use and
why did you not follow the documentation for properly describing the
tool?

thanks,

greg k-h
