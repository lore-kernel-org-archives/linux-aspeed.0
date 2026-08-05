Return-Path: <linux-aspeed+bounces-4640-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F749C55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnTD0QGGz303D;
	Thu, 06 Aug 2026 09:59:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785931112;
	cv=none; b=i6bbi4KePu+0DQBdxAIErwK7qvPtYuR+w9CZzbGEHiSLQDABmgnHSHEZRo3Lw+uiilOMYafV81Up+9ao16nlsADe7O33I42/YwZm4nCiGRWQUTfHQdvlh58lub3hniitzSM/ZUlVXmLecexL8rIDEAMYAmVxC+Cap0dfICDDtJftzkH5NXliauEAV/LRSgGbUUKQunv6GK8kIdxvb4Z9v9a7okacyBhZaagsPpCzR2jG4jS+RFiIcOPT6s5zGTwfpC7nvLWFznAyBVyKgO+cm/EnUM0Z/BeeSgy4NOw+ynVC965p8beTYFg+2VjW9oVRTzCxXsEx6vzubyknV1SVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785931112; c=relaxed/relaxed;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fFaQoWeEVQLyaCi0EXWaT+63XYVF7l9yojnRvcjmMLTfKVFC8mI5jt0rMZZpQgMpZA2BySLXw+G4CFuOICm/GGtvYnDdHTZgtdvydaX7AeMd5nDYcgRGf3RRd+jQkWLl4FFa0QLb8lWeVdyAzeimG6J6bmm61NWe01wSNcDY4R8+1neL4jYnLZlpQuENeAZLqVI4qSk0VW7Rxgv0MaLLL2TGgflkivivw9Dnc2yLnRjkC5oHOM+w1CBS9lx8cGCUI0mryyucwqz4159qqOkGM2R7EDwCD3Bt91yd3K1MdxjqKx93yPRUpW+n01tJKX94TKg+EBamHHW9U8OKG99WCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDIF0TvD; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWeBQZ8+; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDIF0TvD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWeBQZ8+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTT24JpPz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 21:58:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785931098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=bDIF0TvDV7LWu8hraLNaZRRqG6OPVeZSngFXirqgo8lk6h+a3chhDf8Of34iMqj2g6myrJ
	YCrALYLBMAu9F+c3YkSloICD50sEI6gsGSgjhRGKMzVEa4WZqF9YPaFwz6RXmHU0YshwPX
	oe57vWj47CsaTI1nZkUYyDkXMaH0n+k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785931099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=VWeBQZ8+oEPh+RlaY82/30hvzTaL56i12YkNvbNpIrEDBw7TUyVKsc+BNDYVUCKnq7ijml
	LQFyNTgSKXLkMDyhuqDgnGsm6LvT5L0ToJqyGQ8fhzfHUQqyWCTKK5RNU2OQzMMn3kzTW3
	VOINQEi4jpw+jdv9rhS8nv9XiViEsE8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-yPW5ZYxUMim58sgn2KjWOg-1; Wed,
 05 Aug 2026 07:58:03 -0400
X-MC-Unique: yPW5ZYxUMim58sgn2KjWOg-1
X-Mimecast-MFC-AGG-ID: yPW5ZYxUMim58sgn2KjWOg_1785931081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 826E4195608E;
	Wed,  5 Aug 2026 11:58:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 644DC30001A2;
	Wed,  5 Aug 2026 11:57:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Neal Liu <neal_liu@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 02/10] crypto: aspeed - clear the crypto_aes_ctx when done
Date: Wed,  5 Aug 2026 13:57:40 +0200
Message-ID: <20260805115749.392672-3-thuth@redhat.com>
In-Reply-To: <20260805115749.392672-1-thuth@redhat.com>
References: <20260805115749.392672-1-thuth@redhat.com>
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
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: moOPEn5nshtz0pIQV1QtmSfE88SwmzKZ8UDu8lINOSI_1785931081
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Thomas Huth <thuth@redhat.com>

Declare the gen_aes_key with __cleanup(aes_zeroize_ctx) to avoid that
its contents could be leaking via the stack when the function returns.
And since it is only required in one branch of the if-statement there,
move it to that block, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/crypto/aspeed/aspeed-hace-crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index fa201dae1f81b..e7d3f611df05c 100644
--- a/drivers/crypto/aspeed/aspeed-hace-crypto.c
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -576,7 +576,6 @@ static int aspeed_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
 {
 	struct aspeed_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
 	struct aspeed_hace_dev *hace_dev = ctx->hace_dev;
-	struct crypto_aes_ctx gen_aes_key;
 
 	CIPHER_DBG(hace_dev, "keylen: %d bits\n", (keylen * 8));
 
@@ -585,9 +584,9 @@ static int aspeed_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
 		return -EINVAL;
 
 	if (ctx->hace_dev->version == AST2500_VERSION) {
+		struct crypto_aes_ctx gen_aes_key __cleanup(aes_zeroize_ctx);
 		aes_expandkey(&gen_aes_key, key, keylen);
 		memcpy(ctx->key, gen_aes_key.key_enc, AES_MAX_KEYLENGTH);
-
 	} else {
 		memcpy(ctx->key, key, keylen);
 	}
-- 
2.55.0


