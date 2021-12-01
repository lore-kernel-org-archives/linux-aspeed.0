From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 1 Dec 2021 02:17:01 +0000
Subject: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
In-Reply-To: <YaYPUfFTNkh+zpqz@kroah.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-4-neal_liu@aspeedtech.com>
 <YaYPUfFTNkh+zpqz@kroah.com>
Message-ID: <HK0PR06MB32023684D218259A6236C78C80689@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:47 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; BMC-SW
> <BMC-SW@aspeedtech.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>
> Subject: Re: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
> length issue
> 
> On Tue, Nov 30, 2021 at 06:42:55PM +0800, Neal Liu wrote:
> > If multiple devices in vhub are enumerated simultaneously, ep0 OUT ack
> > might received wrong data length. Using expected data length instead.
> >
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/ep0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > index 74ea36c19b1e..bea9cbb191a2 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct
> ast_vhub_ep *ep, struct ast_vhub_req
> >  		len = remain;
> >  		rc = -EOVERFLOW;
> >  	}
> > +
> > +	/* HW return wrong data len */
> 
> Please spell out "Hardware"?
> 
> thanks,
> 
> greg k-h

Sure, I'll fix it in next patch.
Thanks

Best Regards,
-Neal


