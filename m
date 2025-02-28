Return-Path: <linux-aspeed+bounces-873-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DCBC021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvv4wKJz2ywM;
	Sat,  1 Mar 2025 22:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751656;
	cv=none; b=ExXfYp9FrNOD6hoZD0wwmVq78x674KvyGopeaUj2nEfef/RJyCVFWM5LPhx8ynGdXl1dDpS/0VTeltHmNMhQ08GASu+jf92r9KSrBN9cDEi/ofJK2/Iay0Vj8IwTakJIebZP/5dMKx5wccbO8BeUyhstrAAta2AGgVpRERQ6v1pEvbeUncIHIdW4z9HKPBVpKVlL+ethRdvDNN46vPpJEEaLwdn55d2IbHDXJaDoGGwAYbVsDK3T3nuzjxVNikpxi2Rz1sG4ZV4UADUez2EtchFb/1lmkF1wT4MrfrbilUcMmPCsyb4yw1HFnnqszdlTo1TS9bjX9qLUO4n8cRhrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751656; c=relaxed/relaxed;
	bh=wVgVdQhbC2YyNwH7K95+EhEh/kAvax64uDHN7A2amTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HzYYhpVj7wxs0UIcSa7XWVjxfjlBEFIOBlBKGTAflKF+f7b6l9BYvR9wPslOthdfC4h9x+0G4W7Yrk+KHIkdU3ztnJZJGoZOkVoTEfw/hixD2SElKwzsQmpqy+l7S4QYYgemrqZdHLvQN0WIr9rKBxYwJan9utBdQ7IBVm1NXtQZ7RnVP10T/gd2rbY6/TbEpKHeHdrb4OlavC/qiW4iWCuKaSHgNquHcYQxl6E7U0d9Gn2chUBNtLftUBJdSc1SKX88OWi661WgH2CyV14futOcDYifmo/Frqw7wZ2zUHmkji+JAlplKoDBpOB5QxLXLCMh6qQh3doF+F2MbMPVPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QJmGiKW6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QJmGiKW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495L4Nq8z3c5W
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:34 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso3602133a12.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751650; x=1741356450; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVgVdQhbC2YyNwH7K95+EhEh/kAvax64uDHN7A2amTM=;
        b=QJmGiKW6EcKXQT9O3D+5o/jvgRz2jLQu+4a52mLP7LQfqDcu7dqxNV43jZhH826r6C
         4UTDovtdw50vgT60WBa1LAQQ9Hg1DHiw9h42AaaoQdpk4Kxkexwa+EYp3WI0s5jf0Uzl
         w+14WJ9KOKDoaJ5rPkfCeVHzydRVDChQYUjdKxf4El60dxzG3CtvH6BDnE/miTrbZYDr
         cF2kEoj2dx069PAOQVdkSha3AW4pvvv5dgtgOqoB/92FkJZH1xtOPGskw2EqmmKB02s5
         GDyi2Jyfp5qdMVnrtMLjxfK42QJ9sbIsKxW6fhxRRviZfsOWPzm8drUSeDtLxXTtc+yM
         ZmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751650; x=1741356450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVgVdQhbC2YyNwH7K95+EhEh/kAvax64uDHN7A2amTM=;
        b=tAoRsK1E0DYSsUwes9ihlOCtZ0NdtmArygR/38u2metC4V4ojG5L2zZCuDAFtmq1qy
         k+zNti3Qh9zwSv+raRwzRezGG86eJTy+JZXCmNWh06iN8q2B+kMa9QP79NCykjapc3ij
         PQo+kUynbCyszCXQifIZePyNId4IbK//piw4TOJndc3v1FtsEHD4CiydcWCleWTjtH+6
         WsBWjAFPv3CqtA4Z5LzEqQxCEpOko0MBTO4jV0xzCRnbzNhD/TfjpRr0+mZVPzWRwvZG
         XOCqSBCqcE92eI7vmrzSSqnG4fDrKLPvFF0HnU8dAs0g3B6z1e7kSankPJAAB815xrfY
         eHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt/rPBlgNHkUf6XMxmv/8k00Bwlnb5yLkHIbGw1Wu7ht011ueGEhxC9if1i3bcVFfPEmBVv7VZ7lpjpcU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvMCKDWyAqbLxPu8gcXRlKHRhnKPpSQVqZx0GoP6b77aHrNDJy
	Ax1VaZ293Yho6VfiOoAR2+Y9Sy5W1apuyLIY4Z7YkVq/24a1+XyuJanOV6nV3FE=
X-Gm-Gg: ASbGncuT8SLMUacv7UbJHwn0FPm5xHizMymPuiVnqyU8/QlZcp5z67b0Sl3y0vd5hXx
	MtVqsqqpQNKPV63B9YlPNOsLt/4pB5uZF88bJFAJd8gDl5bOhMHX7nnji33CJHyzd35ic5Le8VQ
	bb5tUAfb5pzXotjqRzpkmCW3Scxg+jiTkhFMurxKcSR7E7aPfkFB3F30fhVUtp0NE/DYf5aPJde
	BoOHjtBiLMO30pj2myYOfWVhMsjS3ES5ZogrnKby/L78q3Xz7Gnp7rqOdeYjny2/Nv8jBYUO7a1
	Rez/RYC29q0t4rIwns9hS4ma5ONoKkZeNOTbk9WDo5coe9AImMPBorq/4ok/syIyzw6Blqn0iyn
	Uqwl9i1RGMA==
X-Google-Smtp-Source: AGHT+IHCyDQzEJ6kBhW3v4N+pYx5F1W3SqfuZOszPC9Ixk4jqjoqtVWckx72H2jiEWEF9nyPWj82Qw==
X-Received: by 2002:a05:6402:254d:b0:5e4:cfe8:3502 with SMTP id 4fb4d7f45d1cf-5e4d6afa314mr2938285a12.17.1740751649850;
        Fri, 28 Feb 2025 06:07:29 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:29 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:27 +0000
Subject: [PATCH 14/18] rtc: sd3078: drop needless struct sd3078::rtc member
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
Message-Id: <20250228-rtc-cleanups-v1-14-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-sd3078.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index fe27b54beaad1c06b70bf7f22e44c3f6da087267..ebb4d45ce2409982880affbc7a85d5e7410c8f42 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -37,7 +37,6 @@
 #define WRITE_PROTECT_EN	0
 
 struct sd3078 {
-	struct rtc_device	*rtc;
 	struct regmap		*regmap;
 };
 
@@ -167,6 +166,7 @@ static int sd3078_probe(struct i2c_client *client)
 {
 	int ret;
 	struct sd3078 *sd3078;
+	struct rtc_device *rtc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -183,15 +183,15 @@ static int sd3078_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, sd3078);
 
-	sd3078->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(sd3078->rtc))
-		return PTR_ERR(sd3078->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	sd3078->rtc->ops = &sd3078_rtc_ops;
-	sd3078->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	sd3078->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &sd3078_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	ret = devm_rtc_register_device(sd3078->rtc);
+	ret = devm_rtc_register_device(rtc);
 	if (ret)
 		return ret;
 

-- 
2.48.1.711.g2feabab25a-goog


