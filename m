From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 9 Dec 2021 02:39:46 +0000
Subject: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
In-Reply-To: <YbCjVqAie/d84oBm@kroah.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <YbCjVqAie/d84oBm@kroah.com>
Message-ID: <HK0PR06MB3202D7AB1492C2DD542FD75180709@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, December 8, 2021 8:22 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> benh at kernel.crashing.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
> 
> On Wed, Dec 08, 2021 at 06:05:41PM +0800, Neal Liu wrote:
> > These patch series include 2 parts. One is adding more features to
> > pass USB30CV compliance test, the other is fixing hw issues.
> > More detail descriptions are included below patchsets.
> >
> > Change since v2:
> > - Add more description in changelog.
> > - Fix remote wakeup issue patch and make it more configurable.
> >
> > Change since v1:
> > - Remove unnecessary configs for SET_CONFIGURATION.
> > - Separate supporting test mode to new patch.
> >
> > *** BLURB HERE ***
> 
> Blurb is missing :(

I would remove this comment if new patch is necessary.
Thanks

-Neal
