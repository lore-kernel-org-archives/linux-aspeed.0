From: Tom Rix <trix@redhat.com>
Date: Sun, 22 Jan 2023 07:46:11 -0800
Subject: [PATCH] crypto: change aspeed_acry_akcipher_algs storage-class-specifier to static
Message-ID: <20230122154611.504808-1-trix@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

smatch reports
drivers/crypto/aspeed/aspeed-acry.c:606:24: warning: symbol 'aspeed_acry_akcipher_algs'
  was not declared. Should it be static?

aspeed_acry_akcipher_algs is only used in aspeed-acry.c,
so it should be static.

Fixes: 2f1cf4e50c95 ("crypto: aspeed - Add ACRY RSA driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/aspeed/aspeed-acry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 6d3790583f8b..164c524015f0 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -603,7 +603,7 @@ static void aspeed_acry_rsa_exit_tfm(struct crypto_akcipher *tfm)
 	crypto_free_akcipher(ctx->fallback_tfm);
 }
 
-struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
+static struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
 	{
 		.akcipher = {
 			.encrypt = aspeed_acry_rsa_enc,
-- 
2.26.3

