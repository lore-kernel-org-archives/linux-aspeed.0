From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 30 Nov 2021 10:40:59 +1100
Subject: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <20211126110954.2677627-2-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-2-neal_liu@aspeedtech.com>
Message-ID: <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> 
> @@ -417,10 +435,9 @@ enum std_req_rc ast_vhub_std_hub_request(struct ast_vhub_ep *ep,
>  
>  		/* GET/SET_CONFIGURATION */
>  	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
> -		return ast_vhub_simple_reply(ep, 1);
> +		return ast_vhub_simple_reply(ep, vhub->current_config);
>  	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
> -		if (wValue != 1)
> -			return std_req_stall;
> +		vhub->current_config = wValue;
>  		return std_req_complete;

This is odd.. why should we support arbitrary SET_CONFIGURATION for
configs we don't support ?

Otherwise looks good.

Cheers,
Ben.


