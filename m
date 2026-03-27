Return-Path: <linux-aspeed+bounces-3793-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED18710F3DC0
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Mar 2026 01:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjKjC2cWRz2yhD;
	Sat, 28 Mar 2026 12:31:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774604018;
	cv=none; b=KdJ+MRbFFbwFf/E9Leya6Zwq5CkYJOVTNIEkYss/Izj/gGkt0mzwIeE/FZadrO6r2JMj0Abx83pDNvxSAUeCQbnzwayLMHtHSC9PDWdyWOJL+vjLoODgULIMvQv9mtuvoKIYcMR0f/LLOjV7drnKeikbylRRPsPt54HXws2OCUkzZNgR8kTj66M5VF8Lt9vWFGiteFoPr09HVu/QQmQmCnBfTYyKwlIB8p0kWpsCXYJ/3ekeHSz8C3O3avcUZDrKDv39jGqHePpuT/GzB3Zrp9V4RQhrnVqzKmN9xMuPTSkxuQZx6DPCk7WyfHsUqQrxvCv/GE3EXJEB4o1Z9kI5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774604018; c=relaxed/relaxed;
	bh=uX0ZkDshfrjUuQd8q4yz2ndynx0ogljmjvdsdmFxGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpS+zqVb1Hty7mppw3GBCWWGDOSt7+3soydKbNmXflkq9tRrLHZa8ih8UvDyeq4blc3bZlts97KIqHY397musxrlM3250Z48PY1qjU4X2P6byrmN+Z1OXgbA4jtTItTDX44SYqSlGfvg4DxdjCviKMC3oDam5gHi76U+1/0asgA7/rlHBEle6VGGU2sUzwWedmFEYB0LRwNYtQdkHxKsDSLzEGMRXiTwOBUda/QP3ngMM0BBbZ4/ZBmLaA7NZfrh3nt5oie/94H6dijVbSkPfmnmXJxB7cHeOhJW97koLBrEiFYbWn8AYNGG+BSo43TVuircmbQCo2qwor9DRhO/EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xSWvcl8I; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xSWvcl8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 524 seconds by postgrey-1.37 at boromir; Fri, 27 Mar 2026 20:33:36 AEDT
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhwSJ05g3z2xC3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Mar 2026 20:33:34 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8F54BC406B4;
	Fri, 27 Mar 2026 09:25:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBE7960230;
	Fri, 27 Mar 2026 09:24:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C40C210450F33;
	Fri, 27 Mar 2026 10:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774603484; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=uX0ZkDshfrjUuQd8q4yz2ndynx0ogljmjvdsdmFxGS0=;
	b=xSWvcl8Isbuq0d92ng8BHqR2A3YD/pHQymygkKgvTGzvpJ/9TUPBQ5jualNb6iSeS3B/5i
	+57n2WSDTy/VWyaeVK08FOZkJNuKikPRGIapifgdHbDCJ9ZVFrsduV9/fUrJANVTpnRhrx
	2ld29wYDZxahiOPJwVtWp8hdCr5cDNzBt/sfpvNU57UZAp3f0cKeGC0wxuEhl6/8F/JBN5
	nxf5oYT+3UZw0LCt+nwOAmrVcAk20MBawzmq2bBImMdMoN4/plhIY/2oA6nx1SxCpCOKRi
	PDQ/77dJF6F5/n3wOy/p0eR4hlX9LJIZNRVgRSGfYVLDb+B37c4uG8wyb//msQ==
From: Paul Louvel <paul.louvel@bootlin.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: aspeed/hash: Use memcpy_from_sglist() in aspeed_ahash_dma_prepare()
Date: Fri, 27 Mar 2026 10:24:18 +0100
Message-ID: <20260327092418.10476-1-paul.louvel@bootlin.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Replace scatterwalk_map_and_copy() with memcpy_from_sglist() in
aspeed_ahash_dma_prepare(). The latter provides a simpler interface
without requiring a direction parameter, making the code easier to
read and less error-prone.

No functional change intended.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index f8f37c9d5f3c..6f0d03cfbefc 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -182,8 +182,7 @@ static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
 			final = true;
 	} else
 		length -= remain;
-	scatterwalk_map_and_copy(hash_engine->ahash_src_addr, rctx->src_sg,
-				 rctx->offset, length, 0);
+	memcpy_from_sglist(hash_engine->ahash_src_addr, rctx->src_sg, rctx->offset, length);
 	aspeed_ahash_update_counter(rctx, length);
 	if (final)
 		length += aspeed_ahash_fill_padding(
-- 
2.53.0


