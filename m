Return-Path: <linux-aspeed+bounces-1203-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC2FC3ABC3
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRl92yp4z2ypV;
	Tue, 13 May 2025 16:43:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118629;
	cv=none; b=ZSu9/ZHdE7XKNadFF1/AyeNbeXDgbXxcULfTAuIbgSJZOi0wcRJP3BhkqvHrNt3IoQuGNLZ1PIlOBSAUf9pSdFAIzyqpqWLhUdE1hh+clOdXMOuIExheR1dMiZC2rsHPX3w9yyDHFPHQaoLzlpRUSl4s8flAaxXHi9w90PTUMZih9kPX1wz+9vyT4qJEKoZ0WwpKGpymmgs/ADoyCdP5kbFMcLRbgIlcm2uyYfH5D0wume5QGONRrd8wnMXxpzYAuBA4lswD+ouv6lWL3j329DQ5/TFDZ0+FQcRgKg2FOXLBezCcAjqLLVmHxA0IKLI0xzezlJyf7VUU35UxINmotA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118629; c=relaxed/relaxed;
	bh=1V2wVUkULAV/+Sb8MCLK5k1wKu01X18xmPR28zR/g40=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=SjLU4zzMumhmTQpbpcuS56/FPVr/w59re1XZpdfvk2KzBdF4intqNah9a4RjHN4QoIGaEeimjxdFMTQ8Y4P2mEQD9TAUILZ/iIvmj3ZDmFSfSJW4yVDfQtn1A1uZRZAtm686xD3pFQqYfQtCbdD4ztdF0TI/CPJ4GFkdJTB4rQqTbawsLSThxul071aVIJ1vGa0UlGHD8uOU+Qz+D9gW68C4UI4G+vM7gNLxt1xzciBveeD0BOomZJ+uXuENfXqHImLdsEloi68iu1aoafLFqwBcX/I9LkVDnet8wPmjn8bUK8vw58HnmXHdIWyw6HTLrTis4vdUgjQUWtJ2GuL6gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=r2cSTnvR; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=r2cSTnvR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRl90CsXz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1V2wVUkULAV/+Sb8MCLK5k1wKu01X18xmPR28zR/g40=; b=r2cSTnvRL3br+JM7Y6e+LIw1uV
	1e39Trn2I1gMcqTkpZmPTVGuBJ+hE5pomHY8ZQJKcUYl29WRF/QEVjci6RZbishGbLRkJQ24ysUEX
	dERKqIZrXzbBGM9sq81Yg8kvXNgd7wcDJSAPkI0FaXIdyoBG1s6qZExsRsEIIdH+W3slVLlQ7Aztw
	cA5Gzcus8SlNri4TkExIQ3lEQ0k6iGFoZflurkYjYeZnLxU9R3cO3WPvcigzMQPKsuYFtGhqH31TI
	8ODrX1BOulELXi49XLPlFx90BvuBWoYWibDZB1QrW3BEYPkkJb9DAR0WfFq3Wp5IctvOJGuH+z2mp
	7nYab7FA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEik2-005g4S-1C;
	Tue, 13 May 2025 14:03:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:50 +0800
Date: Tue, 13 May 2025 14:03:50 +0800
Message-Id: <710e21ad559adb09d5ec81a9b0d1739dde0c8a00.1747116129.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747116129.git.herbert@gondor.apana.org.au>
References: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 02/11] crypto: aspeed/hash - Reorganise struct
 aspeed_sham_reqctx
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

Move the from-device DMA buffer to the front of the structure.

Sort the rest by size and alignment.

Keep the partial block buffer at the end.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/aspeed/aspeed-hace.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.h b/drivers/crypto/aspeed/aspeed-hace.h
index 7ff1798bc198..a34677f10966 100644
--- a/drivers/crypto/aspeed/aspeed-hace.h
+++ b/drivers/crypto/aspeed/aspeed-hace.h
@@ -165,6 +165,12 @@ struct aspeed_sham_ctx {
 };
 
 struct aspeed_sham_reqctx {
+	/* DMA buffer written by hardware */
+	u8			digest[SHA512_DIGEST_SIZE] __aligned(64);
+
+	/* Software state sorted by size. */
+	u64			digcnt[2];
+
 	unsigned long		flags;		/* final update flag should no use*/
 	unsigned long		op;		/* final or update */
 	u32			cmd;		/* trigger cmd */
@@ -181,14 +187,13 @@ struct aspeed_sham_reqctx {
 	const __be32		*sha_iv;
 
 	/* remain data buffer */
-	u8			buffer[SHA512_BLOCK_SIZE * 2];
 	dma_addr_t		buffer_dma_addr;
 	size_t			bufcnt;		/* buffer counter */
 
-	/* output buffer */
-	u8			digest[SHA512_DIGEST_SIZE] __aligned(64);
 	dma_addr_t		digest_dma_addr;
-	u64			digcnt[2];
+
+	/* This is DMA too but read-only for hardware. */
+	u8			buffer[SHA512_BLOCK_SIZE * 2];
 };
 
 struct aspeed_engine_crypto {
-- 
2.39.5


