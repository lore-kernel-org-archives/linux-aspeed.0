Return-Path: <linux-aspeed+bounces-878-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADEEC282D3
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvy4yqsz3028;
	Sat,  1 Mar 2025 22:01:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751649;
	cv=none; b=IZWlk4IjLQTRP+i05DD9TvB6JYHAp6j36HMIKMgSTMvj3Setfr9SUfPZPVWgLiIwAe75SV3aM7dvu30x+Dyxx+YK04zGNBzDLZzVgBlOE2mNw+cmCWiI/ahN+iC6IoJiu4X8a1iA5p4XpGyjouDeHVHnawCmaYl6ef6eZ5qNndpSXyL+pdfmuCOlVn07EDumikV2N/GVD+N5GS6U/ceGcGzwBFytiQPwWyx8+chY8GPaAfrFFfAbj362jtIT3ZbBXVRiB752NfsD9PnwpXUN2yJGZrreBTuKa7JrdvhOL0Xlrc1aInDE79JVSXQFeubYfGchsvQ7xkLLMPdB4gdPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751649; c=relaxed/relaxed;
	bh=NEusmS+5iWAG1jDnjFt/eyKJ89b8w4e+6UytiCX0MQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQLnwDq+qL9PA9VosbuK4QaTULLu8qkjiB2XBqYUub3/cG+Aa/oKFzvK1TuRAzKwNS1DkaoVp88IJt7bvL1ynISUs6v12OjyQZQySWoN2AXANNdtQmjuF8w5MeoNtxlz5wkzlACWYo49eCWooezp7SD99uCxaA5D7s0IFNeq6MoOsye2XabMdOD8a+hg0XDdjgkqlpC2Fn8aafauY/nrHoEwEriH6fMgjdrPv1sCW6bGJoZaezSeGnOAPPRsgFX6pdEwptkt8xLL0qpLpLUYYlB9mgkWBZsAHf4mzi1luWlynBWjLlotKU00Vo5dFjt0yO1BmosJZ30ecmcoeGjw9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o9C+CXUt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o9C+CXUt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495C67fLz3btX
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:26 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso3226215a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751643; x=1741356443; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEusmS+5iWAG1jDnjFt/eyKJ89b8w4e+6UytiCX0MQA=;
        b=o9C+CXUtVNC6eQug8Awk49DTyYBXDxjldDSeBilozrT8VMrekhMz67c+WSqYpaw+p5
         0fUVcRIoZBQaeAeXiLNl8kzD8a6O6oRMavPEb2zhPfK+Rri+eaMwh7C2mrai2ppHGM0H
         AtYBjMxM+vY+rQmqVxxcHh0frVeP9yT1EP6uU9mzwTkDXSxkSBuVopsWFnRcGbdEV/2y
         ttMRQelCGYPfoo6cqW4VwNm/Bp/bqPUAW5KWJF2GmfP5aEW9AvBgxCjxYugMLE50Dzxi
         VLec37Dao1Ikspx7vW7XqUakJ58ZaMR4J3Y4kxpBpslW6Mkvxou3zAqvxfzAGZtiCO0Z
         e5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751643; x=1741356443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEusmS+5iWAG1jDnjFt/eyKJ89b8w4e+6UytiCX0MQA=;
        b=dIMJtIpscOv2dgNeQYNCTW7368YtVBgD80n3Wvk4jDEuXunmGgKUxkCBKmlW8M6Q5v
         kHrjbi9iQwxPztXsG90YRlxg/oDF3ZTEPy0dDwyLigUjL1G2Db5dTUAZmxLub+3AxPit
         +iwLoUj3aSYRigJwXF0O6uULcS+lds7hyClmd+ia74Sb7Ba4XYX5SNsyWQboXltWQEzM
         byJSwPCQBYyoelMscYAik4UX38Ugt6/2NGIk1mAfYJJ7Wcd6if59TgfqAH9fX8LWIucO
         3ilAUNKsjrNCDSZeb2th+Wi5tPAd0MGYvWsI89Ph26oEb7gSOlxdB6L7jxJobiqMnijv
         L4OA==
