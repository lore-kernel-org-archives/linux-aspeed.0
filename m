Return-Path: <linux-aspeed+bounces-881-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E303C282D1
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvz56cTz30Vs;
	Sat,  1 Mar 2025 22:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751657;
	cv=none; b=ilkST5RgPu6Vz22zeb5oDGJfjzLULT5SjQzCaPRshWLey95Dpljc6amu7POnuq96B4V1y2lh18Sifg0m/DxL1VFQkanlpQFAJsFuINZS6C4knw0OTVYdf6EBEfpZS2YoFMnFF4+h6AcFshgeG0hzBsQYU8aXpIy8A0ML8MzWiHNM7A4NEdDJqHicwVI3jJvBlIm70XbTKo31kVi9UYo7yYSnkgM+ulIRvoJiLFaJhUvQHA6TQxtYgeWYpWeVaPaZKwLWWLwLXY5utT4EQ9hnzNpMgc0IFMje4WCsry7kjfePxwH2GwJg8K30fcokztmCisgkr9WoQgJmw4PMDj1VlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751657; c=relaxed/relaxed;
	bh=XNaBzsv98dZxOnoY4pQ3hhfyEv1+PH+c26jk5v5UbcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8/GbI62MNPxMpVm1MWo6YrX1N3pI8hGABnHcedrs4FwsBijv4Tp3yekaju/5OpTDRHgPz++WtoKeDzWdkNZp/a6AVdOz17pFy8rr5iJz6HkjqzW5AefL21oQ4lCDGbDsMsoDg2itmTUCprrCNAnPJaLTHvqgsIpL3fMsu4MLIvPInODAwFbjbNVt908U40nBBK9zxVwOYCdTtO1mu7nBObgcokKk6AtMiAFs/JwcDxOHCQqnQ0Gjefv8CqgYaMW0Am42zpp+GrL7GPhbdjLrwRm/JS5V6mv0exMHeGheqvzaFd9Wb7zFerpvhqJqaDW0wpjSjCIn6cAqQsaokFvMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ifpdE5u2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ifpdE5u2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495L3C09z3btn
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:34 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so3591406a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751650; x=1741356450; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNaBzsv98dZxOnoY4pQ3hhfyEv1+PH+c26jk5v5UbcU=;
        b=ifpdE5u2qkGKJ1xaHVTm76NavR9rYaYe+mDY76js9lHoqgrq4Qxpq2x4QnfbAYAsd1
         3HpMZyqFlnxcIajwleNoQV9776qabARqPljSKvhHkVw4hQhCCeJqJynf8wUjxANLOrDM
         KbzOIlX2RRVM5+7LaGxeS2YtELb3CwSVL7eIzWbgXf+aeON68nOnlxa9f9nSdUd8d8Nl
         7T9rtWW8MC9niHo5qUOWnRqRLKKVPwlUgLjq4EDRKOWORtZyXlxXO+6wSQ/mz+YXW5a7
         1I7lNzxHWFClS+QOcwNKTxJY3anJ4NBRldndhSjgy+0BoKktqk8gwfMfrn6oSP8V8H4X
         IeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751650; x=1741356450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNaBzsv98dZxOnoY4pQ3hhfyEv1+PH+c26jk5v5UbcU=;
        b=mr2HrFoxlavam6M5vlK7sbA/VANZYGramgXveWiYWP1D0iTYybNrBwkA09JNjlQ0L7
         vRVZxCqNBxJG06KpaRp4t/+Y5EnnJh8z4Cqrqbvs/3wQzhVwK87al6lO8EdF3BWOZM3Z
         nwV6MbMpoOlx9XfBRWDliSnMh5tLUupvFCB8V6B3GVBEIi07G/8Yp6Bx2umBFP1q/SGw
         u1r70srM5L5WS9C9fJr79JBJe2TK3aobYwVglu6kLgQJvqJsQ7HYpBKyusSbICv+V9Wh
         WIMQ1EIZiqHAB/DR4kLo2KWGOyvYOoeLVdAsjvX4dWxOnPcKKLpP25N32ujieLzYIS43
         D1mg==
X-Forwarded-Encrypted: i=1; AJvYcCVCo0G/4aKt/wPZOItQBiT6OSDp79banUZNCI7hggj7XVMeuaXNrSR2oaIB0ukbrAt9IljJKatsCjEyyz4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwX6iFqj7yckxf10HQshH0QPDiFHyjezxRycvj1vBe6yvefJ1dU
	pbD3uxjrzHaQJpIJxs+GWs2OVp4/hBNvlg8MyUvVZE+WnkmRPv4FFgFEn+qmDLY=
