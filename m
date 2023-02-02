From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 2 Feb 2023 10:56:00 +0800
Subject: [PATCH-next] crypto: aspeed: fix type warnings
Message-ID: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes following warnings:

1. sparse: incorrect type in assignment (different base types)
Fix: change to __le32 type.
2. sparse: cast removes address space '__iomem' of expression
Fix: change to force cast.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/crypto/aspeed/aspeed-acry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 164c524015f0..f8c733376469 100644
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
+	u8 *sram_buffer = (u8 __force *)acry_dev->acry_sram;
 	struct scatterlist *out_sg = req->dst;
 	static u8 dram_buffer[ASPEED_ACRY_SRAM_MAX_LEN];
 	int leading_zero = 1;
-- 
2.25.1

