From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 22 Jun 2018 14:14:13 +0200
Subject: [PATCH 0/4] mtd: spi-nor: aspeed: introduce optimized settings for
 fast reads
Message-ID: <20180622121417.6762-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

This series adds support for faster reads on the Aspeed SoC SMC (FMC
and SPI) controllers using a SPI timing calibration sequence to select
the best settings.
=20
Thanks,

C.

 Changes since last time this was discussed (06/2017)

 - the "spi-max-frequency" property is now used to cap the results
 - chips on FMC controllers are also covered

C=C3=A9dric Le Goater (4):
  mtd: spi-nor: aspeed: use command mode for reads
  mtd: spi-nor: aspeed: add support for SPI dual IO read mode
  mtd: spi-nor: aspeed: retrieve the ABH clock frequency
  mtd: spi-nor: aspeed: introduce optimized settings for fast reads

 drivers/mtd/spi-nor/aspeed-smc.c | 294 +++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 281 insertions(+), 13 deletions(-)

--=20
2.13.6

