From: Cédric Le Goater <clg@kaod.org>
Date: Sun, 16 Oct 2022 17:57:22 +0200
Subject: [PATCH] spi: aspeed: Fix window offset of CE1
Message-ID: <20221016155722.3520802-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The offset value of the mapping window in the kernel structure is
calculated using the value of the previous window offset. This doesn't
reflect how the HW is configured and can lead to erroneous setting of
the second flash device (CE1).

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> 
Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 33cefcf18392..b90571396a60 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -398,7 +398,7 @@ static void aspeed_spi_get_windows(struct aspeed_spi *aspi,
 		windows[cs].cs = cs;
 		windows[cs].size = data->segment_end(aspi, reg_val) -
 			data->segment_start(aspi, reg_val);
-		windows[cs].offset = cs ? windows[cs - 1].offset + windows[cs - 1].size : 0;
+		windows[cs].offset = data->segment_start(aspi, reg_val) - aspi->ahb_base_phy;
 		dev_vdbg(aspi->dev, "CE%d offset=0x%.8x size=0x%x\n", cs,
 			 windows[cs].offset, windows[cs].size);
 	}
-- 
2.37.3

