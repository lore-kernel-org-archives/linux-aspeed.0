From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 30 Nov 2021 12:47:29 +0100
Subject: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
In-Reply-To: <20211130104256.3106797-4-neal_liu@aspeedtech.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-4-neal_liu@aspeedtech.com>
Message-ID: <YaYPUfFTNkh+zpqz@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 30, 2021 at 06:42:55PM +0800, Neal Liu wrote:
> If multiple devices in vhub are enumerated simultaneously, ep0 OUT
> ack might received wrong data length. Using expected data length
> instead.
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/ep0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> index 74ea36c19b1e..bea9cbb191a2 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct ast_vhub_ep *ep, struct ast_vhub_req
>  		len = remain;
>  		rc = -EOVERFLOW;
>  	}
> +
> +	/* HW return wrong data len */

Please spell out "Hardware"?

thanks,

greg k-h
