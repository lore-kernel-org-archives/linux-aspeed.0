From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Sep 2017 12:02:08 +0930
Subject: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
In-Reply-To: <CACPK8XezE6ZSfSQ7Aq7g85imqXLuahWGu_SQzG=+LAq0UxSdyA@mail.gmail.com>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-2-andrew@aj.id.au>
 <CACPK8XezE6ZSfSQ7Aq7g85imqXLuahWGu_SQzG=+LAq0UxSdyA@mail.gmail.com>
Message-ID: <1505874728.30138.3.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 2017-09-20 at 11:17 +0930, Joel Stanley wrote:
> > On Mon, Sep 18, 2017 at 3:19 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > An unintended post-condition of probe() is that the watchdog is
> > disabled. Rework probe() such that we retain the value of the "enabled"
> > bit from the control register, and take the appropriate actions with
> > respect to the watchdog core if so. Otherwise, just configure the
> > watchdog as directed.
> > 
> 
> This should have a fixes line. The code as it stands in 4.14-rc1
> unconditionally disables the watchdog at boot :(

I'll add a fixes line.

> 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/watchdog/aspeed_wdt.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> > index 79cc766cd30f..99bc6fbd8852 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >         config = ofdid->data;
> > 
> > -       wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> > +       wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
> 
> If we go back to before b7f0b8ad25f3 ("drivers/watchdog: ASPEED
> reference dev tree properties for config"), the driver set up the
> cached ctrl value and then tested the hardware state to decide if we
> should have the watchdog enabled.
> 
> Looking at the driver now there's little reason to keep the cached
> ctrl value. I'd suggest reworking the driver to not have it so we can
> avoid bugs like the ones that b7f0b8ad25f3 introduced.

Alternatively, we can just drop the write I moved to the else branch
and rely on aspeed_wdt_start() to configure the control register for
us.

Guenter: This means we retain the call you questioned. It's name might
be slightly misleading in terms of the effect it gives us (configuring
the watchdog to match the driver's assumptions), but doing it that way
effectively turns my original patch into a one-liner to delete the
writel(). If the watchdog is disabled at the point of kernel
initialisation then the configuration doesn't matter until userspace
opens the chardev, at which point we'll write the configuration via
aspeed_wdt_start() anyway.

Andrew

> 
> Cheers,
> 
> Joel
> 
> > +       wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
> > 
> >         /*
> >          * Control reset on a per-device basis to ensure the
> > @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> >         if (of_property_read_bool(np, "aspeed,external-signal"))
> >                 wdt->ctrl |= WDT_CTRL_WDT_EXT;
> > 
> > -       writel(wdt->ctrl, wdt->base + WDT_CTRL);
> > -
> > -       if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> > +       if (wdt->ctrl & WDT_CTRL_ENABLE) {
> >                 aspeed_wdt_start(&wdt->wdd);
> >                 set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> > +       } else {
> > +               writel(wdt->ctrl, wdt->base + WDT_CTRL);
> >         }
> > 
> >         if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> > --
> > 2.11.0
> > 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170920/57132d2c/attachment.sig>
