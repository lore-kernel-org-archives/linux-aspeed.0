From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 20 May 2021 18:51:53 -0700
Subject: [PATCH] watchdog: aspeed: fix hardware timeout calculation
In-Reply-To: <20210417042048.GA109800@roeck-us.net>
References: <20210417034249.5978-1-rentao.bupt@gmail.com>
 <20210417042048.GA109800@roeck-us.net>
Message-ID: <20210521015153.GA19153@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Wim,

Not sure if I looked at the wrong repository/branch, and looks like the
patch is not included. Do you have any further suggestions? Or should I
send out v2 in case it's missed?


Thanks,

Tao

On Fri, Apr 16, 2021 at 09:20:48PM -0700, Guenter Roeck wrote:
> On Fri, Apr 16, 2021 at 08:42:49PM -0700, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Fix hardware timeout calculation in aspeed_wdt_set_timeout function to
> > ensure the reload value does not exceed the hardware limit.
> > 
> > Fixes: efa859f7d786 ("watchdog: Add Aspeed watchdog driver")
> > Reported-by: Amithash Prasad <amithash@fb.com>
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> > ---
> >  drivers/watchdog/aspeed_wdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> > index 7e00960651fa..507fd815d767 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -147,7 +147,7 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
> >  
> >  	wdd->timeout = timeout;
> >  
> > -	actual = min(timeout, wdd->max_hw_heartbeat_ms * 1000);
> > +	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
> >  
> >  	writel(actual * WDT_RATE_1MHZ, wdt->base + WDT_RELOAD_VALUE);
> >  	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> > -- 
> > 2.17.1
> > 
