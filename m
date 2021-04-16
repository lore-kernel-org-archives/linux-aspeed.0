From: Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Apr 2021 00:36:06 +0000
Subject: [PATCH] watchdog: aspeed: fix integer overflow in set_timeout
 handler
In-Reply-To: <20210416001208.16788-1-rentao.bupt@gmail.com>
References: <20210416001208.16788-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8Xdmm-LL+xvbG6bBe0Yd9ZQbPuvwBKhszhjvbOc3pPoH3w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 16 Apr 2021 at 00:12, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Fix the time comparison (timeout vs. max_hw_heartbeat_ms) in set_timeout
> handler to avoid potential integer overflow when the supplied timeout is
> greater than aspeed's maximum allowed timeout (4294 seconds).
>
> Fixes: efa859f7d786 ("watchdog: Add Aspeed watchdog driver")
> Reported-by: Amithash Prasad <amithash@fb.com>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 7e00960651fa..9f77272dc906 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -145,9 +145,8 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>         struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>         u32 actual;
>
> -       wdd->timeout = timeout;
> -
> -       actual = min(timeout, wdd->max_hw_heartbeat_ms * 1000);
> +       actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);

The unit of timeout is seconds. You're comparing to ms/1000, which are
microseconds. I think the existing test is correct?

As far as integer overflow is concerned, max_hw_heartbeat_ms is an
unsigned int. We set it to 4294967, which *1000 = 0xfffffed8. This
should be fine.

> +       wdd->timeout = actual;

This might be the correct thing to do though. I'll defer to the
watchdog maintainers for their input.

Cheers,

Joel

>
>         writel(actual * WDT_RATE_1MHZ, wdt->base + WDT_RELOAD_VALUE);
>         writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> --
> 2.17.1
>
