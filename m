Return-Path: <linux-aspeed+bounces-872-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7CC282D1
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvt6f1Sz30gC;
	Sat,  1 Mar 2025 22:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751651;
	cv=none; b=fiUCCtsjp8GRD2E74LJGcSQhqnZCIpwtJ+7rd3NFIzs9Vd/gQgoa68hJ+UUhW2tbCyPnElFPmtbjPepHwYhD3QYe01YOx+M04aVdS+vqM1VVrPjtugSAYzP0LV/ccYpQiskIIKEv2SOOYy3y3aLLQFYFEJ7/L00TZN42X/ymxKDQ64Z4wEK3Id5J+qizh6HudirMF547yzER5HHJJJmJaRlUBfOoIPUfHbK35tqoU69icoOC+yfNQHZlc4XC9aIxKu4d28w24UW/uQK9xaUHKu/U+qMtXOj5QXhrBE2t5fBanZfz1b8/0lKwt76VYjX/eiis6HFs48sw8h0/+F7otQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751651; c=relaxed/relaxed;
	bh=dZH0eiBnc3WyY94yEis5FUZqmpsbyvfcyDb3myV5OX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQjp4nWn9Y7pAnmT9ExEYYmuAzzaU2ouPLK51vcGodnZ1DRMGBoqnstKdU+rU+hKSOo7Ji6LcRA7lfoev19mLOHOJ7qCu+s/+K+an31CQW2n0o1nW0HAK0U20CpQiZdDAEfaabE0byAk5Q1WMpD7mkadQdBYFcBmyv8rA5KNYAS5sYJRYMU9YJe3/VmVCTAruBVwrOZUsLzobwibyA27GI8rfXiT9H9V5ki+MLCLcjNcnNKETbZgMdwdBpwIAAY5RUPcU/9hhx676+DjJr34VotD/+kO/kCswYBPPPnCsxeU6Z7YmuOeJhiE2SUHUx7y0j+qos9rn4KnEnIQN5VooA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IG/p3Bb6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IG/p3Bb6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495F5m68z3bvP
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:29 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso1633738a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751646; x=1741356446; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZH0eiBnc3WyY94yEis5FUZqmpsbyvfcyDb3myV5OX0=;
        b=IG/p3Bb6xwT2sajGPy0wsLY3qnwKce1S5yTesaUX0xHRsDJ4t+oboSqeTfy9dF2gQ7
         jghXtilEkBIblICx0RYVRdmXtrjO4z8r2KAqibSEGAglUUmTv4vTTAg4iCWA2Ax20PBw
         p2JklRxddBQKMnx2rOUEn6Pe+u8CNENUk8+5MnbwPX+89q+ixmkD0Dj0q068EuwG/dcv
         +JnXo8W4YoZQ/IVKlDYGxSxlVaVI7k44SUu46g1jZNYWq/t5Tfm5yEaWJg5nQpaWRkSb
         JcjnkDHxyDsxOlfrnFoKPZl/S2LwHPeJAkEhZx7/uXTc9/SWbOiJKBC2S94IMiWwaltU
         aKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751646; x=1741356446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZH0eiBnc3WyY94yEis5FUZqmpsbyvfcyDb3myV5OX0=;
        b=lenKQjtLCXrsPNkUfI6pN+7R2VEGXnL1doqi/R7ChS9hR/ouKkEY9zVDcAg4sKi94L
         I8uMsPBBXWqdFbDnAoXFKmP5wqNEgj+mlyswX0YtkNdFsTc7CyDHXkKsMpp6I2GrRmel
         s8nLdzywmry+i7HcW+o/IztSq209H1Orsv3eLbqOK0oDuAZ0MVIw2fFlSutqCu3iOKCt
         bA2doUYHKFl/JB6Y19kQPQZdDKCQfIt/LyCRO4jRwzFBOK7fpSuVKMMPfByP10qrWqhg
         97woVRha1T/T9l+H/QBfIn5sA3K7NDracq6gNMX49k2FS0ZgpZ18vK4UukVtJBmzvLNz
         FTqw==
