Return-Path: <linux-aspeed+bounces-880-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9240BC282C6
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvz3pLcz3c5s;
	Sat,  1 Mar 2025 22:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751650;
	cv=none; b=PB2tEXe86G0sxpTqdbfBQ42JNCDn+5z6gdRY8VqfcUwggBvQ4qQ5cKCqBF/5AfSnjOBLxCPUxZaGgXBwyXiKCRTpGOdw4Jx2nX71YWtoryJBFhsWDmFnEuLEEQtxEkhfTBD+lo+vOJQWlhzTzmONSHXuiD0j0VuFuaiIpISixuvS2OxTWUlhBxq7g7xsmXLUCjmfW5e7uRgQgxnHS9ukeWpkfdsvA1icuNs17iGpCwfYHjn/8PwqSFs5Ev8iRGvUKaRqYzR9e3rl247jVuu8ntGeyruu2fU3UGdy1r6jUEAR4fBC/6Oyqg54wK2Aeq0dharsVph6mEEdoruoUwdPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751650; c=relaxed/relaxed;
	bh=PxV5ubkQILRDTTOOiWiVBaTKuCWcjZ1klG/odToLNLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzfRTvYDDsnAJNb9UllYsWjkAM3P8IjrwjeH6Ai8k2jX8qZa+aSMjDHZZw3kKqjt21i+Zfl52cLFtBYCyHmRbpAc9liYtQfckHc1dREMGXiX1S/k6nj9mUzM/pn9MRHA6iBl9lh57K9xu899De7mY3yzu6mTKwPB048pJHogabwOKA07/DjA+aibA05PToZwrOO3Zdw7u9NPikfeyXp93/Ca1vE1Yfkhmk7xTDNapav7xUvI1SVdbMA5SGl0pOb6S2TdeK2A4qni+6msl7hU0deCCczsWvV1UfvRIUGsIwJvJcAoZilLoRNVBDuzKpPCIKX2cn9R1UK7CTIe76TDNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YUy144C3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YUy144C3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495C6mN2z3btt
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:26 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-abf3cf3d142so63638566b.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751643; x=1741356443; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxV5ubkQILRDTTOOiWiVBaTKuCWcjZ1klG/odToLNLU=;
        b=YUy144C3LrfXAO03Eyj7OCe9NnZw1swkeEd7mPhpR3BeyKA+i6NJIGxzMuU538nsRj
         EvJktJUeK2N1K1BTUjXkFpdK73bpfNfXoOOqAUKZ8hK7qEwd2kJZU79euoSuVONGyB7S
         G/gmYXCK6lFohETtjZYmDwrkxCEgPlkcU0kPCNNXXbeIgSsFw/KbiNux6Wz7/bznLQtN
         44WwaGtcr2zAVo0B6ursl6vwqGRHZov67ofF+aBYLfKrkQK0CQBLOf3sJc52tBxDWZFr
         Wa/HHK65J6Y2HgYt2V6BEo23BYQMBgvLlBDaSiySyab+Mh2QmW7ICHtUAkSsDS3YdNrX
         XsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751643; x=1741356443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxV5ubkQILRDTTOOiWiVBaTKuCWcjZ1klG/odToLNLU=;
        b=vTS0UIcFKsKxkuPqWA+fC2x4kX12YM5CviOTHFBTD1Fn8n0qAmaUUJBCQ1L+nEc5fG
         UW+QWte4P4DWe1IRf4e2lxNu+cwER7Sxa7P0q3tyn//oUX1g4QTgD70SJuoV5QVQYJPm
         TWf6yApvtYaHTdSxfq5/4wA1jMIvT/ub2kUyMXv51/biJ+VtNugQH4exOBBL8mZoBEyf
         saID8wNpxRCgYBKoU6BUYCYsrB2Uwu57TOxXHLF0cJS70SljTPlxWSOs3BCD1fIGeIX1
         zkxA7cx8qSEMC5SiEUbB+etmTl1AsSFm9voIEIWdDxZjsmbeaWmoaFSRGO+VKnZO9wPO
         Y9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Dz2p0P1S2yMVzwSaXn8YbhS3yKnq1qQ5uWFJio7PSuovotm+vjpY1+QfB5yLun7y0S0SjTdYWF666jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylsBmt0W1v2rKq2H8v0lOwL4jSCoCAVnYx7pMWHEq3OsdFWTjP
	uhW0Z3YeB3mk8TxwvPZLc67hW34SjGzCpYr5xh/AYWRVecFU/dg9W7+P3Vry8Mc=
X-Gm-Gg: ASbGnctOxsZtv5cxaCxwvSrfr++4KRaY1HjEGAkYEPIhW+tydJC+I0UG6YNSz6q+HwC
	F7H4IUcO/Nl+44/bFGeKYGXEucOk3VlwgOPbiPNlKosw3f/BD5TBCmqJBpSBs9KaaGZKRcix7SP
	13ohjFz6Tyg6ZnHXfsGNBz5ja41mMkQe/nWn1mAsTb7m0yu1GMdEWPM036h0dYPsv0I/PvvrHmB
	8XM4zVX6hxeDEg+KUhA8lDglRP/2hFiZEEltx3f2ZSt+ZmXpXzZdTywPCvkOgF7snJdDsnWF8CO
	VsEsXb+Na5UWTGrRGwYarYTEbpl1lwzmHZQ8D0FDP4af9oV1GheZkOFxLteFeuS+RM2zdJ7hqBa
	Kp8vrDS9LVw==
X-Google-Smtp-Source: AGHT+IFUL7DUuq/VqTU9dmynPShF+8aK2RXF+k+UR0pl4bWqZxWvS8VoSsjq66EWlcydyD7uTG7tww==
X-Received: by 2002:a05:6402:1d4d:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5e4d6af436amr7325207a12.16.1740751642551;
        Fri, 28 Feb 2025 06:07:22 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:21 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:14 +0000
Subject: [PATCH 01/18] rtc: max77686: drop needless struct
 max77686_rtc_info::rtc member
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
Message-Id: <20250228-rtc-cleanups-v1-1-b44cec078481@linaro.org>
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

When this driver was converted to using the devres managed i2c device
in commit 59a7f24fceb3 ("rtc: max77686: convert to
devm_i2c_new_dummy_device()"), struct max77686_rtc_info::rtc became
essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-max77686.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7bb044d2ac25aeaaf2404b47b7e7bd485ae3d39e..6b0d02b44c8097453f704cbec9f02580fb869ca3 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -85,7 +85,6 @@ struct max77686_rtc_driver_data {
 
 struct max77686_rtc_info {
 	struct device		*dev;
-	struct i2c_client	*rtc;
 	struct rtc_device	*rtc_dev;
 	struct mutex		lock;
 
@@ -691,6 +690,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
 	struct i2c_client *parent_i2c = to_i2c_client(parent);
+	struct i2c_client *client;
 	int ret;
 
 	if (info->drv_data->rtc_irq_from_platform) {
@@ -714,14 +714,14 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					      info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(info->rtc)) {
+	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
+					   info->drv_data->rtc_i2c_addr);
+	if (IS_ERR(client)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(info->rtc);
+		return PTR_ERR(client);
 	}
 
-	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
+	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
 	if (IS_ERR(info->rtc_regmap)) {
 		ret = PTR_ERR(info->rtc_regmap);

-- 
2.48.1.711.g2feabab25a-goog


