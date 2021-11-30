From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 30 Nov 2021 12:47:04 +0100
Subject: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
In-Reply-To: <20211130104256.3106797-5-neal_liu@aspeedtech.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-5-neal_liu@aspeedtech.com>
Message-ID: <YaYPOAB3Anfhh5AA@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 30, 2021 at 06:42:56PM +0800, Neal Liu wrote:
> Support aspeed usb vhub set feature to test mode.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 18 ++++++++++++++----
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 22 ++++++++++++++++------
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index d918e8b2af3c..4462f4b73b04 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct ast_vhub_dev *d,
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
>  
> -	d->wakeup_en = is_set;
> +	} else if (wValue == USB_DEVICE_TEST_MODE) {

If you return, no need for an else statement, right?


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
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index 93f27a745760..e52805fbdebd 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct ast_vhub_ep *ep,
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
>  
> -	ep->vhub->wakeup_en = is_set;
> -	EPDBG(ep, "Hub remote wakeup %s\n",
> -	      is_set ? "enabled" : "disabled");
> +	} else if (wValue == USB_DEVICE_TEST_MODE) {

Same here, no need for else.

thanks,

greg k-h
