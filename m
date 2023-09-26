From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 26 Sep 2023 11:01:37 +0930
Subject: [PATCH 04/40] soc/aspeed: aspeed-uart-routing: Convert to platform remove
 callback returning void
In-Reply-To: <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
Message-ID: <066ea199-30fe-44e8-a3ef-aca3ca92605c@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 25 Sep 2023, at 19:24, Uwe Kleine-K?nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
