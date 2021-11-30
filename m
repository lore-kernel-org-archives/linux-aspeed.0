From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 09:47:26 +0000
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-3-neal_liu@aspeedtech.com>
 <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Sent: Tuesday, November 30, 2021 7:46 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
> 
> On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> > Remote wakeup signaling will be automatically issued whenever any
> > write commands has been received in suspend state.
> 
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -240,6 +240,9 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
> >  	if (vhub->force_usb1)
> >  		ctrl |= VHUB_CTRL_FULL_SPEED_ONLY;
> >
> > +	/* Enable auto remote wakeup */
> > +	ctrl |= VHUB_CTRL_AUTO_REMOTE_WAKEUP;
> > +
> >  	ctrl |= VHUB_CTRL_UPSTREAM_CONNECT;
> >  	writel(ctrl, vhub->regs + AST_VHUB_CTRL);
> 
> Should this  be controlled by d->wakeup_en ? IE, we have a feature for the
> host to enable/disable remote wakeup, should we honor it ?
> 
For KVM usage, remote keyboard packet would be sent if user wants to do remote wakeup.
In this case, d->wakeup_en is not used.
Set VHUB_CTRL_AUTO_REMOTE_WAKEUP to enable HW automatically signaling wakeup if
any packet would be transferred.

> > +	} else if (wValue == USB_DEVICE_TEST_MODE) {
> > +		val = readl(d->vhub->regs + AST_VHUB_CTRL);
> > +		val &= ~GENMASK(10, 8);
> > +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> > +		writel(val, d->vhub->regs + AST_VHUB_CTRL);
> 
> This is unrelated to remote wakeup is it ? In which case it should probably be a
> separate patch.
> 
> Cheers,
> Ben.
> 
Yes, I'll separate this patch.
Thanks

-Neal
