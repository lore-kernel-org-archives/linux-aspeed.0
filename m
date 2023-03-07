From: Mark Brown <broonie@kernel.org>
Date: Tue, 7 Mar 2023 17:00:47 +0000
Subject: [PATCH 00/87] spi: Convert to platform remove callback returning
 void
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
Message-ID: <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 03, 2023 at 06:19:14PM +0100, Uwe Kleine-K?nig wrote:

>   spi: mpc512x-psc: Convert to platform remove callback returning void
>   spi: mpc52xx-psc: Convert to platform remove callback returning void

As well as the Raspberry Pi patch dropped due to build failures I also
dropped these two as they conflicted with Rob's refactoring of that
driver, nothing especially complex but since there's stuff to resend
anyway...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230307/53950802/attachment-0001.sig>
