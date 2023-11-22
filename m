From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Thu, 23 Nov 2023 00:23:28 +0100
Subject: [PATCH 03/52] serial: 8250: Convert to platform remove callback
 returning void
In-Reply-To: <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
Message-ID: <ZV6NcAXBUcj5wYx8@ashyti-mobl2.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Uwe,

On Fri, Nov 10, 2023 at 04:29:31PM +0100, Uwe Kleine-K?nig wrote:
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

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
