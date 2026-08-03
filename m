Return-Path: <linux-aspeed+bounces-4600-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADAC55182
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 00:33:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDZKF0NjQz306N;
	Tue, 04 Aug 2026 10:33:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785750310;
	cv=none; b=NlnCJW4I8yhchrLZLD7W/Le4RhlHVoQdzo5PJjSNvvvebMBEVgj8nIUKhFvQ/8c0bry2X9qQJRU4Gc9eCTmIKRgxTCqG9qo2/Hpg/3NcteH2d4c+ZZ/uLXpLCr/LrpZ7Ge8TKtbHhHjytNgGLRGaEoAaCSsjp+0RxMsnb6uFwyTc4brhqQ54opbkLQrGTVLjv83RYqD/jdH3XugZksytncJiCeav93F4DvaHMqZ91JhMt+K2TWWeUsfJJ7xD8VtjGYU72UqwEVZsQUu107SKObOKc19wbcu7TSJD7GCdj4gHjsDT7xPgnhX6qHGs2Axz9W1IPpnjaItR/KeYk1mprw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785750310; c=relaxed/relaxed;
	bh=z/s71yf/xbMLaACx3//RVPK21sA9eWV1kaPskwgCZQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AhjOS9gtGDqwaTxTJK7d1wgpoS4tZFLuZcUIcIVEQrCwwfemMPWvSQeivZgZ4CHnlrJMMwx0QtjzZdjaeyDvyxv2blkQ4AjiSS66vcQgPt4gejS+FE0ifev//Bt/MjlR3nVcoQoRFrB2hqrFqUnJne9/5nua7cQbp+3CTZ9ixr69jfZkvsiSsgvCx/+eTt+kTL7WDAlSlSIcfpWC95p1rA/cmFcpauxQHrLl7XIuKsiQkq5ZZX6vlrhUU+FfzlxPVcfWAAKAlwEa6WL+KlwS7scHcYD/N8HmcHIPlqXyy9R9AruRg/j0Kgd9STY52q1iKWEip7HWw6Z0y+Qj6Qst/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6DQ1Llb; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEqbAGA9; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6DQ1Llb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEqbAGA9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDBc474Ydz2yQJ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Aug 2026 19:45:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785750298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/s71yf/xbMLaACx3//RVPK21sA9eWV1kaPskwgCZQM=;
	b=f6DQ1Llbw3O35IQf2ZQ/pIDuYWxbHe2HBSmxwXkMyX0oZKYndiV3vbPdIJSN8O8CGWR7l1
	LoVt7tKGOuusZirAwjNQc7XryFfMoybrJ7t87aoiNbq30WE9U/DSpiTIU5y7RmnbJWKw/j
	l2W/Z8KlawrrD9TSvRYoYYD/B++vJbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785750299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/s71yf/xbMLaACx3//RVPK21sA9eWV1kaPskwgCZQM=;
	b=MEqbAGA9Zu9KWRcnnZT5DZFM48BZe01Mu4vA5AM+heAnIz8eCBEOAH9jB/KfejfBP7cxi8
	y1qP5vNXSA1QAExixplfLOqT1hUSgb4I5obd9hs1m4IeCvW3N1/DFM4GKudstpJ7QvYOtN
	26s4pV6gPETGRlhwuFbRMGUHcYb/DXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-7KxwcOU9NS2jR-v4kKKdKg-1; Mon,
 03 Aug 2026 05:44:53 -0400
X-MC-Unique: 7KxwcOU9NS2jR-v4kKKdKg-1
X-Mimecast-MFC-AGG-ID: 7KxwcOU9NS2jR-v4kKKdKg_1785750291
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56001195605E;
	Mon,  3 Aug 2026 09:44:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.213])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 810F51956088;
	Mon,  3 Aug 2026 09:44:42 +0000 (UTC)
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
Cc: Simo Sorce <simo@redhat.com>
Subject: [PATCH v2 2/9] crypto: aspeed - clear the crypto_aes_ctx when done
Date: Mon,  3 Aug 2026 11:44:21 +0200
Message-ID: <20260803094432.70505-3-thuth@redhat.com>
In-Reply-To: <20260803094432.70505-1-thuth@redhat.com>
References: <20260803094432.70505-1-thuth@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: lOLneD5cM-kkq7tpQaH77e4P6H9yJRShdwF7atDhVUQ_1785750291
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Thomas Huth <thuth@redhat.com>

Declare the gen_aes_key with __cleanup(aes_clear_ctx) to avoid that
its contents could be leaking via the stack when the function returns.
And since it is only required in one branch of the if-statement there,
move it to that block, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/crypto/aspeed/aspeed-hace-crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index fa201dae1f81b..74a4ce62fcd93 100644
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
+		struct crypto_aes_ctx gen_aes_key __cleanup(aes_clear_ctx);
 		aes_expandkey(&gen_aes_key, key, keylen);
 		memcpy(ctx->key, gen_aes_key.key_enc, AES_MAX_KEYLENGTH);
-
 	} else {
 		memcpy(ctx->key, key, keylen);
 	}
-- 
2.55.0


