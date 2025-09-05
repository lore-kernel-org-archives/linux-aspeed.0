Return-Path: <linux-aspeed+bounces-2165-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A89ACA101F
	for <linux-aspeed@archiver.kernel.org>; Sun,  7 Sep 2025 23:53:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cKn353hPTz2ytV;
	Mon,  8 Sep 2025 09:53:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757073209;
	cv=none; b=CVjudJir9TCXLJ77Mr9o70EAML+Biowg+RCGu5/tEaK78J25pzFpIAH5SeFgWNvOhqOGaPr+59BOg7lyhgPwKEvTVVHdcdzsDeDNtPYE7UqwNQ8CqmklalRBASeO2KM7foEQ7ZVlglDSTgRuXXf6FD4QIlzYodyI/UpcKzYC9IBJYI1tRmPEJqQ9Q33lcDXS0ABQcqQePjnfBN/jih0lfFgD9h6JUbEcKHd9k5vOgE+DoiYLBivOJjpmm0orZ1l8Fywjn+jWEU2iRgPuksL9xJpmM6q7pKo/0dFmD6hpHSgcIjWRXfe2SDZLfqtwcnD7z5HE0DY8wk8PVUEvSUqcww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757073209; c=relaxed/relaxed;
	bh=ibSd1EIrnlf1T65R99x8NmkSqz8ymnGekDTIZaoFiU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYM9xcGEO2Vm8HVgd71yxlqa8Bz5iKjsN8xLP1Smy4V3w3Y+82M2aVKDmS9WFgDkXPvuLFZ9iZnR88IMY4lf6DKER9yqocthK7eGkXJxPl83Xx2tED+2oA4U0xjUzQdukXTiTcKj+MficgFr7Ojgk8/fdurwJtazZfqCCck8Ubv0iJSwtJuavufq2+Nz0TUiHHmFdKBF7Tms4mbSP5RYQlutNnkKRoc6SNG72VRsLUlUCYbFxGf2JD6XowC5u5pelq9Ysfx8zdHx3f6twHpHUjppYekWZk0tBdvHvpd+9epXcjuzzU+lH9gdRZEoUlBTrtrpoTXjuSkhqew1ytK1rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=btnl4tWl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=btnl4tWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJF9M1JRRz3c3w
	for <linux-aspeed@lists.ozlabs.org>; Fri,  5 Sep 2025 21:53:26 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3e1a31c692bso33802f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Sep 2025 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073201; x=1757678001; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibSd1EIrnlf1T65R99x8NmkSqz8ymnGekDTIZaoFiU0=;
        b=btnl4tWljHmsSxdFvl0Qy/bvdnCZsVuJIzLqQ2KaJ0PjSzz8SyszyQ6rxWt4Jf6o3j
         S8RQrpHNizlgSMyqi3tfHyIaZWQN17NkN/zVCwYQr8sX5ZlZ3E82EPxBtfjqUZ+WUGMB
         axWH5iAMkpqJdG2tUjEUBTJxr21pazEmWa2boBVtM4GAPsxgJar8M/mJUCGYgxco2h3p
         x0J6L1PIhW3AOW2bx/HqNl7+kY6qJVYI+yhLy8nFN/hw7pjPgKvETjDVwcWUP9VjGMdn
         oBrK4SOxq/ckmyavF+p5fu6KPsVu7odEBxvvmbe4BO/zdFkuOfSEASs6cXQPrzdXAUzC
         DjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073201; x=1757678001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibSd1EIrnlf1T65R99x8NmkSqz8ymnGekDTIZaoFiU0=;
        b=IOJAOLSEkmX5P3xwAi2qZZ+9ufpD5bEMMhVl4OVWles2HDMjYvZL896VnPUqvTdnHS
         1KUEi54m7IVCsJ1jHoOc7wzfFQ/J+f4HBfeAfkNdWQ6PWdHDmrU+IcqvRWEvj9dSn6Dp
         WCJ03VbmuO2Tdj3AFC8l6uPsnNvQqjz3ox9KEDN75xVRQmbOi70SEQTAQxziEvaUb9Cn
         q7IyQpcLCgyL/sUYogrj+bu8TC9r6BzDGVRLesd+SwHnZV7Oe0tESLeMUX1QdVhvHpyU
         V2OoKFztJ6H8lcOqjQFDQjneUvZrWvVac8Lp4lHRxTjq4XIY1HiUT883kI0UEYNvE5a2
         h41A==
X-Forwarded-Encrypted: i=1; AJvYcCVAilw78cGn6CJHOy7tAla7SinbC3cEbRPlvwGHCIx8KlAw4KyvEHwpoTGb4bxwJlyUzIR3Dp4WWx2YHH4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8K9xg0cTpSh7G235X2JX8Q71yw4oWCM6PR+zgjcWm3Fab3zAJ
	OZpvIEX36qnmHd+0Q0SjAdF2t4/qNkcKS8wOTLuOCoH/M727ZhBqJSi2
X-Gm-Gg: ASbGncv3x0SGm8tYeJ5+seh0J+G5p5DbONK8ZQuW3wjvdSvF1nxW+HNORykqSTsFhEq
	db9UZswycg34hhXAzuFtRQhMp6MKbhYd8P6iiFNDwoEcOP746E7N5Cb5TYvBITEWvE67sPZpQTt
	LB3q3bT7A2ApcuDjpzoyP7qjbtvO74zGKsjBFJZcefJEX9Fl/uN81Kt4sMioHdiSZpCm3L6/ADy
	zk5MxbLQhm3cHYHYkqgqPgYJg/KXaiIjQkQeaq822Hest9NKyYw3Tl38sDOivSv8FkKwPoewGQr
	pkabJSNTd5FYU6ddUgXOcfpPigx1pZ30bdGf+p1QWvZKMYiPVes8SQAq2SZG5/tKwoHAPdckCV/
	fwivByh7E79zcjXGolhjTqeH2aUHCDpK1NbBs/JOKrC/dfdpevPR01lslqNBvxcF32zwAyTSd
X-Google-Smtp-Source: AGHT+IFgyUVRsNnagZ84Pf1RIyYo5EbfYhRyDK79C1hAlhHc/Tz4Dui23mAaHaZv4EihvJszPYZfqQ==
X-Received: by 2002:a05:600c:3110:b0:45c:b659:6fd8 with SMTP id 5b1f17b1804b1-45cb6597198mr40677645e9.3.1757073200933;
        Fri, 05 Sep 2025 04:53:20 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:999e:a0c8:e30c:983a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm1903897f8f.57.2025.09.05.04.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:53:20 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Neal Liu <neal_liu@aspeedtech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Dhananjay Phadke <dphadke@linux.microsoft.com>,
	Johnny Huang <johnny_huang@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: aspeed - Fix dma_unmap_sg() direction
Date: Fri,  5 Sep 2025 13:51:11 +0200
Message-ID: <20250905115112.26309-2-fourier.thomas@gmail.com>
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
bidirectional, req->src is mapped with DMA_TO_DEVICE and req->src is
mapped with DMA_FROM_DEVICE.

Fixes: 62f58b1637b7 ("crypto: aspeed - add HACE crypto driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
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


