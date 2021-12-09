From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 09 Dec 2021 11:06:00 +1100
Subject: [PATCH v3 4/4] usb: aspeed-vhub: support test mode feature
In-Reply-To: <20211208100545.1441397-5-neal_liu@aspeedtech.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-5-neal_liu@aspeedtech.com>
Message-ID: <9290cfc85fbb857f55ff297e482b06d96c807f1a.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-12-08 at 18:05 +0800, Neal Liu wrote:
> Support aspeed usb vhub set feature to test mode.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 19 +++++++++++++++----
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 23 +++++++++++++++++-----
> -
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index d918e8b2af3c..b0dfca43fbdc 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -110,15 +110,26 @@ static int ast_vhub_dev_feature(struct
> ast_vhub_dev *d,
>  				u16 wIndex, u16 wValue,
>  				bool is_set)
>  {
> +	u32 val;
> +
>  	DDBG(d, "%s_FEATURE(dev val=%02x)\n",
>  	     is_set ? "SET" : "CLEAR", wValue);
>  
> -	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
> -		return std_req_driver;
> +	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
> +		d->wakeup_en = is_set;
> +		return std_req_complete;
> +	}
>  
> -	d->wakeup_en = is_set;
> +	if (wValue == USB_DEVICE_TEST_MODE) {
> +		val = readl(d->vhub->regs + AST_VHUB_CTRL);
> +		val &= ~GENMASK(10, 8);
> +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> +		writel(val, d->vhub->regs + AST_VHUB_CTRL);
>  
> -	return std_req_complete;
> +		return std_req_complete;
> +	}
> +
> +	return std_req_driver;
>  }
>  
>  static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index 93f27a745760..65cd4e46f031 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -212,17 +212,28 @@ static int ast_vhub_hub_dev_feature(struct
> ast_vhub_ep *ep,
>  				    u16 wIndex, u16 wValue,
>  				    bool is_set)
>  {
> +	u32 val;
> +
>  	EPDBG(ep, "%s_FEATURE(dev val=%02x)\n",
>  	      is_set ? "SET" : "CLEAR", wValue);
>  
> -	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
> -		return std_req_stall;
> +	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
> +		ep->vhub->wakeup_en = is_set;
> +		EPDBG(ep, "Hub remote wakeup %s\n",
> +		      is_set ? "enabled" : "disabled");
> +		return std_req_complete;
> +	}
>  
> -	ep->vhub->wakeup_en = is_set;
> -	EPDBG(ep, "Hub remote wakeup %s\n",
> -	      is_set ? "enabled" : "disabled");
> +	if (wValue == USB_DEVICE_TEST_MODE) {
> +		val = readl(ep->vhub->regs + AST_VHUB_CTRL);
> +		val &= ~GENMASK(10, 8);
> +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> +		writel(val, ep->vhub->regs + AST_VHUB_CTRL);
>  
> -	return std_req_complete;
> +		return std_req_complete;
> +	}
> +
> +	return std_req_stall;
>  }
>  
>  static int ast_vhub_hub_ep_feature(struct ast_vhub_ep *ep,

