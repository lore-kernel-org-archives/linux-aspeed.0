From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Apr 2021 22:07:32 -0700
Subject: [PATCH v2] watchdog: aspeed: fix integer overflow in set_timeout
 handler
In-Reply-To: <20210416021337.18715-1-rentao.bupt@gmail.com>
References: <20210416021337.18715-1-rentao.bupt@gmail.com>
Message-ID: <2771f72a-cc3c-54a5-cc2c-715ea61be6b7@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/15/21 7:13 PM, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Fix the time comparison (timeout vs. max_hw_heartbeat_ms) in set_timeout
> handler to avoid potential integer overflow when the supplied timeout is
> greater than aspeed's maximum allowed timeout (4294 seconds).
> 

I think this is the wrong focus: What this fixes is the wrong hardware
timeout calculation. Again, I think that the wrong calculation leads to
the overflow should not be the focus of this patch, though it can of
course be mentioned.

I'll leave it up to Wim to decide if he wants to apply the patch with the
current explanation.

Thanks,
Guenter

> Fixes: efa859f7d786 ("watchdog: Add Aspeed watchdog driver")
> Reported-by: Amithash Prasad <amithash@fb.com>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  Changes in v2:
>    - do not touch "wdd->timeout": only "max_hw_heartbeat_ms * 1000" is
>      updated to "max_hw_heartbeat_ms / 1000".
> 
>  drivers/watchdog/aspeed_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 7e00960651fa..507fd815d767 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -147,7 +147,7 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>  
>  	wdd->timeout = timeout;
>  
> -	actual = min(timeout, wdd->max_hw_heartbeat_ms * 1000);
> +	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
>  
>  	writel(actual * WDT_RATE_1MHZ, wdt->base + WDT_RELOAD_VALUE);
>  	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> 

