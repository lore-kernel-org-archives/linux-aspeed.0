Return-Path: <linux-aspeed+bounces-1199-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A57C3ABC3
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRl1290dz2ygm;
	Tue, 13 May 2025 16:43:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118621;
	cv=none; b=TtqJKJBQcMVKOfAK/hYuH8UTaPKxdvUSNEFLwwGNNqDpCf9kHHWte5fHNGW4fKh2XB0rCpoOVbASDLbDPRBIfknMn1IhFv2GY5Gst9EmtKpBFKG2ZyDBq7IJYopFJEeRHVP2JRHnzl8sfAA1W3jgSzxBptG4WQPxCBK4DRNBcT1bbOXivVcMHoBWz5YwKXvdJ4jkWOSqiqryUu5jcrVgRQRgJK9DIVxoS9778HvgRcbC6SZwJDPggW8JRWqhIprNr+LB3oICmJCkP3qxPjFpB8HfJEIaKkNAoQnctWnaLqf5/Yg3XRRXo+iKsa/MLPZPWK4c1unl7QPyVlggZmnrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118621; c=relaxed/relaxed;
	bh=g5TyIwjCBw1+nLoen01HIIVGROBiFVaqY1TIdUAEmyU=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=b54jU8zHh0YWclzZVNRK/qSLgFosQDgte44GxJN5NYKRSIJ/KLILQ7s2eZ6ga7HXCc9a+I/uOoNzdTLdgSx3u5Z+I1QnVvgGBE1DuHH0oDnJqGrQMe+K+I9en8tvLSuxft5+9AYBpuIkwTAoduIApGbo6fUK4+WdRXEwkIDKEQ1nd+i2dZekILsMVLMap2aVSqipUuU9bNWyd7T2IjFVv9PR75bE6rezUwcpQhF22FcILxS2cBvIpSoPyepemYL8iBs3VNG5ubKiQA/lmN34pQid2kDwFk1w9SI6+nml75Jbu/fnquZDw8HlI2SXEKgAzqKTc5ZYT8Rj1kQEK7Qi0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=OYLFLiKe; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=OYLFLiKe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRl06C4hz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g5TyIwjCBw1+nLoen01HIIVGROBiFVaqY1TIdUAEmyU=; b=OYLFLiKeUNWggRDoB/iPzRELlN
	P7Cjy+3h/SABOv8UFh9KCC+JSt8a+0ZA8PvxCI3eFAoS8xzaUfBPGUzxQTkl2cPFDcP5J9rVl24ZY
	ftYNv2Qr24c/A6YUL9I2JUuSR97n5w89aEnfg+hDRPA1RxOGnQSxOCj9GUvs6DLo2d+ur7J61s2a1
	w4y0Z+njJR7M0yHQ+njnte0v4e3yv2dBVgrqvbtwAHmnHv95Xy9LLycTBl81ZNBriZuyladmrSAYF
	rGpzHtQGDbTJKX/Q9oYgf7zpx0NlV9aJP7eHAN83ddDVA53atc0lvc9LyxKy3z/Ba3BjsD/toOPsK
	fhLy/wGA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEik4-005g4f-2F;
	Tue, 13 May 2025 14:03:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:52 +0800
Date: Tue, 13 May 2025 14:03:52 +0800
Message-Id: <03bd7038c76f33a0cdb76a13ca8b377c0b6c5a3a.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 03/11] crypto: aspeed/hash - Use init_tfm instead of cra_init
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Neal Liu <neal_liu@aspeedtech.com>, linux-aspeed@lists.ozlabs.org
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list

Use the init_tfm interface instead of cra_init.

Also get rid of the dynamic reqsize.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 0bcec2d40ed6..4a479a204331 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -660,18 +660,15 @@ static int aspeed_sham_digest(struct ahash_request *req)
 	return aspeed_sham_init(req) ? : aspeed_sham_finup(req);
 }
 
-static int aspeed_sham_cra_init(struct crypto_tfm *tfm)
+static int aspeed_sham_cra_init(struct crypto_ahash *tfm)
 {
-	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
-	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
 	struct aspeed_hace_alg *ast_alg;
 
 	ast_alg = container_of(alg, struct aspeed_hace_alg, alg.ahash.base);
 	tctx->hace_dev = ast_alg->hace_dev;
 
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct aspeed_sham_reqctx));
-
 	return 0;
 }
 
