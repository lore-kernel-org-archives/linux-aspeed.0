From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:55:51 +0000
Subject: [PATCH 22/23] mtd: spi-nor: Add Global Block Unlock support
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Message-ID: <20190917155426.7432-23-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Add Global Block Unlock support as an optimization for unlocking the
entire memory array. A Global Block-Protection Unlock command offers
a single command cycle that unlocks the entire memory array.

Status Register Block Protection support does not imply the support for
the Global Block Unlock Command. Microchip's SST26VF064B does support
the 98h command, but use dedicated registers for the individual block
protection, and not the Status Register, as in the stm_lock/unlock case.
Call spi_nor_unlock_global_block_protection() in spi_nor_unlock() as an
optimization for unlocking the entire memory array.

Note that the Global Block Unlock command has different names depending
on the manufacturer, but always the same command value: 98h. Macronix's
MX25U12835F names it Gang Block Unlock, Winbound's W25Q128FV names it
Global Block Unlock and Microchip's SST26VF064B names it Global Block
Protection Unlock.

We can't determine this support purely by manufacturer type and it's
not autodetectable by anything like SFDP, so make a new flag for it:
UNLOCK_GLOBAL_BLOCK. This flag can be set just at per-chip level, we
don't need a SNOR_F_ correspondent.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 47 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 700b1700a7a1..19556a9dd3fa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -196,7 +196,7 @@ struct flash_info {
 	u16		page_size;
 	u16		addr_width;
 
-	u16		flags;
+	u32		flags;
 #define SECT_4K			BIT(0)	/* SPINOR_OP_BE_4K works uniformly */
 #define SPI_NOR_NO_ERASE	BIT(1)	/* No erase command needed */
 #define SST_WRITE		BIT(2)	/* use SST byte programming */
@@ -233,6 +233,7 @@ struct flash_info {
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
 #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
+#define UNLOCK_GLOBAL_BLOCK	BIT(16)	/* Unlock global block protection */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -837,6 +838,44 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 }
 
 /**
+ * spi_nor_unlock_global_block_protection() - Unlock the Global Block Protection
+ * @nor:        pointer to a 'struct spi_nor'
+ *
+ * The Global Block-Protection Unlock command offers a single command cycle
+ * that unlocks the entire memory array.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ULBPR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_ULBPR,
+						     NULL, 0);
+	}
+
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d on ULBPR\n", ret);
+		return ret;
+	}
+
+	return spi_nor_wait_till_ready(nor);
+}
+
+/**
  * spi_nor_write_sr1_and_check() - Write one byte to the Status Register and
  * ensure the bits in the mask match the written value.
  * @nor:	pointer to a 'struct spi_nor'.
@@ -1916,7 +1955,11 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
 
-	ret = nor->flash.locking_ops->unlock(nor, ofs, len);
+	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK &&
+	    !ofs && len == nor->flash.size)
+		ret = spi_nor_unlock_global_block_protection(nor);
+	else
+		ret = nor->flash.locking_ops->unlock(nor, ofs, len);
 
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ca650f895903..6812416ab013 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -66,6 +66,7 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_ULBPR		0x98	/* Global Block Unlock Protection */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
-- 
2.9.5

