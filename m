From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 09:49:15 +0000
Subject: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
In-Reply-To: <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-4-neal_liu@aspeedtech.com>
 <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB3202AAE5C89029C64399DD3680679@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Sent: Tuesday, November 30, 2021 7:49 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
> length issue
> 
> On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > index 74ea36c19b1e..bea9cbb191a2 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct
> > ast_vhub_ep *ep, struct ast_vhub_req
> >  		len = remain;
> >  		rc = -EOVERFLOW;
> >  	}
> > +
> > +	/* HW return wrong data len */
> > +	if (len < ep->ep.maxpacket && len != remain) {
> > +		EPDBG(ep, "using expected data len instead\n");
> > +		len = remain;
> > +	}
> > +
> 
> Wow, that is a nasty hw bug ! Patch looks good, I had to swap some of that
> logic back into my brain but it looks like it won't break any normal case :-)
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Cheers,
> Ben.

Thanks for your review.
-Neal
