Return-Path: <linux-aspeed+bounces-4665-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98BEC5AC67
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 03:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHjMM2NmTz2yXj;
	Sun, 09 Aug 2026 13:01:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786086470;
	cv=none; b=lwcZBUXDyClbZtLWWY0b/lUVrZw37qXbsXI580W+h9d3zCPtbZlppiX+6lyAjiRh2hGBK2sCjWpUFMzUCm8Pl5RYfoq9IQpNBS4P5Ak4Fp38z3OWjZkMCJcLULcB96MmnInPHeL2v3O8HgLA0in8TSjIos/BgjcmiN8JKGrWGHNHZeP52UkSYBQkkh1wSuAxhW2k4Htj4JjImsTI0zx4me0MH7EUE1OVbdxNJdFvPM/erQtafPNOjOyEuaI8nZWnJPJ5h/sgiEX3FRtDvIOsp1Q9BgeU8qy+pyDbvBaf9fkfEmw9O1NIExynUR/L2qVc7yeIq3TEfKPC7VVfiwDhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786086470; c=relaxed/relaxed;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ogEiUaVR6eh7UBYgknH8KNdutCOqEZ3bQzIMYtiS6v+XUHiVaLwJVexdQMJgwrxUJWVEqwsOLr6z4hn9ZUS9e8S44spuLnBiV0XBJHP/jgkc9PzqPuvsOSMzsfqvGIQMYKDozCcnAn/diXyOjiSSTpdfxGLf8MhF4I83ova213YdvW/scq+TXP6PeG2ycDZ7LT+GMF8tYKxEyVq2+Qi+D5XMb7cU4d/RCjQOhNayaHH6CUppGyGceNvQJiJyFOMx2BwTK8dod1JvYc4LfpNh+qNxuDlnhUHnzDdaBc/x4UwIBb6ElciPzOsBHvB2IQvAUM8UxLBMX8D7Vthflj1u/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGOE46MH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YniLkcuD; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGOE46MH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YniLkcuD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGZwh4F1Nz306N
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 17:07:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786086460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=XGOE46MHikk8bERzS/8eJq8ZTvYw8KT6uMZpkl/eP5f4mNSb8RxrhP7uzvi5p/viAhZtl2
	K1UmWz5PnnY7/OoBNq+t6rcgDxG6/3D2GAByDcmAsDtHGZlkGIPhINenX6PrW7AVXUaWYP
	0LehF5wF1gNe7DgJvZws1nrjqP6k/dE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786086461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFuj09l13bDJWP8ROOQNO6DWGBJe5ddETVvR3frCMgU=;
	b=YniLkcuDWw4Cohuz4Yb8mLUj6XmQoTZs4DLM5nqkps6/A3xueRmZwXvvb+d9kdY8O/US1f
	HONw1GKBrim65E9QXcsIkz2B8djCUyVYrWtZS81H0uPJqzF25rkoSOIcKlpjL136DCru5J
	bIJrqC/17KN8FjrmHBsIce1nDGXvxLw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-nXN2oDJ3M8CXiPfpwlk0eA-1; Fri,
 07 Aug 2026 03:07:08 -0400
X-MC-Unique: nXN2oDJ3M8CXiPfpwlk0eA-1
X-Mimecast-MFC-AGG-ID: nXN2oDJ3M8CXiPfpwlk0eA_1786086427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09EF31800471;
	Fri,  7 Aug 2026 07:07:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A279C1956094;
	Fri,  7 Aug 2026 07:07:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Neal Liu <neal_liu@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 02/10] crypto: aspeed - clear the crypto_aes_ctx when done
Date: Fri,  7 Aug 2026 09:06:29 +0200
Message-ID: <20260807070651.228713-3-thuth@redhat.com>
In-Reply-To: <20260807070651.228713-1-thuth@redhat.com>
References: <20260807070651.228713-1-thuth@redhat.com>
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
X-Mimecast-MFC-PROC-ID: EiwM7-88nQAxvu1pu5XjjgKCjUDVE9Re7Wwor36EGv0_1786086427
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


