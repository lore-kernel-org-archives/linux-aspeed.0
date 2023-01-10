From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Mon, 9 Jan 2023 19:39:17 -0600
Subject: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
Message-ID: <Y7zBxbEAvcEEJRie@work>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
array declaration in struct aspeed_sham_ctx with flex-array
member.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/aspeed/aspeed-hace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
index f2cde23b56ae..05d0a15d546d 100644
--- a/drivers/crypto/aspeed/aspeed-hace.h
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -183,7 +183,7 @@ struct aspeed_sham_ctx {
 	struct aspeed_hace_dev		*hace_dev;
 	unsigned long			flags;	/* hmac flag */
 
-	struct aspeed_sha_hmac_ctx	base[0];
+	struct aspeed_sha_hmac_ctx	base[];
 };
 
 struct aspeed_sham_reqctx {
-- 
2.34.1

