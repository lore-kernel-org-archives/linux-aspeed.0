Return-Path: <linux-aspeed+bounces-938-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A4C282D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWg3Q4Kz3bsQ;
	Wed,  5 Mar 2025 10:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107940;
	cv=none; b=T4up7rkfLVl/iq8zWycs3ud9PiMHYV4Y/a782hbsCZDEHhlQEhRijsBsfU0u2epn/bGOwJb6Rq7iZ4NScq1ToeiIwH7qMtRvrZVzdRUeXbfS9xGNB8mv5YyfQzDrs7banQD2M1KYojtFDo80raSn3aSI+EtxpsN3GgMMlpG2EjKXoMWxHh/inL7jF+nM6Bd5AR7Tdo0cEH2UjT7rphTWd64Tr5Drs/ErE8vXr86q1+nYqYFbxo0nblfIGZRpN+MoQ8ESKAMV4CvQIfkjWhLsFuD6saIipydJWzIvP2FENbwIGG9ltPKHBkQJJAaTad0fb6pZNCoxHiCXQuD1VhqdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107940; c=relaxed/relaxed;
	bh=LQ1rnmYNsg12IhA38qEJtyyMHRjZg5dsRkHMsIbiHfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVLtgT+tPI3BI+xunDR/xoWglCkTkHsi6YgcmXzcl4CniS0GA9ArNArhYGtd8N/jSpqBr17AQ6dpbbfWzNFNkh/jMmJtgK0v4V3hUUnWz93lTsdi1jYBtMmkBcimRC4Hwsv/Pgvjb0IExeGQ0+3LEmkiotHDYtE1K4Ce67U0T65BfdilQyhxCFdKLgUruHErKOaYhNeYTWOSfalLOH/RMyRG3EXo1VHWRNSAbReOffADHHa3MQFeFne9cDqx3hGoj7bod2ZrZFJ4MWD47cms8hKrE/dPiFcDQg/9LwocjT25LxK3g95z+zZ7AHM5cHhZhRTfssKVNc/pIl+1ei1lzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HB6V6GBb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HB6V6GBb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hry4vGnz3bqC
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:38 +1100 (AEDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso21766b.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107935; x=1741712735; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ1rnmYNsg12IhA38qEJtyyMHRjZg5dsRkHMsIbiHfY=;
        b=HB6V6GBbPVBpxO4Ao24Ffm2xraR+JgQZVvHqnqcxRAUmSHcAvrC8YbLRe05TIHP+BL
         H65L8RYijRWy2ogbQpFKFm/wzI61oKzEo/l7CmL1rOlZdWQ9ultBMyD5vN5+Cqcxopdo
         t51p8LcJfm395O00AuKF7TsnLh3dBDMEu9WbNL004X3nrl36mSpdhNx4971+yiqV5Gap
         aj1AcAF8taIwo1mjSaP+SKMBm34BaLIRMikYEKF1eJ7RzHvSeun8s3l5QtpI0EtuNK7U
         ORL2U/tKeLNsmuVDbTr1xYfhxUJ5EUCXCxV1GR/poDG2KxMSfTGY9o0A5ezx+Z4mbgsc
         8a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107935; x=1741712735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ1rnmYNsg12IhA38qEJtyyMHRjZg5dsRkHMsIbiHfY=;
        b=RssVNnaiB1y+4PfzSKEthBnGOw8Tp2ldMVx1NMWDy6Nc49WtpHSkjd5FVk+7+7tBgq
         ervKaRanRCu/CiAfPMQXphG/49Ev8XS8SU4U2fM2Jqwd2UWOnl0vgKJ0ZdgPLiTJAINY
         94gP1Isw69HpO/ztMTnAxpnZIdNAV5KUTi+4vdr3vuhm5KCcw75hf5QFd9Y4JUu8P6Bx
         Rj0Pq0qOsIFwlfWYm+YL2nAstX5FHUYqWcbNRXNhHZ+zvYA6Efalko1V+/J/p+Oe27f6
         Wp39D+j42elf8ShqLqt0p2PZFXd5P/Exl/ZgUO933kl2DDgwXNdW9n18zB+OoA1rwpTO
         vwlw==
X-Forwarded-Encrypted: i=1; AJvYcCVViHpjc14LzuVNVuH885qatxWngcMTc1Mdk1Zwtn61ZJXMKgVBsEd9NFasPEkhWU6qjfAuCpM6X/Qe+w0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyDgcJqWYNNoLMLlsGDv2zZA46cYYja9CulZCS2/02n/So0IyP
	2dM1GQP3tpqfbKz7OWdwMxQohAlnXuEhn+em6pfDGbzaN0juiG3ePJiAMbMZ0Es=
X-Gm-Gg: ASbGncsWjQitO8Q5CEkxAHsFpt6Dl7vWYlXGF8EIQH210jvGylWWoPUnOKVIJ5BE4Tc
	f7LLA2gSG8dgtS+m7b3+/MePc2f/qw1zAulgDaiEe7cxpyceRyl4cDSxDNsa+7AyE9eJKeuuPiW
	1dKfj/lMFlLTjdOwZgf4XThIYMm8AJYfEFbCgHCi26DPfBHh8eehlYoeTVPWqceJfXfPmf8f0k3
	4a/xOoY12O5wrI5ZBiyMmWgdobNtAG04C5zL6PyXR4UeIe/xhH50x8GGubCkIbtebs3agG37ylo
	eUfp1864pWN/uWcf3Y7DoPad4PZcjh+zGZfIQYbCBM7bWFvrsU0Z43U3UEcF84Clsv3D/3TyKDB
	/F87UMXR+cp6NZDDO0trawWxNRklD
X-Google-Smtp-Source: AGHT+IEctYzZlVVwQPucj8CUHKEVuZPV8n583Yq6QohmEvkW8JU3S9SRTA4/uuDakASHnMKJ8bAleA==
X-Received: by 2002:a17:906:3814:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-ac1f11e6c1dmr291303166b.21.1741107935167;
        Tue, 04 Mar 2025 09:05:35 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:34 +0000
Subject: [PATCH v2 06/16] rtc: ftrtc010: drop needless struct
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
Message-Id: <20250304-rtc-cleanups-v2-6-d4689a71668c@linaro.org>
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

The memory pointed to by the ::rtc_dev member is managed via devres,
and no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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


