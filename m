Return-Path: <linux-aspeed+bounces-882-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1733C282D5
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvz6K1Mz3bs0;
	Sat,  1 Mar 2025 22:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751656;
	cv=none; b=Q3eHsJqzsWXI0jx9LoCXtRqLfHyb+/edv6Unvnkz/d2/HO4uFSGSc8C588MIdOIyg9wIJ90MKlhgLZVknLkKzP5nayOOd5Tp5t7EphkopTdxeBWO9Esj51EOIIkgQPKp96YjKxRn5fzOqJrGrwmtBfOuycYbqJrdwHLah+QEyLfbPt6a5pCAzBh6movZuhw32QJ59DEMSeSUhcKbwOhpZX2ig1rw4dezPEdha9NZkaApw5qzrZY5u3ek4fSVtArwANu0GGhBfII33O5saptqwoxr5EAbDDXLlriwleHxJqNTBWZKkD+VdEzkPj0lrCYn3FQpg+dp6apXsXQUNLWFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751656; c=relaxed/relaxed;
	bh=ucCmymGJlfsI4F5PNnMG7qiqKtfzqtFmwv0m9GhXqKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P198XSiak/km7/zrmejcyJ7vzvUvWOw1kd9iLSFd3ie6Bsbl9p+gk3RQ9uMrFPhiep51fXL+r1WKYhd6rQkgKVBH8OMKlljc8f7QZYlltc3BbouA0oQW/uk/j5yvQiOk257LrSfeHfOdnHpXHCYCbW5vcaUIM1NC80eaGc7YN6tEUBBvQ2MbdW0UIoTrJcJPsDwjww8fnbsp3yxjJ814+FgopUTc96gWbkvwid+SS1BhO8fPm4Dc/UzXMSuJ8dW7yCbet8/PQIclAAXwfUzINmv/iT/14MIe4RWSa4FpzNCkypnuh2BLMrsWHDGPZlQZK9T461dEpuqbygBELLRqUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iO9ckRHh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iO9ckRHh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495M2blDz3bvd
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:35 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso3226446a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751652; x=1741356452; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucCmymGJlfsI4F5PNnMG7qiqKtfzqtFmwv0m9GhXqKs=;
        b=iO9ckRHhKGPGa9kvgE8sCnkfLBIfDazpGu9c8YmxHSmDZcsnnHtOQ8ze0y0lpEnXhp
         fj+C34tZWB1+I+mXpNSkFWj5q+l7fwIX6g0LDGV1vudu6jCFw9phIF+KAd/LgfnxlZfu
         1ts2U+SE8/YHri7ziMNXiVbLXYVvB4vp8NnIV6HM/vheabyFtZSWPKkp7wPcNw124Mik
         O0QZBOZnGRfpYE7qXj5o7LSk+Pt0pAfvrJrL1qVPTzQqbUGyfPs37Hi5H1E762ZGF4l3
         f9LQZK/pxgsiponccr7yjkASwOT82as2yL3RLd3EYbWmC+vu7eaphiqTFVSKgiNx8LbL
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751652; x=1741356452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucCmymGJlfsI4F5PNnMG7qiqKtfzqtFmwv0m9GhXqKs=;
        b=hut7vcWR60cZSLfx2Prq+Ol6WiM5sw45nfowetwBl4vtb9G2+1AZbODhWCJcjxdcIj
         A+2E1OnpJ2KBTFda5syoD3vHyrDkm/uUK+8dgKNvtSQpfXx0zCCz/RCrMaTZNhtPOY6r
         s7DdlXTYFyU1f9HI9WfUPBExV91zIMthK+qEl8OOFjA/2CvE8jK+s1IX5GgizQPETsCZ
         kemv5Lw8mypjcS3kbFfMRD/n8TiwFbyyRRPRgo/pW3j2WcDU5lZoTelC7d/8uFmquNxk
         I1OaPhj4G19gjK2qAA9/E3yciLmKS4aSmqILHGV1wKm7Vq52kqkeATukIYZmBsilxVoO
         XD7A==
X-Forwarded-Encrypted: i=1; AJvYcCUagaTp6Rkb8pLNlA6gpZpH6r65VdINS2E3oYbL+zXdMR8zME+8cjeKRey5ORD9cECHCX5mzfnE/ysx4Co=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyR8+Wgg9nGKA0F0foJt3WNew6IlwQffi3cE0rFB1xqTQyLP3vE
	IZTz8mHIkW+TnbZH/ftSo0Sg2dj5aukjdSl+vZLeizComxw27Gdmn4p1y+UDKrI=
X-Gm-Gg: ASbGncssgrcONTQz3L4ryn2mqjsL+sIHoKhA8s1ixFsMdbOPbP5U4X6PRLbRsSeKgZD
	AgT4pSUMbhOijPFnyfvYQ31BsQP8fMGWI4HGDxv+b8TZftmHEheTXQp+pzMnI4NQAaII1U1bce/
	r7JidsiZQCT3nYFEd/hR2LqVI4UImhh7tGNG0ZoptVjFXU8WAiXZjMMUwMnQfNIVxwvgjfv4tat
	1/DbaAYCGTkzGcMnzDAm0VpNMKFqNrqaKtNYl3npg+ZQUT6L0Pv4ot73zDSSobMY2N8fPAzPrBU
	I2kTan0SCy2EZGjzULNf1EdaVOld1SdMGTLvgFQuF3mL1bAmShr8xqYcesC57aXjy3R5VldcZJW
	ZIAxBh1ufJA==
X-Google-Smtp-Source: AGHT+IHUtKBxx/Kb6wMivayuykLjA27f1K+WzySysSQHyW8EvpaAIClZC0PRyUOpjP+2MS95jX29jw==
X-Received: by 2002:a05:6402:35cd:b0:5db:f5bc:f696 with SMTP id 4fb4d7f45d1cf-5e4d6ad3e14mr2592499a12.5.1740751652457;
        Fri, 28 Feb 2025 06:07:32 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:31 +0000
Subject: [PATCH 18/18] rtc: s5m: convert to dev_err_probe() where
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
Message-Id: <20250228-rtc-cleanups-v1-18-b44cec078481@linaro.org>
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

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 77dd61c30681b8f0a2f23063ad5f7eb52f5b7158..4c66e38145b02638c48685580c7943bdf79bfbd4 100644
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
 
 	i2c = devm_i2c_new_dummy_device(&pdev->dev, i2c->adapter,
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


