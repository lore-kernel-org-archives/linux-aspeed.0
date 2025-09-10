Return-Path: <linux-aspeed+bounces-2201-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24949CAC58E
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Sep 2025 23:41:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMcdx605Wz2yGx;
	Thu, 11 Sep 2025 09:41:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757493300;
	cv=none; b=RxLlf2KH9J3RECxriWGkLMAnu6BejCXZq5XYzuNoUzT5i2Q6Ou07MalpGTlVXV1yEO54DYz4E/96ZLU5gcuyHwT0Bib1K1fvDuIp9wIkmZ5x/Oz2UnZxEoYaEhwBTVfOXoq3rs1ATqeW3o6BCFg6ShSdfUpbZQ64mSwPJ7Rhz3OfPcckye/wYXgTXBhzIldwXGSEkT1bBLESll6MhrmqluPdMBS+VjVJk526oQVQC1DA8KYhYJl2TEwdIUUHhCcotnnnlofDIAy9BOoyQNzyjVVcHQztQiEZi/IcIvzSl1P7otvLGP5WnuQOHQ0aheziuTEsKEEYrCML3pgfwqSUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757493300; c=relaxed/relaxed;
	bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg7W4VOssWgscRsQSicPxDKIJsaGaXhgL7x9lCFp3ntVNf+gUzOdxhP2d+7A3V3pYtKSYyzEGzWdRnyy7ozaEtGLcT/fOJX0DtIatuBBIIbg8TeJ4UDhlleKwCB2HmEhy8OiKunABJthIVBmXExP2KJSLxg83bHTFWnJM63T2vNTnvFrCiMoPRweGdO/xbzUpU9plv0cGn/MuIx5V+/fVZubSXlcBF6PWCxec24BfklbGTXuhbN6bzcmmih2yNosXhHUl8fDxITRnAhZOr+NBlL37zMqQ32mLWYywdiNNB98FjOGkzhd3hJAXhmekX5AzDyaUp5a3mWs6BguvyxVLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MrfR+0JG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MrfR+0JG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMDX30Jd1z3d8t
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Sep 2025 18:34:58 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3e35d87f961so219952f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Sep 2025 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493294; x=1758098094; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=MrfR+0JGP3dKADpVUtuyGVe27Z+FglTD9Alk7N4QqAJ3tSsNq8gHvcyFxMZ8/udKXZ
         /J8ZvrYLIeszpeFbusnrpt+aANRyUjZWUNlLtv/fQyMSXyL3jW3NWM8+P8kDz9C70vg6
         4QhWBm2LTG2EThy56d4c9QJRaEb7/Rc8EbbhX16Y6nYA1EtAZvniixunr3ijjKsrkxBH
         1xq5eT+t10guUUHICZ+TjO+9iIeH64PNwyh3Pi8B8Gbe4xLRFha21q8a4X+5ov95S5HZ
         DxycNZDsceuaFevKGVGliaZFBTDOGbnICYvNNqDfHkqGzqP5FLz95ByMPPIhFY6ZW/0Z
         L6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493294; x=1758098094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=Xao3GifUKiT3f3mReEiZkzQJV17/Hhsh0hm7i+frezddilFsAaGUX0pe8uuMSkw+3O
         Dd06aR04JX1WDpJYKBAcpMbFqJUXKdQ05GPiSdI5v35ocEI1xO24Gw5xGCy2621TmnB6
         cJBWJQ8a96gQcxgayaFkAWb+4NJFU9ukQHxDZKUcRlrdzBrfsVW2jWVXDurkf4/0xqrD
         bupBHTgf6yZ7dLESK39EoDZKC06qirbJirXKJMfH9puKRELfy37GFAm4jaboSpWziVjg
         q5KdjcJiazjD8y/hjDwrLLySbUShJUHICbyHiweoIq4x7MAsQJPM5G/FdSX7G/aAbjrA
         eqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuF8W/g/84Opg+/60xvike1EM3yP6uHj7yho+9OVA/dHq83+n08DqbF/G+bdwTp0gMSofyKzL2KBwA23w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFeULGQxSRLHc36g1BaUz/hOkT+DkI3ZPs6XHVquPLl+SU0W5j
	/M/3E8xJ1N4I6MJ25PKKtpST5GbaY6KsbhtioWZBAqMoH1wF5zKDHzkb
X-Gm-Gg: ASbGncuWLDyuXvu56EUjnDI/p/0LBJnAhZ5YDAHYZIdYrSc7RK8d/pjeA/0Eg1R677O
	NTDU+0DuWS7RPxvnZeYxOvRR2t7/QuFuP21EYlydQqnmMbbyAcLDOKTsbpN+7x0LCw5g/YTDwzP
	MdWrD8Yl/a+1s7waiwt6pihigpB/iU1jnUC4bKgPLrVDzWjy8TUVbC8AhcMWqI/33Js9wOSTj1s
	WsnSbybno/8PfBPIkqsSZA/w2+1FFX/4Mnom3qRO1zyyLRrSCCdrouOOEDlQeAmHj2YWG0joqOR
	yxBbzpOOp7STSMI7GfMJSN0W8q10+kTh+db88UtRtJ1VYY8dytVWVsYwGLcs012Z6633eHpuqKB
	dPYhtiFYqSgQlLVrszY1hDLtpG/UaIPXCDbTtpo+N3sAxJrJlRL5U1qiOsb5ZWQZw9v4=
X-Google-Smtp-Source: AGHT+IFvK6FSXou9OenUrrz/PdbIoxF3WcJL69A9lP4CdFPOW3aq92qZPlSoHiBDeanssK1jlGOOKg==
X-Received: by 2002:a5d:5d05:0:b0:3e4:e4e:3438 with SMTP id ffacd0b85a97d-3e63736d9bcmr5889161f8f.1.1757493294125;
        Wed, 10 Sep 2025 01:34:54 -0700 (PDT)
Received: from thomas-precision3591.inria.fr ([2a0d:e487:311f:7c67:b163:f387:29a1:c54d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a2esm6378854f8f.14.2025.09.10.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:34:53 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Neal Liu <neal_liu@aspeedtech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Johnny Huang <johnny_huang@aspeedtech.com>,
	Dhananjay Phadke <dphadke@linux.microsoft.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: aspeed - Fix dma_unmap_sg() direction
Date: Wed, 10 Sep 2025 10:22:31 +0200
Message-ID: <20250910082232.16723-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
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

It seems like everywhere in this file, when the request is not
bidirectionala, req->src is mapped with DMA_TO_DEVICE and req->dst is
mapped with DMA_FROM_DEVICE.

Fixes: 62f58b1637b7 ("crypto: aspeed - add HACE crypto driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - fix confusion between dst and src in commit message 

 drivers/crypto/aspeed/aspeed-hace-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index a72dfebc53ff..fa201dae1f81 100644
--- a/drivers/crypto/aspeed/aspeed-hace-crypto.c
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -346,7 +346,7 @@ static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
 
 	} else {
 		dma_unmap_sg(hace_dev->dev, req->dst, rctx->dst_nents,
-			     DMA_TO_DEVICE);
+			     DMA_FROM_DEVICE);
 		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
 			     DMA_TO_DEVICE);
 	}
-- 
2.43.0


