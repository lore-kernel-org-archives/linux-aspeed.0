From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 11 Apr 2024 09:15:03 +0200
Subject: [PATCH 0/6] ipmi: Convert to platform remove callback returning
 void
In-Reply-To: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
Message-ID: <3uhfeeahn2u23mxyumyxcyx4kmcxzczipkan7eqh4aslsmhxyz@zgsmwj2jvb2v>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, Mar 05, 2024 at 05:26:57PM +0100, Uwe Kleine-K?nig wrote:
> this series converts all drivers below drivers/char/ipmi to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform: Provide a
> remove callback that returns no value") for an extended explanation and the
> eventual goal.
> 
> All conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
> 
> There are no interdependencies between these patches, so they could be
> picked up individually. But I'd hope that they get picked up all
> together by Corey.

Apart from a (positive) review reply I didn't get any feedback to this
series. My quest to change the prototype of struct
platform_driver::remove depends on these patches, so it would be great
if they made it in during the next merge window.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240411/87b1ccd8/attachment.sig>
