Return-Path: <linux-aspeed+bounces-945-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F313FC021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWj4N5cz3brt;
	Wed,  5 Mar 2025 10:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107938;
	cv=none; b=WKNkeXsQ9bfNK0k2OPQeh9YtyCBniQK2K7rmDbPiljpH6sV1Umtzj2RWAmQmfxA3Bf36sCwpHgTew/HJqak3fc8Hnri+1o0xZBCVSu9PcaTiYUnQ1l/rr96wFX9N1tSAHhCcOUaTitEnVOBomTDBJE1LZGIDoT5w0PhOADBiy1eHk6JaqfVi0j16efL7nxGlz4ltzV09uquq+g4WxpAbdITY6aUG0qO2H/ku53W5NZgfiN/0pXIcAK7wT/z3vKAsH0TybdFkIZX4Q3VnvNEsiPNXguTPYlNMBTzyNttiLRpWaxtLOEMnPpl9EANa+/5hekt/c5Q+pxk3ra3KjennDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107938; c=relaxed/relaxed;
	bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y170rgLNBUcNhXBeuulcMQUvcG7Pf4IqSL52vhpJnzSLNoaoIRbh5LViih8hZgA+zcY5+rQjayJfsB7Pi6fDLNJ7jdToFBd/m5RoBcd+ecXJXErERMPujb8TfwevXpeMx6e74lnW9YAT3d6qVIpvuXHXBbNvxFHFJT9KIm+endJqEK1k+1aIr/PUUNgu4ZZibzNLZG11hClar4LmH7k1rYCuaMLxZcy9H4XPbfy5HBM32LFreUmgTQiCodN81+fzCRULfTYN4hSizIVl1hCCjPpJVNHu1IiD3R4A5Q8I6ASM/u6fyEKJl0h3CNKNef1EOSiyQ92QGD49nIzRWyZhgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y04EOChi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y04EOChi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrx1dnLz3bpm
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:37 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so10385456a12.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107934; x=1741712734; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=Y04EOChiTk9JCyXvhLLE7SUkmsAm+/3R3T+EJxRHDBOSO7sv9txqNBOyVvArvRpwd3
         2cRjfF7kTah8ZSrZpqwweIdnD/Ja/DZhDdGgAbpfzQym8ItLsynnR8eQNuBRMY8VD7Ph
         odM9mK7dOdJfmR4shMlxbrITkXzumlGCkDs16a0Aq2C8TDqPNYH+BpsNJVBNga+fEH/2
         GzuVJ0RczN5qg0iaiJXE20ydf9XfqMlv34s3anrmBm+X/nHjARAS1uCghagKtlAZyZWa
         BpsS4yhJaCRQAjA2x8G0JH/Cho2B586q0HKarcv0VrnvfVE4j4Bofy88mdB7uiWu/r9w
         XMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107934; x=1741712734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=AoSUSTjFRaaWfYKPAnggeXDoqlIQOAdGXu8chiiZt2AmkhssgqNwph3LXCvwF1v1X2
         JuRwK5MOAzUbiwX1YLqNCp7RrW91hBDmoaHU8QgB6k/PEivj/h/QoIqKK4/ZoriZ+d9M
         BqNlmftoHOQ6LHeovLGl/ubiowZ60bYCsjZsoSrudwikZR51oZRa+UemwDH4j/Uq2lcy
         Myvr7QrRlf3bkmOKo5WgnKCtRuk+T/NXUaS3Qs1368JTv+CrSsXeaSE5syXTnMoEZwra
         MNZyYML47FlFew0C9pctwelpV+nW6p90icw8zkU4XbOyGT7Gg9DmrH2NZxfTIv7t4SGq
         fWkw==
X-Forwarded-Encrypted: i=1; AJvYcCV9kwhgLQtdkoFAkzqf5OT676YVOgpW0XyhHvGL3ArPCMsg5dQrEEBlQnVEY1LxnxexiZ3DN6CvPuAJPUo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxwAFqhIh5BExsjKWtBJtxGHHSYfkNUL+5OEuEZbp/u3UkYW8Db
	xrnrmgf4XDKqhvgfCbmIt6jhfgsnVVF9NKoGxCm+9DWVv9oDDfBINBi1b0JgLbk=
X-Gm-Gg: ASbGnctNC4WyVGMfqGDFdJrACWpg/6Bxhs4fNxWNucdyrxVNEoKbqebkHA4whqhVPtR
	AcR0iLcQphPDRhqPvlRbDIMG4sCatpeNqTnyc+TdsZ5/MxVH+nzK77q7Z5e3QxPZsy/eJd+FoJW
	IDJa+Yzs/oVXVunM1iC62hGTQCtOtLovyjZjK8+FxGH1dgqp7ZAYp1IgDm6XKD9fQZMrXgjtOPB
	9neUELz2SdxVH3O8+TfBZ/YeWLax9cpGHzswGspwzaPjaJi+9g0/u8jRM+FLOrz9kf+8L4C7qxr
	VSmruWN+Gf+mnyfNMr2A/jWNmoXURQFoNhdhWPCcoaNHR35Ihnl8kCvEDlJHZOn4uqUr9tW9um0
	pqoqbgqMC4oSoNw+DUcQpW7+6yPub
X-Google-Smtp-Source: AGHT+IH7IWkH6sGgCqXOqo1X+qUMKDFtMNOejwKoQaGxlKvxwXw1Icl3WBZaF1ebexseFdyLVEv5Qg==
X-Received: by 2002:a05:6402:847:b0:5e4:cd5c:50f6 with SMTP id 4fb4d7f45d1cf-5e4d6afaf1dmr21403911a12.18.1741107933866;
        Tue, 04 Mar 2025 09:05:33 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:33 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:32 +0000
Subject: [PATCH v2 04/16] rtc: ds2404: drop needless struct ds2404::rtc
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
Message-Id: <20250304-rtc-cleanups-v2-4-d4689a71668c@linaro.org>
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
 drivers/rtc/rtc-ds2404.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 3231fd9f61da49bdaf00e46486fc34836094ee78..217694eca36c3432a8db3b874374e347eeb802d9 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -31,7 +31,6 @@ struct ds2404 {
 	struct gpio_desc *rst_gpiod;
 	struct gpio_desc *clk_gpiod;
 	struct gpio_desc *dq_gpiod;
-	struct rtc_device *rtc;
 };
 
 static int ds2404_gpio_map(struct ds2404 *chip, struct platform_device *pdev)
@@ -182,6 +181,7 @@ static const struct rtc_class_ops ds2404_rtc_ops = {
 static int rtc_probe(struct platform_device *pdev)
 {
 	struct ds2404 *chip;
+	struct rtc_device *rtc;
 	int retval = -EBUSY;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(struct ds2404), GFP_KERNEL);
@@ -190,9 +190,9 @@ static int rtc_probe(struct platform_device *pdev)
 
 	chip->dev = &pdev->dev;
 
-	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(chip->rtc))
-		return PTR_ERR(chip->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	retval = ds2404_gpio_map(chip, pdev);
 	if (retval)
@@ -200,10 +200,10 @@ static int rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	chip->rtc->ops = &ds2404_rtc_ops;
-	chip->rtc->range_max = U32_MAX;
+	rtc->ops = &ds2404_rtc_ops;
+	rtc->range_max = U32_MAX;
 
-	retval = devm_rtc_register_device(chip->rtc);
+	retval = devm_rtc_register_device(rtc);
 	if (retval)
 		return retval;
 

-- 
2.48.1.711.g2feabab25a-goog


