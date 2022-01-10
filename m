From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 10 Jan 2022 06:29:14 +0000
Subject: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
In-Reply-To: <HK0PR06MB3202796B4DDF471856149B1480429@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-3-neal_liu@aspeedtech.com>
 <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
 <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
 <HK0PR06MB3202051E7C15E84006DF55C0807B9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <HK0PR06MB3202796B4DDF471856149B1480429@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <HK0PR06MB320263FDED955EA4B6E0557480509@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Neal Liu
> Sent: Monday, December 27, 2021 10:07 AM
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Felipe Balbi
> <balbi@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel
> Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
> iKVM use case
> 
> > -----Original Message-----
> > From: Neal Liu
> > Sent: Monday, December 20, 2021 10:23 AM
> > To: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Felipe Balbi
> > <balbi@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai
> > Huoqing <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia
> > Lawall <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>;
> > Sasha Levin <sashal@kernel.org>; linux-usb at vger.kernel.org;
> > linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-aspeed at lists.ozlabs.org
> > Cc: BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup
> > failure in iKVM use case
> >
> > > -----Original Message-----
> > > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Sent: Tuesday, December 14, 2021 10:36 AM
> > > To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi
> > > <balbi@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai
> > > Huoqing <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>;
> > > Julia Lawall <julia.lawall@inria.fr>; kernel test robot
> > > <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> > > linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org;
> > > linux-aspeed at lists.ozlabs.org
> > > Cc: BMC-SW <BMC-SW@aspeedtech.com>
> > > Subject: Re: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup
> > > failure in iKVM use case
> > >
> > > On Thu, 2021-12-09 at 02:37 +0000, Neal Liu wrote:
> > > > I'm confused. Signaling Wakeup when wakeup_en is set if it has any
> > > > ep activities is not exactly what you said?
> > > >
> > > > wakeup_en is set only if host allows this device have wakeup
> > > > capability and bus being suspended.
> > > >
> > > > Normal ep activities would not write the MMIO because wakeup_en is
> > > > not set.
> > >
> > > Hrm... I didn't think wakeup_en was limited to the bus being
> > > suspended, but maybe I misremember, it's been a while.
> > >
> > > Cheers,
> > > Ben.
> > >
> >
> > wakeup_en is only set in the case of host set
> USB_DEVICE_REMOTE_WAKEUP
> > feature to vhub devices.
> > I think this behavior only occurs during host is going to suspend, and
> > set this feature to any device which can wakeup itself before sleep.
> > Thanks
> >
> > -Neal
> >
> Would you like to test it if you have some free time.
> Please feel free for any feedback.
> 
> -Neal

Gentle ping for this patch.
Thanks

