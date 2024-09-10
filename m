From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 10 Sep 2024 16:30:20 +0200
Subject: [PATCH v2 10/19] crypto: drivers - Drop sign/verify operations
In-Reply-To: <cover.1725972333.git.lukas@wunner.de>
References: <cover.1725972333.git.lukas@wunner.de>
Message-ID: <65b1bb40a042cc73ba486e0ed41d3f6bfd083929.1725972335.git.lukas@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The drivers aspeed-acry.c, hpre_crypto.c and jh7110-rsa.c purport to
implement sign/verify operations for raw (unpadded) "rsa".

But there is no such thing as message digests generally need to be
padded according to a predefined scheme (such as PSS or PKCS#1) to
match the size of the usually much larger RSA keys.

The bogus sign/verify operations defined by these drivers are never
called but block removal of sign/verify from akcipher_alg.  Drop them.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/crypto/aspeed/aspeed-acry.c         | 2 --
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 2 --
 drivers/crypto/starfive/jh7110-rsa.c        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index b4613bd4ad96..7a1e153733e1 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -601,8 +601,6 @@ static struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
 		.akcipher.base = {
 			.encrypt = aspeed_acry_rsa_enc,
 			.decrypt = aspeed_acry_rsa_dec,
-			.sign = aspeed_acry_rsa_dec,
-			.verify = aspeed_acry_rsa_enc,
 			.set_pub_key = aspeed_acry_rsa_set_pub_key,
 			.set_priv_key = aspeed_acry_rsa_set_priv_key,
 			.max_size = aspeed_acry_rsa_max_size,
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 764532a6ca82..bdd7e1df8a06 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -2004,8 +2004,6 @@ static void hpre_curve25519_exit_tfm(struct crypto_kpp *tfm)
 }
 
 static struct akcipher_alg rsa = {
-	.sign = hpre_rsa_dec,
-	.verify = hpre_rsa_enc,
 	.encrypt = hpre_rsa_enc,
 	.decrypt = hpre_rsa_dec,
 	.set_pub_key = hpre_rsa_setpubkey,
diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index a778c4846025..d109c743f076 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -565,8 +565,6 @@ static void starfive_rsa_exit_tfm(struct crypto_akcipher *tfm)
 static struct akcipher_alg starfive_rsa = {
 	.encrypt = starfive_rsa_enc,
 	.decrypt = starfive_rsa_dec,
-	.sign = starfive_rsa_dec,
-	.verify = starfive_rsa_enc,
 	.set_pub_key = starfive_rsa_set_pub_key,
 	.set_priv_key = starfive_rsa_set_priv_key,
 	.max_size = starfive_rsa_max_size,
-- 
2.43.0

