Return-Path: <linux-aspeed+bounces-1197-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92B5C3ABC3
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRkx2vfwz2yb9;
	Tue, 13 May 2025 16:43:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118617;
	cv=none; b=Kd2OzdVdWhg3KBN/NrqKVAcRCebuLL4/Pfl9oUOfBsO/dPC+IMGjMqVSL7wTuqtQrJv/BohgSlB6csk8nybpN6yGiNzh8w0tVA2BACn6QA6fRVs1ZPZmfhDsqkyIRVZKhDojyRP1RMxey7HhCSAUpGEDEROSTh1p89SiH6JNTDozEOK3UzVFUJQ3KPtsiLCYnrXillzyAEnzAPAAc7yB2NGCCTIGr4I3WPCXmj9UqJkCNdvU8oz16BT9ejGcY21F5QucqoGZxex96mgVyWIxpnioEkRqDsdj7Dh8CCqSHFEwOWZU6Kcnun9lKxZ1OF85f8PVPCQSitxLl2fQ+NH6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118617; c=relaxed/relaxed;
	bh=G2Lc0QFGnWxVtIeoNbU2gsltKLmPXJFEXW2Gxk51PXo=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=Cathw+zVvmkKJZYxp0ejnMMVTuJeIAsaoacH8afSVzgeoNJeGqLMdimTQQlXK5//U2e0h8MUzrShQSj9lGWwKwIyWekwu0c7SOZ46OQPSdbGBhSNUhoUAkVh7Q0DUEnYXPkOKr3DKQgqZDI9uQpYhBUEqjo//t7FOrP5WSgqdBoUNllgyfzVWiKV1oQdJ9Ebet+Ct9Om3swt5az52UtpJ5syxNwqTX+tysAN5/28ZV58H+WLipMCm3phAT5B+Fke5gyEljqxBfp1vmCL6xPOhaQrzijH9fA+bu+fary+FedqMfhbpLQG4jmnDOT+ridvlSgaem8qx8u++xNY73h6yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=BkwNcdTn; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=BkwNcdTn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRkx030Kz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G2Lc0QFGnWxVtIeoNbU2gsltKLmPXJFEXW2Gxk51PXo=; b=BkwNcdTn4k88s0pLdNrU2mVVTk
	EAzY0EMopxpBrHqVEl+1BYUgpKxEn4IVQxcay8posOX/WaAGxNUYf4ccGAiXsniSvF+9x7l5g8Msp
	OThA/Z8avnrqzsnpbjl5g65N8YtitPUXuGhOBKwqaEXZ3Wpn4bqSs+3GSGbBjbUUcaTsVp7RL9ofz
	ZIyGibi1bf+rOuFJ/7/TdQrsEjwjmOkQChgYVtkzNXSt5kAmrCf2IAEatiD7dRX59GWsDVMJIkWnY
	AQI7mWx2Q5CdNY9n4HHEoEhoqxUaiaHfTq2Tf+5PFOP+ey0uN5jSG+Cp40KBboKawUSsEJXtcyzrH
	fNzXkUiw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEik6-005g4s-39;
	Tue, 13 May 2025 14:03:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:54 +0800
Date: Tue, 13 May 2025 14:03:54 +0800
Message-Id: <3db52f4361ee682678c526a8e21160b26418d79d.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 04/11] crypto: aspeed/hash - Provide rctx->buffer as argument
 to fill padding
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

Instead of always writing the padding to rctx->buffer, make it
an argument.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 27 ++++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 4a479a204331..9f776ec8f5ec 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -73,10 +73,10 @@ static const __be64 sha512_iv[8] = {
  *  - if message length < 112 bytes then padlen = 112 - message length
  *  - else padlen = 128 + 112 - message length
  */
-static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
-				      struct aspeed_sham_reqctx *rctx)
+static int aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
+				     struct aspeed_sham_reqctx *rctx, u8 *buf)
 {
-	unsigned int index, padlen;
+	unsigned int index, padlen, bitslen;
 	__be64 bits[2];
 
 	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", (u32)rctx->flags);
@@ -86,25 +86,23 @@ static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
 	case SHA_FLAGS_SHA224:
 	case SHA_FLAGS_SHA256:
 		bits[0] = cpu_to_be64(rctx->digcnt[0] << 3);
-		index = rctx->bufcnt & 0x3f;
+		index = rctx->digcnt[0] & 0x3f;
 		padlen = (index < 56) ? (56 - index) : ((64 + 56) - index);
-		*(rctx->buffer + rctx->bufcnt) = 0x80;
-		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
-		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
-		rctx->bufcnt += padlen + 8;
+		bitslen = 8;
 		break;
 	default:
 		bits[1] = cpu_to_be64(rctx->digcnt[0] << 3);
 		bits[0] = cpu_to_be64(rctx->digcnt[1] << 3 |
 				      rctx->digcnt[0] >> 61);
-		index = rctx->bufcnt & 0x7f;
+		index = rctx->digcnt[0] & 0x7f;
 		padlen = (index < 112) ? (112 - index) : ((128 + 112) - index);
-		*(rctx->buffer + rctx->bufcnt) = 0x80;
-		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
-		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
-		rctx->bufcnt += padlen + 16;
+		bitslen = 16;
 		break;
 	}
+	buf[0] = 0x80;
+	memset(buf + 1, 0, padlen - 1);
+	memcpy(buf + padlen, bits, bitslen);
+	return padlen + bitslen;
 }
 
 /*
@@ -346,7 +344,8 @@ static int aspeed_ahash_req_final(struct aspeed_hace_dev *hace_dev)
 
 	AHASH_DBG(hace_dev, "\n");
 
-	aspeed_ahash_fill_padding(hace_dev, rctx);
+	rctx->bufcnt += aspeed_ahash_fill_padding(hace_dev, rctx,
+						  rctx->buffer + rctx->bufcnt);
 
 	rctx->digest_dma_addr = dma_map_single(hace_dev->dev,
 					       rctx->digest,
-- 
2.39.5


