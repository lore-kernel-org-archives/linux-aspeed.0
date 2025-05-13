Return-Path: <linux-aspeed+bounces-1206-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80283C3ABC3
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRlG73HFz2ygm;
	Tue, 13 May 2025 16:43:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118634;
	cv=none; b=WCO8Oz5/IFY9/jDMGdUz6W0IZFkmctf3E7ibUuMhW26gWiUYIW7DPli0i4H/rcJ4l3PD2/GYhdf+2s08qd6Ah50ETjooABmVLtbJmaLK7EvkcVoxSOPyMMEqwYP3c8+Z/3XYMVwSiKhOUm405kBuCoSxQxJUb22hf0dw7TZHNolBXeHok9hSt0UZC3ZNWqRYbzs0IEDq9RhYrR1IDu4Oul585ZD20NQ17xG/WEthlH5qK4ExidEwUvCEJLKKqOwLPFriFwLNYt4DGlkxhN5h/T6H9qQTLuTLqz7ZEl7tvplJYhaehCWPFTA5TiLbXFAi7FYBrofO3jF3X38Rwoa1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118634; c=relaxed/relaxed;
	bh=CD9BMpmVjGPJ6XdNaixWC02LuRV2gzAIiirjItpgEnU=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=LwaJvx0wiotRpB3a9JmvEHCClxM4anRKJob4PW4nBc37yA1jpYd1gpdKqu4raVMI+iqgkB2KBUHm9Zn3zC/V0WOx8HSAlWWlUoFQfQMvEzm32XONUIH5gC3v0VdIY5mcVPxt/sf7CPdy+StZRnflmAG6Lbzm0ZlUkzYr5bWPN2WiSmO40NUj4UQRV/Ut86KAbqCc57GClSzKdcG+HeMMe40+lNX/ae6bwV26P4kF3fqMpQWVV76Tp8iY2UN5kLU7OtmeVKcBude1gT2wlfrvWflk95+RGkQS4SqIhnCKC1QK0ax1ikhrv5kErDmLWNYiR4uZgVEO7AgtaE0BuRBAcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=CJjtnEHD; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=CJjtnEHD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRlG3PMlz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CD9BMpmVjGPJ6XdNaixWC02LuRV2gzAIiirjItpgEnU=; b=CJjtnEHD8etfMeS4pTaJXvRevV
	Ml9CemH3NE8Fbdt6XOlj4Q8gCFgT83qx6br72UAfaLyIpPCcO9rq6u1uKVJccNmDQVjB9DaGO9ASs
	zAss1yO4g3vCyo/H2f24ReZ5Dye5gu4hnKWSc01mZSAN8ouuxhEpJItIkVNUY0pomPPj61WdgtIcs
	m2U0/rlkMYrnZ7JRw25XaV1yWpN4ZW0pJIOptPoEQnOrihgUc35Ox78wBZHsgfRX4PPgHQns9B9wt
	QJ+jGWTrBO9udv5Ekp6iUbnRJrO1E29MWiRPXPq1kEfa8A1n+5NvknOXAsPN9zmkwjXL2ISSqC/py
	FgjptRfw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEikB-005g5I-1s;
	Tue, 13 May 2025 14:04:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:59 +0800
Date: Tue, 13 May 2025 14:03:59 +0800
Message-Id: <e5f9015032207aea18724b3be618118ed6bceb95.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 06/11] crypto: aspeed/hash - Move final padding into
 dma_prepare
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

Rather than processing a final as two separate updates, combine
them into one for the linear dma_prepare case.

This means that the total hash size is slightly reduced, but that
will be fixed up later by repeating the hash if necessary.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 29 ++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 40363159489e..ceea2e2f5658 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -114,29 +114,34 @@ static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
 	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
 	struct ahash_request *req = hash_engine->req;
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
-	int length, remain;
+	bool final = rctx->flags & SHA_FLAGS_FINUP;
+	unsigned int length, remain;
 
 	length = rctx->total + rctx->bufcnt;
-	remain = length % rctx->block_size;
+	remain = final ? 0 : length % rctx->block_size;
 
 	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
 
 	if (rctx->bufcnt)
 		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
 
-	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
-		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
-					 rctx->bufcnt, rctx->src_sg,
-					 rctx->offset, rctx->total - remain, 0);
-		rctx->offset += rctx->total - remain;
-
-	} else {
+	if ((final ? round_up(length, rctx->block_size) + rctx->block_size :
+		     length) > ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
 		dev_warn(hace_dev->dev, "Hash data length is too large\n");
 		return -EINVAL;
 	}
 
-	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
-				 rctx->offset, remain, 0);
+	scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
+				 rctx->bufcnt, rctx->src_sg,
+				 rctx->offset, rctx->total - remain, 0);
+	rctx->offset += rctx->total - remain;
+
+	if (final)
+		length += aspeed_ahash_fill_padding(
+			hace_dev, rctx, hash_engine->ahash_src_addr + length);
+	else
+		scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
+					 rctx->offset, remain, 0);
 
 	rctx->bufcnt = remain;
 	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
@@ -423,7 +428,7 @@ static int aspeed_ahash_update_resume(struct aspeed_hace_dev *hace_dev)
 			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
 
 	if (rctx->flags & SHA_FLAGS_FINUP)
-		return aspeed_ahash_req_final(hace_dev);
+		memcpy(req->result, rctx->digest, rctx->digsize);
 
 	return aspeed_ahash_complete(hace_dev);
 }
-- 
2.39.5