X-Gm-Gg: ASbGnct1eoVgpBpJ8/p+fxO7jTHSzt98Ia8DEcfax7GIKgjuKAB2siFyhO6uqFhpEL5
	8B0rHzosCXDUfzxJgQSbEYfMrqo7BC7HE5QH5oisbQcyl5B76CmmB1UqgzfO7ehs1ewkMkk0nQ8
	CeCDLfMXAIHihCZTVphlZKaVxRJdU3svNms6u40ED+LBwuafTrLzLlO/gxuX9vWuehD9n8tn3OL
	Yda6mHzPj2VM+ab8ZnKpsl7Am4KzSncNR2ygsIq0h2SwKnN8UtjYoGtUjCG/5tWO4UHCQpCJKwK
	sHnWdr7ycaQEi5ea07v8jqZLJpdo8khJRs/DTCQHEROV2rOv4a/I1ieto8uIX+QSlLS1avfwqDv
	Rv9RgSP/W7Q==
X-Google-Smtp-Source: AGHT+IHJgHIb94bIAN1OxpmT/CmpG5hxROPCgFLfrUaKlqlLkHckO5CTYjuy4Kdl9gpiKvePvUPO6w==
X-Received: by 2002:a05:6402:35d3:b0:5e0:9959:83cd with SMTP id 4fb4d7f45d1cf-5e4d6b70ef7mr2396243a12.21.1740751650375;
        Fri, 28 Feb 2025 06:07:30 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:30 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:28 +0000
Subject: [PATCH 15/18] rtc: rx8581: drop needless struct rx8581
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
Message-Id: <20250228-rtc-cleanups-v1-15-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-rx8581.c | 63 +++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 785ebaca07ac971eee34559f8d1e0a8a872cbba9..20c2dff01bae833ae4e100cc38cd5f030017be75 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -52,10 +52,6 @@
 #define RX8571_USER_RAM		0x10
 #define RX8571_NVRAM_SIZE	0x10
 
