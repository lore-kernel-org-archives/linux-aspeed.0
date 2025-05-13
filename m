Return-Path: <linux-aspeed+bounces-1196-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDF5C3ABC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRkv4X12z2ySl;
	Tue, 13 May 2025 16:43:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118615;
	cv=none; b=oPdDhib5lEZdPnsz7LFrMREhy195Sj8xhQZXrKHvaA1icn46VVBxe1KuztbC72LDBsZ8eOu50MUEi1xY3Q2FXI87YwXN7D+l+FoI9bM2KdKGrkjKpgF0Th4UPm2X0UAScWvevVfJAfXrRdr1RU7dZKuyxRC+CFDkp5817eUpDEuZxA0229/4PHhYXPmuKr2ZOHviuxIAJmpl1XWsVNiV4Y+Fj/rp8m2gkDHYokwsMBJxffB6LkhlRH36s46wOJhBOjNkQXF7NWZ59/n/uTJkIX95XHdn1dfMiTLLfYjIu/75nzmCyUNDq0Xqk4lJGtTW1mPjiLVOABa1llYXsaLsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118615; c=relaxed/relaxed;
	bh=+ru/O8aStcq/NQmOby3M3IUJaHQQYoWzI78Ee/BXevc=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=cd89Hpe8u8/dDD2F1sj1Hd7zxgaeEydUYCHkaaX+jpChXTJkaDXK5js0tbrMZzq3O6UnPVbtD4iS79PUw0K/QaMqYrJ4PkyJ2mJgbiOSjfWsZh/yNuR4WXJhR99l7sI3S7J2Eec9jACnIDLIlPHOR2YXMfdzIVJd1vjRiZgzT45dBZ4oEpkJ5TsK2SH9JqLb89Yy8mMjmWhYSwk2uwVh5rBp/ssinZrklLkwc2Y9AK0YDr2XGXBtvd8F0K0QqG/SFXkhjUnqjk0HoUw1F5FMwP6UtquEglsAcmxTZISR5dGOZeaQlzCkD/P9K8YUU877dPItfqQhZG2swNegKuNJgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=l6BB8w0S; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=l6BB8w0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRkv1bbDz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+ru/O8aStcq/NQmOby3M3IUJaHQQYoWzI78Ee/BXevc=; b=l6BB8w0SXIScJvvtBJDupeualf
	y15f5EAYbX/YzEwXXeP5ZT1eqOrfyzKhK0ZGdopkw412Afs6nHtv/SCumlNTcgJC8OCFCwEQ/PFfd
	ja8LLosnDpsLvnMFKnY9UGpPc0M3IWJXG2vHNQLhYi3BCWSkzYHg8KJWKBcw0U9oDmtk9pLKvvG0r
	2rAozuI7XAiKdTvt0VyDhPGU9aDj53rBliC5Ed9PT+Sg3Wce56IR3R9CQfPRELcFgHG+HWN7LgSH7
	POKsKm2bt5th9c8REREEODVioDguG3oT/5v5DD1HqQ6CUzV/0c0b91jCKkeCKbNvTtxAcxoVkZdbK
	UZzrSt0A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEikD-005g5W-2r;
	Tue, 13 May 2025 14:04:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:04:01 +0800
Date: Tue, 13 May 2025 14:04:01 +0800
Message-Id: <18fe5ff62fad08206de4c02f67746120aeb41fc0.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 07/11] crypto: aspeed/hash - Remove sha_iv
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

Removed unused sha_iv field from request context.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 5 -----
 drivers/crypto/aspeed/aspeed-hace.h      | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index ceea2e2f5658..d31d7e1c9af2 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -593,7 +593,6 @@ static int aspeed_sham_init(struct ahash_request *req)
 		rctx->flags |= SHA_FLAGS_SHA1;
 		rctx->digsize = SHA1_DIGEST_SIZE;
 		rctx->block_size = SHA1_BLOCK_SIZE;
-		rctx->sha_iv = sha1_iv;
 		rctx->ivsize = 32;
 		memcpy(rctx->digest, sha1_iv, rctx->ivsize);
 		break;
@@ -602,7 +601,6 @@ static int aspeed_sham_init(struct ahash_request *req)
 		rctx->flags |= SHA_FLAGS_SHA224;
 		rctx->digsize = SHA224_DIGEST_SIZE;
 		rctx->block_size = SHA224_BLOCK_SIZE;
-		rctx->sha_iv = sha224_iv;
 		rctx->ivsize = 32;
 		memcpy(rctx->digest, sha224_iv, rctx->ivsize);
 		break;
@@ -611,7 +609,6 @@ static int aspeed_sham_init(struct ahash_request *req)
 		rctx->flags |= SHA_FLAGS_SHA256;
 		rctx->digsize = SHA256_DIGEST_SIZE;
 		rctx->block_size = SHA256_BLOCK_SIZE;
-		rctx->sha_iv = sha256_iv;
 		rctx->ivsize = 32;
 		memcpy(rctx->digest, sha256_iv, rctx->ivsize);
 		break;
@@ -621,7 +618,6 @@ static int aspeed_sham_init(struct ahash_request *req)
 		rctx->flags |= SHA_FLAGS_SHA384;
 		rctx->digsize = SHA384_DIGEST_SIZE;
 		rctx->block_size = SHA384_BLOCK_SIZE;
-		rctx->sha_iv = (const __be32 *)sha384_iv;
 		rctx->ivsize = 64;
 		memcpy(rctx->digest, sha384_iv, rctx->ivsize);
 		break;
@@ -631,7 +627,6 @@ static int aspeed_sham_init(struct ahash_request *req)
 		rctx->flags |= SHA_FLAGS_SHA512;
 		rctx->digsize = SHA512_DIGEST_SIZE;
 		rctx->block_size = SHA512_BLOCK_SIZE;
-		rctx->sha_iv = (const __be32 *)sha512_iv;
 		rctx->ivsize = 64;
 		memcpy(rctx->digest, sha512_iv, rctx->ivsize);
 		break;
diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
index a34677f10966..ad39954251dd 100644
--- a/drivers/crypto/aspeed/aspeed-hace.h
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -184,7 +184,6 @@ struct aspeed_sham_reqctx {
 	size_t			digsize;
 	size_t			block_size;
 	size_t			ivsize;
-	const __be32		*sha_iv;
 
 	/* remain data buffer */
 	dma_addr_t		buffer_dma_addr;
-- 
2.39.5


