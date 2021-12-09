From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 9 Dec 2021 02:37:13 +0000
Subject: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
In-Reply-To: <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-3-neal_liu@aspeedtech.com>
 <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Sent: Thursday, December 9, 2021 8:05 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
> iKVM use case
> 
> On Wed, 2021-12-08 at 18:05 +0800, Neal Liu wrote:
> > Signaling remote wakeup if an emulated USB device has any activity if
> > the device is allowed by host.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> 
> I still think it should fundamentally be the device making that decision, but
> since they don't, this is an acceptable workaround, but please, don't write the
> MMIO on every EP queue. Either keep track of the bus being suspended, or
> turn on the AUTO bit in HW when wakeup_en is set.
> 
> Cheers,
> Ben.
> 

I'm confused. Signaling Wakeup when wakeup_en is set if it has any ep activities is not exactly what you said?
wakeup_en is set only if host allows this device have wakeup capability and bus being suspended.
Normal ep activities would not write the MMIO because wakeup_en is not set.
Thanks

-Neal

> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > index 917892ca8753..ccc239b5cc17 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > @@ -381,6 +381,11 @@ static int ast_vhub_epn_queue(struct usb_ep*
> > u_ep, struct usb_request *u_req,
> >  	} else
> >  		u_req->dma = 0;
> >
> > +	if (ep->dev->wakeup_en) {
> > +		EPVDBG(ep, "Wakeup host first\n");
> > +		ast_vhub_hub_wake_all(vhub);
> > +	}
> > +
> >  	EPVDBG(ep, "enqueue req @%p\n", req);
> >  	EPVDBG(ep, " l=%d dma=0x%x zero=%d noshort=%d noirq=%d
> is_in=%d\n",
> >  	       u_req->length, (u32)u_req->dma, u_req->zero,

