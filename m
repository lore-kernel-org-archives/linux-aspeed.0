From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 09 Apr 2024 21:20:14 +0930
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tach) Convert to platform remove
 callback returning void
In-Reply-To: <20240409085552.19868-2-u.kleine-koenig@pengutronix.de>
References: <20240409085552.19868-2-u.kleine-koenig@pengutronix.de>
Message-ID: <26cd92fbbd4fdb519434dc5420714b1b20b0a94d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-04-09 at 10:55 +0200, Uwe Kleine-K?nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
