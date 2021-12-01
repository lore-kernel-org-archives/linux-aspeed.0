From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 1 Dec 2021 02:09:13 +0000
Subject: [PATCH v2 0/4] Refactor Aspeed USB vhub driver
In-Reply-To: <YaYOFTmLLUJpPug1@kroah.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
 <YaYOFTmLLUJpPug1@kroah.com>
Message-ID: <HK0PR06MB3202C0D98DD6B300D9102B1380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:42 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> benh at kernel.crashing.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 0/4] Refactor Aspeed USB vhub driver
> 
> On Tue, Nov 30, 2021 at 07:38:43PM +0800, Neal Liu wrote:
> > +Ben.
> > ---
> >
> > These patch series include 2 parts. One is adding more features to
> > pass USB30CV compliance test, the other is fixing hw issues.
> > More detail descriptions are included below patchsets.
> >
> > Change since v1:
> > - Remove unnecessary configs for SET_CONFIGURATION.
> > - Separate supporting test mode to new patch.
> >
> > *** BLURB HERE ***
> 
> No blurb?

It been cut off...
I'll fix it.
Thanks

- Neal