-struct rx8581 {
-	struct regmap		*regmap;
-};
-
 struct rx85x1_config {
 	struct regmap_config regmap;
 	unsigned int num_nvram;
@@ -71,14 +67,14 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned char date[7];
 	unsigned int data;
 	int err;
-	struct rx8581 *rx8581 = i2c_get_clientdata(client);
+	struct regmap *regmap = i2c_get_clientdata(client);
 
 	/* First we ensure that the "update flag" is not set, we read the
 	 * time and date then re-read the "update flag". If the update flag
 	 * has been set, we know that the time has changed during the read so
 	 * we repeat the whole process again.
 	 */
-	err = regmap_read(rx8581->regmap, RX8581_REG_FLAG, &data);
+	err = regmap_read(regmap, RX8581_REG_FLAG, &data);
 	if (err < 0)
 		return err;
 
@@ -91,20 +87,20 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	do {
 		/* If update flag set, clear it */
 		if (data & RX8581_FLAG_UF) {
-			err = regmap_write(rx8581->regmap, RX8581_REG_FLAG,
-					  data & ~RX8581_FLAG_UF);
+			err = regmap_write(regmap, RX8581_REG_FLAG,
+					   data & ~RX8581_FLAG_UF);
 			if (err < 0)
 				return err;
 		}
 
 		/* Now read time and date */
-		err = regmap_bulk_read(rx8581->regmap, RX8581_REG_SC, date,
+		err = regmap_bulk_read(regmap, RX8581_REG_SC, date,
 				       sizeof(date));
 		if (err < 0)
 			return err;
 
 		/* Check flag register */
-		err = regmap_read(rx8581->regmap, RX8581_REG_FLAG, &data);
+		err = regmap_read(regmap, RX8581_REG_FLAG, &data);
 		if (err < 0)
 			return err;
 	} while (data & RX8581_FLAG_UF);
@@ -136,7 +132,7 @@ static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	int err;
 	unsigned char buf[7];
-	struct rx8581 *rx8581 = i2c_get_clientdata(client);
+	struct regmap *regmap = i2c_get_clientdata(client);
 
 	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -159,25 +155,23 @@ static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[RX8581_REG_DW] = (0x1 << tm->tm_wday);
 
 	/* Stop the clock */
-	err = regmap_update_bits(rx8581->regmap, RX8581_REG_CTRL,
+	err = regmap_update_bits(regmap, RX8581_REG_CTRL,
 				 RX8581_CTRL_STOP, RX8581_CTRL_STOP);
 	if (err < 0)
 		return err;
 
 	/* write register's data */
-	err = regmap_bulk_write(rx8581->regmap, RX8581_REG_SC,
-				buf, sizeof(buf));
+	err = regmap_bulk_write(regmap, RX8581_REG_SC, buf, sizeof(buf));
 	if (err < 0)
 		return err;
 
 	/* get VLF and clear it */
-	err = regmap_update_bits(rx8581->regmap, RX8581_REG_FLAG,
-				 RX8581_FLAG_VLF, 0);
+	err = regmap_update_bits(regmap, RX8581_REG_FLAG, RX8581_FLAG_VLF, 0);
 	if (err < 0)
 		return err;
 
 	/* Restart the clock */
-	return regmap_update_bits(rx8581->regmap, RX8581_REG_CTRL,
+	return regmap_update_bits(regmap, RX8581_REG_CTRL,
 				 RX8581_CTRL_STOP, 0);
 }
 
@@ -189,29 +183,27 @@ static const struct rtc_class_ops rx8581_rtc_ops = {
 static int rx8571_nvram_read(void *priv, unsigned int offset, void *val,
 			     size_t bytes)
 {
-	struct rx8581 *rx8581 = priv;
+	struct regmap *regmap = priv;
 
-	return regmap_bulk_read(rx8581->regmap, RX8571_USER_RAM + offset,
-				val, bytes);
+	return regmap_bulk_read(regmap, RX8571_USER_RAM + offset, val, bytes);
 }
 
 static int rx8571_nvram_write(void *priv, unsigned int offset, void *val,
 			      size_t bytes)
 {
-	struct rx8581 *rx8581 = priv;
+	struct regmap *regmap = priv;
 
-	return regmap_bulk_write(rx8581->regmap, RX8571_USER_RAM + offset,
-				 val, bytes);
+	return regmap_bulk_write(regmap, RX8571_USER_RAM + offset, val, bytes);
 }
 
 static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
 			     size_t bytes)
 {
-	struct rx8581 *rx8581 = priv;
+	struct regmap *regmap = priv;
 	unsigned int tmp_val;
 	int ret;
 
-	ret = regmap_read(rx8581->regmap, RX8581_REG_RAM, &tmp_val);
+	ret = regmap_read(regmap, RX8581_REG_RAM, &tmp_val);
 	(*(unsigned char *)val) = (unsigned char) tmp_val;
 
 	return ret;
@@ -220,12 +212,11 @@ static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
 static int rx85x1_nvram_write(void *priv, unsigned int offset, void *val,
 			      size_t bytes)
 {
-	struct rx8581 *rx8581 = priv;
+	struct regmap *regmap = priv;
 	unsigned char tmp_val;
 
 	tmp_val = *((unsigned char *)val);
-	return regmap_write(rx8581->regmap, RX8581_REG_RAM,
-				(unsigned int)tmp_val);
+	return regmap_write(regmap, RX8581_REG_RAM, (unsigned int)tmp_val);
 }
 
 static const struct rx85x1_config rx8581_config = {
@@ -248,7 +239,7 @@ static const struct rx85x1_config rx8571_config = {
 
 static int rx8581_probe(struct i2c_client *client)
 {
-	struct rx8581 *rx8581;
+	struct regmap *regmap;
 	const struct rx85x1_config *config = &rx8581_config;
 	const void *data = of_device_get_match_data(&client->dev);
 	struct rtc_device *rtc;
@@ -276,15 +267,11 @@ static int rx8581_probe(struct i2c_client *client)
 	if (data)
 		config = data;
 
-	rx8581 = devm_kzalloc(&client->dev, sizeof(struct rx8581), GFP_KERNEL);
-	if (!rx8581)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, rx8581);
+	regmap = devm_regmap_init_i2c(client, &config->regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	rx8581->regmap = devm_regmap_init_i2c(client, &config->regmap);
-	if (IS_ERR(rx8581->regmap))
-		return PTR_ERR(rx8581->regmap);
+	i2c_set_clientdata(client, regmap);
 
 	rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rtc))
@@ -299,7 +286,7 @@ static int rx8581_probe(struct i2c_client *client)
 	ret = devm_rtc_register_device(rtc);
 
 	for (i = 0; i < config->num_nvram; i++) {
-		nvmem_cfg[i].priv = rx8581;
+		nvmem_cfg[i].priv = regmap;
 		devm_rtc_nvmem_register(rtc, &nvmem_cfg[i]);
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