X-Forwarded-Encrypted: i=1; AJvYcCWzH5fPHJpTBawnPs8icHUYPLS3/yRZVg7MX9pkF+Qq46l/y7VNREpF4CPkke4mXccC5znIV9KiTJMrwNo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwalIwG2jLjKgK2DIbgGqplVsZc6tHxnYvXkHzgI/WlVabiYgsS
	9FfgHct8UyFGZZz3A8+XN8VCEwLxl8z0isCxIV8GOooC5lyscmKg9N+A9MBTKyQ=
X-Gm-Gg: ASbGncuZ5xmFu3+icUgRLOkzWvL8urbEu0ygT9bCewW+LTF2Jvon/JUBD4AWiz3sfxf
	5S22Kex5NckjSS4HDDmkrjuppm54SS3ovfTtpbyfZqiXuJ8sXUXgdOecIRPjaoN3uktvfV2iZH0
	1ekgk23v3IejHTiswbyg1FjQaKH906USrpZuVY0WMueHpq4DofX3QH5Z3BRQD7C3m1LwCay7e9Q
	71kh0xnsfznPbOL7dWneSBa4UpxoHYKhchk8IAtiIHVvRqTQmdSIDgjgkKk4xPikgUZTGja4Po6
	eXA1HluR+HU75KM0HFHjUaNLSbruqYrxE8uftiV3k2Od8hQNqzJ+H+Oy+qyBOcZ/daFGHLutRyE
	Px2KoJjMhJg==
X-Google-Smtp-Source: AGHT+IHzPJx5i3RI7O2yaVdHtPJ0az692A2jfkouiK94jhHcaAYqi/2J0zpg5aMdk74cXIZT8BcCug==
X-Received: by 2002:a05:6402:42cb:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5e4d6af0565mr2697422a12.11.1740751643440;
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:22 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:15 +0000
Subject: [PATCH 02/18] rtc: s5m: drop needless struct s5m_rtc_info::i2c
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
Message-Id: <20250228-rtc-cleanups-v1-2-b44cec078481@linaro.org>
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
in commit 7db7ad0817fe ("rtc: s5m: use devm_i2c_new_dummy_device()"),
struct s5m_rtc_info::i2c became essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 36acca5b2639e272dd9baed06ea5582f635702b0..77dd61c30681b8f0a2f23063ad5f7eb52f5b7158 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -146,7 +146,6 @@ static const struct s5m_rtc_reg_config s2mps15_rtc_regs = {
 
 struct s5m_rtc_info {
 	struct device *dev;
-	struct i2c_client *i2c;
 	struct sec_pmic_dev *s5m87xx;
 	struct regmap *regmap;
 	struct rtc_device *rtc_dev;
@@ -640,6 +639,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *s5m87xx = dev_get_drvdata(pdev->dev.parent);
 	struct s5m_rtc_info *info;
+	struct i2c_client *i2c;
 	const struct regmap_config *regmap_cfg;
 	int ret, alarm_irq;
 
@@ -675,14 +675,14 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info->i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
-					      RTC_I2C_ADDR);
-	if (IS_ERR(info->i2c)) {
+	i2c = devm_i2c_new_dummy_device(&pdev->dev, i2c->adapter,
+					RTC_I2C_ADDR);
+	if (IS_ERR(i2c)) {
 		dev_err(&pdev->dev, "Failed to allocate I2C for RTC\n");
-		return PTR_ERR(info->i2c);
+		return PTR_ERR(i2c);
 	}
 
-	info->regmap = devm_regmap_init_i2c(info->i2c, regmap_cfg);
+	info->regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "Failed to allocate RTC register map: %d\n",

-- 
2.48.1.711.g2feabab25a-goog


