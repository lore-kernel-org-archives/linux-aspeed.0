From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 15 Jun 2022 09:31:41 +0000
Subject: [PATCH][next] usb: gadget: ast2600: Fix a couple of spelling
 mistakes
In-Reply-To: <20220615073518.192827-1-colin.i.king@gmail.com>
References: <20220615073518.192827-1-colin.i.king@gmail.com>
Message-ID: <HK0PR06MB3202A6D92D8FD10CFE48F8E680AD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> There are a couple of spelling mistakes, one in a dev_warn message and
> another in a SETUP_DBG message. Fix these and remove an extraneous white
> space too.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Neal Liu <neal_liu@aspeedtech.com>

> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c
> b/drivers/usb/gadget/udc/aspeed_udc.c
> index 1fc15228ff15..05cfcc4812b8 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -904,7 +904,7 @@ static void ast_udc_epn_handle_desc(struct
> ast_udc_dev *udc, u16 ep_num)
>  	int i;
> 
>  	if (list_empty(&ep->queue)) {
> -		dev_warn(dev, "%s reqest queue empty !\n", ep->ep.name);
> +		dev_warn(dev, "%s request queue empty!\n", ep->ep.name);
>  		return;
>  	}
> 
> @@ -1036,7 +1036,7 @@ static void ast_udc_ep0_handle_setup(struct
> ast_udc_dev *udc)
> 
>  	memcpy_fromio(&crq, udc->creq, sizeof(crq));
> 
> -	SETUP_DBG(udc, "SETEUP packet: %02x/%02x/%04x/%04x/%04x\n",
> +	SETUP_DBG(udc, "SETUP packet: %02x/%02x/%04x/%04x/%04x\n",
>  		  crq.bRequestType, crq.bRequest, le16_to_cpu(crq.wValue),
>  		  le16_to_cpu(crq.wIndex), le16_to_cpu(crq.wLength));
> 
> --
> 2.35.3

