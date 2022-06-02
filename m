From: Klaus Jensen <its@irrelevant.dk>
Date: Thu,  2 Jun 2022 07:48:42 +0200
Subject: [PATCH] i2c: aspeed: do not mask SLAVE_MATCH
Message-ID: <20220602054842.122271-1-its@irrelevant.dk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Klaus Jensen <k.jensen@samsung.com>

When commit f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed
I2C driver") added slave mode support, the SLAVE_MATCH interrupt bit
(bit 7) was not added to INTR_ALL and so will never be set by the Aspeed
I2C controller.

Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
I am working on slave mode in QEMU and noticed that the device would not
generate the SLAVE_ADDR_RX_MATCH interrupt. This patch fixes it, but I
do not have a spec sheet on the Aspeed, so I am not sure if this is the
intended behavior?

 drivers/i2c/busses/i2c-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 771e53d3d197..7f432babcd72 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -86,6 +86,7 @@
 #define ASPEED_I2CD_INTR_ALL						       \
 		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
 		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
+		 ASPEED_I2CD_INTR_SLAVE_MATCH |				       \
 		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
 		 ASPEED_I2CD_INTR_ABNORMAL |				       \
 		 ASPEED_I2CD_INTR_NORMAL_STOP |				       \
-- 
2.36.1

