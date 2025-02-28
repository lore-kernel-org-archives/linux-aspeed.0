Return-Path: <linux-aspeed+bounces-879-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D49C282D4
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvy6gGPz3btt;
	Sat,  1 Mar 2025 22:01:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751650;
	cv=none; b=E06SL22x2bdxlmtsjWFf/nFC5z/qm6G/QzxeYQz/3GmQ60waFpoVV4janNP76PZkWL6PjQyuuvQiLFcpg+hBaG4txJsMR0v5cgRlyoJcK14wuHXgIU0ShUQ8F5JCXYGHFIwTzcNyLQJLuGeDDKY51g9NknMr3Y2Z9KCp7TuDHOFdyLUDI8DX7mKtE37clHVvn6tGVPN4DiWxCsXEtIXxdmrUde4csQBFUiMKv+ZOYAiptfA4FdgMEXkPGYuQMUiKBmOlZNup2RnnoiniBzvfhsJcneb3/KGJXWCy/5d/8c2CSgfUKufEFJXwly7kEyaWF8ow5sditBmrSTj/EiV5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751650; c=relaxed/relaxed;
	bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leunle+GgvUmKyOCLnw/VAEuFRmA8d48hc/3dA+SnOe3pHGTGWkjaPneq8+uioBkePNpNJIKd0eOTmF7ewiqGgm0lVM5J43WuWgXmgN/CJQGkUwac9Jz6J1jC7fJD0MoIaklHrgkceaP0/3By0rsqdb2eizyzpt0463AseCwgvCsDgQV3WyM5VEPNrwFF3QQMkxUWyQIsIR47OFJQTXRtB3n++WpgkLk/UUxnFoetqQRWfoC/Mbc6OBAZlagRpSGMvM0hvKraMsdghPAEAFV8IPmt8o0I75d4tvDkE9hLGlMbcCFkNQTrfwZl2Z1+GKrJIld56fMBGDRg8G3nGkn/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c2pDZVdN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c2pDZVdN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495C6f18z3btn
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:27 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3851604a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751644; x=1741356444; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=c2pDZVdNeK8Tvzoz80PfQYO2td0wqtVxVFamcc4zwrzvK7j7RzwTFlcgQuCQqWym5G
         2LSEQ5YleKnNE15Ky5tqVnNZk9iMbtncO9sROwPOWMReAQvjsdHJkkJVU/fClt6W7EDs
         eEWVW9xZf2qAINFSuPc1lMqpj1qfdAueLMcNNPTHrDzyJcuXFLfrHiyG919B6OxRSqPI
         F1LHCPGZz2enefcNRTBbP3QypkfZNogc3i4lUtyt1uRxPQITxDo5k8fq+fER+sCNsDNO
         xeQhkXy/LU1V/syJMQ70vddfbiZTjE5OykGjwZ/8wh4PfTWMqTD5xQEIugbXDrCeLfGB
         BhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751644; x=1741356444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=COfFkhp+FIw1AQAj1b7c5RbRhJBKz8ZkFbBroNXhL6bJmovFcHwILic2/xgIpqOP4l
         s+2KyJoIfWEaMTpavKt/HnsJvmTEXFUUii5OUwvxuECCJR4LAO0hjjbcgunXCKE7O5WB
         foIQx7M5d1O99aS963KvoBVm4PrCicHAS7ckPcRFfOb3pHQOi7e5Uz5tTsC26hGmqnYr
         zacHLaek52BPcdRypKZgf74hJAYrKZlBbijLNXZeMSj0FvEUJKqUrsg4VWL7+CsC/pJG
         QKlAbyAz3gq8gVRf1lujD4yM/RHhCN/JajD/RHNw+ddwwrn5s/HLA1Zht9Vv3m/U/DsO
         VEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkY44irHQ3lDB/xeVj+eJmeKqI1dvgYZkP8INlZdLCwM59F3sEdidZD/lDex1QDLxJHMYhy7Q0jCOTze0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJbvP57yLduDTPEDd03URFetpyfeN4+FLyxccMa6+kEVmOwTbd
	QMpnrgqGz9/si1kuwbfB30rCfRwSsXbWAWKT2Ehp5R4crRkSDP+ve7HxlLRnajQ=
X-Gm-Gg: ASbGncvpZmDG53Xf7jr3faqdeYpjLsexhU0YMsv3F8Ev8zoBI97Q0BRKaRQjI6rTqnv
	6kugbGovpMqvPRziqWDg68sx5c+N27ez2SNM6ljM7V1O6sk+GOLNJ/1wJT6znC1HY4GPXzCSDqB
	ByuhEo/qyuDcWFvVyUISDrJhWmXF70k/7Bje8khkU4VzT9gcpA3t2Eyn0NWeYBrwYqis3IKvnxi
	MHT1MUbyWjDjvmELcI94+1YBclAkjur3xfNfEwswSIB2PuBMBliZwOtoCDWHhLLSH01xUAWEIAo
	flsmBy8ksQdG31M7Eoml0MO994thzVgHUEOTKUi9I/QZul6XwP0FubiHu8kv8ZfV4gVFXCz3RNe
	kPPX13XFkAA==
X-Google-Smtp-Source: AGHT+IESLHMD1ALp0fl5UNtQkvu55XFyzsWGAW2ARn4G0KwygGU8Ail6xNyHqVhAMNH9i4466iKXaA==
X-Received: by 2002:a05:6402:848:b0:5dc:d10a:1be8 with SMTP id 4fb4d7f45d1cf-5e4d6b0e6c9mr2959043a12.19.1740751643974;
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:16 +0000
Subject: [PATCH 03/18] rtc: aspeed: drop needless struct
 aspeed_rtc::rtc_dev member
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
Message-Id: <20250228-rtc-cleanups-v1-3-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-aspeed.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index 880b015eebaf796f68ed82c29998f345e1fd418b..0d0053b52f9b90a61725bf29435bfc8071977f9e 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 
 struct aspeed_rtc {
-	struct rtc_device *rtc_dev;
 	void __iomem *base;
 };
 
@@ -85,6 +84,7 @@ static const struct rtc_class_ops aspeed_rtc_ops = {
 static int aspeed_rtc_probe(struct platform_device *pdev)
 {
 	struct aspeed_rtc *rtc;
+	struct rtc_device *rtc_dev;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -94,17 +94,17 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev->ops = &aspeed_rtc_ops;
-	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
-	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
+	rtc_dev->ops = &aspeed_rtc_ops;
+	rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	return devm_rtc_register_device(rtc_dev);
 }
 
 static const struct of_device_id aspeed_rtc_match[] = {

-- 
2.48.1.711.g2feabab25a-goog


