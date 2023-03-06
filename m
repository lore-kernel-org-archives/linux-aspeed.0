From: Mark Brown <broonie@kernel.org>
Date: Mon, 6 Mar 2023 17:32:49 +0000
Subject: [PATCH V5 01/15] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230306172109.595464-2-amit.kumar-mahapatra@amd.com>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-2-amit.kumar-mahapatra@amd.com>
Message-ID: <479f5b1e-6ac1-47c7-9f5b-4080e0c77c16@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 06, 2023 at 10:50:55PM +0530, Amit Kumar Mahapatra wrote:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
> spi->cs_gpiod references with get or set API calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.

This doesn't apply against current code, there was a rework of the
mpc512x-psc driver.  Please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230306/6d1ebfab/attachment-0001.sig>
