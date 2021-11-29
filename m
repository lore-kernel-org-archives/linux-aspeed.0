From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 30 Nov 2021 10:45:44 +1100
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <20211126110954.2677627-3-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-3-neal_liu@aspeedtech.com>
Message-ID: <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> Remote wakeup signaling will be automatically issued
> whenever any write commands has been received in suspend
> state.

> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -240,6 +240,9 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
>  	if (vhub->force_usb1)
>  		ctrl |= VHUB_CTRL_FULL_SPEED_ONLY;
>  
> +	/* Enable auto remote wakeup */
> +	ctrl |= VHUB_CTRL_AUTO_REMOTE_WAKEUP;
> +
>  	ctrl |= VHUB_CTRL_UPSTREAM_CONNECT;
>  	writel(ctrl, vhub->regs + AST_VHUB_CTRL);

Should this  be controlled by d->wakeup_en ? IE, we have a feature for
the host to enable/disable remote wakeup, should we honor it ?
 
> +	} else if (wValue == USB_DEVICE_TEST_MODE) {
> +		val = readl(d->vhub->regs + AST_VHUB_CTRL);
> +		val &= ~GENMASK(10, 8);
> +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> +		writel(val, d->vhub->regs + AST_VHUB_CTRL);

This is unrelated to remote wakeup is it ? In which case it should
probably be a separate patch.

Cheers,
Ben.


