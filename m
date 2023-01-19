From: Yang Yingliang <yangyingliang@huawei.com>
Date: Thu, 19 Jan 2023 09:48:59 +0800
Subject: [PATCH -next] crypto: aspeed: change aspeed_acry_akcipher_algs to static
Message-ID: <20230119014859.1900136-1-yangyingliang@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

aspeed_acry_akcipher_algs is only used in aspeed-acry.c now,
change it to static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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
2.25.1

