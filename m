From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:03 +0200
Subject: [PATCH 00/16] mtd: spi-nor: aspeed: AST2600 support and extensions
Message-ID: <20191004115919.20788-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series first extends the support for the Aspeed AST2500 and
AST2400 SMC driver. It adds Dual Data support and read training giving
the best read settings for a given chip. Support for the new AST2600
SoC is added at the end.

I understand that a new spi_mem framework exists and I do have an
experimental driver using it. But unfortunately, it is difficult to
integrate the read training. The Aspeed constraints are not compatible
and i haven't had the time to extend the current framework.

This patchset has been in use for some time in the OpenBMC kernel on
these systems :

 * OpenPOWER Palmetto (AST2400)
 * Evaluation board (AST2500) 
 * OpenPOWER Witherspoon (AST2500)
 * OpenPOWER Romulus (AST2500)
 * OpenPOWER Zaius (AST2500)
   and many others
 
and it is now in use on these boards with the new SoC :

 * Evaluation board (AST2600) 
 * Tacoma board (AST2600) 

Thanks,

C.

Alexander Soldatov (1):
  mtd: spi-nor: fix options for mx66l51235f

C?dric Le Goater (15):
  mtd: spi-nor: aspeed: Use command mode for reads
  mtd: spi-nor: aspeed: Add support for SPI dual IO read mode
  mtd: spi-nor: aspeed: Link controller with the ahb clock
  mtd: spi-nor: aspeed: Add read training
  mtd: spi-nor: aspeed: Limit the maximum SPI frequency
  mtd: spi-nor: aspeed: Add support for the 4B opcodes
  mtd: spi-nor: Add support for w25q512jv
  mtd: spi-nor: aspeed: Introduce a field for the AHB physical address
  mtd: spi-nor: aspeed: Introduce segment operations
  dt-bindings: mtd: aspeed-smc: Add new comptatible for AST2600
  mtd: spi-nor: aspeed: Add initial support for the AST2600
  mtd: spi-nor: aspeed: Check for disabled segments on the AST2600
  mtd: spi-nor: aspeed: Introduce training operations per platform
  mtd: spi-nor: aspeed: Introduce a HCLK mask for training
  mtd: spi-nor: aspeed: Add read training support for the AST2600

 drivers/mtd/spi-nor/aspeed-smc.c              | 593 ++++++++++++++++--
 drivers/mtd/spi-nor/spi-nor.c                 |   5 +-
 .../devicetree/bindings/mtd/aspeed-smc.txt    |   2 +
 3 files changed, 551 insertions(+), 49 deletions(-)

-- 
2.21.0

