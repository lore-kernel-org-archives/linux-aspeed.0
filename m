From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 23 Dec 2022 15:54:37 +0100
Subject: [PATCH v3] usb: gadget: aspeed_udc: Add check for
 dma_alloc_coherent
In-Reply-To: <20221215123112.20553-1-jiasheng@iscas.ac.cn>
References: <20221215123112.20553-1-jiasheng@iscas.ac.cn>
Message-ID: <Y6XBLcTGUp/2ta9i@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 15, 2022 at 08:31:12PM +0800, Jiasheng Jiang wrote:
> Add the check for the return value of dma_alloc_coherent in order to
> avoid NULL pointer dereference.
> 
> This flaw was found using an experimental static analysis tool we are
> developing, APP-Miner, which has not been disclosed.
> 
> The allyesconfig build using GCC 9.3.0 shows no new warning. As we
> don't have a UDC device to test with, no runtime testing was able to
> be performed.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Add information of finding tool and tests to commit message.
> 
> v1 -> v2:
> 
> 1. Add "goto err;" when allocation fails.
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 01968e2167f9..7dc2457c7460 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1516,6 +1516,10 @@ static int ast_udc_probe(struct platform_device *pdev)
>  					  AST_UDC_EP_DMA_SIZE *
>  					  AST_UDC_NUM_ENDPOINTS,
>  					  &udc->ep0_buf_dma, GFP_KERNEL);
> +	if (!udc->ep0_buf) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
>  
>  	udc->gadget.speed = USB_SPEED_UNKNOWN;
>  	udc->gadget.max_speed = USB_SPEED_HIGH;
> -- 
> 2.25.1
> 

Why is this just a duplicate of the patch previously submitted here:
	https://lore.kernel.org/r/20221125092833.74822-1-yuancan at huawei.com

confused,

greg k-h
