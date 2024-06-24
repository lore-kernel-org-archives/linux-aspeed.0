From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 24 Jun 2024 10:22:34 +0930
Subject: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240622095618.1890093-1-make24@iscas.ac.cn>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
Message-ID: <f31f59cc4381a41c57b94d10560ec2a7356f8868.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2024-06-22 at 17:56 +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 3916c8e2ba01..95060592c231 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
>  		break;
>  	case USB_RECIP_ENDPOINT:
>  		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
> +		if (epnum >= USB_MAX_ENDPOINTS)

Shouldn't this be `epnum >= AST_UDC_NUM_ENDPOINTS`? Further,
USB_MAX_ENDPOINTS doesn't appear to be defined here?

What steps did you take to test this patch?

Andrew
