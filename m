From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 3 Mar 2023 19:39:09 +0100
Subject: [PATCH 00/87] spi: Convert to platform remove callback returning
 void
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230303183909.65uqvaznntwmfwht@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Fri, Mar 03, 2023 at 06:19:14PM +0100, Uwe Kleine-K?nig wrote:
> this patch series adapts the platform drivers below drivers/spi
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> By changing the remove callback to return void driver authors cannot
> reasonably assume any more that there is some kind of cleanup later.
> 
> All drivers touched here returned zero unconditionally in their remove
> callback, so they could all be converted trivially to .remove_new().

One thing I failed to mention here (because my coccinelle patch to
detect that was suboptimal) is: There are 6 drivers---namely
atmel-quadspi.c, spi-imx.c, spi-mt65xx.c, spi-qup.c, spi-sprd.c, and
spi-ti-qspi.c---that might return a non-zero value in their remove
function. Note that this is exactly the problem that I target to rub out
with the effort to change .remove() to return void.

I'll address them separately.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230303/0d8002f1/attachment-0001.sig>
