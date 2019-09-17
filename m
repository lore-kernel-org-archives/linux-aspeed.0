From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:54:40 +0000
Subject: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
Message-ID: <20190917155426.7432-1-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches 1 - 14 are just clean up patches for the Flash Register
Operations.

Patches 15 - 21 deal with the Quad Enable and the (un)lock methods.
Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

Patch 22 adds Global Block Unlock support as an optimization for
unlocking the entire memory array. Patch 23 uses it in sst26vf064b.

This is just compile tested, I don't have a relevant spansion-like
flash memory to test the (un)lock() methods.

The patch set can be tested using mtd-utils:
1/ do a read-erase-write-read-back test immediately after boot, to check
the spi_nor_unlock_all() method
	mtd_debug read /dev/mtd-yours offset size read-file
	hexdump read-file
	mtd_debug erase /dev/mtd-yours offset size
	dd if=/dev/urandom of=write-file bs=please-choose count=please-choose
	mtd_debug write /dev/mtd-yours offset write-file-size write-file
	mtd_debug read /dev/mtd-yours offset write-file-size read-file
	sha1sum read-file write-file
2/ lock flash then try to erase/write it, to see if the lock works
	flash_lock /dev/mtd-yours offset block-count
	read-erase/write-read-back test
3/ unlock flash and do a read-erase-write-read-back to check if the QE
bit was not cleared.

Thanks,
ta

Tudor Ambarus (23):
  mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
  mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
  mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read() definition
  mtd: spi-nor: Rename nor->params to nor->flash
  mtd: spi-nor: Rework read_sr()
  mtd: spi-nor: Rework read_fsr()
  mtd: spi-nor: Rework read_cr()
  mtd: spi-nor: Rework write_enable/disable()
  mtd: spi-nor: Fix retlen handling in sst_write()
  mtd: spi-nor: Rework write_sr()
  mtd: spi-nor: Rework spi_nor_read/write_sr2()
  mtd: spi-nor: Report error in spi_nor_xread_sr()
  mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
  mtd: spi-nor: Drop duplicated new line
  mtd: spi-nor: Drop spansion_quad_enable()
  mtd: spi-nor: Fix errno on quad_enable methods
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Rework macronix_quad_enable()
  mtd: spi-nor: Rework spansion(_no)_read_cr_quad_enable()
  mtd: spi-nor: Update sr2_bit7_quad_enable()
  mtd: spi-nor: Rework the disabling of block write protection
  mtd: spi-nor: Add Global Block Unlock support
  mtd: spi-nor: Unlock global block protection on sst26vf064b

 drivers/mtd/spi-nor/aspeed-smc.c      |   23 +-
 drivers/mtd/spi-nor/cadence-quadspi.c |   54 +-
 drivers/mtd/spi-nor/hisi-sfc.c        |   23 +-
 drivers/mtd/spi-nor/intel-spi.c       |   24 +-
 drivers/mtd/spi-nor/mtk-quadspi.c     |   25 +-
 drivers/mtd/spi-nor/nxp-spifi.c       |   23 +-
 drivers/mtd/spi-nor/spi-nor.c         | 1697 ++++++++++++++++++---------------
 include/linux/mtd/spi-nor.h           |   75 +-
 8 files changed, 1050 insertions(+), 894 deletions(-)

-- 
2.9.5

