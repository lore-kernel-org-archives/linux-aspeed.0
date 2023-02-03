From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 3 Feb 2023 11:29:32 +0800
Subject: [PATCH v3] crypto: aspeed: fix type warnings
Message-ID: <20230203032932.971586-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes following warnings:

1. sparse: incorrect type in assignment (different base types)
Fix: change to __le32 type.
2. sparse: cast removes address space '__iomem' of expression
Fix: use readb to avoid dereferencing the memory.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
Change since v2: remove unnecessary cast.
Change since v1: keep iomem marker to remain its purpose.

 drivers/crypto/aspeed/aspeed-acry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 164c524015f0..f2429e699d14 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -252,7 +252,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
 				    enum aspeed_rsa_key_mode mode)
 {
 	const u8 *src = xbuf;
-	u32 *dw_buf = (u32 *)buf;
+	__le32 *dw_buf = (__le32 *)buf;
 	int nbits, ndw;
 	int i, j, idx;
 	u32 data = 0;
@@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
 static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
 {
 	struct akcipher_request *req = acry_dev->req;
-	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
+	u8 __iomem *sram_buffer = (u8 __iomem *)acry_dev->acry_sram;
 	struct scatterlist *out_sg = req->dst;
 	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
 	int leading_zero = 1;
@@ -321,11 +321,11 @@ static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
 
 	for (j = ASPEED_ACRY_SRAM_MAX_LEN - 1; j >= 0; j--) {
 		data_idx = acry_dev->data_byte_mapping[j];
-		if (sram_buffer[data_idx] == 0 && leading_zero) {
+		if (readb(sram_buffer + data_idx) == 0 && leading_zero) {
 			result_nbytes--;
 		} else {
 			leading_zero = 0;
-			dram_buffer[i] = sram_buffer[data_idx];
+			dram_buffer[i] = readb(sram_buffer + data_idx);
 			i++;
 		}
 	}
-- 
2.25.1

