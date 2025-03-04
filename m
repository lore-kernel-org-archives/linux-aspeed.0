Return-Path: <linux-aspeed+bounces-955-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76110C282D3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWv2Qvzz3c2b;
	Wed,  5 Mar 2025 10:36:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107941;
	cv=none; b=Cs6mVaiqbFqxumN3W0ZAV6pdjFJ8zzwCva82Fbl0i3luS72qfH+TRGbsI/t8XDuTNRZEB6QdtpgXgAyuLnMvtmk4M32PNhDPkyCLUGNYFbXndaex0HajmkpCBXyUK0TNQMwDKHcxL0+t3oB+q25uy7/8/iCpgqoNH0rWi9BvprjiaJ9a6nJKDgV+KYatQW6z1SjsG5FZgSRoE9Tso78esglhvCk9ZgSYoPl6dywaMR/buCQKLTfcKPiTzsy7p2YSQrkuAEDi/9cCNeoLrlEzANIh2EiTdtvAIgNksAPwQ46PSxj56BSzgZ9Ii3gHWx34+KtC03YzmEM36o0VIaTsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107941; c=relaxed/relaxed;
	bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hE0Chub2jkaWeJAyP7UbjHf9uPkLjnbYFPXmYTTrcU3pHu67wgDz5Zxv5ebCCHWmvaDNECZ9eTEV6h7AwwNxiEG9q8QIPhnWTVfrLHtqhasH5og7G2pBkHFZ7If666GKjsuB+cm7zF0OzZPsuxXUEpObF0d71+sDbL8kv4v4mMXm71FFKubOdozBAXIVf3fA9NywZYE7zQx4ImDfjlvG9g0T1aTzYY8BFLmFlThjCWOXkQG78DgWYl3S2NI/M/8WziyDHGFbiPWrfo1cHz716zq8m5o5uRFBetr8AuM8o9kKj9D2vB6lgfkPzZSnNHgJZ2tfTsl+VSddWMjEqTtrRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X5SjYKDz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X5SjYKDz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs024r5z3brH
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:39 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-abf4b376f2fso584950366b.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107937; x=1741712737; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
        b=X5SjYKDzZfVHzpEHlUfPnC0s/OmmDGTpk503yfsYtCZWn7+TvITtnr4m0V83y01CeV
         SuUGlFdLYKZ28bf/pQwINB5MquhskeKM/N+vB3HAj2+jaoZCMHSusDbf8Y1iVRAFLCQb
         d3ofbw1tCG74FSf853+p268x32GAWFcMF2ARjkfMNP99JYCclErsnhKvFNBRehs5XWwK
         rfPEtjD2keSjDfoVD2OpqgKdQZZLh5W07ybu+CZRcXG/XrOKF1SPMJKCSH/Sz2+jWXNE
         juP62gKDPmXwJ30l1+HAqLJ2QK7n9AKLhby27hRqPbALpkSIGHMz95w+C/SadRQGagn1
         6cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107937; x=1741712737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
        b=PEHXW1iUkIk45uRsxAfWi5Dq9l7i+NvLUoTdn/NjNQyktUWx23HEkn++hbCb3H6ttM
         ZwvPNRnUN207X0cskouIl2GPclrOt4wjctT1855JSYMIkxoopQjcS0K5Fa1oUI1bgRkb
         oeyoWsyrkTT4/xjOUC7UwVib0pYY/E3uMnOdlN07HXpjTUSGYkAq0JgRTtCRC8o95+ji
         rjunpBpbIcc4NVhDUCVv1IvWcZ5qWEBzt3BMPFKA/PzJ6SFUtB25odwYFJcORdHM/UcJ
         LcxzM9dmUnGfIRROSDZf1BX53sLx7oeK62PZstZYiWNc//gqyB2iw9qjTDJYA+HW8bcc
         4qkg==
X-Forwarded-Encrypted: i=1; AJvYcCX6jdqgxjjgiggeu6Zio9IxeK8rQbKrwb2oDuBrSUqQHV+pmqJR5Quvh/cIGaxxvQJASER4zRT+1/Vfizg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLBj7hwRiAleFEdKZ5NYLxE08Q+8WoMoEr7DB5A8hhP7yRXhB8
	ycipF/sUoPdrraOPD7LOjhZ2wTR/Fol16zqNt7Hm7ms4dBj2faGYieOi9DW/hCc=
X-Gm-Gg: ASbGncsO6XF1J4nWj1UzBFTAaoyg5GKIN3tkqiGST49VsJNlR0j8nTTSiK9ELcVyC+k
	q3PzwlcHfRzQjZg0emYq59G/UVlkEZbv5qPXQCy6AoRaxkr4D+quyoTX0E12puZ+09Yzmq+39gp
	/9l7Rm60JLLdA7LUFqG86+qxhdFhhFdQmMzfObSvMF40A5a7mYLAom+Vpl9sSVH1c9TyLUPJaBQ
	MClu11/2PiDM85zFXZ/LTyhvZ7W36GY9cIz0UrlZMlxVLkoRj/VJ/8o+N0KQM75pp9fPOTv9MR4
	ed15Fi5pDENHuwve2A/fHiJG3hHXp7wzQiS378VNblqIMDXlhCuVgx7dXOjWSGjUo/v6GcnA0yQ
	XFW7/OPZBaFObHovncom79rq1h5nv
X-Google-Smtp-Source: AGHT+IH4UfROsxQRuhFhpuKVUGIkJvl9GfdlUj4CrGm+kiSC0tb2f0MQezXBSz1TfcCGXXToQh+ymA==
X-Received: by 2002:a17:907:7210:b0:abf:778c:58c6 with SMTP id a640c23a62f3a-ac20dab329fmr1852966b.16.1741107936481;
        Tue, 04 Mar 2025 09:05:36 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:36 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:36 +0000
Subject: [PATCH v2 08/16] rtc: meson: drop needless struct meson_rtc::rtc
 member
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
Message-Id: <20250304-rtc-cleanups-v2-8-d4689a71668c@linaro.org>
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
 drivers/rtc/rtc-meson.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index db1d626edca5fbb590f26c1cdd0774d350244a99..47e9ebf58ffc2f2b6c65932f8ec3773a213a62ef 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -59,7 +59,6 @@
 #define MESON_STATIC_DEFAULT    (MESON_STATIC_BIAS_CUR | MESON_STATIC_VOLTAGE)
 
 struct meson_rtc {
-	struct rtc_device	*rtc;		/* rtc device we created */
 	struct device		*dev;		/* device we bound from */
 	struct reset_control	*reset;		/* reset source */
 	struct regulator	*vdd;		/* voltage input */
@@ -292,6 +291,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct meson_rtc *rtc;
+	struct rtc_device *rtc_dev;
 	void __iomem *base;
 	int ret;
 	u32 tm;
@@ -300,16 +300,16 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
-	rtc->rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc))
-		return PTR_ERR(rtc->rtc);
+	rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->dev = dev;
 
-	rtc->rtc->ops = &meson_rtc_ops;
-	rtc->rtc->range_max = U32_MAX;
+	rtc_dev->ops = &meson_rtc_ops;
+	rtc_dev->range_max = U32_MAX;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -365,11 +365,11 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	}
 
 	meson_rtc_nvmem_config.priv = rtc;
-	ret = devm_rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
+	ret = devm_rtc_nvmem_register(rtc_dev, &meson_rtc_nvmem_config);
 	if (ret)
 		goto out_disable_vdd;
 
-	ret = devm_rtc_register_device(rtc->rtc);
+	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
 		goto out_disable_vdd;
 

-- 
2.48.1.711.g2feabab25a-goog


