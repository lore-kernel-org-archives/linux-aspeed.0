Return-Path: <linux-aspeed+bounces-952-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D1C282E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWn09pNz3bw9;
	Wed,  5 Mar 2025 10:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107940;
	cv=none; b=OKQfyVLWxFjhlyjipJGgXGMoGXu+9fsLm8Zupa/XE/bpEW7NTe36P/xzUI1nsaORrf8OlLrijVNCHh/scQFiWEpd6UIkPBmwslX1ng4h8oy0UdiYuB3DGygDD6JWkCBwQdWWZOPF/O2NwW0Rh4cGuC6s2bRAgYmstVQXViyRyZ5si0cizF9t0AKJKhMn4zElpIpDHzkhXsYSRVRAnY5PO2Z+TGul4CiRLPGaxE/5LbcJBGGAMqmSnRtvSnzHMPOXV+h7Csxnk2mFvWJgvL/1gioefu/zXQHh0G73UnrG+dYxagJNRg5B854lLxSJOZ0hdTUAaR/u3U9zlHop+/aYig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107940; c=relaxed/relaxed;
	bh=M1Zs+DHu4keoQ7nH0HfotkX9qiVtwoVoQvIhvtnI4DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoyMnWvw9CyRYP6HgGc/YEXkLfkgYpVEM+HiEACBwHdj9iDktWtxSutvBO768BgOEKsqmwP7+q5z751rChYS55J+zvPTq3Jd3ZDfNF2wywGmx8x13iILIwm+IZJ3+BIVISRcDUKnfvrDdPtm72j1sh8Ps6UzA+aegVoitV3m7CQ4nfGy/K8+U+ycPDcJxT+r6JZZ0LZrVk2kV8LqcxA8dwlqzd627ZP07MW3Vn5VmEtNwNqOM2HD4ym2alaWXxZOEGLGxhCVgtArYBs/orQq3guXzeEGc/ESU5enzP0yz1EU/pr4UwK1FJRwEPbxLMTI1c8wh2O1hzPBoyhS8D9qOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eaQNwT+C; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eaQNwT+C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrx0N5Bz30TQ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:36 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso6933932f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107932; x=1741712732; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1Zs+DHu4keoQ7nH0HfotkX9qiVtwoVoQvIhvtnI4DA=;
        b=eaQNwT+Cqnxmmyef4MCW8oFXQz0dka9UWOI//gPgsC3ROYxJV8ZBkDEIYFxQQJ/gJA
         c/fg2DWDWIM+B+pmxpN+/RHSP2i/Vn6CYlEUnfWlw2IcOdSdsWgllJme17x+gfBaEsEy
         imYeGVLYq2sRLxE8SNeQZhnnUQuSPeSqzFg9dNfJt6ev/YCaa/C4/XSSh6AQ0n38wwMX
         Xt4UktWFRGeyIyWXeu21KfxDmack8hNO0BG0nBquNqgA7ICtGuvBLN9Jeh+JLI17aN6X
         tQwTEJbNlTYWxppfInqv7VoPh0lJSKM0L6wSTRifb/KPKqf4xHf0SJT947LOj78CRDx4
         o/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107932; x=1741712732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Zs+DHu4keoQ7nH0HfotkX9qiVtwoVoQvIhvtnI4DA=;
        b=BSxl2njRvQxvo4wKj0gEoCui0kFXBzWSUYQibsl9GUO1x8akfCLM++JNkXi9l2dn1D
         zblBaeb/vjM849xGdn/fcEg2nzlyHy5KWl2rmeDLTQXl3xSUAWrl5+i04w1/d7VtWhE+
         OArqJ8AXb1V5Z3YtUQ75KFBTb5HmJVYMxTTlDinoOFofUgYtYosVkcyB/7S6jwYKHez+
         poD6yERMiEcWJVA/0j9ZCcALnaWI7qz6D3ipAWDZAGZm5FjxB9ljYRT/leUZyP0jPc3t
         ZdJIhJV1kFlj7PFXsegXNCD1LzZT6XcRPR80CTECEc5DP0ba/WSoPAe1pP5LX0zWN3KT
         u+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUA1JcZID+tmOGuv/GpU8odYzs1fCv3qn44+PXdFIRqcDtVfpuQxZo+wyfdc4a8Mbb6du/ShtWjDwWEYjc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4bKgpkagdkhWsl9lm1yE8ChHXAfhnrmYmXo26GD5UDwFUSbVo
	mO+f2Ug+UHbGVkId7DEdjEi37o9teijlZ8zitm1KYJrAxsy+x557rg8WI7NhiXc=
X-Gm-Gg: ASbGncu3KLdRMWDQcAEhENGsz3sZxWC/XnV6xRU4qYlL8bFtCgP2Qi6Q21ALOQ+XZ4d
	i2x+xfeGOZBPxB4MzelR5RlPzsAsFCvmxFTjwHnr7DjnvG80DHvDs46azK+thhApFH3dFnjx9sK
	mOeU4Fvzkwfsh+RRELu9/PrzfaUSHJZZcSP8cX4Yp4sGacDqbr7wIlr5UazjyrcYtjX25ri3D5W
	Mrg6OMm5xF6O8bOtf/++PXGiofr5Tw+OVOaJeE6O8OpvuxjKRQg0Oo2DL3EFIjnKnkybokLcgyX
	/2P7vPe45WD2V9p0V8M6HZwYvFA6J1HiADtTUBc9PxD8TELcn+8bT0tkp3OJDBHqfNnfSVmQxOf
	ynrR8/2AtpOaW9MbVgB2XEIp6frc7
X-Google-Smtp-Source: AGHT+IHSc8pjwattEBJyeHF3OjOkT41+G9Y/Rh1pozPSubIjG3eC8i5kYIqu87xMZCHZm4ULB7j+yA==
X-Received: by 2002:a05:6000:1faf:b0:391:888:f534 with SMTP id ffacd0b85a97d-3910888f656mr7939190f8f.20.1741107931986;
        Tue, 04 Mar 2025 09:05:31 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:31 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:29 +0000
Subject: [PATCH v2 01/16] rtc: max77686: drop needless struct
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
Message-Id: <20250304-rtc-cleanups-v2-1-d4689a71668c@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

When this driver was converted to using the devres managed i2c device
in commit 59a7f24fceb3 ("rtc: max77686: convert to
devm_i2c_new_dummy_device()"), struct max77686_rtc_info::rtc became
essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


