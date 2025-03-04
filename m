Return-Path: <linux-aspeed+bounces-937-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB390C282D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWf1G7qz3bnJ;
	Wed,  5 Mar 2025 10:36:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107941;
	cv=none; b=nLCbjy/5oaqm570OMZMoEDtTvnuYnWxXkhttnjNpIptPvF28DPI6q34MdzC4qw/vSR2LD8MI7y6Qsl5ujHYOwL1vy3LSVxDm9fUaraqG2A/B8BLn9UpOms794MzFB0pbsWiZ5WlbOrHiy/UVY9fSqjJQKkulzONzw0f+p2oPJzPwFzi+5rTQ2+h87XF381N25/kBdPaXNn3pcIUve8HUb1LVlp0gA2kmudExTigcJFBSCDU9ZzZhZGqs0PJTcu8nJM4wpBmHu0B00LxyZuDrV/z3FR2ceq77A2Q34EJlYKIwn8J2Xc1PbN/ga39qgcIoQaAPA1IAGGm5tslJLsoL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107941; c=relaxed/relaxed;
	bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4n0aFtSbvyrm535bVk/bJyZ3FLyGGGUKa8XKxmMNkun+CJwHsjbg0eBqp84TfiJ3/825wzBoiHVW4XFJ7BoBYOj2LWhOFrzDmrCSVJC1pFOg+NlWaQHD1AG5yuWyOx1zcoQTfcqpZHEUvc7yQweYq1qDBiMIM6kgkHZgn/7/1TLRoIVOzJss3ZOIWXZBbcUsHEkMtPDHUZp6PyV8QKTM/sDN3Pbx26I08mNcHarzMA72UnGol82mReKCK0mdExRN6CdgbEx60Kv8lr+HaaCedGbdkk3IgujVflpe5daB/Ys2VRPUXeWDuZbbmCyevx6wO/vEAZAAhRA0uyf1Qa3yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AoKV2Gyt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AoKV2Gyt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrz4KFSz3bpL
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:38 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso10157462a12.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107936; x=1741712736; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
        b=AoKV2GytEtucRKkPgSGieRDD17wnoiO12hhMlX23aYHMckmj2anuPFm8MrsCqfwNGp
         rHVIWscldSVWXEYnOnpF7hnCCfW62tyjG6nU/O+auk2tld6wCNfvx1tPyRGRlf2v7cIt
         HRtMMJR0E7e1Le7AC75mJjuxzO3sj7bh8SdQwqHd2SpnR+S4zaDeKnXAmxyc+MsxwpQE
         RoMaTFKS7WOMZ4yEQakg1CWxNLx22xUK/ilgHSnC7Nhdwy313coeoSs0EKdQ5gHFbmUv
         UtoCbSogWgG/TpG/rhRPB2IJfMT5e/ntVEoglSpdlA6tdUXLes72bt2Woj9ZcEmYZIXN
         6kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107936; x=1741712736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
        b=wcqkPnTKLdQf0OaOJkjmDNvA9I/9G10LvLGtVlyPyeJL9LYdO9i7Pj6mKdYVdG+S32
         hmLPCOHliGU14mCo48hW9rIwmhyiu7puCC/KuYbD+dQONrxJL9qJzVEGOwABMpjh9gC0
         HqpBn2s3p2Ynh208FUmKmoULpbgXhcuQgaBKXaia7Z0Itx6erphhAocRI5YnjPtw39p1
         JqXsZRjUWStRoYFnruWPyMjlwyMqbimFk1v9wRav3EH/aX65+UnFRY5ML4F2W3Fx3y7U
         SNBGhPSQNC7P6nPXwgsAzd1aWYqDBtfrJUpDoPFoOWcabQUlc0D88aYefELoGELe+MA1
         Tx4w==
X-Forwarded-Encrypted: i=1; AJvYcCVA/aCPgq1BwK3iM/xMOryRRybO+yxBELoMPEbX8qkAos5YycNKLXHEAHPY1zlSOuA0BgmnbxXTjh3ipfM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTaOTdkSbYwdBw7QtdUQl4xUZK4NrnoWBXzhoA/VNruMxiPR/t
	4bfYo145JTfhT0wI7qpsjkYtOkK0y+1pmGKiWe0pztDfUCmCg/7kLKtH/sdP8p0=
X-Gm-Gg: ASbGncsk7sGaPJvOx24T9cuqH7rngieg7Yrx+YJqAwTPArO3XJjh0HKino19pI/SMQz
	STcyZjybMS7IGNr7JcS/ivo3GsA8k+lQyHxMWr3ZsZri0ibvGYOOY/NbX3Zo/mASkQ/tqW6slpP
	Dy4p6e1xyF3qlkc9bFDb9aJp0fT+NQe0MORtzQUif1XkQU8uEhZUbmh8n06KEou1ESXymXnigYy
	jR0O1gI1GA9I4nm6wBEcDKsD8+1WO/jvwnszKJi9FlPpy+ZOffaDv7Bsz14K3+Cw60RhI3EiGPY
	+5R46zC+jskUT01Txx/xa36L3SHFRf76mcykipKAjPzLt31i7qur1SEf+ASFO/dJEKwhoAi6cwD
	lA8HymPUvW30hqr6o4zCEG0aD81c6
X-Google-Smtp-Source: AGHT+IEZSM7e60umftuoTA+5yHKxOw5bEfyTXKI9tFiIm+4qyPCIhcf70tbw/wLp28VjnQQVfyBtmQ==
X-Received: by 2002:a17:907:c2a:b0:abf:6b30:7a94 with SMTP id a640c23a62f3a-abf6b58f60cmr1276559166b.45.1741107935884;
        Tue, 04 Mar 2025 09:05:35 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:35 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:35 +0000
Subject: [PATCH v2 07/16] rtc: m48t86: drop needless struct
 m48t86_rtc_info::rtc member
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-7-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-m48t86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index dd4a62e2d39c73b1c8c3f50a59fd4fffc0b45105..10cd054fe86f9e6be74eb282222b2751dd91cc7e 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -41,7 +41,6 @@
 struct m48t86_rtc_info {
 	void __iomem *index_reg;
 	void __iomem *data_reg;
-	struct rtc_device *rtc;
 };
 
 static unsigned char m48t86_readb(struct device *dev, unsigned long addr)
@@ -219,6 +218,7 @@ static bool m48t86_verify_chip(struct platform_device *pdev)
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t86_rtc_info *info;
+	struct rtc_device *rtc;
 	unsigned char reg;
 	int err;
 	struct nvmem_config m48t86_nvmem_cfg = {
@@ -250,17 +250,17 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(info->rtc))
-		return PTR_ERR(info->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	info->rtc->ops = &m48t86_rtc_ops;
+	rtc->ops = &m48t86_rtc_ops;
 
-	err = devm_rtc_register_device(info->rtc);
+	err = devm_rtc_register_device(rtc);
 	if (err)
 		return err;
 
-	devm_rtc_nvmem_register(info->rtc, &m48t86_nvmem_cfg);
+	devm_rtc_nvmem_register(rtc, &m48t86_nvmem_cfg);
 
 	/* read battery status */
 	reg = m48t86_readb(&pdev->dev, M48T86_D);

-- 
2.48.1.711.g2feabab25a-goog


