Return-Path: <linux-aspeed+bounces-1204-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870C6C3ABC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 06:43:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxRlC1kx2z2ySl;
	Tue, 13 May 2025 16:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747118631;
	cv=none; b=X4WcfY39za3QgyjHfJHPqvwWxYeGTEIMdKDWeYhiIKP3u3BK9FuD16PSOk0P+q3s1WRB9DI++vpQfP4BkCRfAIUI8HxmkUM5+pug8BhIVWzQf2sG+NM47+Hn7RcRoIfeVEDlPSlnVRP/AHCVsqu/0dG8OowdZ7vjDHs2Z1rRCdl2gb3D6IyyDvznjwyVHYa1nbJJdh26Ji9T9dXv5gvsV+AuX8ElNwYMgTRKPylk9MjjjBRTg+wz/8Kdk7e5OlJcD7pAhcnfFUhOZgcpywN2bv7B1KWiXNcwra6OUGRQzxRRZXe9AbI+n+3eBdK/tRftDa+fkg7Is+HuVo5RMAgvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747118631; c=relaxed/relaxed;
	bh=gnhH4MKBTnxG4N3owibGYMEInxvdW62epN6YeSvvHb0=;
	h=Date:Message-Id:From:Subject:To:Cc; b=a32fTpKq3ZEciS38xKCqQCUqzG8kXMWgKZCUus2rGJk55leD65ECWsijO0kKosZBLhQXKo61A9MvKGQQ7s7oZgBjKaDcR8gPzpLc5/Ly6mYEjB3pByZQ87vfNsU7aPmR18a1UOAGuryyHa5xgpuQnrEO1TrgMwQRpFsLcgdf5kBFhIg69J+a+FNcI4rRPgdSKo32V/uQ8V+vkRRUCTfP2ZviN58r3jiZElrQApO+H2ga9A+g7sdzJYNdq3rFzrB3l3riSeoVlwkcSLYxMI5SGg6Faj8i41lnavar5R5ghb/0QolQH6gieN8V0LaMila4pO844mNmU5JZLbRtye13fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=ZsYoYNhH; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=ZsYoYNhH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxRlB5lTfz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 16:43:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:Message-Id:Date:Sender:Reply-To:MIME-Version
	:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gnhH4MKBTnxG4N3owibGYMEInxvdW62epN6YeSvvHb0=; b=ZsYoYNhHT5C2TvhqdTySZwpFrG
	PvBrA/tLe2BXPJikfcVZjL6pQQyjh1R+d9HWw4wGsg9V/5kbPi/KwKdsOFeo7Smtuc0q9yxOR3Ahi
	RFk08Ndo94H53jxUr6xQ+R4vaDGinsCkun58GjzCe7YEFU7geuCyZcTnbOKKEtgUZeQEj34JNevkg
	T2qUSEmp9Dt7RLQuesGUKcC496KLfBTQ1lou47KtT/utyt+bemHRFfsyDjlC6FNRWrsRaRzSZ6/bB
	50eSmkGyj770u4uAbj6smX+JF4v1qxAvQLB3VQo2+pRRuy2IppnqnX/qPRe0gHom6lZ4CAW21UpPs
	islexMOg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEijx-005g48-2K;
	Tue, 13 May 2025 14:03:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 14:03:45 +0800
Date: Tue, 13 May 2025 14:03:45 +0800
Message-Id: <cover.1747116129.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 00/11] crypto: aspeed/hash - Convert to partial block API
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

This series converts aspeed to the partial block API while removing
hash length limits and making it more robust if dma mapping fails.

Herbert Xu (11):
  crypto: aspeed/hash - Remove purely software hmac implementation
  crypto: aspeed/hash - Reorganise struct aspeed_sham_reqctx
  crypto: aspeed/hash - Use init_tfm instead of cra_init
  crypto: aspeed/hash - Provide rctx->buffer as argument to fill padding
  crypto: aspeed/hash - Move sham_final call into sham_update
  crypto: aspeed/hash - Move final padding into dma_prepare
  crypto: aspeed/hash - Remove sha_iv
  crypto: aspeed/hash - Use API partial block handling
  crypto: aspeed/hash - Add fallback
  crypto: aspeed/hash - Iterate on large hashes in dma_prepare
  crypto: aspeed/hash - Fix potential overflow in dma_prepare_sg

 drivers/crypto/aspeed/aspeed-hace-hash.c | 802 ++++++-----------------
 drivers/crypto/aspeed/aspeed-hace.h      |  28 +-
 2 files changed, 207 insertions(+), 623 deletions(-)

-- 
2.39.5


