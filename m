Return-Path: <linux-aspeed+bounces-951-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEDC282D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWm23S0z3brC;
	Wed,  5 Mar 2025 10:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107940;
	cv=none; b=Xi7WorwJza4SBwtg+zC6zEcm8H3AymfLDIAseMmelSeVnqt9diSYCyXhLviwEsh++WA7PQtG6DI81/KRyaQPwPjFMr3egRYEaFuRGrzjBZlxnqyHb1097P57WDH3zdCBWeBVxzUvSjBuN/wLaYysfQynNbQcXzHn3JJE8NjigxEfsr/id1b6Zy786bCBJySp41fTwnwYsI1Rd8PlAqSroq0H0SzQzpfIL0Mo6JqALYtRlbHWXliWGg9BBZgv9DZFqG+gESYMT0mhs5yEh0eVFTpeX1OUFDylyqLifyZmKLxgUIyQJB/3OYVteQ6YENS/ejrteXkJTnKmU2Ao9uYoew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107940; c=relaxed/relaxed;
	bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TpLx07HH8UbmkuTgOrPsxG1o1CifR1XO4WvpcCbqS2W96VVgRTNppX5ZSYGd64ldOvK3EHqBXd+CrqVeiiTX39wmdkUw5FFDteWzcTps/215ohEAk/HSV9Cak7bjOc7lRwxq1Bnz0BTGUvsF7IihWv9K8y4AQFqJuRbJnVRHEqy+AlkLfMoxrIh5d6d1o9XymnQQl4HHFIIp7rC1UZnvPnKerKkIQHixFUJSbNDKd6tdiNmkLhJ3vQ7RAxLfOBn8nSOqRrw2lSqZBg/Uv9uJ+tGRFGRIyjohuXWNWz8qrGweWeq9zxaAqCqBXCNg7bJ+Fi61CbhcJfxEiq1p5xd6zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=de2DxrTP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=de2DxrTP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrx4dkkz3bpn
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:37 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-abf4cebb04dso643804166b.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107934; x=1741712734; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=de2DxrTPkmB7q/Zw+gB2as/h+0BJoLbEcUV6RBnpekVO00pl1vDMRSu1ZjzuUaXS+y
         1+G6lMPr7xqrMUjcTgBJc8ZjngIan0PhsJ6qWVOdpaNF1TABMZK56UCBn8NVBxynP1Nb
         scp9/8BvOXJEwftgxuJWh1pssnDpbjN0jqxaCG1FKhYVKYcqzTpIdlZS41N25OOxf7yN
         l43zFl6yQAAMgMHFKVb1mjZW6Q1a6awbQHSztlfabX0X7E2fCeof+AWzHMnV826rK1Bf
         jJgJkG50ewXjKaBoQEun9q+aXNMqT38NrmqgrKxYZl20WrOTsU3wcM5aFOJuRytKIjXM
         +7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107934; x=1741712734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=bak3FqoKvFkH5xhC7NRz69jHhEuM0dlPp+gKY0RDt6CEC+fSsyoAZjLO1P0WAWdKv3
         boGG5aRW2ebPskLttfmUvZfX0864qzmnYd8mANh69V8uqnUIx2vsf69QTrJchf09F1I6
         Nq9N0C9ZBMbcIyDhUaEWS/TOXuUVyipQQT0Z9QfkpowLnygmPpBpjMJRWc8CL6MEMW01
         5wqhc+zmNrQv0OpZQVIT65zquWguA83xZ3tCfRGLIE5LtaN5POy9ujMzSsj7LlM1V5Dm
         YawBiC+E9iIUphMcVFw6j3Rp2OMrlzZJZhvIQRwy8rYz4yVyUQyjgwC0hSIn3/Ls//2E
         yq/w==
X-Forwarded-Encrypted: i=1; AJvYcCUJmkvTcoun32ky/nk9gYYDWi44wsMYRDNfeBxS3N0zB6SL6zG5OcFyn/DlUqvJZWHqwVayNlEuKibSdPU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw31EqsGF2+NgCI5LrGacTlU/kmqJTwHlc/0WWSHbdzZERFNYkB
	dxSYRWDlG6ETWnxpSKBdm80E2EUIyjqqyk+zNLY3WcN3qGPbGZml4ZPY+NOfyHE=
X-Gm-Gg: ASbGncvZjqRycM9z/IyCaWqvCl9Eb1gHcj4NuVG6b3SubjF3mHIfM3+318Eo0L/bBge
	t/bXbvK50UwXGvVe99jfY96hEQArF8MtsPh74hbTAXd6qwHP8xv30GjKDtc7zjhzZDN0ozHQbAS
	98HIEso7ud2C5z/hENLWFBzVbXuGNvnkmCN7Zcem6l9wWa1Ai0o/Y3Wvd0Oh3YVqgeyXTyi/nGA
	owbU+1QXnqnOW0R42axVaOi6cCLZGHeVpQIRwpsLg7sDNAguhxOUcrGR9qtpEDPmMIYhNhSysLc
	/hODTeQp6g+7+g6kfNC69kp/676Mf/Tf9uZE0KgweUNZuhaohmp29RE9SRSYI46XOdIx3A6DMM9
	o2fVB/dLEHS1zq7JxHXVw23LIG7Ml
X-Google-Smtp-Source: AGHT+IGsdjvAcycMp31oFEdsdwWFqJQmXbxtDBoL5DRz6SC3HgSNRmbkL1ZXNDzmFm2b5aF1OyYNnA==
X-Received: by 2002:a17:906:c150:b0:abf:4a62:6e5b with SMTP id a640c23a62f3a-ac1f0e60023mr427555766b.5.1741107934486;
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:33 +0000
Subject: [PATCH v2 05/16] rtc: ep93xx: drop needless struct ep93xx_rtc::rtc
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
Message-Id: <20250304-rtc-cleanups-v2-5-d4689a71668c@linaro.org>
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

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-ep93xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 1fdd20d01560ef4fae2b996cf366b4f812329225..dcdcdd06f30d1ff6d0939f6bcad2c17c03c5a65e 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -28,7 +28,6 @@
 
 struct ep93xx_rtc {
 	void __iomem	*mmio_base;
-	struct rtc_device *rtc;
 };
 
 static int ep93xx_rtc_get_swcomp(struct device *dev, unsigned short *preload,
@@ -123,6 +122,7 @@ static const struct attribute_group ep93xx_rtc_sysfs_files = {
 static int ep93xx_rtc_probe(struct platform_device *pdev)
 {
 	struct ep93xx_rtc *ep93xx_rtc;
+	struct rtc_device *rtc;
 	int err;
 
 	ep93xx_rtc = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_rtc), GFP_KERNEL);
@@ -135,18 +135,18 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ep93xx_rtc);
 
-	ep93xx_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(ep93xx_rtc->rtc))
-		return PTR_ERR(ep93xx_rtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	ep93xx_rtc->rtc->ops = &ep93xx_rtc_ops;
-	ep93xx_rtc->rtc->range_max = U32_MAX;
+	rtc->ops = &ep93xx_rtc_ops;
+	rtc->range_max = U32_MAX;
 
-	err = rtc_add_group(ep93xx_rtc->rtc, &ep93xx_rtc_sysfs_files);
+	err = rtc_add_group(rtc, &ep93xx_rtc_sysfs_files);
 	if (err)
 		return err;
 
-	return devm_rtc_register_device(ep93xx_rtc->rtc);
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct of_device_id ep93xx_rtc_of_ids[] = {

-- 
2.48.1.711.g2feabab25a-goog


