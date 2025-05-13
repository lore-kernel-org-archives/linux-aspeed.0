Return-Path: <linux-aspeed+bounces-1198-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE7DC3ABD8
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRkz335Vz2yf1;
	Tue, 13 May 2025 16:43:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118619;
	cv=none; b=RUP8VNUvNbm3/dhnTfO3Fua376Qz+QnV4+6nCgxtiJys0HEQBU2HCXImdNjC5kFdzk/MN0ZTN0mOp3vITvtMgFGIZ588EZ3R3j/vEXqvYSRl3o1yb+YvziyoDpYzrWnS3JEA6X51FEsJK5I5OJAoiWz4yTxURGqEb6huBhgFQBx9fejODBRG3lMyFHBww/faN7jS8nxSDYwcBTsBMhRVTyc9hWz2BHlza0oL1h0GpDKyS0xFHCpuTLGs/C07tP95PI6P6iTBxvKDHV/Bpmok71iLzfcZwgbsHVwnFvbr3WdcDt8swJGSIVmUuPwvFAJDtUFW8hDDGWdLDPExj6v5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118619; c=relaxed/relaxed;
	bh=HMpZOccRKLHOxt1j9Wb25Ygiudgle05mCvS8XV7VkL4=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=nyiPq6XdT6HnB07Dfqd6vxPjRVyUiCklptDWLLNHMhP9H3KNFUlOSVn51+xUwUiobdbLVVyYJEVpVxHrhhs3P6JSiiZvhjt8j/9kNNOvok7+RmCPnSi5MjEbE+OXFMC36ChT3YsD2YbagAWWHy2v/qgrp7f7J9TLbT3bn2CkrF8dJkkzIvIebO5/K99HujnG8s/RKvtCDfuaNTOQ+2S/IXiVVMDSs72sEkObz3jIhyFV8AxiKEuWxajwrKYMPV8ftm3KV5s6ZtdmzJp+P0LeUjtCS5Qsuk26NWQVzYlrBu9mnlPGZZ/gTwRHwZhuGqMJR24rOtmz5gI3fkhyFAM1pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=O7iVStjT; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=O7iVStjT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRky6Vfdz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HMpZOccRKLHOxt1j9Wb25Ygiudgle05mCvS8XV7VkL4=; b=O7iVStjTolbqkytUZCqVPNDQ57
	hEds29Vg+JmHYMqpgENVxgbOZsjwvJNlO7RcnKPd9jDsdgLEE3ub0BhkPwG13DAKNcox3c0gIMtSu
	Zi6/0R5efmvXloB26C5QxGMw/BPk/EYlpSJWikTk7rEC6Sjf2j3fu3kl25j2KF9Cd46JN4v9wibnS
	tGsKaYoQ9imitw74a3l1GvlO2YHc2nzPfer8y4zl0Gr+64AuoZiWHR6ugQf6/4fEplGTGBKA0okw/
	6NLQt6hr6cYhDJ0W+oue5hakZ3jnYgzxdwz9Vfloj6+0Rg3t8H8XgEUwxto+kc6ICk8sL752Yvd3b
	IFLPmF8Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEik9-005g55-0s;
	Tue, 13 May 2025 14:03:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:57 +0800
Date: Tue, 13 May 2025 14:03:57 +0800
Message-Id: <889c7e7d5a3e16da52ac39ecafaab2a4a2cf22dc.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 05/11] crypto: aspeed/hash - Move sham_final call into
 sham_update
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

The only time when sham_final needs to be called in sham_finup
is when the finup request fits into the partial block.  Move this
special handling into sham_update.

The comment about releaseing resources is non-sense.  The Crypto
API does not mandate the use of final so the user could always go
away after an update and never come back.  Therefore the driver
must not hold any resources after an update call.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 44 +++++++++---------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 9f776ec8f5ec..40363159489e 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -508,6 +508,20 @@ static int aspeed_ahash_do_one(struct crypto_engine *engine, void *areq)
 	return aspeed_ahash_do_request(engine, areq);
 }
 
+static int aspeed_sham_final(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
+
+	AHASH_DBG(hace_dev, "req->nbytes:%d, rctx->total:%d\n",
+		  req->nbytes, rctx->total);
+	rctx->op = SHA_OP_FINAL;
+
+	return aspeed_hace_hash_handle_queue(hace_dev, req);
+}
+
 static int aspeed_sham_update(struct ahash_request *req)
 {
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
@@ -533,49 +547,25 @@ static int aspeed_sham_update(struct ahash_request *req)
 					 rctx->total, 0);
 		rctx->bufcnt += rctx->total;
 
-		return 0;
+		return rctx->flags & SHA_FLAGS_FINUP ?
+		       aspeed_sham_final(req) : 0;
 	}
 
 	return aspeed_hace_hash_handle_queue(hace_dev, req);
 }
 
-static int aspeed_sham_final(struct ahash_request *req)
-{
-	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
-
-	AHASH_DBG(hace_dev, "req->nbytes:%d, rctx->total:%d\n",
-		  req->nbytes, rctx->total);
-	rctx->op = SHA_OP_FINAL;
-
-	return aspeed_hace_hash_handle_queue(hace_dev, req);
-}
-
 static int aspeed_sham_finup(struct ahash_request *req)
 {
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct aspeed_sham_ctx *tctx = crypto_ahash_ctx(tfm);
 	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
-	int rc1, rc2;
 
 	AHASH_DBG(hace_dev, "req->nbytes: %d\n", req->nbytes);
 
 	rctx->flags |= SHA_FLAGS_FINUP;
 
-	rc1 = aspeed_sham_update(req);
-	if (rc1 == -EINPROGRESS || rc1 == -EBUSY)
-		return rc1;
-
-	/*
-	 * final() has to be always called to cleanup resources
-	 * even if update() failed, except EINPROGRESS
-	 */
-	rc2 = aspeed_sham_final(req);
-
-	return rc1 ? : rc2;
+	return aspeed_sham_update(req);
 }
 
 static int aspeed_sham_init(struct ahash_request *req)
-- 
2.39.5