X-Forwarded-Encrypted: i=1; AJvYcCUSnF3GguhSEAtklERyWfiptE++yGtt387TdjaLc8AW3iFKeZHoyP1U76T/MrBq7p4DMxNQM4W6McXpsJU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytMOkqlCMpvV/V2QPV7adoW/klwmfJyNAeP9l9F7ppaOHPWtov
	+qXCcTqaGrMaCYXpkmmNkBj4huLmO4ABIlhsd6HjiR+rxKlEOag49pd5MeyOTC0=
X-Gm-Gg: ASbGncvZ36xc1HWIUf91L4g08Z6EV7ri/ja5ozO0k/uWOQ6LkIgbZL4gtQItPi/TXQT
	xRAEAu133LuChRIc+r5BZJZnQpjgnGNXwdTimaBbGq2XcHTEbE3BJdHjtYaT0C6SBhATFqPkF/C
	/I8X32e0oR+Za7ZA6ra3EH3nOLbo/uQhkFNuOOSaLs/cpnJOiDbFyMjQtBweRXWyA8A+rYXTSI0
	cHOQdD0P7W+Xpj84I2mrPMsYtx35M5wPN8ymLAtVB8mkA/xb7+y6Yspg8tbjPAQdA5cM0grhL/r
	vlSdoSbV5taS4/cqQb2tfuwnTKKaRb6a89o//bos3ghYWgmG9bMYXPjJW1dQaZPCt9vMto/3nNL
	pLHoyAfPNlA==
X-Google-Smtp-Source: AGHT+IFbzXWayjdSMfWjy9cwjYueSFy4YBp7IQ8OjzR2IKI5f4QLOeDnV9cvNi5W4D61UevFMTrZwA==
X-Received: by 2002:a05:6402:239a:b0:5e5:552:32a8 with SMTP id 4fb4d7f45d1cf-5e5055238efmr931950a12.8.1740751645786;
        Fri, 28 Feb 2025 06:07:25 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:25 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:19 +0000
Subject: [PATCH 06/18] rtc: ftrtc010: drop needless struct
 ftrtc010_rtc::rtc_dev member
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
Message-Id: <20250228-rtc-cleanups-v1-6-b44cec078481@linaro.org>
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

The memory pointed to by the ::rtc_dev member is managed via devres,
and no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-ftrtc010.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index cb4a5d101f537e20a685bb022e6f6516b0df8271..02608d3784958e69ec0ecbdb9fcc8b333b19e7cc 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -28,7 +28,6 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
 
 struct ftrtc010_rtc {
-	struct rtc_device	*rtc_dev;
 	void __iomem		*rtc_base;
 	int			rtc_irq;
 	struct clk		*pclk;
@@ -113,6 +112,7 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	struct ftrtc010_rtc *rtc;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct rtc_device *rtc_dev;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -160,29 +160,28 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		goto err_disable_extclk;
 	}
 
-	rtc->rtc_dev = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc_dev)) {
-		ret = PTR_ERR(rtc->rtc_dev);
+	rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
 		goto err_disable_extclk;
 	}
 
-	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
+	rtc_dev->ops = &ftrtc010_rtc_ops;
 
 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
-	rtc->rtc_dev->range_min = (u64)days * 86400 + hour * 3600 +
-				  min * 60 + sec;
-	rtc->rtc_dev->range_max = U32_MAX + rtc->rtc_dev->range_min;
+	rtc_dev->range_min = (u64)days * 86400 + hour * 3600 + min * 60 + sec;
+	rtc_dev->range_max = U32_MAX + rtc_dev->range_min;
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
 		goto err_disable_extclk;
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	return devm_rtc_register_device(rtc_dev);
 
 err_disable_extclk:
 	clk_disable_unprepare(rtc->extclk);

-- 
2.48.1.711.g2feabab25a-goog


