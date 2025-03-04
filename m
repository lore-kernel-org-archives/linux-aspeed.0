Return-Path: <linux-aspeed+bounces-953-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A022C282DC
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWp1YJqz3byh;
	Wed,  5 Mar 2025 10:36:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107943;
	cv=none; b=c4hON2xb2/e128h7XvGqLowGk+eVQIoFE+fiPkoulucXlbSdY4AD5jde40klv65xTiokeE7SZsTuf1FujGFgu6n100wmaeR8qy4ihnjpU00cOxAkKOJZsXSFK1nUf0xA0kwQXnwkEL6geIkTQ5DAL3ArfKngo5gXsqy2fSxQLWTWMnUeiaZbabMPmXRz+a9ElXHnP3ylAtkLLrKrKGQjffcZEl+3VHl+zvGxAKvvBJMOYIXkHsEb+KtEqTwMoM4glPmypSkwyzcrrnwty9j2yp7TeSZy2nUFjVxIpDI9/srz2ZiLj0bIT2LXQOPeE5+A0CLo00zbQgBoBUxGuxPakg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107943; c=relaxed/relaxed;
	bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0skE8sO8xDkOy6ek3LhlFRNeRSUOYECQn53E/PatCN4ea2vbawxJFulcl/TQ1s7xTFPVVbtR7sDey11S3dhL4gJNPbI1PF435jE6P5oRNO/uFK4JkP6RnA/XgDXY4w+EmSQ60ZhHO1uo0yUhmVb2QECjRLHB5RmfVscSa6t/ZDeeReDW0O2HeUfO3TuXFWx3VVyROA4X2OS1qv7UE0itiIewukpgEzHdktXwW1abEkNeHXbBIY62y5j8YtCo01XmjP7SS3+7X8Ka49sp/EkZHwfkNPHqTMiKz0B4ju7C9AX9G4x0mIuCUjLrjdHZlUx+iAgWT0Ch39TYWrGgZElFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cns9q5tQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cns9q5tQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs241hgz3bpx
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:42 +1100 (AEDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-ab7430e27b2so962243166b.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107939; x=1741712739; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
        b=Cns9q5tQjaUkGusYeUJMZTRUMESTyCDSX7LOcXCeazRo6R/v6PWn3FsHnm3j4PxGB5
         fYjJkDniT2tfi+POWiFhO/vpXX2GdN6BA/V69jWNM7jqIngHJ1MON8wAg2KzKxSYC2As
         fIDypr3heSNyVkw0TJlE/UvSAV7XN+H7HVNtP2AJLy5sOBvL0JuMewZE/HjWWDwB5lqy
         g+CPT+1iO57NvbvFKOgH/y50BjNsOt1ee969p3W2RXAoEFWBi649WVoOCpCmL8MPTi4L
         txT/hYtwp/1/C0rpp+N+mX/JHdxVvsoNB5bIOlvRgiU61tyl2KukRfN8L56LVi0TLZKy
         pX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107939; x=1741712739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
        b=Aj3RwNuDyuDFw8qEou7p7NogydHdb76yq2e2h3SHhSf+WSPP2eyHBA7WsIDQpMJcGU
         D+4E2Noadk2plww+cJepBwgdnhE3uq9cz3HZDxjk2qnTTS/rDRosgiUQwZH5IgXh7ztj
         LjuJfUxdYYc+A5Ny1nQTpORPIOPLsPrQ5+wp8r16dGj/WTLnLN9WmeIV+ejBNXd+I7LD
         CWNXZ3o2p0CB2hZ3svWvtAtdWdNOJdLQjZOjK9M45Q2zZYJ4qCP5vP+XJ8n5p3b2s88w
         tLQs0xM20Piis3lF/6fh0Z+WTKiWNqAvCKb+dm7nMcZg0fDefRjF/XM70Y/oREhcQP8O
         SzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrP4iW7rJ5Zu7fx5VVCscD2BROyJi3SGIonSUe3RQNS9ZY5mv67iNORZYaO3guu75f2qiD5zUYhFYOZc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpypM0guqDNmw1SDSVlgW7xGEfAfBML020F4je5tuOntR8frgk
	DPMJyoMEXSZTWewXzEc1HBPiazJlj5fyQIUY+VeLPmAXtj1bWwy6pVuJsm6IXL4=
X-Gm-Gg: ASbGncsH8QUtm8X/pjGMuOr1pXLPO+Z1eTfSnWJmQgiSsU51PhUClXN4I9XXX1XofSR
	JsmfG3phbPGJS07IIBbRznymhmiznIJ3/OBYTacPb5GqnGB87g4KCfy11py+M4dOO2kNqmpi18x
	riFh4Fb2tQaen87Ub3PNeBp4N39USyaaCZS5uyMHJ8ddtf5RUhxnTmuYxFDgF102FWgnhNRh0zf
	Iv7dQoJMAP/bwlTbhZBC6nDJCZdrGqjNpxsJwBAlsHMKS0lEk1hk/V2MmpJubagSFpyrSK972pM
	zPa5qS1t3SgzB1Mqykjt6YpR8+esD5/oipuzQUMuQ+auskJjYRDn3ZcZIYEX4gwTf1mfCYpW23T
	n8sz6vMlrOFskaWvKb2E/6xgvLAGC
X-Google-Smtp-Source: AGHT+IEZqUVJFopMcdCw0Fa6138jis8STGfKBc9DN3g8sZLmJaNDRTq42x6nu+WBoJl/BXVMQfaxGw==
X-Received: by 2002:a17:907:97d5:b0:aba:246b:3954 with SMTP id a640c23a62f3a-abf268263f9mr1810089466b.47.1741107939344;
        Tue, 04 Mar 2025 09:05:39 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:40 +0000
Subject: [PATCH v2 12/16] rtc: s35390a: drop needless struct s35390a::rtc
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
Message-Id: <20250304-rtc-cleanups-v2-12-d4689a71668c@linaro.org>
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
 drivers/rtc/rtc-s35390a.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index e3dc18882f41445c41fbea56edbd5c869514880c..3408d2ab274194e39cde38a83567d37bd53f6632 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -63,7 +63,6 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
-	struct rtc_device *rtc;
 	int twentyfourhour;
 };
 
@@ -422,6 +421,7 @@ static int s35390a_probe(struct i2c_client *client)
 	int err, err_read;
 	unsigned int i;
 	struct s35390a *s35390a;
+	struct rtc_device *rtc;
 	char buf, status1;
 	struct device *dev = &client->dev;
 
@@ -447,9 +447,9 @@ static int s35390a_probe(struct i2c_client *client)
 		}
 	}
 
-	s35390a->rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(s35390a->rtc))
-		return PTR_ERR(s35390a->rtc);
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	err_read = s35390a_read_status(s35390a, &status1);
 	if (err_read < 0) {
@@ -480,17 +480,17 @@ static int s35390a_probe(struct i2c_client *client)
 
 	device_set_wakeup_capable(dev, 1);
 
-	s35390a->rtc->ops = &s35390a_rtc_ops;
-	s35390a->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	s35390a->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &s35390a_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, s35390a->rtc->features);
-	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, s35390a->rtc->features );
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
 	if (status1 & S35390A_FLAG_INT2)
-		rtc_update_irq(s35390a->rtc, 1, RTC_AF);
+		rtc_update_irq(rtc, 1, RTC_AF);
 
-	return devm_rtc_register_device(s35390a->rtc);
+	return devm_rtc_register_device(rtc);
 }
 
 static struct i2c_driver s35390a_driver = {

-- 
2.48.1.711.g2feabab25a-goog


