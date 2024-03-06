From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 06 Mar 2024 12:27:55 +1030
Subject: [PATCH 5/6] ipmi: kcs_bmc_aspeed: Convert to platform remove
 callback returning void
In-Reply-To: <d125e83788ddc27fc52a3f11b2c329b40cbdd6f9.1709655755.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
	 <d125e83788ddc27fc52a3f11b2c329b40cbdd6f9.1709655755.git.u.kleine-koenig@pengutronix.de>
Message-ID: <9b390f91102100f1e91098e9d49d6f200aa8a6fd.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-03-05 at 17:27 +0100, Uwe Kleine-K?nig wrote:
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

Thanks!
