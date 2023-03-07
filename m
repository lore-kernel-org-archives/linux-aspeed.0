From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue, 7 Mar 2023 18:46:22 +0100
Subject: [PATCH 00/87] spi: Convert to platform remove callback returning
 void
In-Reply-To: <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <ddcda593-f8e9-43a4-bba6-dae31e8d6b39@sirena.org.uk>
Message-ID: <20230307174622.vluzrlicw2gdn7hq@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Mark,

On Tue, Mar 07, 2023 at 05:00:47PM +0000, Mark Brown wrote:
> On Fri, Mar 03, 2023 at 06:19:14PM +0100, Uwe Kleine-K?nig wrote:
> 
> >   spi: mpc512x-psc: Convert to platform remove callback returning void
> >   spi: mpc52xx-psc: Convert to platform remove callback returning void
> 
> As well as the Raspberry Pi patch dropped due to build failures I also
> dropped these two as they conflicted with Rob's refactoring of that
> driver, nothing especially complex but since there's stuff to resend
> anyway...

Fine for me. Given that my queue of patches to convert the remove
callbacks is quite big, there is no pressure from my side to get these
all in. 84 from 87 is great already, I'll care about the remaining 3
patches (and the few drivers that don't return 0 in .remove()) later.

Thanks
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230307/3cc53edf/attachment-0001.sig>
