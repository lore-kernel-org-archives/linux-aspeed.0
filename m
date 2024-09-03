From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 3 Sep 2024 19:19:04 +0300
Subject: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
In-Reply-To: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
References: <20240903131503.961178-1-liaochen4@huawei.com>
 <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
Message-ID: <Ztc2-OuaL2IJI6QW@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 03, 2024 at 05:49:54PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:

...

> I wonder if you found this entry missing by code review, or if you have
> a machine with that UART and so you actually benefit.

Using arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts in QEMU
I never experienced an issue. Seems due to defconfig having it =y.
(used arch/arm/configs/aspeed_g5_defconfig)

> Otherwise looks right to me.
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@baylibre.com>

-- 
With Best Regards,
Andy Shevchenko


