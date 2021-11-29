From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 30 Nov 2021 10:48:48 +1100
Subject: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
In-Reply-To: <20211126110954.2677627-4-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-4-neal_liu@aspeedtech.com>
Message-ID: <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> index 74ea36c19b1e..bea9cbb191a2 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct
> ast_vhub_ep *ep, struct ast_vhub_req
>  		len = remain;
>  		rc = -EOVERFLOW;
>  	}
> +
> +	/* HW return wrong data len */
> +	if (len < ep->ep.maxpacket && len != remain) {
> +		EPDBG(ep, "using expected data len instead\n");
> +		len = remain;
> +	}
> +

Wow, that is a nasty hw bug ! Patch looks good, I had to swap some of
that logic back into my brain but it looks like it won't break any
normal case :-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.

