From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 23 Oct 2023 13:06:42 +1030
Subject: [PATCH 07/42] crypto: aspeed-hace - Convert to platform remove
 callback returning void
In-Reply-To: <20231020075521.2121571-51-u.kleine-koenig@pengutronix.de>
References: <20231020075521.2121571-44-u.kleine-koenig@pengutronix.de>
	 <20231020075521.2121571-51-u.kleine-koenig@pengutronix.de>
Message-ID: <8980a7fbe644bf00d1840a114e4745395f13b6df.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2023-10-20 at 09:55 +0200, Uwe Kleine-K?nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
