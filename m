Return-Path: <linux-aspeed+bounces-954-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07BFC282EC
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWq091jz3c17;
	Wed,  5 Mar 2025 10:36:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107938;
	cv=none; b=eljJlQ2q6KmiVXYranYwrY0vADnUZOIvVjq6DH/7TYfy9zsnDc8rEkuaVv0wdoQc6Lji1+3286SOVtWsY1evegddkGmj8tqh2h6SOxHgrErr++kTosszXVgwyShXehhgx+HtxV7t25LR3kot8/9sAHGt+l5J+K28NyQ2wKEhkp1sHAYq9ok5cSNDR5hsiyPGJxsEcXNk6mjy4g3M6KPjAPz1u+6lxgAQGklviRmozjgDe6uc9S0JCN9Qu6H9IFqwpu+czov15xcGcBvF12q9C73oC0G/J5nXdKomT4N7/4GleeRdYFBnOF5lYgIBj3xIrNgl37/+k+rT5awUpgGdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107938; c=relaxed/relaxed;
	bh=VXesqtK3A8i6ZSMFwP8n6Z6kZDUFNsTogrZxF0Gh9Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHRigMi+1Mrk6cUvaI/PrYEZWG+MzGBq0Ro24Fg/+Dtv8DdwxssTRkr6U7mtfnfFdFUpmQNEuCXG5ABF5TKKfkYV86i56SLex767mflY05/mMzQcgVga8YFzhGFjrTFuzU4AckgP6SFAHIP6gvNKjfcYNV6cd5lx82TJbCRN22E5xpVOMpSWu7LxeU0ltsOo8zM3uhqj60KshUWQE7IkE9E2ZwbdF2qR3n7AgA8+pBUK0BEq/wCgYin4go5hQxW1saYIq8XVtQFGLi5f8JXCExbcjjknSEPyQ1tQ0+wYEHLxXTc3ziIhjcRQBp5TrR4RY1IYkU8Fdr7lkOIUjXrSfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X7mW659I; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X7mW659I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrx0vJ7z3bpL
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:36 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-abf57138cfaso615817666b.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107933; x=1741712733; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXesqtK3A8i6ZSMFwP8n6Z6kZDUFNsTogrZxF0Gh9Ac=;
        b=X7mW659IXTpQSRxEkFcngwaK4ELbE9ivPB2kWFuJ7Or0YFKf4hb3U2UbQt/hp40hjW
         mff23xDxedaPVvUcnSuhQEjItm3gcGPrmsqN/GcSyNbwZzh1yp/6B+GQYB7CnVIbI/CW
         h94KWWId+9vlN7CUqdBZCHQ1E18opuJ8x10XmdUIBdwmirDRlIUePOXUTY3OBaEXokPm
         7I/KNPAQ/mVvv+Kz7UV156UFZSK0WHB+xiRYFCCcExJ82xOLv3g6lmL8NgEovSsbKp3S
         IOktFbjIfMby9BZWXTb8zd2lo5oWRrlXIMvzGG02NbR4pDI/Z2S7WPuqMovp1Tk6RW8g
         hC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107933; x=1741712733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXesqtK3A8i6ZSMFwP8n6Z6kZDUFNsTogrZxF0Gh9Ac=;
        b=WERZRDXDmLItABObpoO4Aeqj0I33YZreR/FteWtQPwXSY6Qd3fiG8jhV6lb9hpTdbv
         6ly6cPcQRGoikA+fII8yfaNyoFekDIy2p4fg8mlSZqyhP9BH3UZhF7XKfUVq056kbl5O
         kAtAjqKvRpXDV56vmS1vl71yG+w230V3AU1+GrNNaaFh6vT7cZcn512avUWhV0sOn3At
         Ea2e96z1NnYhftnt746guFNbXs2Feb5yHWhSxfYh8XVNPRDjqltTMKd0sT84PJKhwZbC
         74NjjANAm/f+FrTiF5tM9Rms51tU8Z/++ON8yYBwNZrvzFsb2lJBC7d4MVC9k9Xaali6
         uc2A==
X-Forwarded-Encrypted: i=1; AJvYcCVjhcBtGXqzzsxRCPh4B+NdJPA7eIghuBO1S60df9H9nbO9gzHKTeV7EfwaCpmHG6Cm7dscqkqfJ7fDdGA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywf4st/XqfD8GnxFeWkUzPPZfKCTuIlyeAWM1DzlnvmcMeaqqx1
	D+fNV1UILaF2zuH/Kf8nDY07bN6T4lMZSR8uUOmfXJ9wvL0kj/ZXgOAYNubhEmk=
X-Gm-Gg: ASbGncthkTiL83shlUT1hF77rBD8VZ2dtHthVLdDz8IDyVRjPPA+q4JQzWGLHjloaBg
	ffHgXXg3kZ5j+SP72y5A/jbYrJKVcjgLKWZzn61SxUCFRRHyrKurNF946wSHLfc+em5C0cybwIh
	e/zoV2wk6B7+RPb6LM4YMwgZZKuGi3hsqprHS/P4m10+Z29e9MN2smm4Cdjt2tFQwA2M3TGUGuN
	bljiiluAca5AT1T8oPhoMdd4g7SW2knaC5BQ5lSxNgCE+5FyfpGxhOt7+7FqrKKqhinlzUKl6CC
	xab0Tmn6+vSMm93EQ+V2QG+oRyYqwW+3tTjDuQ1rgICb44FbYE6HRQc6w5G6KI26HliVUQnqdvJ
	lkj7Cy2yGHlH6oABFAIbxaWmk/28a
X-Google-Smtp-Source: AGHT+IHVbcY6l9+JTAHHIw3fmIWanoQo+sapqWdolutCogJsq5sGcHSbYPT4D1lGvFYrwfxZJsMGVg==
X-Received: by 2002:a17:906:f5aa:b0:abf:59a3:df19 with SMTP id a640c23a62f3a-abf59a3fa56mr1580793966b.57.1741107932647;
        Tue, 04 Mar 2025 09:05:32 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:30 +0000
Subject: [PATCH v2 02/16] rtc: s5m: drop needless struct s5m_rtc_info::i2c
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
Message-Id: <20250304-rtc-cleanups-v2-2-d4689a71668c@linaro.org>
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
in commit 7db7ad0817fe ("rtc: s5m: use devm_i2c_new_dummy_device()"),
struct s5m_rtc_info::i2c became essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* fix arguments to devm_i2c_new_dummy_device() - too eager sed //, and
  gcc didn't notice, only clang :-(
---
 drivers/rtc/rtc-s5m.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 36acca5b2639e272dd9baed06ea5582f635702b0..88aed27660348a05886f080a2848fcabbf9666d0 100644
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
+	i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
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


