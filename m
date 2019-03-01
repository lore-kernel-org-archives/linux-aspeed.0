From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 1 Mar 2019 17:21:41 +0100
Subject: [PATCH] usb: introduce usb_ep_type_string() function
In-Reply-To: <e2ff70a3608dce315b52aea710398ba79d0f6f93.1551422947.git.chunfeng.yun@mediatek.com>
References: <e2ff70a3608dce315b52aea710398ba79d0f6f93.1551422947.git.chunfeng.yun@mediatek.com>
Message-ID: <20190301162141.GB19937@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 01, 2019 at 02:58:23PM +0800, Chunfeng Yun wrote:
> In some places, the code prints a human-readable USB endpoint
> transfer type (e.g. "bulk"). This involves a switch statement
> sometimes wrapped around in ({ ... }) block leading to code
> repetition.
> To make this scenario easier, here introduces usb_ep_type_string()
> function, which returns a human-readable name of provided
> endpoint type.
> It also changes a few places switch was used to use this
> new function.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/common/common.c              | 16 ++++++++++++++++
>  drivers/usb/core/endpoint.c              | 18 ++----------------
>  drivers/usb/core/hcd.c                   | 17 ++---------------
>  drivers/usb/dwc3/debugfs.c               | 23 ++++-------------------
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c |  6 +-----
>  drivers/usb/gadget/udc/dummy_hcd.c       | 16 +---------------
>  drivers/usb/host/xhci-trace.h            | 19 ++-----------------
>  include/linux/usb/ch9.h                  |  8 ++++++++
>  8 files changed, 36 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 48277bbc15e4..2174dd9ec176 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -16,6 +16,22 @@
>  #include <linux/usb/otg.h>
>  #include <linux/of_platform.h>
>  
> +static const char *const ep_type_names[] = {
> +	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
> +	[USB_ENDPOINT_XFER_ISOC] = "isoc",
> +	[USB_ENDPOINT_XFER_BULK] = "bulk",
> +	[USB_ENDPOINT_XFER_INT] = "intr",
> +};
> +
> +const char *usb_ep_type_string(int ep_type)
> +{
> +	if (ep_type < 0 || ep_type >= ARRAY_SIZE(ep_type_names))
> +		return "unknown";
> +
> +	return ep_type_names[ep_type];
> +}
> +EXPORT_SYMBOL_GPL(usb_ep_type_string);
> +
>  const char *usb_otg_state_string(enum usb_otg_state state)
>  {
>  	static const char *const names[] = {
> diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
> index 1c2c04079676..afa43f9a47b2 100644
> --- a/drivers/usb/core/endpoint.c
> +++ b/drivers/usb/core/endpoint.c
> @@ -60,23 +60,9 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
>  	struct ep_device *ep = to_ep_device(dev);
> -	char *type = "unknown";
> +	int ep_type = usb_endpoint_type(ep->desc);
>  
> -	switch (usb_endpoint_type(ep->desc)) {
> -	case USB_ENDPOINT_XFER_CONTROL:
> -		type = "Control";
> -		break;
> -	case USB_ENDPOINT_XFER_ISOC:
> -		type = "Isoc";
> -		break;
> -	case USB_ENDPOINT_XFER_BULK:
> -		type = "Bulk";
> -		break;
> -	case USB_ENDPOINT_XFER_INT:
> -		type = "Interrupt";
> -		break;
> -	}
> -	return sprintf(buf, "%s\n", type);
> +	return sprintf(buf, "%s\n", usb_ep_type_string(ep_type));

You just changed a user/kernel API here, the strings are now different
from what they used to be :(

That's not ok, odds are you will break tools if you do this.

>  }
>  static DEVICE_ATTR_RO(type);
>  
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 015b126ce455..193ee92b2fdb 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1875,23 +1875,10 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
>  		/* kick hcd */
>  		unlink1(hcd, urb, -ESHUTDOWN);
>  		dev_dbg (hcd->self.controller,
> -			"shutdown urb %pK ep%d%s%s\n",
> +			"shutdown urb %pK ep%d%s-%s\n",
>  			urb, usb_endpoint_num(&ep->desc),
>  			is_in ? "in" : "out",
> -			({	char *s;
> -
> -				 switch (usb_endpoint_type(&ep->desc)) {
> -				 case USB_ENDPOINT_XFER_CONTROL:
> -					s = ""; break;
> -				 case USB_ENDPOINT_XFER_BULK:
> -					s = "-bulk"; break;
> -				 case USB_ENDPOINT_XFER_INT:
> -					s = "-intr"; break;
> -				 default:
> -					s = "-iso"; break;
> -				};
> -				s;
> -			}));
> +			usb_ep_type_string(usb_endpoint_type(&ep->desc)));

You also changed the message here for control endpoints, but that's not
a big deal, it's ok.

>  		usb_put_urb (urb);
>  
>  		/* list contents may have changed */
> diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> index 1c792710348f..d9e2a63835fe 100644
> --- a/drivers/usb/dwc3/debugfs.c
> +++ b/drivers/usb/dwc3/debugfs.c
> @@ -750,28 +750,13 @@ static int dwc3_transfer_type_show(struct seq_file *s, void *unused)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	if (!(dep->flags & DWC3_EP_ENABLED) ||
> -			!dep->endpoint.desc) {
> -		seq_printf(s, "--\n");
> +	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc) {
> +		seq_puts(s, "unknown\n");
>  		goto out;
>  	}
>  
> -	switch (usb_endpoint_type(dep->endpoint.desc)) {
> -	case USB_ENDPOINT_XFER_CONTROL:
> -		seq_printf(s, "control\n");
> -		break;
> -	case USB_ENDPOINT_XFER_ISOC:
> -		seq_printf(s, "isochronous\n");
> -		break;
> -	case USB_ENDPOINT_XFER_BULK:
> -		seq_printf(s, "bulk\n");
> -		break;
> -	case USB_ENDPOINT_XFER_INT:
> -		seq_printf(s, "interrupt\n");
> -		break;
> -	default:
> -		seq_printf(s, "--\n");
> -	}
> +	seq_printf(s, "%s\n",
> +		   usb_ep_type_string(usb_endpoint_type(dep->endpoint.desc)));

It is debugfs, so no real API guarantees at all, but you did change the
output format, and that's not always good.

>  
>  out:
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 4a28e3fbeb0b..165b0a43670e 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -593,10 +593,6 @@ static int ast_vhub_epn_disable(struct usb_ep* u_ep)
>  static int ast_vhub_epn_enable(struct usb_ep* u_ep,
>  			       const struct usb_endpoint_descriptor *desc)
>  {
> -	static const char *ep_type_string[] __maybe_unused = { "ctrl",
> -							       "isoc",
> -							       "bulk",
> -							       "intr" };
>  	struct ast_vhub_ep *ep = to_ast_ep(u_ep);
>  	struct ast_vhub_dev *dev;
>  	struct ast_vhub *vhub;
> @@ -646,7 +642,7 @@ static int ast_vhub_epn_enable(struct usb_ep* u_ep,
>  	ep->epn.wedged = false;
>  
>  	EPDBG(ep, "Enabling [%s] %s num %d maxpacket=%d\n",
> -	      ep->epn.is_in ? "in" : "out", ep_type_string[type],
> +	      ep->epn.is_in ? "in" : "out", usb_ep_type_string(type),
>  	      usb_endpoint_num(desc), maxpacket);
>  
>  	/* Can we use DMA descriptor mode ? */
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index baf72f95f0f1..40c6a484e232 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -617,21 +617,7 @@ static int dummy_enable(struct usb_ep *_ep,
>  		_ep->name,
>  		desc->bEndpointAddress & 0x0f,
>  		(desc->bEndpointAddress & USB_DIR_IN) ? "in" : "out",
> -		({ char *val;
> -		 switch (usb_endpoint_type(desc)) {
> -		 case USB_ENDPOINT_XFER_BULK:
> -			 val = "bulk";
> -			 break;
> -		 case USB_ENDPOINT_XFER_ISOC:
> -			 val = "iso";
> -			 break;
> -		 case USB_ENDPOINT_XFER_INT:
> -			 val = "intr";
> -			 break;
> -		 default:
> -			 val = "ctrl";
> -			 break;
> -		 } val; }),
> +		usb_ep_type_string(usb_endpoint_type(desc)),
>  		max, ep->stream_en ? "enabled" : "disabled");
>  
>  	/* at this point real hardware should be NAKing transfers
> diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
> index 88b427434bd8..bac73d688f11 100644
> --- a/drivers/usb/host/xhci-trace.h
> +++ b/drivers/usb/host/xhci-trace.h
> @@ -289,23 +289,8 @@ DECLARE_EVENT_CLASS(xhci_log_urb,
>  	),
>  	TP_printk("ep%d%s-%s: urb %p pipe %u slot %d length %d/%d sgs %d/%d stream %d flags %08x",
>  			__entry->epnum, __entry->dir_in ? "in" : "out",
> -			({ char *s;
> -			switch (__entry->type) {
> -			case USB_ENDPOINT_XFER_INT:
> -				s = "intr";
> -				break;
> -			case USB_ENDPOINT_XFER_CONTROL:
> -				s = "control";
> -				break;
> -			case USB_ENDPOINT_XFER_BULK:
> -				s = "bulk";
> -				break;
> -			case USB_ENDPOINT_XFER_ISOC:
> -				s = "isoc";
> -				break;
> -			default:
> -				s = "UNKNOWN";
> -			} s; }), __entry->urb, __entry->pipe, __entry->slot_id,
> +			usb_ep_type_string(__entry->type),
> +			__entry->urb, __entry->pipe, __entry->slot_id,
>  			__entry->actual, __entry->length, __entry->num_mapped_sgs,
>  			__entry->num_sgs, __entry->stream, __entry->flags
>  		)

Another api change with "control" :(

I like the idea, but you can not break user/kernel apis like this
without knowing the affects that could happen.

thanks,

greg k-h
