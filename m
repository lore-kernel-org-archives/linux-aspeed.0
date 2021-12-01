From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 1 Dec 2021 05:43:16 +0000
Subject: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <YaYOvgCaO4FJ8r+z@kroah.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
 <YaYOvgCaO4FJ8r+z@kroah.com>
Message-ID: <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:45 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
> 
> On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> > Support qualifier descriptor to pass USB30CV compliance test.
> 
> Please provide more information here in this description.  This does not
> explain what is happening here very well.
> 
> Also, what is "USB30CV"?
> 

USB 3 Command Verifier (USB3CV) is the official tool for USB 3 Hub and Device Framework testing.
The USB3CV tool includes the xHCI Compliance Drivers for use with the USB3CV.

We would like to pass USB3CV - Chapter 9 Test [USB 2 devices] - Device Qualifier Tests.
A high-speed capable device that has different device information for full-speed and high-speed
must have a Device Qualifier Descriptor.
This patch is to support device qualifier, and the host will retrieve it through Get Descriptor request.

> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 24
> > +++++++++++++++++++++++  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |
> > 1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > index b9960fdd8a51..93f27a745760 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > @@ -68,6 +68,18 @@ static const struct usb_device_descriptor
> ast_vhub_dev_desc = {
> >  	.bNumConfigurations	= 1,
> >  };
> >
> > +static const struct usb_qualifier_descriptor ast_vhub_qual_desc = {
> > +	.bLength = 0xA,
> > +	.bDescriptorType = USB_DT_DEVICE_QUALIFIER,
> > +	.bcdUSB = cpu_to_le16(0x0200),
> > +	.bDeviceClass = USB_CLASS_HUB,
> > +	.bDeviceSubClass = 0,
> > +	.bDeviceProtocol = 0,
> > +	.bMaxPacketSize0 = 64,
> > +	.bNumConfigurations = 1,
> > +	.bRESERVED = 0,
> 
> Fields that are to be set to zero do not need to be set here, the compiler does it
> for you.
> 
> thanks,
> 
> greg k-h

This is more clear that we specify each member's value.
Thanks

-Neal
