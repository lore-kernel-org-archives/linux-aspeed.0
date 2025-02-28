Return-Path: <linux-aspeed+bounces-887-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06AEC282D1
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw10YGXz3c6Q;
	Sat,  1 Mar 2025 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751655;
	cv=none; b=kCMoDAJNamOupCj5Crf3AIUWAcVw0bIbmcbLs9FxseUUI+/fdv32/xyAvQroJC1xyjiW4tUockyG0khtKUdVDwNytDmAyuva2XDQC9vXnSW3rPvzElVf+YGLcLqglmMZZp0dAYLF9Hqae41XzrXZNEGa7lUwFlrLlZc7NJB6LR9cXUAFzGFlgGashwCN0kJM5eoJUz6Tift3UWVKfEm3lvdXlIg5YHewCDweMZ8rlWwB5YYkvor6ykDaWSndFPlDkfODPMgNHZ8jZlNc//0vOpfoPw9fIFAPCNcPPZEeIWD3PxpyNQHuCN0+98G9JxNtJODuFGgYkTJOUnt5TKRhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751655; c=relaxed/relaxed;
	bh=/r1ypkbSjtebcdcKcBz70+d9/hPyy6PTiaBKA6Wiwh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isGKnuNFkaZ5IFfwvjz8ag9OI3f67pZzg7plc9JJa3/SppUrn/42hevpaLhNysfYRpCehctztDYJpDFsQkQK77AfMAQIgF9iWmf0S2CV17jGgmw6o2I2Mq3n4VF1Xer8ZSWjzbLAyn+zWxJmXWFNm4VXimNpBZmDy8lUBKc7DhH5zh8ckEhgfWcKI74/YY/FwPiqomSnuq4gfqI5/z9xgBCOjl+BKIffx5psRtSTRHj950FnIUz6ReInexjzGOVWo97fBqI5suUbJDOJz5Aq3UhFBXRpmtdP2/dxTuHQpsr+B9b6u7+WoVzK027H+nzSK3arvwOL1b2Kkx+GIJxZaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aQmH70TA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aQmH70TA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495L2YN5z3c5B
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:34 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3851895a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751651; x=1741356451; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r1ypkbSjtebcdcKcBz70+d9/hPyy6PTiaBKA6Wiwh8=;
        b=aQmH70TAp8W6Hs13FkP4H+SglAJqvvWfSuDL9eSEZql1CEB0ovWl1dDZKvOOuIz6Fm
         76g6R36cvsdo4hyohZUk7tGC3pvirW/2Tqus2s3Vy67W/5CQJJGXvJGFekxh9FwmYLFO
         KKTBAPqIuE8ncgKOuQ+4pxAhtuECqMbrQ7sI5LMYlnuEQy4Uh9aer3NepoyOeDVMzdXX
         VBASyE2saqwz1VBQE4eBpMhO6lKtnTiN/9Y9H/mJFl0TBo32ENjijAdaUzeigr/tjY4c
         WwZBV+j6ub0RKL1qB4vDKJZD7vAUjzhqixQO+xFpSWIPhYWWsJvgLyrwH9jFtYfFKbau
         GQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751651; x=1741356451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r1ypkbSjtebcdcKcBz70+d9/hPyy6PTiaBKA6Wiwh8=;
        b=qaGprsvZ8B0/1EMOf6Kib9ha9dFFgfghSDsPrN/ps/Xh4/mQcJVYJle4DNS9XZhZUf
         aPCodYKH/4vnuxVgPqRb4pX1NAKt8l9bTPSKSmh3y+Hi/YSFp4HngQ37x3l1y1vm4PGS
         ngeNyi/qXIYM2kU/hE+dpop+5b0Nr52TUlaG5k7c2BpBlBheyFRhygm7EZCUE6rk/ZWP
         cObPx9kMXXj9db15BSotieaZYDK9MSaWotJQiGWE9YR9REtazEmHzyWyJbUL3fmQVLm4
         B8YDF89zPaHYHQ0Fcc1MQJOic6J7ginhd5KGhNC+OMdNuhLw91/0uxire1Hq4+X76xn8
         HqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUfAxv1oP+nYTWcAqgjXw6r02mg0OsYx3e3es04JZAw9ytO84txYGk+w5fWCqO90lGvNpe3jAupoXRGuCk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy76nRGl+qnwNT+ATAJGjnn6zztjRgGFQh1C+3I/LEFCdPKnE9q
	c2dKiOi7JMyP4b2XG6g8wchpD7bJUu5xC2IES0we6R+j2EdzBRH7PePNDKTImWA=
