From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 19 Sep 2017 12:00:56 +0930
Subject: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
In-Reply-To: <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-2-andrew@aj.id.au>
 <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
Message-ID: <1505788256.4080.24.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-09-18 at 06:25 -0700, Guenter Roeck wrote:
> On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> > An unintended post-condition of probe() is that the watchdog is
> > disabled. Rework probe() such that we retain the value of the "enabled"
> > bit from the control register, and take the appropriate actions with
> > respect to the watchdog core if so. Otherwise, just configure the
> > watchdog as directed.
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >   drivers/watchdog/aspeed_wdt.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> > index 79cc766cd30f..99bc6fbd8852 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> > > >   		return -EINVAL;
> > > >   	config = ofdid->data;
> >   
> > > > -	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> > > > +	wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
> > > > +	wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
> >   
> > > >   	/*
> > > >   	 * Control reset on a per-device basis to ensure the
> > @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> > > >   	if (of_property_read_bool(np, "aspeed,external-signal"))
> > > >   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
> >   
> > > > -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> > -
> > > > -	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> > > > +	if (wdt->ctrl & WDT_CTRL_ENABLE) {
> >   		aspeed_wdt_start(&wdt->wdd);
> 
> Why call the start function in this case ?

... Good question. It was already there so I didn't touch it. I expect
it can be dropped - I'll look into it.

> 
> > > > > >   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status); > +	} else {
> > > > +		writel(wdt->ctrl, wdt->base + WDT_CTRL);
> > > >   	}
> >   
> > > >   	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> > 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170919/d8e14082/attachment.sig>
