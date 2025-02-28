Return-Path: <linux-aspeed+bounces-885-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA72C282D2
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw06drHz3c6C;
	Sat,  1 Mar 2025 22:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751650;
	cv=none; b=fFGOtlQMj3e8fZP+XVntAem0gfKE38K8Jt6mJ0Bd9+0uNXuuqpZy2FBST0icWdQ/NyJqA4K5aLg5qs09jlXt7hASI9N8pcM6gXY+yXZx2q6YISbC0ZgAJaXvPYMueh3ByWijnV1zfsq636oOCg/I+Gii8eNLHRP657jpeNmAeklxT5YHAqmZrUeisrL8+jgpt2j9WHPOdODCcK/5xUt8au3f1vBuRXiJYxINAIPbssuRRtJ5rJPqMUE8kB4p8tVwQ6u10fyDeMbpsVqiUHY4WSOlcNsGszwfMe6p8nqxch6okyHEzxJ61gtNl6AFqyw6jQL2hr6Pm4UvzcvxcDcRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751650; c=relaxed/relaxed;
	bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcqn4mrCloK02v4F43UjY2qb1/MN+u5HH/7Kf1Sqf4sFjMmiMjL0rmfZojFZbS+sKxteVKOQ/qQ+j4sn0ec9po8onmyw4Dc5aA1VGTMnzfbzGA05UJEIGjloH4fqdCYhzVRSDU1Sy3ZivY8soi3NMGh/0VmTc2nPaojfN6lluSK+vnmJtau9qg2d0MEA+ppg3+Psh+DIAHOpORUARIShVKhSncKI1e+ednSii+4O55KNqzIsgYh8OxKzp6DwAQvwMSd/nNKw5K2ne7OvtBC297vN/m2+pWbggTpFy6aSpVCSEnidJygfN3QOBMamkkzdg9FblZeKDomvkI9WqpNXEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VZ4xkkSH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VZ4xkkSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495D1dzdz3bvJ
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:28 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so3473752a12.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751645; x=1741356445; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=VZ4xkkSHgjVJXnueSk9MRhix2+IQVgo805721LazuEhdAK50Pj9CLOjyN0ypzrnA8M
         wmxHt2SSFxy7UJ1twpc5jmVXI50PvQ6HZvcruPAAWSFYbEDGkNKWIrylv2wuTCRH6biy
         jCnfuPQkOxWOOP6V69msLDEQgBg1dJQLPsWXR4sZQgg6zU/xmQC1TVUywUKusxb7+P6Z
         z5uh70EtBCWrRujy0/t+DhEYu2i2sq8tReEQjFqlXS/5vumreTn3h1tgwR3d8S5JZNYQ
         kZM8xTtRsuzdirSbTcSzBUrJrjIP96Bja30rCr2V76WhoKswqT5b2ag0tZ7CRH9TLks1
         xb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751645; x=1741356445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=CbgoaGgQkTw9S6iQDlRu1G33tVH5gWM1jKHtbHCGvZhfXoo1uUqYjNuEYbRtwXd4nN
         aPnboL4bFE/rzBi57I8S24myUbPVKQugHIvc3Hzn+OYSuMmWBpV5+iVdpnplxBuAJjau
         Q7z7EichRjzUvfCVFpuBXQBRV8W7A536YQKAnYVv9MTBbKzakutzlz0kvDKsJLdcMpXF
         cw0D+yfBST1GAwsIAtw8zQbyrEIWW/lo8RtRivtP6A9024hbDbXa4Yr3x/jfjSuh+67Y
         s/fC1hbPWYw5jQumFPiXvatfiQhajkKS+a1nGSHT+IfLATGlyVJU8kKf4yY9I3OF3QRW
         0Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCVfUYe/jyX1QDu3yZL1yNCYx+jaO7fJ2E2gdt+cilIvOXlpM+wNS557dPKQUA0ghNbbNjGiuQd9lpFydOk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwErHMf6+zmnz4xzqJ45F4Goiq8LqzZa9Ru7ytaLPF7doeZ8l/3
	/GD0zvrtSKXNei+L9/Fmc41bYB74RPoZewmE5YW843jjWYDp9RTC8e9CQAjYKsI=
X-Gm-Gg: ASbGncst8s+Hqpk/vF8l7OI51bxMuDjnrgkGCJ3A0eQSnamvd3m8N16QXJ5H3SARbkI
	izOM5sdmM8/CJvPjwHbFjZIFPJ7A4dsMd6i5RwegbUbHxK/jfMA4UXf9tToTlZRrABpUaClpREX
	aIxjYT2sf4qre3oLFiKm9RZ3D9ZeNXLJzBvVr5Ao8hx5UXYAhCixOtl2yDcyAeKzGKzLNXfUj+4
	x+sp2vxqkjE5vahsIlUMnBYkybWss+4lkQOWGf/xdfRgUHnZpks6/1fif8P6gqJx8/nhoGX4qtk
	9CJizxmwinPXwHKyhlN0tO556g/SPgrfkNbN6Ou2vMTx+62kdVVXOdxg3mxY6QXjILVfUkVRuAD
	LrIquDSVGMw==
X-Google-Smtp-Source: AGHT+IFjP5A5it0oOhAqjGMiq+zBlLn6/wyStXZ9TEpg3CsfQx18Ux73fzaAw5ZlIGleu7roV3QB1Q==
X-Received: by 2002:a05:6402:84d:b0:5df:5188:11cc with SMTP id 4fb4d7f45d1cf-5e4d6b702a7mr2552045a12.20.1740751645245;
        Fri, 28 Feb 2025 06:07:25 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:18 +0000
Subject: [PATCH 05/18] rtc: ep93xx: drop needless struct ep93xx_rtc::rtc
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
Message-Id: <20250228-rtc-cleanups-v1-5-b44cec078481@linaro.org>
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


