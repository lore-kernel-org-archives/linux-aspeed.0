Return-Path: <linux-aspeed+bounces-890-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D638C282D5
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw166f3z3c5B;
	Sat,  1 Mar 2025 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751656;
	cv=none; b=UJPiwlgVgui/0Axo2y7St4GLHD2/dNJX0CSsVlQNa/UhuCrSKyNNhfUSp/l4YLcxD9NkhRonzncTqO2wv+uXJQhZ9VFfnYkp5V9KnyQ9AYv9582pfosk8plfa4jL80SY9tDBnChoR0+dqpL2Qf0dypmtmVx/88o1GAjlSOoCNSZF1zJi8AQBZ848oFkxVh3fy0pCeOiLpGSXbJ5Cdh0fdaqsoJs9XcsKTt4+NwjLhoas26FF8ewawBcbCSnDyHBO7X08G+BdQKqZ74RLTSvaq6GZscYXXk3oYc3bOVzOIVaCQ9DU3jyh/N4sAMcHqf6jO8mCQlT16AuRAtEXZ2+1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751656; c=relaxed/relaxed;
	bh=J1wrjOZ25AMEbbC5RG2Bl34Xp7n5uiu5eMlW7fz5kxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnBCU+3mafPaLwSMbRMPcMRTf3zJHMA4pffTBOlhLYIpL3ACPxrs12nkLSWDidFvAvqT/N0xBQDzRIynkHKpIpYwzGT6h5o9/6/zVhAHDqru7A2qi65t+0EaA016fV3GGnSdabWfQyIsQ59PiYfQ1L3E3iTlOKoe0lneyJJNpEBOWddmjMPkWoaQIaYFlgQmcWx7Y5JnxTIhef57slRCY+Vn5yUbNpUdEhA7owg2S13X+RhFmIhf+YIFCo+aAynZ7Z5adkOMhU72pddcta+wJ9XlXwe2V/nl9gsU7dax8tzuN9dfWbF8G+zD1uRGtzVDcZoA/+z4tPY+MxAlX596gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DyptJZpP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DyptJZpP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495L5Nwfz3c66
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:34 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3851940a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751652; x=1741356452; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1wrjOZ25AMEbbC5RG2Bl34Xp7n5uiu5eMlW7fz5kxo=;
        b=DyptJZpPV04tPPnJ4pt4W2SDSDthegvxKbUaJgJHcI1K8mGPGgyUSibdGOWxyeN59E
         ymaaa7v2RLNPMfAXFEKpVKi2ORe5z99OeOaNRs35g+wmIqO6n0bO1dhPSpbAyjfv4mJG
         /b9lR0AcENXnsBs/UUlk4u+/HdIJJu/+SoIwUHkys3HK2ee+A/+3TAMFIkFtOA/U1f52
         Cvf8mX863WRlM+6UhmOdqbj7X/+t0XK4O09q7HYn+KfkA/HFxzoIVdhO3doMgmZqCbMw
         qjSqpo0wyOQX/NTvTyD82aljLfuSG3rKZ14I4FI0z1Y/ZMqiSr+Kz4KYOPaJSqezVgI+
         TrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751652; x=1741356452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1wrjOZ25AMEbbC5RG2Bl34Xp7n5uiu5eMlW7fz5kxo=;
        b=Ew3N5Sk7HoXCeXwotM5m0ZS8L4hTMeu6p4muaKJUTrlMdgV3lZgN9QdcWrENuiLpE5
         qKX5pBFPpx2xcWq3bl/9VPXD6D9eVGtOPYYMdhYHWHQSB4xjyg5jjyaDAnqt/uCPpkrm
         qZndGIrTeAq9zJjUfn6PfSOhYBUlyWcsTZHFT7BLIPRL6ZSlRUrE4yH4OFb/sKPJDzQG
         FIJXirZ6wfz1+6MHvQKx40MNnwnPoioawsOCMT9LzM1QPShcd0FyI3ffqTTxkoTp5/Cp
         3tU1joblPJtp8s0WXwtmJl+su6f62rYNdQy33bQegwaUHSGqrP8q7bMA6Q3HBVZFPk8k
         bNxg==
