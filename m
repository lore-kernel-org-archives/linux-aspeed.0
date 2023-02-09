From: Mark Brown <broonie@kernel.org>
Date: Thu, 9 Feb 2023 14:30:29 +0000
Subject: [PATCH v3 01/13] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230202152258.512973-2-amit.kumar-mahapatra@amd.com>
References: <20230202152258.512973-1-amit.kumar-mahapatra@amd.com>
 <20230202152258.512973-2-amit.kumar-mahapatra@amd.com>
Message-ID: <Y+UDhWK6u9NkMTxv@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 02, 2023 at 08:52:46PM +0530, Amit Kumar Mahapatra wrote:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the

This break an arm multi_v7_defconfig build:

/build/stage/linux/drivers/spi/spi-pl022.c: In function ?pl022_transfer_one_message?:
/build/stage/linux/drivers/spi/spi-pl022.c:1592:31: error: ?struct spi_message? has no member named ?spi_get_csgpiod?
 1592 |         pl022->cur_gpiod = msg->spi_get_csgpiod(spi, 0);
      |                               ^~
/build/stage/linux/drivers/spi/spi-pl022.c:1592:49: error: ?spi? undeclared (first use in this function)
 1592 |         pl022->cur_gpiod = msg->spi_get_csgpiod(spi, 0);
      |                                                 ^~~
/build/stage/linux/drivers/spi/spi-pl022.c:1592:49: note: each undeclared identifier is reported only once for each function it appears in
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230209/9ceef7c4/attachment-0001.sig>
