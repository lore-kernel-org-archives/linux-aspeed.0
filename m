From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 10 Feb 2023 17:40:57 +0800
Subject: [PATCH] crypto: aspeed - Fix modular aspeed-acry
Message-ID: <Y+YRKdWUA4jjoUZ2@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When aspeed-acry is enabled as a module it doesn't get built at
all.  Fix this by adding it to obj-m.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 24284d812b79..15862752c053 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -6,4 +6,6 @@ aspeed_crypto-objs := aspeed-hace.o	\
 		      $(hace-hash-y)	\
 		      $(hace-crypto-y)
 
-obj-$(CONFIG_CRYPTO_DEV_ASPEED_ACRY) += aspeed-acry.o
+aspeed_acry-$(CONFIG_CRYPTO_DEV_ASPEED_ACRY) += aspeed-acry.o
+
+obj-$(CONFIG_CRYPTO_DEV_ASPEED) += $(aspeed_acry-y)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
