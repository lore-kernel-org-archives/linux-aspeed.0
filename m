Return-Path: <linux-aspeed+bounces-875-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD5C282D2
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvx34ZPz3c30;
	Sat,  1 Mar 2025 22:01:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751654;
	cv=none; b=ZSjtuq8NAkAXr6O+SL5jKqSEbQAV38VRKmKHbx9uP2gzrIWtgltzFGrQza1x1A7OI5kXVk00tMxAO+d4mSB74B9O/77uLrh2ZKhZTcBXx5ix1JsNvvyj3R72JjR56zmODeCbeqXLuzkIxBGpSPzY/Ma2xfKlM4plvetIhjHui4Ker1cOF1X8dfz6H4yKVqXOP73llm7D5LF4K3DbEZYwSnCDDaXG73H3rwqaY0FIrRkuk/XtCQ7ee8JNAgszr6v0q+HWYLJTWUg8XidBdL8thsJ3q0IAq+JAO3+PYY+EccnPn1xlHU2+Qyik7dz7b93N5vb+BQFVD+YE4GY4U75o7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751654; c=relaxed/relaxed;
	bh=7nzHwlkUM09BG0CuM/bA+EpIQxILewT/ffWeXrAz77U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCkwm3AtAFMSRQglatODeNrC/rl4zxiX6fSAFOxXMhZS3ru09yQsn6Xktk/czpzomm9fKRZgfVYN1hl9zurH9mcN6OQcnlZuveoorx2NEGYrCifvFL0Ciq8hO9tXVwr84H+76/z07xkPoEVpnucQ5SJXjt9I37b85ZQ+TflUWt1Yt/P96qJjuQzZ3svBGQ+XcLB7eghja9KUWOFZQav0iR32Grl+N2n1+fWiXCR4O8Sto2I3lYYhbqXO8eJqLr4XCfDbHlbdoRzI+dBC0EHJcyPVkoqXv3fp4+vTyJYo84CisoxfAXP7SV+sGDBCARhfSbMKJaW/55vlTySpI79Ldw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hrj2UGCj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hrj2UGCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495K2jgCz3btn
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:33 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso2624199a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751648; x=1741356448; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nzHwlkUM09BG0CuM/bA+EpIQxILewT/ffWeXrAz77U=;
        b=hrj2UGCj8NGxaUhckMZNGnJBOwYCB5gfxWj+llt5oHJbRYHX6kg5q+QugRxw4Hmr39
         P/pcVRemOmzKB0j/WfTSd4kpMeC9b+vyaM6EUBZSt8C+qMGpKwfrwZm7rIyFUPQXavmA
         HSJwkm+hl3qO4sJk9V6y+PWsMFvCUmZuw6S21HA3l25XiaP3ZgZPmQlHp4exc8mA9YSY
         3SKCPvfYILJuF5tiUoRZZ7z9bn6APxAuFp1/a0sXVpXecZ+1IIGcEMGXVHgwiZVzJFI8
         pYa2VnFkWGTuW5kYSpP3XaOJpEJan7oMlAs9tqy03VN17Xmc5TppCStEEuJ/+fDyUYta
         Ixtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751648; x=1741356448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nzHwlkUM09BG0CuM/bA+EpIQxILewT/ffWeXrAz77U=;
        b=GsrinTUJxPjpOuJTSj7tA89GqS84AH95uFo2o1c5z0XlppePbyNUUSa6JrMsNL/1eI
         oQmTAY6n/nmjr/BbHSYRoPpxNZZ1IWNic2kQp7upfTnfY419x48hDtFqCFjRN6561Djl
         XUzkIUDNZX+PAxowRf5lMwD7n1atwl2UDGdVKitUzVYz/iTGHugsqMjmZ21VLoW20XF4
         Wr45iQNdikx2TJ1MdS/tgzma0akeP7sbPD6YAVX0nbcl/+kBz02nwui3XVoJgPlPge34
         +tO7izKsrdnhOmERKGDKsgh+2BBWFMnc5xA14xYv+xMjXH6L22szP23atKbMqSlo0bxJ
         mEkw==
