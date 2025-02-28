Return-Path: <linux-aspeed+bounces-886-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161A4C282C6
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw06zTlz3c6J;
	Sat,  1 Mar 2025 22:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751650;
	cv=none; b=h3Vxn2LsJeeM7zP8/0WRexYdyA6Q/V3LVS0HK2lqTIEG53ejEtX906Q5OgyiCZ/mGfscJCjOW8etWj7S3Jrt53hAcJPhclgksHR/sWqxu4TsOWradkTTBqx3nOLfT1zQf3hu/yjiLT4/tEQCPly+YKVYQTc53fImxELbutWbpTjchVWYgc+6+n7XfoQik4qF2d+y7a/TmnVY1vvdzQ9fi3Xu1YwkliWBwnazB2U2C/5wHPtwiMmpGxw7r+MkaoY0gsqxMFKUCA2t6z/kmBWA88j9WfeLvaQd/YvIh3Ww3pARTIXa1ZNTzsDEmvImQZRNV4yjpyzb5dHQzMUIsrCucw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751650; c=relaxed/relaxed;
	bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLOwCISoRbv35z0DB2zkYIMMrAjsJrz/s/26ELtvZvFK1/7RK/gdnuTKb6o3AJdkQClxIGbcIyHC96h1Z2XFaNkrHSoaVhAqHUuU6WSAmBxaSOZVmrE9E6yt4tXqKXge3hnRNoCTxuoGTgyu+FsZG9JkahjM1xqKvZCu1DdNPIRtv34v7fPhCrUlPddxhGAhfkhMq7OE6lOYcYUHzmz+O+ob20kIYgyWhHzTvmIhwAXxE0+sO/mI+Z2OsNChNrkj57W/PlvHR0th3W1vPyTpdoge/zqprR0OGasa97nnKnlpt0UABwnBOkNKwLZjZzpvSVOlE5pyBVkRxpQJG0l2IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RnQgG38f; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RnQgG38f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495C6Z8sz3btk
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:27 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3586829a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751645; x=1741356445; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=RnQgG38fsAo+S1Aq7WQGKmiiKs09bSkw4S4XH7Vf+tgheMVhcgOffSdT3W7L1SudkA
         XbSJFgGBlurT8IeVmXTd8NmANrKDpIHXi4oXktB+5sYy2PzwHLiUgMc8WSaGWo0PJ8mU
         J+wC4dzn55ipjFBshTKSKXGegWmfJOqbKZhpRfpaELmQ6g+JvrHmEUB5dzrIum6GM1VL
         k1ZOdO+bBiNGZU5Zlt9e170UCDGovORNYwd8uY1ixJgL8P0sVlXZVujntzzMGyOH/qeC
         VmFw9+NVRXM9XbeXrPLHVAVhzm3h/C1XeWtDcSSJhq26cATIHk218NMm++PuceANAPzK
         YObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751645; x=1741356445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=nKvA0BDGFv8Rgmq99wZCJik2zEzESViD2F0f2ZgNY3bzDyYIf8+RjDQ/MbEy30Oaeu
         u7+oTEqkTDfShIMZji2mA0RdVT0svnD/WbQzBWijh7WppZMsNTtfBXkbpgX8+ezJb/QL
         QhwNqIr67StArkLAF/49hRfyfdwOxQjoBL/+twXd/wworFRI2eqjX1AtjV0IXHfrA+fp
         dYcehZall3TQfSEhW8xe9qwqauqf0X6tVmRTxZAyKTvhWW2B3RuqhFVgyYeO+xWYFSBR
         LF0QTq9av0ji4xPIOkvzocJigTWJSrvPmFtui0dQSnfxBS7cH3SbcW3phphouc3sgNT+
         mWUA==
X-Forwarded-Encrypted: i=1; AJvYcCUD4Wd6P0erldOsY0SbusjJDAjeBrgwINl4V4eU+YD9mh9rnzpzxo07mbwmJQy1BEAH8EP0iKOI/4go1Bo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAWNGcutpSZL4qCy7VNZ9blufNGc/4ngFs1Mm9xv+bqeFKNjN5
	kRlYhirCD6DLC0C7GHDENy0uDnK7p/uZ/DP7jqUjNbT0JVnbwnFT2qr61eqzdfI=
X-Gm-Gg: ASbGnctiYaM5QHafxBnEVBhqlpqtc1S3wl//KktFYLHOMKJB0ySz2N9MIQw04t22LY0
	j6+N6QOisvnfICdSW2mYrT3DVK4+LmNNRKOr3vF0/86aDLntdAHY3tn5KAHSBhy2o1GaQWbhi5t
	ff4Ken0y1cThEK1g9GYSB+mC7AbXNxafLjPsXhsQDgtUOJjJ4vLMBhUX+AczuAff0krQDnyOMF4
	3V5sb7pyRMS+nkbJEcW1SSWHTCBflh6/3vyEwXFdFHw5/g64TdPUAe75tY+1oGb/JfC6vV9ywlw
	aX4MMU/AG/FUbXsinlmZ+COYilZCqnTW07zBJWZjOGyA3zx3KGns6jLFpF5BxtMkMOyzkNH0zIk
	UkQ1dD33YSw==
X-Google-Smtp-Source: AGHT+IFpdib5eLXvAKlYp3fUyW87rQ1IfZ8GEMoJsXuLGkDw56XS2aTZMwaUmenZ5apuVJAYF/Nggw==
X-Received: by 2002:a17:907:c018:b0:ab7:fc9a:28e2 with SMTP id a640c23a62f3a-abf2681f8f2mr377695266b.47.1740751644708;
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:17 +0000
Subject: [PATCH 04/18] rtc: ds2404: drop needless struct ds2404::rtc member
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
Message-Id: <20250228-rtc-cleanups-v1-4-b44cec078481@linaro.org>
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


