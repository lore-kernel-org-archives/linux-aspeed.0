Return-Path: <linux-aspeed+bounces-874-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F54C282D1
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvw30NRz3c2b;
	Sat,  1 Mar 2025 22:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751654;
	cv=none; b=PFajBrACDcYn5SXe/z+gJjSOxlKDwLqkM7/SM+X6vNC+ybGZMMPPdacYcrp0/cHtHNFUBp39Igm0SqOleeQ1nKfeUspZdONZuyh+L25HdwgzBTL4xe10wEOSI1UQdskcONccJN8A4EWKS/HWQAOJyAwyNcTGMXnIxmWEwSoduXw2tJAQZqE1hAVFzj+MAR8ZHe5fXfrTik3Ri9hiPAfgFn87Lrfos+aQtr5rCs6cTmZkFUUCIThNCcXXQiaMQ4H0QEuCg3JWmzrQsfdTS4ckl4EiL6lVhALPmTk0qw3XnmeUQrvwq0VxpykhqLcMBwV2JVSu6VNKiGSFwzvRlps+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751654; c=relaxed/relaxed;
	bh=e0FEi4ElpfP7bsjHYl+IPy7QOEVjafD0mk0qg+EAmzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGfNQtBIJfnN87SXg2FxfE0Reusi81Hor1lqg+OTeGmrO4TMYUeUJDbZmJM4HN/eKuGb3ZoH58rcJNzjj2R1piIm12+FqE08AqA6bzt1xpZ+mOGPLIheJJCdiBqiaAGyMlQf94J/s1l6MsWZzOH4e0wtNBCj2jT6pcQyNfHeEPUnGDFR4QR4Dv2n+EEjc36WPHfgWN94XorYUNjyM6GZtCQPQKV66Qg6k5mxmyVXbrQMLF1slLgZHCJgIJlYuAVzpBlp8XjbnlC4N3QBRJah9Gz7iFOfrCJeAFYOX4K1tEu7cd/SmHBi+8r3KEc6l/MUz3yC02R+nXXY7wEjdyWZpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZO9Hk+MI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZO9Hk+MI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495K3Fttz3bvW
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:32 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso3544847a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751648; x=1741356448; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0FEi4ElpfP7bsjHYl+IPy7QOEVjafD0mk0qg+EAmzU=;
        b=ZO9Hk+MICb8EFI9Opr98AAr4BW/CvFKa3o+kOEvqhW2KanJJXm6nwv35KEagNYqkJ8
         pcD+u8bba2ylp93ygR4NpRVDE0uojLHxBKnpvuj8574Uqn7pTKqt+eUZNt1xPTDd8f/7
         EkyVQcXVkbHEYOQTidYtvBEE5QbQy/y/EtvYLJ7riymUOF82kuXLIyeiasxTQSqASADZ
         8V2yJtDdn77hgFES4SbjaaJEKA6dYjGgfrDtDjFHtg0Oc9uV+14IOO3MNin9bNoD3xjF
         5BqkkgiYDnDQ56S5cy1gZOIvK6LJd8lTO3cqXsRCaL46iYIRXdbIQJcgkezDCoAmVjvJ
         LEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751648; x=1741356448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0FEi4ElpfP7bsjHYl+IPy7QOEVjafD0mk0qg+EAmzU=;
        b=OrbHCgdl5K8gxn9OYwyzXHPLGj5Eq+IznjMf8yxo88JAQ0k2RkjmK/Y1UQu8OIGHr+
         o/xKfLo4MM5pKwzpBWHBCO7qpknYUa5JbgKyWjymhJUCMnLLwSZskXeXFBNWHMomT1Gc
         tsYW1Iou+s08mh6EtTKQ8b12n4dl6Wkp6QrJo41kM9lI8wZIV52sDDJsLpVYc3Uu/JD9
         tPOFXCO9AvzjbtnGgGWH2NvBaK+nYMKqHB70y1XB5k0MybSSQCMN7bEbx73ktAl/lEcb
         l6t2mx9tSxkRqluPXrSN6rzwtCrWTc+BhdaRPM9M/KiGW3k9KEr0IFokJpzdG88AM54W
         ehrw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLSdOJWzbn6MJhzkJlOBwp/QJ0TSWcwbJXTHjiU47QLLD2LWztii/6aF6mNSfAsqDuMYNW41a7eiBOEg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEWyHIEqofhD7Fti8/mHFttO8quVrKwR8Fxb828N2ZhWseLnsR
	HnD2qCuSly3ulvwhgEkuyZTcHWhFNk9xChTU+UMPFPEO0dpA1wSLwYODYYlqV5w=
X-Gm-Gg: ASbGncvC1gW8Qg0zFB1pmKmCtpbhAvt2wwOvNg38dDLSK/6auJauewLMgzJUL+x8Shc
	T+MM8k9beveUxl6f6adPmE+bNxOd5Y3fpUQUfkPGLmZVajOHz0HJSu0PuGEjnR1OYUlhnFFV4id
	K7k2Sis+IW4J6Pxnj45JnRhPwAL3oU9aTcXk7x+kBaAG+NQV61jTctsGkXhR9IdnHBPycPdcRIz
	nS3QcsWCOwxMNN0TwUQUGmC5clgI/Qg91k+ztKhUL39sq7kc00GbTNU5xI/NHhOF+yHcpelJPPC
	4i3QPfuaz9TKphWhP6SN2tOcT46LjkxnjpBe4A/bL+VNmP1mUuqyBvBqkaNVvMeceNjYx24DryQ
	6DWZlxWMK5Q==
X-Google-Smtp-Source: AGHT+IFd5qkPHWKs7u0kGQaxuAKFWYEyb+eqqsQgE6/A1ZcU9oZLI/LHqjeh9PQlI3f0EWIivI7Brw==
X-Received: by 2002:a05:6402:26c2:b0:5db:f423:19c5 with SMTP id 4fb4d7f45d1cf-5e4d6ac4066mr2619097a12.5.1740751647799;
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:23 +0000
Subject: [PATCH 10/18] rtc: pl030: drop needless struct pl030_rtc::rtc
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
Message-Id: <20250228-rtc-cleanups-v1-10-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
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
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 39038c0754ee55a952e5986afe711cffff35840b..e7c81740061bb60c4d8447d6522819685bea9180 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -21,7 +21,6 @@
 #define RTC_CR_MIE	(1 << 0)
 
 struct pl030_rtc {
-	struct rtc_device	*rtc;
 	void __iomem		*base;
 };
 
@@ -86,6 +85,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct pl030_rtc *rtc;
 	int ret;
+	struct rtc_device *rtc_dev;
 
 	ret = amba_request_regions(dev, NULL);
 	if (ret)
@@ -97,14 +97,14 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
-	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	rtc_dev = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
 		goto err_rtc;
 	}
 
-	rtc->rtc->ops = &pl030_ops;
-	rtc->rtc->range_max = U32_MAX;
+	rtc_dev->ops = &pl030_ops;
+	rtc_dev->range_max = U32_MAX;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -121,7 +121,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	ret = devm_rtc_register_device(rtc->rtc);
+	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
 		goto err_reg;
 

-- 
2.48.1.711.g2feabab25a-goog


