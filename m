From: Mark Brown <broonie@kernel.org>
Date: Mon, 6 Mar 2023 21:27:32 +0000
Subject: [PATCH V5 01/15] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230306172109.595464-2-amit.kumar-mahapatra@amd.com>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-2-amit.kumar-mahapatra@amd.com>
Message-ID: <00684da3-520f-459d-b6bd-55e728e93ebf@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 06, 2023 at 10:50:55PM +0530, Amit Kumar Mahapatra wrote:

>  drivers/spi/spi-omap-100k.c       |  2 +-

This is also not against -rc1, this file was removed in bcace9c4c9270292
("spi: remove omap 100K driver").
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230306/77d163c1/attachment-0001.sig>