X-Forwarded-Encrypted: i=1; AJvYcCVhMSGSocfOvQYcfTmODXJjCSDMR0u0klT6r8MT6b2aI7bwkK3/FaVnmONCjMS33spIgEJMXXko9N5N3gE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv1NSoOUkNrSb9uADI5p0Y2dviTv8WkXjwXCVOak+2UzsB6qDb
	6jDf5jzIcFI4IGaOXZ6tmo5wHgPVM1fSlr1hb1did+2WVJuVpXhOBVtHY5DfGEk=
X-Gm-Gg: ASbGncuRF5dfumDD0jtVjG1o9UlRW9aL3G4NcrfFuyQESX9c1P0gZx8Qlw/+yWkrY0u
	8L7zKAObkTI73jK51Q1vw1xtMbtMtsrbXXpm62qZVf93t3M72dU19fo8p1sThMV/aOMIHcxv68e
	5jbPSKp6hJTYM/7If/1YCVimpNCO04QyQxctBEXsybux7/XGCIybqDgOyIMitKMp9KLtubplYzz
	O6vzYslp9Elvu1UpAKsJJzyZkvI4/JCb1f+PYHr3FGDkePdrlSKYzpx2AWg2iPQAGaUIwfKjJLW
	1ipzqMkmNAoCUMckv/YwQ7W+GV3sgk7WCxuV7Vz+VBxgYtBUgF1N+dXXz1bcg+VTOh3GXklF271
	HDyEUj9sbjA==
X-Google-Smtp-Source: AGHT+IH8oBqlrNujitdioxAVXjdPgLAryRZxpXTnrztyLFYptlh+GD/CB4rbFiDA0RhEFxZK1lBu3A==
X-Received: by 2002:a05:6402:35c6:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5e4d6ad4a6amr2900190a12.3.1740751651952;
        Fri, 28 Feb 2025 06:07:31 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:31 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:30 +0000
Subject: [PATCH 17/18] rtc: max77686: use dev_err_probe() where appropriate
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
Message-Id: <20250228-rtc-cleanups-v1-17-b44cec078481@linaro.org>
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

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-max77686.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 6b0d02b44c8097453f704cbec9f02580fb869ca3..69ea3ce75b5a5426d4a56b979773be71c4ee7562 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -704,10 +704,9 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 	}
 
 	info->regmap = dev_get_regmap(parent, NULL);
-	if (!info->regmap) {
-		dev_err(info->dev, "Failed to get rtc regmap\n");
-		return -ENODEV;
-	}
+	if (!info->regmap)
+		return dev_err_probe(info->dev, -ENODEV,
+				     "Failed to get rtc regmap\n");
 
 	if (info->drv_data->rtc_i2c_addr == MAX77686_INVALID_I2C_ADDR) {
 		info->rtc_regmap = info->regmap;
@@ -716,28 +715,24 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 
 	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
 					   info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(client)) {
-		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(client);
-	}
+	if (IS_ERR(client))
+		return dev_err_probe(info->dev, PTR_ERR(client),
+				     "Failed to allocate I2C device for RTC\n");
 
 	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
-	if (IS_ERR(info->rtc_regmap)) {
-		ret = PTR_ERR(info->rtc_regmap);
-		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->rtc_regmap))
+		return dev_err_probe(info->dev, PTR_ERR(info->rtc_regmap),
+				     "Failed to allocate RTC regmap\n");
 
 add_rtc_irq:
 	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
 				  IRQF_ONESHOT | IRQF_SHARED,
 				  0, info->drv_data->rtc_irq_chip,
 				  &info->rtc_irq_data);
-	if (ret < 0) {
-		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(info->dev, ret,
+				     "Failed to add RTC irq chip\n");
 
 	return 0;
 }

-- 
2.48.1.711.g2feabab25a-goog


