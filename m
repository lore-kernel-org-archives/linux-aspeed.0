Return-Path: <linux-aspeed+bounces-877-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF4C021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvy0488z2ywC;
	Sat,  1 Mar 2025 22:01:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751651;
	cv=none; b=Cxu9QJEwjeIHCcSNIcR+/608MBOu/U/xIjHiXRd9hmSnEc6BXLQitWa0ayLe84oSgobpT8W3zIhJieaCLS2Z73ebDkTJ99qevpCBUZ9AwMEe3B2ZRvFWbKR/y/7PC6Ex8PneAG3kN3rJbBF2AY5PIq6gQ+OeHBdjVT3sm/0inAxkRPrnwfZm+/jeejwoPaok/gJXk07I8ZrYYN6AFnvYaIC7tfYA+yASlMFvGoeZI47bHQ5hn+U4t393b0JUWB3AUwX1vuPjYq51Bwyya5g7a5DXYqQ/bWCTSd3Z9zuv8p4EIBh3K+qwcVPBgWkyOFo4lcsLz7LXXh2vb5HH7yzt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751651; c=relaxed/relaxed;
	bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kM5UWsgxhnJ0qypJTByZyPxSiigPUxEdJmkBWAzd+byEETnvToZ/wj3S2L7u4HEEwV8QKafTN0ggh//6QpvWTqd74sCSSzzYvv5jeGbvdXl5xTyDSbohKw1mfJStFYdJUGW5LZYdriA/fzDWeHcnxOP1FovTr3STEg5jRS84DeNfK3bN0R4PycrTYXUtc+hEpBvg8eS1KWGqN8QrW3eKDHMES4TQ2F7/prrPIChqWueM/MkC0LGott4GllQI2UK5yoUDbS8k1cUbybOSgW+Az0PNddgL9XAxZUTmRE56jaC6YXV8BTlSZs4oMHoNDt5qSp5feYeOI/spPEvMSe04Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=onZNBFJw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=onZNBFJw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495G0wmhz3bvW
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:29 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so3595795a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751646; x=1741356446; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
        b=onZNBFJwy8fz402hj13+Ie/lzml76/h6UMsfmeK5EzuyneCtwm/q0scMj9bWHaL6vb
         F+TQd85GkxtRWhlV0H+cEJ9SBLrP7sAxuC9TBWkwFRliD2IDd/yQuOrjhL4T0vrNZR4G
         U5I/wdwllsPcadopm6HehU9TLqXKYU1CdzpoMDXIarG8rvuce5cs5LjWtuCbDTPvC+Hj
         yx5wV+s/Gl4nx+bVRmcu6UpF3voeZxa27bkCbAZ+srJjnOtwME+zOnz7IWoxnTKdR49C
         kwTniTFEu9ogsFKyHcI3v4LQcusQAXyhGi5tQ2lSoYa6WRDdr5akKCCrfDOuWSI8OXoA
         jDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751646; x=1741356446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgG/ZB1ufhyJ5LLnH+TbRO+Ff9QR7sb5p8sH4cYGYcE=;
        b=VOPazQfxVlDpZOe5qupsEcNeBhPIGHbtWBi6vLJAHEb41WXEwURxV0ZqkH9Ipw53J/
         OhSxw3CiRdFeK+ztm3guTVXYp4U0keQLv6WG5LlxOYsT6XIsIqgrJMgzf6PDrHVS5ZLK
         NMi8N1EYUXDFf6jXv3yrmt+dIF6+I2Qckmivg4eRq6V1+jNDX2OL5eZrD83+LCXoHULH
         3vmNR9j/mzFfo23JIlSX0AW/7G16hmaMukNgBzYTXxlaoc8jnBldAHfFehEtIWoF9cgE
         NxTrCfrDIq+p49QGX8ngt5UHgXbv3ZR1twx+8pETFZAyDFcXn/9NhxXW7rKTj4lgjOXL
         30tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdiKX2Wb+niUmViH8rKevq9YvCHb6t9ZQ+h0/GVU6fLL25KQ1yVKCsQHtwYwK9ZJiq+/qS3JnDcQ0aklg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvkmTW1K/QR1U5WziK6GdBx57wIkHkM/OHnDK/zWgrqRXYqnfx
	P8WJXOVJJf4y2MpW76ex5CooTwRotekDrCIwDeqq6i5pJamETgb8nFpBzslqF5w=
X-Gm-Gg: ASbGncuKo+hBvZpi9Lr1IqN8HZx17GRHz140RErD1SKVNnZMbJWG+frTsjKSJ5c0RgZ
	sXtwoFuUOjZ8iTo+uC1bhJwb0w7zlpt5dPYo+9SN2JQnGwT3wuvcVt0LoNlxEUTviWa87pBa7Go
	9iKizmgFVuQfPHyOxFf1JBWR2gXkm4kXsJNy3SqAU03qqelSJALkfS0PtgpXIdSzlKXbIzzGNsN
	xwXT8bzJZLRKBM0x3RzzDIMEX57xz8F4CUUJYbe+H1ZdFdCBi+3QMrmQJGXYDU++gatpBNNca1k
	iZXDxSGY+kE8VXyGuYIHH46GHibDKfmqAXiMbnBqgpiTaoDsAVZxEsoYyokPREeQrR2YTQNtf+J
	0vskymBJT3w==
X-Google-Smtp-Source: AGHT+IGw8/Em8B8f2s0ytjmI+eWh2dyA3vFh7dmQ8lnXofAka3id8ECQEXS4gzzEIESeh9rUlyHc/w==
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr2881207a12.12.1740751646341;
        Fri, 28 Feb 2025 06:07:26 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:25 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:20 +0000
Subject: [PATCH 07/18] rtc: m48t86: drop needless struct
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
Message-Id: <20250228-rtc-cleanups-v1-7-b44cec078481@linaro.org>
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


