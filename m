From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 16 Jun 2022 10:16:05 +0000
Subject: [PATCH] usb: gadget: Remove unnecessary print function dev_err()
In-Reply-To: <20220616090410.128483-1-jiapeng.chong@linux.alibaba.com>
References: <20220616090410.128483-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <HK0PR06MB320275CCAE8E424810C8907F80AC9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The print function dev_err() is redundant because platform_get_irq() already
> prints an error.
> 
> This was found by coccicheck:
> 
> ./drivers/usb/gadget/udc/aspeed_udc.c:1546:2-9: line 1546 is redundant
> because platform_get_irq() already prints an error.
> 
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Neal Liu <neal_liu@aspeedtech.com>

> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index 1fc15228ff15..2c3dc80d6b8c 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1543,7 +1543,6 @@ static int ast_udc_probe(struct platform_device
> *pdev)
>  	/* Find interrupt and install handler */
>  	udc->irq = platform_get_irq(pdev, 0);
>  	if (udc->irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get interrupt\n");
>  		rc = udc->irq;
>  		goto err;
>  	}
> --
> 2.20.1.7.g153144c

