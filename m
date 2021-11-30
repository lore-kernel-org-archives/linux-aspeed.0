From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 30 Nov 2021 12:45:02 +0100
Subject: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <20211130104256.3106797-2-neal_liu@aspeedtech.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
Message-ID: <YaYOvgCaO4FJ8r+z@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> Support qualifier descriptor to pass USB30CV compliance test.

Please provide more information here in this description.  This does not
explain what is happening here very well.

Also, what is "USB30CV"?

> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 24 +++++++++++++++++++++++
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index b9960fdd8a51..93f27a745760 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -68,6 +68,18 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
>  	.bNumConfigurations	= 1,
>  };
>  
> +static const struct usb_qualifier_descriptor ast_vhub_qual_desc = {
> +	.bLength = 0xA,
> +	.bDescriptorType = USB_DT_DEVICE_QUALIFIER,
> +	.bcdUSB = cpu_to_le16(0x0200),
> +	.bDeviceClass = USB_CLASS_HUB,
> +	.bDeviceSubClass = 0,
> +	.bDeviceProtocol = 0,
> +	.bMaxPacketSize0 = 64,
> +	.bNumConfigurations = 1,
> +	.bRESERVED = 0,

Fields that are to be set to zero do not need to be set here, the
compiler does it for you.

thanks,

greg k-h