X-Gm-Gg: ASbGncv+N6U3GEcaOdEZSIJGQQosaRfJFFV4SavzeC5TmYrlJPwu6JWcK2IJD5RhH4B
	hY3J7qOByNq/a7Prjp8Sm3XhiHoC+Zh5ZN4mIE/Purmpgw10Jc4d7jeAYH8rq0SpZ5jcUEKDtA0
	Hzlkz09TsjHHp4EDJD1dWV/YUxw9BrgB2DEMo7zTCpbpmetlq0COVhVGJOZUgD+atHr8tPLPhiS
	9qAIES+2MFwfnkwuwUnQjClKyxk7zjyqSyfw3oQGY0V1nqoh+L0AyjnGfma9q+GR2PqN2B8qYdz
	lTO6Fu1eepgaP6/YMLWAvwg+Z6lW3Kr5obLJ/3OHHjpMTvWIonR5LwS6uKbaHPYE2dZkbQYMwI3
	W79AwkmEz/g==
X-Google-Smtp-Source: AGHT+IEmNzc9psOsG8S5U8hQjyEGUEZtM5fJSHlUXxz0d+LoEipOpq1K+57NoVXqKGgpzCnWIQsf3g==
X-Received: by 2002:a05:6402:2711:b0:5de:dfd0:9d22 with SMTP id 4fb4d7f45d1cf-5e4d6b6ebf3mr3156214a12.22.1740751650904;
        Fri, 28 Feb 2025 06:07:30 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:30 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:29 +0000
Subject: [PATCH 16/18] rtc: sd3078: drop needless struct sd3078
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
Message-Id: <20250228-rtc-cleanups-v1-16-b44cec078481@linaro.org>
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

This private data struct has one member only, there is no need to
allocate data for it and pass that around via the various callbacks,
just to extract that one member.

Instead, we can just pass that one member and avoid the extra memory
allocation, reducing runtime memory consumption.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-sd3078.c | 55 ++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index ebb4d45ce2409982880affbc7a85d5e7410c8f42..10cc1dcfc7748144f51ef674939506feee1fb471 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -36,10 +36,6 @@
  */
 #define WRITE_PROTECT_EN	0
 
-struct sd3078 {
-	struct regmap		*regmap;
-};
-
 /*
  * In order to prevent arbitrary modification of the time register,
  * when modification of the register,
@@ -48,14 +44,11 @@ struct sd3078 {
  * 2. set WRITE2 bit
  * 3. set WRITE3 bit
  */
-static void sd3078_enable_reg_write(struct sd3078 *sd3078)
+static void sd3078_enable_reg_write(struct regmap *regmap)
 {
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL2,
-			   KEY_WRITE1, KEY_WRITE1);
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
-			   KEY_WRITE2, KEY_WRITE2);
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
-			   KEY_WRITE3, KEY_WRITE3);
+	regmap_update_bits(regmap, SD3078_REG_CTRL2, KEY_WRITE1, KEY_WRITE1);
+	regmap_update_bits(regmap, SD3078_REG_CTRL1, KEY_WRITE2, KEY_WRITE2);
+	regmap_update_bits(regmap, SD3078_REG_CTRL1, KEY_WRITE3, KEY_WRITE3);
 }
 
 #if WRITE_PROTECT_EN
