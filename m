Return-Path: <linux-aspeed+bounces-942-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BF8C282D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWh1mvSz3bv8;
	Wed,  5 Mar 2025 10:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107946;
	cv=none; b=A3euRG9E/1vpA6xG4J+FxxnDMUIRm4oP362pCQHjnzGj1dtk9Gu/8qHK/RaCNPlXBaPxRFWjnA1iiy8DmIGg9esWEJBJ/209BBBd+DbvSgcIyvXDpYUgF/7Rc3a4rktunXTiSrx1+4BnhvLHXS5pWWb/y7tLZXvrHD1ZAS49DmNptEFIWCKNkZDhuW6UAlkvekjXl6WbA5/lIgTwh5G5tonrNAf+QHuyjybHrO8E829IcGZ06ggMWxYWIOCb7EkhoB1bj2pR4qgpMEc6Da8Q+mFxSwGqkqWhgBjURcbcGgam/t0C9J8G9Mst9wZvY8G6AiuRES3SA3DyIV/fWTDLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107946; c=relaxed/relaxed;
	bh=dKiEbfv2wxdcP+dRwBnTiew8ux2INId3e+zLxFho3GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRvXORNiLxEx5PFwbPKijyaQechFDtAHk5JL9PLy9ovpu75j6CgGo9VaTRMbWbbuc737hIrqt3X7VlZTVAXJWs3zD+XPzzLuYxwpcrYwAadIU5Ejg7SALSE9ynnheuOHvntwnapfV3vgWNMlSXUPN1sebccBvcw46Y+YhEGoYk3Y7OFfL7j0beuPW3G90PsA7CH3VvSrO6gZmVwSlWHtmmq4S4beNSmpvGLwwRCbrnXMNhXG4TzxUGXg56AxlQzMuFksHO8LebJE7HkAi5yCS1+YaGAfhja6+hzFWYMUbJ7SWDMfWYmwEAEsoPWdrLfEDw2kSYQBwqaMkTdUxfXkWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Bb1wFIEy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Bb1wFIEy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs54DKHz3bpx
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:45 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-abf4d756135so566785966b.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107942; x=1741712742; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKiEbfv2wxdcP+dRwBnTiew8ux2INId3e+zLxFho3GE=;
        b=Bb1wFIEySDpAaHN2ypHdHqbwMlao4l2yEJIJYgVEylEWqMEzXy7dX8O+SkpthmgMkO
         1DxosU2J42eORjbvq2GHiPzmDzRahyCQ9jbv26DVrCCConOaitXK80lHAO03VGELUvxs
         8PhHB53A6Ql8e3jE4Ly52YUhGz3dUrTTv3mNVj9phT4xrZau/bU+OKdjVZT1iaJRTuq1
         XveGUVq6jIwa79ywRZj/pLe2jPCxWO3b/wVfkr5/fcCUJrtyF+9rOQ5HMcZ1WOWxRbng
         qy+ug2gj4UnD1fiKGiM/HQ7mW0ZgaENNPN0ICV2wtAcy9XcHzUBSPxUdw5A0oDG38Clo
         E/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107942; x=1741712742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKiEbfv2wxdcP+dRwBnTiew8ux2INId3e+zLxFho3GE=;
        b=xPOg1kIW2bARRXIrdVc4vmZoyOl3yTvDzWt5vx4aN9DZhAWln3QSBGbRIbzfQTg+es
         PuK4m/mYhBdG31bCgawiH4sSf3143w3mjGdUR54nuV28I1pCrYuHJ4f1jlMAJCs2tmuQ
         NH8cxEBGMvh+5ciqbwzV64FT/f3kXT8GLTpMF/typ2JTWc4YTaHr7hdL55WSLDQJDXbz
         DcISugx/e367DSpwc/eWXm/2WP5W7A6q82t3agqhgU1VP+lyyT1l8Jzp4ejqu4sqlgeH
         ctL3LkHgDiroj0IzFiCOtJm6caqbMYlhACwlCiGxuPlumrbePfFi+ksH6L6yqJe968dm
         bK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNAM9VyL9dsxVx1x79B35vsCit3Z/FL9tEPkTl9xy/ibWM1nLdAKfHSkAQrE69FVHhD2dp8OcfpNcXWsc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7xiTmmOJZSenGGL8tbSL14yBYsbXtR1Gpzzc3+jTiNZ0mpoI8
	u2bXf/uu8PfsnXpaUIxFXc6h08wdluTCcu6b7h1iyU6BzW4nJ5OFSG3077CB7tc=
