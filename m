From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 20 Nov 2023 17:20:54 +0100
Subject: [PATCH 00/21] EDAC: Convert to platform remove callback
 returning void
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20231120162054.haryuye4qedlfd7j@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Boris, hello Tony,

On Wed, Oct 04, 2023 at 03:12:33PM +0200, Uwe Kleine-K?nig wrote:
> this series converts all platform drivers below drivers/edac to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side. However none of the edac drivers suffered from the easy
> to make bug, so all drivers are converted in a trivial way.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> The patch for npcm was already sent back in June
> (https://lore.kernel.org/linux-edac/20230628071354.665300-1-u.kleine-koenig at pengutronix.de)
> but didn't result in enthusiastic review comments and it wasn't picked
> up.
> 
> There are no interdependencies between the patches. As there are still
> quite a few drivers to convert, I'm happy about every patch that makes
> it in. So even if there is a merge conflict with one patch until you
> apply, please apply the remainder of this series anyhow. I'll come back
> to the part that you (maybe) skipped at a later point.

Any news on this series? Would a resend help?

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231120/5d402a14/attachment.sig>
