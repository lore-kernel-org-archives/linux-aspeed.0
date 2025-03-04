Return-Path: <linux-aspeed+bounces-950-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC7DC021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWl71fLz30T6;
	Wed,  5 Mar 2025 10:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107942;
	cv=none; b=a68N0X4lmV1ZdGlHqe/5n91cL0TDHN+kQ29oeF1gjpg1ZkujpvQHq5R1noegnGrqpMCF5cxdpaiBTf26zHfZXbe88ZhxwkZklhAruvYFWgPW2Tw8Hr29agRAdBpnFW1zfhDkOgyJHfejC3mwWpFBNU4QsFZ7zsDYr799Bsj6hTQdruXjzIJVK5TaWEbCVOdGmAVRsns5H+wPEswk7FGcplShdgLuqv/FRWW2aspSt/VToQqaaJ5ZH9qt3xTgwJ2cTB+oyr3KAp3Rrf2qPZNu224ooful6yqr3wVfwq6w2YdPXBvfvyI6xn0hXd3LagZmASkbnIqZQD8MkWuIu3qttw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107942; c=relaxed/relaxed;
	bh=l1dbxTlHkaw5uSKNsqDfe9Jgr4Kg+vWUXd+ullz5kUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ5Y9QeJ3f4kyl/taccJva82lIVITDzXlY/qdZOHwn0bgPq1MmoVvptbEB1IaiXSIm+w8I3bDoHeqv/hQO+Dx8zZP8vbk0fTo2oX85WXqjgeeQ+XG98HBlxSyrtyxMADQtuAXG64mA568m12rltvJmuDM8GXbte33atk0RSXZ5eKOhLuG0md3+Q4UD1r/1VOIL2WH32lJ7Mz2emceEYMpyEbRyDnFZP/jC3xB2KS/TR2DTUOtb1sN2FXZFjC1kxRgZrMlHA/r2SDIS4Y2083b5skHgCOU1AoyTXjGfadynxUQcDgxNEw/3bqoOxjC1PQqEQW8r1uOM34ic9vUJLypQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oN8Av3xr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oN8Av3xr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs110HFz3bpx
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:41 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5e538388dd1so3544504a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107938; x=1741712738; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1dbxTlHkaw5uSKNsqDfe9Jgr4Kg+vWUXd+ullz5kUQ=;
        b=oN8Av3xrIpHle9nJSz03Sb835ptzwzDfBT9LmszClEJUo1vFT+asR+27o4pUGxT1ND
         SjrN/kuE7NTIzFnHSZBLWHGEG5dJTzBqRYW8TVq21r/tDD7cWw4p0qcremo3UfCDc4+Z
         eibst6yDyfbF5MoJ32wwiT6F3OTm+yKMc5DoztLi81ppoSxB3cf6cWLKoy1+DOSURGcR
         lJw0Se/0Wi8fhpa/iT3Sas+LHtGeh8TryfZZh3/VEiPw6xbgbgzYYjKszmNk5UTeUsSV
         6YAbbhymrSoEaoG+Lm8g2VaRl6qsyxhdC+LowbIshr0oN49zokAXLKAKoihdlnkqlRYL
         HrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107938; x=1741712738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1dbxTlHkaw5uSKNsqDfe9Jgr4Kg+vWUXd+ullz5kUQ=;
        b=KL1rSIviVrBWwKtnapQ/5BevD9HR3C1tjYlPpAGbSlhMjbvJMPDvWimN+xxvaFNW6u
         qGkSWC+L25H7D+TeHaXGit6z2B1SpI7tu3nfIPbpO5hHNxC5SJJWHEjXe7s6XdMA6oX3
         qZr3R/HF+dgmTjvMUIeo5D+rsWSG7nxDBzo4Ag7pvYh+pLt1r9CIf1iu2KNtYh50uiyS
         Zc5MQLhoLscAe2rcHGuc2JvMw9UsmNbB5KC51Tn4i34Cq2OBddB83PY9CGYO6DeRkmrt
         IORz4mSJh/UuOCJr7Q9wSwPvjC7DfnyS1ubODEa9FZMpO2R5lvcy3hQ1XKy07eWgtsFB
         e59A==
X-Forwarded-Encrypted: i=1; AJvYcCV4+ab6fe7TnR1nU7yuvt01pyWJh77VCuPO0p1HsoGQTCJAYhGMNofw75qlnouGJPye+uC+GkA67FG4/DE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzybVk/d+kYxZpolFtqLxJ8sjBAVsHPGS3gTKlnAwFky5kJqbEL
	8AaqvkntznpUjr1wGUKHSgKvbra03oh5eyBjaaC2f7eE4OTreZ0X3WljvB9zsNU=
X-Gm-Gg: ASbGncvcKokRxlq43+s8xed1uT+ip4tK0l+PXo5ZrJ1UWPolm0bvKgAPRw30flS0AhU
	Nc6U6E4KoR7HKACntp1o4lq8Lk7TKVPU6Ce7000RJFXqMp5mVt1bCmIVsxqXFb+lC8+2IQqRmG2
	wCSavSMRK921Sz6dWV4SooQREUjhk4/TgsvMCa2t7pVAdfO3OzVVhfIVF3RjXXA+YTh1f+Zd0ZT
	IxEPNzWcU9rFFQfrHGb/yYjrL8+jD3u3MBIVKEqTBV6o+dgID2CB8jfqdwn0TOZCDihYVix/I2O
	2XhFsy7C2Y5EWzDC/EqqqgAKjUTxrJIugKSCQKh01n4g1CW4wHb1nY1GIKgdL1ByUhR3gLvvoBo
	4XFPdHO2wwgsg5+1YyaYK2kUrwcqk
X-Google-Smtp-Source: AGHT+IHF998NpSXE/Qa2EdiSn4vtx17I0lnFV/wyKnxAJsCHaDM1j6HSEMvcUwtHdnvoXlFd/CgYog==
X-Received: by 2002:a05:6402:d0b:b0:5e4:c532:d693 with SMTP id 4fb4d7f45d1cf-5e4d6b8535fmr16782448a12.31.1741107937989;
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:38 +0000
Subject: [PATCH v2 10/16] rtc: pl030: drop needless struct pl030_rtc::rtc
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
Message-Id: <20250304-rtc-cleanups-v2-10-d4689a71668c@linaro.org>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 39038c0754ee55a952e5986afe711cffff35840b..e7c81740061bb60c4d8447d6522819685bea9180 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -21,7 +21,6 @@
 #define RTC_CR_MIE	(1 << 0)
 
 struct pl030_rtc {
-	struct rtc_device	*rtc;
 	void __iomem		*base;
 };
 
@@ -86,6 +85,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct pl030_rtc *rtc;
 	int ret;
+	struct rtc_device *rtc_dev;
 
 	ret = amba_request_regions(dev, NULL);
 	if (ret)
@@ -97,14 +97,14 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
-	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	rtc_dev = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
 		goto err_rtc;
 	}
 
-	rtc->rtc->ops = &pl030_ops;
-	rtc->rtc->range_max = U32_MAX;
+	rtc_dev->ops = &pl030_ops;
+	rtc_dev->range_max = U32_MAX;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -121,7 +121,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	ret = devm_rtc_register_device(rtc->rtc);
+	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
 		goto err_reg;
 

-- 
2.48.1.711.g2feabab25a-goog