@@ -703,6 +700,7 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 			.digest	= aspeed_sham_digest,
 			.export	= aspeed_sham_export,
 			.import	= aspeed_sham_import,
+			.init_tfm = aspeed_sham_cra_init,
 			.halg = {
 				.digestsize = SHA1_DIGEST_SIZE,
 				.statesize = sizeof(struct aspeed_sham_reqctx),
@@ -715,9 +713,9 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 								  CRYPTO_ALG_KERN_DRIVER_ONLY,
 					.cra_blocksize		= SHA1_BLOCK_SIZE,
 					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_reqsize		= sizeof(struct aspeed_sham_reqctx),
 					.cra_alignmask		= 0,
 					.cra_module		= THIS_MODULE,
-					.cra_init		= aspeed_sham_cra_init,
 				}
 			}
 		},
@@ -734,6 +732,7 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 			.digest	= aspeed_sham_digest,
 			.export	= aspeed_sham_export,
 			.import	= aspeed_sham_import,
+			.init_tfm = aspeed_sham_cra_init,
 			.halg = {
 				.digestsize = SHA256_DIGEST_SIZE,
 				.statesize = sizeof(struct aspeed_sham_reqctx),
@@ -746,9 +745,9 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 								  CRYPTO_ALG_KERN_DRIVER_ONLY,
 					.cra_blocksize		= SHA256_BLOCK_SIZE,
 					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_reqsize		= sizeof(struct aspeed_sham_reqctx),
 					.cra_alignmask		= 0,
 					.cra_module		= THIS_MODULE,
-					.cra_init		= aspeed_sham_cra_init,
 				}
 			}
 		},
@@ -765,6 +764,7 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 			.digest	= aspeed_sham_digest,
 			.export	= aspeed_sham_export,
 			.import	= aspeed_sham_import,
+			.init_tfm = aspeed_sham_cra_init,
 			.halg = {
 				.digestsize = SHA224_DIGEST_SIZE,
 				.statesize = sizeof(struct aspeed_sham_reqctx),
@@ -777,9 +777,9 @@ static struct aspeed_hace_alg aspeed_ahash_algs[] = {
 								  CRYPTO_ALG_KERN_DRIVER_ONLY,
 					.cra_blocksize		= SHA224_BLOCK_SIZE,
 					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_reqsize		= sizeof(struct aspeed_sham_reqctx),
 					.cra_alignmask		= 0,
 					.cra_module		= THIS_MODULE,
-					.cra_init		= aspeed_sham_cra_init,
 				}
 			}
 		},
@@ -799,6 +799,7 @@ static struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
 			.digest	= aspeed_sham_digest,
 			.export	= aspeed_sham_export,
 			.import	= aspeed_sham_import,
+			.init_tfm = aspeed_sham_cra_init,
 			.halg = {
 				.digestsize = SHA384_DIGEST_SIZE,
 				.statesize = sizeof(struct aspeed_sham_reqctx),
@@ -811,9 +812,9 @@ static struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
 								  CRYPTO_ALG_KERN_DRIVER_ONLY,
 					.cra_blocksize		= SHA384_BLOCK_SIZE,
 					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_reqsize		= sizeof(struct aspeed_sham_reqctx),
 					.cra_alignmask		= 0,
 					.cra_module		= THIS_MODULE,
-					.cra_init		= aspeed_sham_cra_init,
 				}
 			}
 		},
@@ -830,6 +831,7 @@ static struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
 			.digest	= aspeed_sham_digest,
 			.export	= aspeed_sham_export,
 			.import	= aspeed_sham_import,
+			.init_tfm = aspeed_sham_cra_init,
 			.halg = {
 				.digestsize = SHA512_DIGEST_SIZE,
 				.statesize = sizeof(struct aspeed_sham_reqctx),
@@ -842,9 +844,9 @@ static struct aspeed_hace_alg aspeed_ahash_algs_g6[] = {
 								  CRYPTO_ALG_KERN_DRIVER_ONLY,
 					.cra_blocksize		= SHA512_BLOCK_SIZE,
 					.cra_ctxsize		= sizeof(struct aspeed_sham_ctx),
+					.cra_reqsize		= sizeof(struct aspeed_sham_reqctx),
 					.cra_alignmask		= 0,
 					.cra_module		= THIS_MODULE,
-					.cra_init		= aspeed_sham_cra_init,
 				}
 			}
 		},
-- 
2.39.5