@@ -68,14 +61,11 @@ static void sd3078_enable_reg_write(struct sd3078 *sd3078)
  * 2. clear WRITE3 bit
  * 3. clear WRITE1 bit
  */
-static void sd3078_disable_reg_write(struct sd3078 *sd3078)
+static void sd3078_disable_reg_write(struct regmap *regmap)
 {
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
-			   KEY_WRITE2, 0);
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
-			   KEY_WRITE3, 0);
-	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL2,
-			   KEY_WRITE1, 0);
+	regmap_update_bits(regmap, SD3078_REG_CTRL1, KEY_WRITE2, 0);
+	regmap_update_bits(regmap, SD3078_REG_CTRL1, KEY_WRITE3, 0);
+	regmap_update_bits(regmap, SD3078_REG_CTRL2, KEY_WRITE1, 0);
 }
 #endif
 
@@ -84,11 +74,10 @@ static int sd3078_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned char hour;
 	unsigned char rtc_data[NUM_TIME_REGS] = {0};
 	struct i2c_client *client = to_i2c_client(dev);
-	struct sd3078 *sd3078 = i2c_get_clientdata(client);
+	struct regmap *regmap = i2c_get_clientdata(client);
 	int ret;
 
-	ret = regmap_bulk_read(sd3078->regmap, SD3078_REG_SC, rtc_data,
-			       NUM_TIME_REGS);
+	ret = regmap_bulk_read(regmap, SD3078_REG_SC, rtc_data, NUM_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "reading from RTC failed with err:%d\n", ret);
 		return ret;
@@ -122,7 +111,7 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char rtc_data[NUM_TIME_REGS];
 	struct i2c_client *client = to_i2c_client(dev);
-	struct sd3078 *sd3078 = i2c_get_clientdata(client);
+	struct regmap *regmap = i2c_get_clientdata(client);
 	int ret;
 
 	rtc_data[SD3078_REG_SC] = bin2bcd(tm->tm_sec);
@@ -134,10 +123,10 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_data[SD3078_REG_YR] = bin2bcd(tm->tm_year - 100);
 
 #if WRITE_PROTECT_EN
-	sd3078_enable_reg_write(sd3078);
+	sd3078_enable_reg_write(regmap);
 #endif
 
-	ret = regmap_bulk_write(sd3078->regmap, SD3078_REG_SC, rtc_data,
+	ret = regmap_bulk_write(regmap, SD3078_REG_SC, rtc_data,
 				NUM_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "writing to RTC failed with err:%d\n", ret);
@@ -145,7 +134,7 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 #if WRITE_PROTECT_EN
-	sd3078_disable_reg_write(sd3078);
+	sd3078_disable_reg_write(regmap);
 #endif
 
 	return 0;
@@ -165,23 +154,19 @@ static const struct regmap_config regmap_config = {
 static int sd3078_probe(struct i2c_client *client)
 {
 	int ret;
-	struct sd3078 *sd3078;
+	struct regmap *regmap;
 	struct rtc_device *rtc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	sd3078 = devm_kzalloc(&client->dev, sizeof(*sd3078), GFP_KERNEL);
-	if (!sd3078)
-		return -ENOMEM;
-
-	sd3078->regmap = devm_regmap_init_i2c(client, &regmap_config);
-	if (IS_ERR(sd3078->regmap)) {
+	regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "regmap allocation failed\n");
-		return PTR_ERR(sd3078->regmap);
+		return PTR_ERR(regmap);
 	}
 
-	i2c_set_clientdata(client, sd3078);
+	i2c_set_clientdata(client, regmap);
 
 	rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rtc))
@@ -195,7 +180,7 @@ static int sd3078_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	sd3078_enable_reg_write(sd3078);
+	sd3078_enable_reg_write(regmap);
 
 	return 0;
 }

-- 
2.48.1.711.g2feabab25a-goog


