From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 19 Sep 2017 11:58:17 +0930
Subject: [PATCH 4/4] watchdog: aspeed: Move init to arch_initcall
In-Reply-To: <b7524108-1927-95a5-e5d6-ade0a8b9ab47@roeck-us.net>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-5-andrew@aj.id.au>
 <b7524108-1927-95a5-e5d6-ade0a8b9ab47@roeck-us.net>
Message-ID: <1505788097.4080.22.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-09-18 at 06:32 -0700, Guenter Roeck wrote:
> On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> > Probing at device_initcall time lead to perverse cases where the
> > watchdog was probed after, say, I2C, which then leaves a potentially
> > running watchdog at the mercy of I2C device behaviour and bus
> > conditions.
> > 
> > Load the watchdog driver early to ensure that the kernel is patting it
> > well before initialising peripherals.
> > 
> 
> But you are doing a bit more. 

True.

> You are making it bool, and you are enabling it
> by default. Both isn't needed for the intended goal (arch_initcall is converted
> to module_initcall if a driver is built as module).

Okay, my understanding on this small point was fuzzy and was something 
I should have chased up. Thanks for the feedback.

>  Your change focuses on
> and optimizes the case where the watchdog is already running. That may not
> always be the case, and there may be systems where the driver is not loaded
> on purpose.

Is this a general comment, or regarding a specific Aspeed BMC-based
system? Currently selecting ARCH_ASPEED will force select WATCHDOG and
ASPEED_WATCHDOG. Thus "default y if ARCH_ASPEED" doesn't actually
change the resulting configuration, but removes the need for the
explicit select in arch/arm/mach-aspeed/Kconfig. I don't know what's
better, but I felt that if we moved from tristate to boolean then
changing the default in the watchdog Kconfig was the right way to go.

The way to reboot the Aspeed SoC is to trip the watchdog. Perhaps
wanting to build without the driver isn't unreasonable, but it would
produce a system that you couldn't reboot. However, that's independent
of whether or not to build as a module so it can remain a tristate. I
think I'll just drop the Kconfig changes and add the exit handler. Sing
out if I should do anything different.

Cheers,

Andrew

> 
> Guenter
> 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >   drivers/watchdog/Kconfig      | 6 ++----
> >   drivers/watchdog/aspeed_wdt.c | 7 ++++++-
> >   2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index a1b92ebe74b6..6103185983ed 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -741,8 +741,9 @@ config RENESAS_RZAWDT
> > > >   	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
> >   
> >   config ASPEED_WATCHDOG
> > > > -	tristate "Aspeed BMC watchdog support"
> > > > +	bool "Aspeed BMC watchdog support"
> > > >   	depends on ARCH_ASPEED || COMPILE_TEST
> > > > +	default y if ARCH_ASPEED
> > > >   	select WATCHDOG_CORE
> > > >   	help
> > > >   	  Say Y here to include support for the watchdog timer
> > @@ -750,9 +751,6 @@ config ASPEED_WATCHDOG
> >   
> > > >   	  This driver is required to reboot the SoC.
> >   
> > > > -	  To compile this driver as a module, choose M here: the
> > > > -	  module will be called aspeed_wdt.
> > -
> >   config ZX2967_WATCHDOG
> > > >   	tristate "ZTE zx2967 SoCs watchdog support"
> > > >   	depends on ARCH_ZX
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> > index 99bc6fbd8852..679c35abadc4 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -313,7 +313,12 @@ static struct platform_driver aspeed_watchdog_driver = {
> > > >   		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
> > > >   	},
> >   };
> > -module_platform_driver(aspeed_watchdog_driver);
> > +
> > +static int __init aspeed_wdt_init(void)
> > +{
> > > > +	return platform_driver_register(&aspeed_watchdog_driver);
> > +}
> > +arch_initcall(aspeed_wdt_init);
> >   
> >   MODULE_DESCRIPTION("Aspeed Watchdog Driver");
> >   MODULE_LICENSE("GPL");
> > 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170919/e1365d50/attachment.sig>
