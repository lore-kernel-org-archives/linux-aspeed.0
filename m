Return-Path: <linux-aspeed+bounces-4678-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC1C5B56D
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Aug 2026 00:14:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJsYs6xWwz2ynW;
	Tue, 11 Aug 2026 10:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354245;
	cv=none; b=Rw5kG2hDQOVSPUiwVw133oFlFU0AplT7Q5rxvlzBhjNDRHv5ScLaL3rMpK+6MqLjH224105+cZ8TcvUU5tpv2zt3ckKt9oUuvocLHGuH3c+1BS43xnGXULwEZNeuLIRkZoGTPd1gl5PMg/7+xU50U2RKlRbYNy/1orCAp+oRj/FZxPAepERwMKqRbCjrdjZLwTffCqzT8DB7mJM9ruuf1FxqTvol8GEE0Jnx0o2b4TQy8P69S0rmr3bEaXo6n2jp8WA5Z0zLIpNwyYfyjRyWFwH4VWYHriku8Q78plhGGzOiuHv7RXe+fAoffkpyfZi24NEdBp6jI1zquNSg4Gvbow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354245; c=relaxed/relaxed;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iOFmq0+EnAEMRSGzwQjjSic8RRuK4obeLO5LFLNNkvgJUaTITvD2HCRI70WvczAzLajYYM0H2eK1Gc9tWn5YURVXGZuiZylvagfFYrAgZ42hSr5p24lIscdBm4qw8oQjeIGpZUpF96smkIRbH+S1atgsmH2ap8Lsu3QcFuj7MAqvVV0b2FrMalV3ywz+re4DpTtXlxCuKcnDXu/yFsI1N2p6RkDI/xGupqUkPvsVuM+nLfgIyymJATumEbikw9XgXlDdURXuEiH5rm3t/gX2qo45MZVDrB/Wr1KfvkRQA4A3lo+/D2I0lkYN+Ep8lnvskswOdlO1pIYb8nt+ZS0Dcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQm2P49T; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aCWeCV1l; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQm2P49T;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aCWeCV1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJTyC0TNcz300V
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 19:30:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786354231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=DQm2P49T0aiCuCyLIOKfFqraZoPE9uWJMHnSq40koGEkuMgjxR5L6JGjcQyM3Ibh9sKirT
	fDDzT33BKjUBeZ4eESl5cqvOvt6Lj74+SHLnVc779MmBTM0vB9VIHelkub0y6aJeu2fRDK
	ZCDdB+ZppDFoarBEO+oar0Kn3KiT2WY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786354232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=aCWeCV1l/FBUWmXaVOha2C5cpiidj5/RL3LbBAAu493GK8qQtrOjvU+8WgAEIpv1yehVdV
	V26vtxWZ6wyAb/KjQasmhRRUA02m4lNsFE0DWxX88B0KvN7BFGRuhkADxMh7EfqnBW7kYy
	hJRITiUu81MtVZe89HYRNxyy/O9GX1A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-U7rsMKF7Nkq7P_7Ivsxu4g-1; Mon,
 10 Aug 2026 05:30:25 -0400
X-MC-Unique: U7rsMKF7Nkq7P_7Ivsxu4g-1
X-Mimecast-MFC-AGG-ID: U7rsMKF7Nkq7P_7Ivsxu4g_1786354224
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324011800846;
	Mon, 10 Aug 2026 09:30:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BF853001D38;
	Mon, 10 Aug 2026 09:30:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Neal Liu <neal_liu@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-kernel@vger.kernel.org,
	Antoine Tenart <atenart@kernel.org>,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 02/10] crypto: aspeed - clear the crypto_aes_ctx when done
Date: Mon, 10 Aug 2026 11:29:57 +0200
Message-ID: <20260810093009.608090-3-thuth@redhat.com>
In-Reply-To: <20260810093009.608090-1-thuth@redhat.com>
References: <20260810093009.608090-1-thuth@redhat.com>
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
X-Mimecast-MFC-PROC-ID: GIuYe5S7n5EnbKKHelqs2rufb-6BZdT5W4pS0Z0gkxk_1786354224
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


