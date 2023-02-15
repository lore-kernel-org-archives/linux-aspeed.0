From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Feb 2023 14:19:16 +0000
Subject: [PATCH v4 01/15] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230210193647.4159467-2-amit.kumar-mahapatra@amd.com>
References: <20230210193647.4159467-1-amit.kumar-mahapatra@amd.com>
 <20230210193647.4159467-2-amit.kumar-mahapatra@amd.com>
Message-ID: <Y+zp5F2l8pffEEvN@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 11, 2023 at 01:06:32AM +0530, Amit Kumar Mahapatra wrote:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and

This again doesn't apply against my current code - I think the
best thing to do here is going to be to rebase against -rc1 when
it comes out and resend then, that will also make the issues
integrating with other trees easier as then I can make a clean
branch against -rc1 that other trees will be able to merge as
needed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230215/38de00d3/attachment-0001.sig>
