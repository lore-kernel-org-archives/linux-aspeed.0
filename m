From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 5 Sep 2022 13:24:49 +0800
Subject: [PATCH v2] crypto: aspeed: fix format unexpected build warning
Message-ID: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This fixes the following similar build warning when
enabling compile test:

aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
[-Wformat=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
v2: Use "%zu" format to print size_t.

 drivers/crypto/aspeed/aspeed-hace-hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 0a44ffc0e13b..6e833d238253 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -185,7 +185,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
 	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
 	length = rctx->total + rctx->bufcnt - remain;
 
-	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
+	AHASH_DBG(hace_dev, "%s:0x%x, %s:%zu, %s:0x%x, %s:0x%x\n",
 		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
 		  "length", length, "remain", remain);
 
@@ -324,7 +324,7 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
 	struct ahash_request *req = hash_engine->req;
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
 
-	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
+	AHASH_DBG(hace_dev, "src_dma:%zu, digest_dma:%zu, length:%zu\n",
 		  hash_engine->src_dma, hash_engine->digest_dma,
 		  hash_engine->src_length);
 
-- 
2.25.1

