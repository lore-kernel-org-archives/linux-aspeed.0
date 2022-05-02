From: Cédric Le Goater <clg@kaod.org>
Date: Mon,  2 May 2022 10:13:41 +0200
Subject: [PATCH v5 11/11] mtd: spi-nor: aspeed: set the decoding size to at
 least 2MB for AST2600
In-Reply-To: <20220502081341.203369-1-clg@kaod.org>
References: <20220502081341.203369-1-clg@kaod.org>
Message-ID: <20220502081341.203369-12-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Potin Lai <potin.lai@quantatw.com>

In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
address offset is set to the acctual offset - 1MB. If the flash only has
1MB, the end address will has same value as start address, which will
causing unexpected errors.

This patch set the decoding size to at least 2MB to avoid decoding errors.

Tested:
root at bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"
[   59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
[   59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
root at bletchley:~# devmem 0x1e631030
0x00100000

Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Potin Lai <potin.lai@quantatw.com>
[ clg : Ported on new spi-mem driver ]
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 35f6934847b7..496f3e1e9079 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -474,6 +474,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
  *   is correct.
  */
 static const struct aspeed_spi_data ast2500_spi_data;
+static const struct aspeed_spi_data ast2600_spi_data;
+static const struct aspeed_spi_data ast2600_fmc_data;
 
 static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 					 u32 local_offset, u32 size)
@@ -497,6 +499,17 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 			 chip->cs, size >> 20);
 	}
 
+	/*
+	 * The decoding size of AST2600 SPI controller should set at
+	 * least 2MB.
+	 */
+	if ((aspi->data == &ast2600_spi_data || aspi->data == &ast2600_fmc_data) &&
+	    size < SZ_2M) {
+		size = SZ_2M;
+		dev_info(aspi->dev, "CE%d window resized to %dMB (AST2600 Decoding)",
+			 chip->cs, size >> 20);
+	}
+
 	aspeed_spi_get_windows(aspi, windows);
 
 	/* Adjust this chip window */
-- 
2.35.1

