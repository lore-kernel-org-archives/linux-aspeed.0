From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 15 Dec 2020 02:17:34 +0000
Subject: [PATCH v2 5/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <d6f83615-c9d1-4906-81e7-10528e963c94@www.fastmail.com>
References: <20201005082806.28899-1-chiawei_wang@aspeedtech.com>
 <20201005082806.28899-6-chiawei_wang@aspeedtech.com>
 <2e2d3a02-6677-4b0e-b538-d3130a3b20d1@www.fastmail.com>
 <HK0PR06MB3779F5B4B9629909DDF441F091C70@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <d6f83615-c9d1-4906-81e7-10528e963c94@www.fastmail.com>
Message-ID: <HK0PR06MB3779995E6FA5D6B2DE16F73D91C60@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, December 15, 2020 8:12 AM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Lee Jones
> <lee.jones@linaro.org>; Corey Minyard <minyard@acm.org>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Linus
> Walleij <linus.walleij@linaro.org>; Haiyue Wang
> <haiyue.wang@linux.intel.com>; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> openbmc at lists.ozlabs.org; linux-gpio at vger.kernel.org
> Subject: Re: [PATCH v2 5/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
> 
> Hi Chiawei,
> 
> On Mon, 14 Dec 2020, at 13:14, ChiaWei Wang wrote:
> > Hi Andrew & Rob,
> >
> > Do you have any suggestion on this patch?
> 
> Rob hasn't responded, but I think it will be easier to get an Ack out of him if we
> do a v2 of the binding so we're not breaking backwards-compatibility with the
> current definition. Concretely:
> 
> - compatible:   One of:
>                 "aspeed,ast2400-lpc", "simple-mfd"
>                 "aspeed,ast2500-lpc", "simple-mfd"
> 
> Becomes something like:
> 
> - compatible:   One of:
>                 "aspeed,ast2400-lpc-v2", "simple-mfd"
>                 "aspeed,ast2500-lpc-v2", "simple-mfd"
> 
> We can convert the in-tree devicetrees, immediately drop support for the
> current binding in the drivers, and _only_ support v2 of the binding going
> forward. That way your patches stay largely the same, the binding isn't
> hamstrung as it is currently, and we're not trying to maintain code to support
> the current binding definition - but we're also not pretending that old
> devicetrees will work with newer kernels that only support the new binding
> definition (which is the problem with your current patch series).
> 
> How does that sound?
Sounds good. The v2 binding string should be a notification to sync both the new device tree and the new drivers.
I will prepare a v3 patch with this change and the commit reordering suggested.

Thanks,
Chiawei

> 
> As to how to implement this, I think we'll need to add some
> of_device_is_compatible() checks in the relevant drivers to make sure that
> they're using the new LPC binding, such as in
> drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c before we fetch the regmap on line
> 2657.
> 
> Sorry that this is dragging out a bit (and for the mess I made).
> 
> Cheers,
> 
> Andrew
