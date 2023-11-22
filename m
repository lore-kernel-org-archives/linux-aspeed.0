From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 22 Nov 2023 12:10:34 +0000
Subject: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
In-Reply-To: <20231122014212.304254-1-chentao@kylinos.cn>
References: <20231122014212.304254-1-chentao@kylinos.cn>
Message-ID: <2023112236-bullseye-pranker-491e@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 148d7ec3ebf4..e0854e878411 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
>  	ep->vhub = vhub;
>  	ep->ep.ops = &ast_vhub_epn_ops;
>  	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
> +	if (!ep->ep.name)
> +		return NULL;

This will break things if this ever triggers.  How was this tested?  The
"slot" for this device will still be seen as used and so the resources
never freed and then you can run out of space for real devices, right?

Looks like the other error handling in this function below this call is
also broken, can you fix that up too?

thanks,

greg k-h
