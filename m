Return-Path: <linux-aspeed+bounces-939-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39032C021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWg4r12z30Sw;
	Wed,  5 Mar 2025 10:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107944;
	cv=none; b=E2nW7OC+6hdGM6039zrY9zh9muW95SAP+gsB8wxWvc2cH2Omw5SCrsMmmbxXqphOuMqiiL9qw0LIR7/Mc5Y4b2dzUmsnhAi2TnI1gc8Kpm4YeLBHLoK9LqMjZm0ubxbdvpraoOIauOCzPyqmAJF32t2XLrLQcIUw8Pjx/WYNXtchuLm7XLqE7X4H+gH2zQHp2ykvht+s3O5mWz6jR2W08EcD7NQiJFJ2D32UJvrG/Gn/wJORg18e86pUj4XhFyX1a2/nKrAgTpFLb37MS0YlSp/UVhFey4OsPJcWpFaNt4sC2LM3CRVzaQFUeaG2tdB4abzM2vy7QaYxD5MxnNMqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107944; c=relaxed/relaxed;
	bh=jDySvxIgslRZrTqVd7bcfGaor7CHMjwsKayUWf5uR70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLj2noUYPEwAFaXt8WBhmlsUb8q2xmPHi767327b/37X1+n0QILpYPDT4A0OwyAngQ1DGnnLf79gRfZWi2TXg/cXiWEHma/zO2lKBHJwS+IhQyKl16V50q/eCaXVohBQsHzQFNdC+5NfWrHgiJ0Mbk4KVqOAL7b4CYpffAIa8l7i/DN6u/iRQIdkziG9LW/MiGm8V2SgbZV8eUBoFPiksEFJwNjH4R5/PPsJltFNjnQs51RO/l/bXy0A11oeAGvzhH4vSTbubxBh6zqe1+eRkSNTkB0Z/e3sGgxZzb8vm8FeXjh+YMG+pcIroq9Ihd86iiZMB5joGiBvgjWYDBbJWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LQNlPhFB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LQNlPhFB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs35Tnbz3bpx
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:43 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-abf3cf3d142so522600966b.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107941; x=1741712741; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDySvxIgslRZrTqVd7bcfGaor7CHMjwsKayUWf5uR70=;
        b=LQNlPhFBG31/B73os3FJSxRdsxzj1jUdROi6Ql01zD9XF55htAD1ZdJFbTT6nizLfN
         8WCqA254eHzsE9ZHtbVMaQBJb3ZcqBktLUdbLPou54K9rhrsYAJgh/78AKfMA50F2Tw/
         x7DgT6Xzd2oYMEgTT38QMnhC7wcVNc03GmOAArFz2FhEEEOddOaMhVSamfjPZeuaQA/x
         jWP713cPbd9jOw88pjZYsL6Kg1bC7JHlG2D/f1F8SS2GImdvJSg4/din2pomYWnXp0eF
         tJ2ZORXMhtkZAH6fnapEkgYUmBCpjCZeXBH3k2SK0bnu+9zH2sZMWn0XfvjQJOpPJ1FM
         chSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107941; x=1741712741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDySvxIgslRZrTqVd7bcfGaor7CHMjwsKayUWf5uR70=;
        b=BUwdR6DguL/1ERPMCkLfuMZft7ldb3ALM+O1D+SxLOGch5LaOK1+XLHW0OHtj74us+
         ATQUykgdqFFBup+bw0HUx7tyqHIVgWa57j58Sf0I2UX9LEZaZXYUIFGvDehGtC6EcWRn
         jZ4sYoZjMOs1XKErcQocHg8pMGFKRP4mx6czULbcYop6vGpPtMhrWguirItGADX3POEc
         x1kMJPepkpZskmWmNg7DQuIOQlPc1dsMpMQoJn0zLwlJffUOC88xRaeDBP5VHByZa/v3
         J90VGuqB1H0TbxpraUKdB6JO/Wm778POFCB+JDfhAsfTuIl170RXjPj9Rbcoun+NZ+lr
         y+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHjHkl4WZLB2yJBqoHmHwedCQZ7BrdeRsdDOngufLccfr6mpzQjhI4TGBbCJCvh22lExMSatOvIRVh0Uc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuBHturK/KBhVbDnIT7dqHngLmhmkkcoJNgvl0XU76tMTes95w
	5lPHlxqtA+XzWmdCGygOMFXuSXetLEK5o8NgfPUhi7iPplV2krIgNpKf3ximD50=
