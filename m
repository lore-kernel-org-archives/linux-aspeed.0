From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:46:47 +0000
Subject: [PATCH v2 17/22] mtd: spi-nor: Check all the bits written, not just
 the BP ones
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-18-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Check that all the bits written in the write_sr_and_check() method
match the status_new received value. Failing to write the other bits
is dangerous too, extend the check.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6429c855547e..48bcb2ee1be5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1493,7 +1493,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 }
 
 /* Write status register and ensure bits in mask match written values */
-static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
+static int write_sr_and_check(struct spi_nor *nor, u8 status_new)
 {
 	int ret;
 
@@ -1507,7 +1507,7 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
 	if (ret)
 		return ret;
 
-	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
+	return (nor->bouncebuf[0] != status_new) ? -EIO : 0;
 }
 
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
@@ -1673,7 +1673,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
 
-	return write_sr_and_check(nor, status_new, mask);
+	return write_sr_and_check(nor, status_new);
 }
 
 /*
@@ -1758,7 +1758,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
 
-	return write_sr_and_check(nor, status_new, mask);
+	return write_sr_and_check(nor, status_new);
 }
 
 /*
-- 
2.9.5

