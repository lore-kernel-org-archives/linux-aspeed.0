Return-Path: <linux-aspeed+bounces-1205-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D1C3ABD8
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRlF0JCQz2yb9;
	Tue, 13 May 2025 16:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118633;
	cv=none; b=kL/peiXySMGdqMt94W7raovyjG8UjIQPHLSduW2tQxqqG9PsfPsxPmqQFTVdd8Ns+ecNT/OzmXzqh0adcmaxBiuZ6IxRj4N1nuhk5ZZWdBEqXbpMPZti22S+EMegCl/vW0zAilDhyDNbh7VuI83C+1rqUTUHBqj7QO/jB4kH8aWLTKgOaQPsVjuQ76Ejax9MFoLTCnMwtxu7ssrMXiZ+lg1Ncx1b2j4SbDHe8QI1tCxd4uexak7wp40mfKX6fkMzrk8ZULHo8WucCrkdvw+Wja7gagm8PibTVxeT2Lwkv+FpL0my45fuDHbh3sladxKD8Yr0SXgXy0FgnzPGHEgi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118633; c=relaxed/relaxed;
	bh=4Wtwzookz1HcELV23w9yfUZZzRBWFBxswmKn3PTe1iA=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=g9pDeh+F1uf2zL5o2f95Sf56tdV0ubEh9qmqLiLkhUuAeceZAF7kseffOgRvX17/aE+cUJExSbfNhPGWaa1Y7WiQ45I6Z3lLOOWN3/dszXm86fQE27v1NDY2kFbEL3PTC9PIptQeZaI1VG7B0FRSYFTECi2h9V60QEbkaQ8ANhk5j/ngg15YzVsO9huMggH/gSmWgWgDYzBuwa+j0FRx2lHDeJh91bZoWHONNSYSLqJ+4i1SEaKxdpCh8nEGQUkcGl3EArIt1vAEfZMZwkAAUCBVcxgy/StyN6pWvd2Wsz8T9N1O9+2W4cvVw4JWAhRKatKquF23Sp9uoYKAyUhRbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=BUhd5ZUM; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=BUhd5ZUM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRlD4ZYqz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Wtwzookz1HcELV23w9yfUZZzRBWFBxswmKn3PTe1iA=; b=BUhd5ZUMed8sFBr3W4Xv6t4PIh
	+DJAGKLIhpIoq0XDh7/JKKKY25q8NdVLJZAHyeDJoUM9NcsJnZyoqtExv+MiWrbsTFn43JzDMFL+l
	myY4YIE6cvCo/K7Ssqpbrp/vEhjfoFJIDiJXZwMa5zl7U2AorNXDOp/EknLaKTXTz06P+qi1PJMgm
	5AmhHk3FTGTRQ47SsC93JcVAV5fvE/gKJf7tqXXSyauZBtxX5v9EiuMPkoKLd/+vQ2lchdr3Fbl5V
	MX9ujeXy/xRLm/qNSAGTi82saqCFDEWEZ4ghvTx/UA5HWthDUk8cprJQxKoV9fxxs9C1hjIwBe/St
	D0iogDtg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEikI-005g6J-1e;
	Tue, 13 May 2025 14:04:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:04:06 +0800
Date: Tue, 13 May 2025 14:04:06 +0800
Message-Id: <67a2783ef1a4a5c37ba868af511fe0f0c6ef8476.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 09/11] crypto: aspeed/hash - Add fallback
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

If a hash request fails due to a DMA mapping error, or if it is too
large to fit in the the driver buffer, use a fallback to do the hash
rather than failing.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 28 +++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index d7c7f867d6e1..3bfb7db96c40 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -420,6 +420,32 @@ static int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
 			hace_dev->crypt_engine_hash, req);
 }
 
+static noinline int aspeed_ahash_fallback(struct ahash_request *req)
+{
+	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
+	HASH_FBREQ_ON_STACK(fbreq, req);
+	u8 *state = rctx->buffer;
+	struct scatterlist sg[2];
+	struct scatterlist *ssg;
+	int ret;
+
+	ssg = scatterwalk_ffwd(sg, req->src, rctx->offset);
+	ahash_request_set_crypt(fbreq, ssg, req->result,
+				rctx->total - rctx->offset);
+
+	ret = aspeed_sham_export(req, state) ?:
+	      crypto_ahash_import_core(fbreq, state);
+
+	if (rctx->flags & SHA_FLAGS_FINUP)
+		ret = ret ?: crypto_ahash_finup(fbreq);
+	else
+		ret = ret ?: crypto_ahash_update(fbreq);
+			     crypto_ahash_export_core(fbreq, state) ?:
+			     aspeed_sham_import(req, state);
+	HASH_REQUEST_ZERO(fbreq);
+	return ret;
+}
+
 static int aspeed_ahash_do_request(struct crypto_engine *engine, void *areq)
 {
 	struct ahash_request *req = ahash_request_cast(areq);
@@ -434,7 +460,7 @@ static int aspeed_ahash_do_request(struct crypto_engine *engine, void *areq)
 
 	ret = aspeed_ahash_req_update(hace_dev);
 	if (ret != -EINPROGRESS)
-		return ret;
+		return aspeed_ahash_fallback(req);
 
 	return 0;
 }
-- 
2.39.5


