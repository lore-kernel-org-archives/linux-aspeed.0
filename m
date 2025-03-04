Return-Path: <linux-aspeed+bounces-946-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D99C282E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWj5Jdxz30Ns;
	Wed,  5 Mar 2025 10:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107945;
	cv=none; b=GeJXI3SDqkntWFNhiB+DSmAH+s+RqMJFJvxCnEhJLQ1SFsGn/uN/CnfHcCMD1VGD/udeu33dE407nBnHTZ7RUUmK0XHY4L9Z0yY7o4MLfFfUMFQW3Iah5qv2fS0NvTLXyAFGWlVrZsGOGNIJOHPTOnRDXj2QIcLV5iLSBpZxsBaF2qCBusI/uN2C+6O4s9q/HJg3akiu6K/+xYzfgxEd7GCabiPgwKCm6RIuXJ297xtdtuXlB/ylSt5tA+S6A8IPBtV8nyErNgvqExfyCzmwGTxVQWvvnaGe3S6bpxqhLItJTN2PreQQcMeBUgc079dGz0H0F4laGI2VK6Fs/q2x0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107945; c=relaxed/relaxed;
	bh=2+a3Z9er7HS5GhzYho010S7pznnO0QcQ46P/wgZR3Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGJonTl1HRzH4tvKMFRPWb3JUydQa5NIjVxg1A7qVf2wcxbcSTosD0YGIb1gA2WTXXCrNNoC8y9uzXdwUyDMD3PGvsgtaYUq6KpWNVkrYhSHvPsLYBjru2uKIT41QCEWL1lHb217wgo1XXIynpWGko/5Jj0NIZzkbva7NEcqdXTL+K9Iok6dPHHNswDLUIhXZ6+l7Mi9UVzqg0edHAZ/ezMrWjNomqpM/8WXo6GWVS/GVxRyr/ioEUMmpjXa2UPaICGE2znhjj2YiVrWD/9Cazk+o7h2A+MxikmqIl8mb76OX0yqPF7F1h4MQZliUbwoMRCLYBzCGSAr6o30hAqT0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sZ1aFMnn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sZ1aFMnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs45MrJz3bpM
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:44 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-390ec449556so4764854f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107942; x=1741712742; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+a3Z9er7HS5GhzYho010S7pznnO0QcQ46P/wgZR3Rg=;
        b=sZ1aFMnn96nB2L8n5Tx1Qib+qPe9Q3O53WUSxZ/6UUSzWz9DkFvunKCGSzFPaptt5e
         avfKJ1t34wECN5VZL9jMtL1fgwIS/Jcr9nnzLmEHP2skZ6xuIdt2uALcwvdJXSi1H3f2
         xukQmtR6mjdqO/dI1D1XkVx/uLM526X/0as3fNUX4d3nnaYg8OcvhllqKIEkYaV8SqHG
         w45eBpFyiQzBd8S7bYchxi1omikCmErq0BlzENnBw0tVEJHvA/4twFRLn5NvCPumTyLc
         OYY1LZzbUR79G8ERYyVsoE54xIpTTLhdk23q60BBy+8SAJQZNbrGTAjAJv4F7alFrt8n
         oZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107942; x=1741712742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+a3Z9er7HS5GhzYho010S7pznnO0QcQ46P/wgZR3Rg=;
        b=t0JBueuSSFsZKxIMpD+xrGppdstzL0RtdobN9qBZf6IMS1jpuolGjhpkPLrJORSOYE
         AgKY7E+b5h56NIYV/1520DTf2yRLiUaS8S9d0plLs0Pw14HCLIorX4cOnP9AWUlNAGt7
         4RlzkaQiJCor/64ydUPOwDlRKvDvnd7NrqOc9ca/eAR0TkIA4f7WDDLiN5sRHTbmADhT
         bYMTo66PDGWh7zRQ162cGQ+BFm+inecrfNMmUZc7voAe1ou8fsqOUCJUv5FifV9pI1Rk
         7nKoDvT1MB7ekCtcIX+eFdzTQUyIWLxgYmXGi5/TQTlXsg/tzpyMGkznqO91qVRz6VT9
         V1TA==