X-Gm-Gg: ASbGncufxDeskVOB8sOlnXwhSfoDDLfu3QTLZRaYr7iEi/0+2r+/Eiiq6U5l4rNdpC5
	ek+yqomTaHchFZMSAv1jvAdxOWdXx9wTC+X/iDPuiZkLrO7cYhEe4rpmEwBhnLQksOMdfUItOiB
	IlBrj+h7QfxZJ098nN4RpQqaTXYhi7jrk8vNs6i0qNK+CPjuLM+W5zhNi72/5l/zQnyKzQbAZ8f
	D8FIa61vN7o5H0EVnsqR1K1kRU0zKsTSul3QX4vFjgjmCLyI5eBs1FmespKvnRLcTz+dfRDI42t
	JSOH+DCcq5GiwXUQQUSRdTy3rR4ugU8I81o9pt8Yo79pxKgKarLSu3/FIEtA9mFCNYOh6oUb8Gg
	piKjt3kupBrcWLI9ThDgOTANOEYHH
X-Google-Smtp-Source: AGHT+IGw6DMujSSlMe4X/Gi0vjiilArq9AgwOJMWr49ZazH2bLzcdxFw+AmPTscolQ+3wmW3ZQIPiA==
X-Received: by 2002:a05:6402:50d4:b0:5e5:9543:fc0d with SMTP id 4fb4d7f45d1cf-5e59543fd82mr4097180a12.31.1741107940802;
        Tue, 04 Mar 2025 09:05:40 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:40 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:42 +0000
Subject: [PATCH v2 14/16] rtc: sd3078: drop needless struct sd3078
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
Message-Id: <20250304-rtc-cleanups-v2-14-d4689a71668c@linaro.org>
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

Since this now means that the structure has just one member only left,
there  is no need anymore to allocate data for it and pass that around
via the various callbacks, just to extract that one member.

Instead, we can just pass that one member and avoid the extra memory
allocation for the containing struct, reducing runtime memory
consumption.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-sd3078.c | 71 +++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index fe27b54beaad1c06b70bf7f22e44c3f6da087267..10cc1dcfc7748144f51ef674939506feee1fb471 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -36,11 +36,6 @@
  */
 #define WRITE_PROTECT_EN	0
 
-struct sd3078 {
-	struct rtc_device	*rtc;
-	struct regmap		*regmap;
-};
-
 /*
  * In order to prevent arbitrary modification of the time register,
  * when modification of the register,
@@ -49,14 +44,11 @@ struct sd3078 {
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
@@ -69,14 +61,11 @@ static void sd3078_enable_reg_write(struct sd3078 *sd3078)
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
 
@@ -85,11 +74,10 @@ static int sd3078_rtc_read_time(struct device *dev, struct rtc_time *tm)
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
@@ -123,7 +111,7 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char rtc_data[NUM_TIME_REGS];
 	struct i2c_client *client = to_i2c_client(dev);
-	struct sd3078 *sd3078 = i2c_get_clientdata(client);
+	struct regmap *regmap = i2c_get_clientdata(client);
 	int ret;
 
 	rtc_data[SD3078_REG_SC] = bin2bcd(tm->tm_sec);
@@ -135,10 +123,10 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
@@ -146,7 +134,7 @@ static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 #if WRITE_PROTECT_EN
-	sd3078_disable_reg_write(sd3078);
+	sd3078_disable_reg_write(regmap);
 #endif
 
 	return 0;
@@ -166,36 +154,33 @@ static const struct regmap_config regmap_config = {
 static int sd3078_probe(struct i2c_client *client)
 {
 	int ret;
-	struct sd3078 *sd3078;
+	struct regmap *regmap;
+	struct rtc_device *rtc;
 
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
 
-	sd3078->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(sd3078->rtc))
-		return PTR_ERR(sd3078->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	sd3078->rtc->ops = &sd3078_rtc_ops;
-	sd3078->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	sd3078->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &sd3078_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	ret = devm_rtc_register_device(sd3078->rtc);
+	ret = devm_rtc_register_device(rtc);
 	if (ret)
 		return ret;
 
-	sd3078_enable_reg_write(sd3078);
+	sd3078_enable_reg_write(regmap);
 
 	return 0;
 }

-- 
2.48.1.711.g2feabab25a-goog


