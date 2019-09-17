From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:55:09 +0000
Subject: [PATCH 09/23] mtd: spi-nor: Fix retlen handling in sst_write()
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Message-ID: <20190917155426.7432-10-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

In case the write of the first byte failed, retlen was incorrectly
incremented to *retlen += actual; on the exit path. retlen should be
incremented when actual data was written to the flash.

Rename 'sst_write_err' label to 'out' as it is no longer generic for
all the write errors in the sst_write() method, and may introduce
confusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 271c2b465038..151db98f7d49 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2665,12 +2665,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* write one byte. */
 		ret = spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 	}
 	to += actual;
 
@@ -2681,12 +2681,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* write two bytes. */
 		ret = spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
 		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 		to += 2;
 		nor->sst_write_second = true;
 	}
@@ -2694,35 +2694,35 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	ret = spi_nor_write_disable(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
 
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
 
 	/* Write out trailing byte if it exists. */
 	if (actual != len) {
 		ret = spi_nor_write_enable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 
 		nor->program_opcode = SPINOR_OP_BP;
 		ret = spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 
 		ret = spi_nor_write_disable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 
 		actual += 1;
 	}
-sst_write_err:
+out:
 	*retlen += actual;
 unlock_and_unprep:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
-- 
2.9.5