X-Forwarded-Encrypted: i=1; AJvYcCXSdf3MDepHuyxWEP+dxG+AEnmSIHjPafpQWeWb1PZqFgso3kA7Dp4aurFqvFpTJUiQ7ClrROitCKmlNeE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUo2hxKaKJEe0GyjAPT4u7CMh7mQg/HjV6N2nPmIPlKYm+hf/1
	yekjClMVvsuXSENV7UWkSDjoDoAjCtWu7nz+kHHfAYsAVX7TWot0TiU4Wbv91LI7oAHztqXYDMf
	aYlU=
X-Gm-Gg: ASbGncs7mAIc7WoFfRiG284AoYbSwCmaapUO0HPO3dr31FEMLVNUq7oY/4NedYLlPiB
	mtMyTeLn/FyiLtPAq5oz3QHAGXHDq7BDVMPQspkHy56FHXXzZ53qrwAIBYrrOSNVwd12iijJvRK
	6hDhvQM7lpumRC+TOcR4kMMK4UlzXFGI7fk65OB+J5aUtgtJPfB1QWajZh7hWH2zz8HojH2V1eF
	RJjp+30NJ0zJnPf91qY/dqEL36CJdWk2gzMjQxQaCFVUB6OnnLzlTkM9gLDmWE291J2ieb+Lg48
	vP/JaKe/rHrtRC5QtY2fywUqIaRxnFqGYKuB2+DcsLx4uxtjcUM/ckpaBF9uQzUjuRD9e1t1E2w
	R5C4SjWQfVQ==
X-Google-Smtp-Source: AGHT+IGquByOTAI+pOBsMihZmYnZaIy5p2XitRnKkTWDJg07k5RO868wRYsHEejBUavy8mEmWjqo9Q==
X-Received: by 2002:a05:6402:13d4:b0:5e0:8a27:cd36 with SMTP id 4fb4d7f45d1cf-5e4bfacb0a8mr8959084a12.8.1740751648271;
        Fri, 28 Feb 2025 06:07:28 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:24 +0000
Subject: [PATCH 11/18] rtc: rx8581: drop needless struct rx8581::rtc member
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
Message-Id: <20250228-rtc-cleanups-v1-11-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-rx8581.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index b18c12887bdc3705ea4cee9b8d75086a05b24e71..785ebaca07ac971eee34559f8d1e0a8a872cbba9 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -54,7 +54,6 @@
 
 struct rx8581 {
 	struct regmap		*regmap;
-	struct rtc_device	*rtc;
 };
 
 struct rx85x1_config {
@@ -252,6 +251,7 @@ static int rx8581_probe(struct i2c_client *client)
 	struct rx8581 *rx8581;
 	const struct rx85x1_config *config = &rx8581_config;
 	const void *data = of_device_get_match_data(&client->dev);
+	struct rtc_device *rtc;
 	static struct nvmem_config nvmem_cfg[] = {
 		{
 			.name = "rx85x1-",
@@ -286,21 +286,21 @@ static int rx8581_probe(struct i2c_client *client)
 	if (IS_ERR(rx8581->regmap))
 		return PTR_ERR(rx8581->regmap);
 
-	rx8581->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rx8581->rtc))
-		return PTR_ERR(rx8581->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	rx8581->rtc->ops = &rx8581_rtc_ops;
-	rx8581->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	rx8581->rtc->range_max = RTC_TIMESTAMP_END_2099;
-	rx8581->rtc->start_secs = 0;
-	rx8581->rtc->set_start_time = true;
+	rtc->ops = &rx8581_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->start_secs = 0;
+	rtc->set_start_time = true;
 
-	ret = devm_rtc_register_device(rx8581->rtc);
+	ret = devm_rtc_register_device(rtc);
 
 	for (i = 0; i < config->num_nvram; i++) {
 		nvmem_cfg[i].priv = rx8581;
-		devm_rtc_nvmem_register(rx8581->rtc, &nvmem_cfg[i]);
+		devm_rtc_nvmem_register(rtc, &nvmem_cfg[i]);
 	}
 
 	return ret;

-- 
2.48.1.711.g2feabab25a-goog