X-Forwarded-Encrypted: i=1; AJvYcCXcTxgAmlUex+7Qfv/2z+ef9gSkKn9uQzd3gszEnu4zzM/Prh2kF270IFk8mVjBhgqQXqg2AgrYhCeUJ7I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyy9KAZhRMglLqFiVR7rr8g4bBFdpMMnEKoE1yaRy1VTle5mh4q
	KNa5zWjNfDbgrTwsYAGfOHdLRPkgW8mr1Xkw3MlP17QQnWR6p6lqzAWINImQZVg=
X-Gm-Gg: ASbGncvVpzbnxIgjFL3hUXZnhqRPf/atEbfT/zkrCuhBmqcNbb4y6QXKEVL3fm0vbw7
	hVjxnFsz/7v6BQVss4ISk819J8Bty5spLUmJjYxB+HHtKMBLUH59kbLyYLqdMM+SKODQjiY61eo
	P4YQXRdoe5XMVr6f9sABgHbO+FyLoTknBwo1JQIDEk9Q8vfziX90DSJ1CSwP9y/HfNjykUBw22k
	SrbrAuama2kRJZvgnBQGNy7GRzSa7ymzXATON+5Mbp/4nXAHiKSU5LsvfpRYiQ+WWYIlfAkywZv
	kzcWztPW7gIPD1HugI1MS40bDUNqaQhWWXwCJZOnbZsMewhJ1wEp7S5peHl1kQQ5qaw/JIu2q2w
	/H4LV+2eIemIi0gjjXijYcSiBIQ7U
X-Google-Smtp-Source: AGHT+IFBi6JjsYJDnSEwMCPY80NtpnY/0pWo317IbLvcMp22I1j/lVgkodnN+FQ/p9Zn6V6GISOI9g==
X-Received: by 2002:a05:6000:178c:b0:390:debd:70c3 with SMTP id ffacd0b85a97d-390eca25fbdmr19248281f8f.54.1741107941433;
        Tue, 04 Mar 2025 09:05:41 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:41 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:43 +0000
Subject: [PATCH v2 15/16] rtc: max77686: use dev_err_probe() where
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
Message-Id: <20250304-rtc-cleanups-v2-15-d4689a71668c@linaro.org>
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
 drivers/rtc/rtc-max77686.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 6b0d02b44c8097453f704cbec9f02580fb869ca3..69ea3ce75b5a5426d4a56b979773be71c4ee7562 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -704,10 +704,9 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 	}
 
 	info->regmap = dev_get_regmap(parent, NULL);
-	if (!info->regmap) {
-		dev_err(info->dev, "Failed to get rtc regmap\n");
-		return -ENODEV;
-	}
+	if (!info->regmap)
+		return dev_err_probe(info->dev, -ENODEV,
+				     "Failed to get rtc regmap\n");
 
 	if (info->drv_data->rtc_i2c_addr == MAX77686_INVALID_I2C_ADDR) {
 		info->rtc_regmap = info->regmap;
@@ -716,28 +715,24 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 
 	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
 					   info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(client)) {
-		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(client);
-	}
+	if (IS_ERR(client))
+		return dev_err_probe(info->dev, PTR_ERR(client),
+				     "Failed to allocate I2C device for RTC\n");
 
 	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
-	if (IS_ERR(info->rtc_regmap)) {
-		ret = PTR_ERR(info->rtc_regmap);
-		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->rtc_regmap))
+		return dev_err_probe(info->dev, PTR_ERR(info->rtc_regmap),
+				     "Failed to allocate RTC regmap\n");
 
 add_rtc_irq:
 	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
 				  IRQF_ONESHOT | IRQF_SHARED,
 				  0, info->drv_data->rtc_irq_chip,
 				  &info->rtc_irq_data);
-	if (ret < 0) {
-		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(info->dev, ret,
+				     "Failed to add RTC irq chip\n");
 
 	return 0;
 }

-- 
2.48.1.711.g2feabab25a-goog