X-Gm-Gg: ASbGncu1ZCMSQ3LINhdZZwY3LxApEeLXWt3nDQ0+8rVW95WWpD9BewvyZ1gZoncHBTV
	GCiXP7zrvSbjjtXKGG96vPE/6xUkF/c/RhigYPlIQzxgjxv29nhKZ7GHfxB2hBxuhEKoS+ikZk7
	N6IfE0cbqR9RoD/wGANYnSPSvTiAgagB0aGJ1TJge0hRNu5TRMTW5p7Ha4vWMUpUUT9+jHREiS1
	pctKP6l0qCUshWLvrHtzMoQL1AyJSgogncJE68D+PA7rK/KRGkFGVD7Dj+5demUBGfOUEJ5d8SD
	PbPMhx93utOAOffb7YoabLSt82rpCBoCIqTVM1t63jVCpKUNwtR2GgSMVSdRfu/hUcNouoC/1KV
	cEcM03ZcseLtpO4zvkPZd4JPpYHkk
X-Google-Smtp-Source: AGHT+IFbhvINfL30hs3YpvAxvNGhpuF08a7SPp+ErND7dZCCpi05AobDmHrT2jaUznfQQ+NeOSHQXw==
X-Received: by 2002:a17:907:2d0d:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-ac20da97c7dmr2947466b.46.1741107942351;
        Tue, 04 Mar 2025 09:05:42 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:41 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:44 +0000
Subject: [PATCH v2 16/16] rtc: s5m: convert to dev_err_probe() where
 appropriate
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
Message-Id: <20250304-rtc-cleanups-v2-16-d4689a71668c@linaro.org>
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

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 88aed27660348a05886f080a2848fcabbf9666d0..db5c9b641277213aa1371776c63e2eda3f223465 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -626,11 +626,10 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 	}
 
 	info->rtc_24hr_mode = 1;
-	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write controlm reg(%d)\n",
-			__func__, ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(info->dev, ret,
+				     "%s: fail to write controlm reg\n",
+				     __func__);
 
 	return ret;
 }
@@ -669,26 +668,21 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		alarm_irq = S5M8767_IRQ_RTCA1;
 		break;
 	default:
-		dev_err(&pdev->dev,
-				"Device type %lu is not supported by RTC driver\n",
-				platform_get_device_id(pdev)->driver_data);
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Device type %lu is not supported by RTC driver\n",
+				     platform_get_device_id(pdev)->driver_data);
 	}
 
 	i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
 					RTC_I2C_ADDR);
-	if (IS_ERR(i2c)) {
-		dev_err(&pdev->dev, "Failed to allocate I2C for RTC\n");
-		return PTR_ERR(i2c);
-	}
+	if (IS_ERR(i2c))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c),
+				     "Failed to allocate I2C for RTC\n");
 
 	info->regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
-	if (IS_ERR(info->regmap)) {
-		ret = PTR_ERR(info->regmap);
-		dev_err(&pdev->dev, "Failed to allocate RTC register map: %d\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(info->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->regmap),
+				     "Failed to allocate RTC register map\n");
 
 	info->dev = &pdev->dev;
 	info->s5m87xx = s5m87xx;
@@ -696,11 +690,10 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	if (s5m87xx->irq_data) {
 		info->irq = regmap_irq_get_virq(s5m87xx->irq_data, alarm_irq);
-		if (info->irq <= 0) {
-			dev_err(&pdev->dev, "Failed to get virtual IRQ %d\n",
-				alarm_irq);
-			return -EINVAL;
-		}
+		if (info->irq <= 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Failed to get virtual IRQ %d\n",
+					     alarm_irq);
 	}
 
 	platform_set_drvdata(pdev, info);
@@ -724,11 +717,10 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
 						s5m_rtc_alarm_irq, 0, "rtc-alarm0",
 						info);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
-				info->irq, ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to request alarm IRQ %d\n",
+					     info->irq);
 		device_init_wakeup(&pdev->dev, true);
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


