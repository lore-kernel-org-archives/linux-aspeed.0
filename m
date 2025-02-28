Return-Path: <linux-aspeed+bounces-884-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8040C282D3
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw041qZz3c1w;
	Sat,  1 Mar 2025 22:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751655;
	cv=none; b=cscantGV3uE/EEHrFZA2T3bkxjKxHW099Uov5RZVTVjT800EGtdKNB3us5V9LrgrmaRllb1kakV4oQ51LHrOnCbmZ0wu1Ib78CB/Qx53FQif4uqEiw8IuWy+PSFSPEAIUgKQyau8dMSayOgemm5A74PRW/ArLwekzgqQo7YmhtkRo5JHwEcMJ43VavYJwHEO9uLBen4Rgd+p/DurhjZsBD5OhrPKiZbB+MJHXj+pUmmDlpSSaUq9KTrke7IKXo13TtthvEcOBdcJZHFEZ8Mp0FOvqcC3h7WvOIUhWVSxBwlvP1sDVEhuLSluojQHxcxYOuM2UqOsV+eCDQD47KZ/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751655; c=relaxed/relaxed;
	bh=IKZrDxBZwKYSSWAqYI1nyzOGiPZfFb6S25OWnyP8uMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XO56izKodd0AiA66XggiQTIxuOYOsV2SBLEk5lZ3XkjKQATSGX6J4ZuzdOslXMo7m+PCe3eW5qw2xLqmynRu2yAkBXAwygsaaCjxAfxDc2ell+IGc0PRkonhnYvHvwFNYB4GVx8L14DCoCzn5881JeQEt9rZHMX1L6DOankDclMLKFOe8h87aPxubkoYXNtCVdWzyWNzJklBN3+mnR61iR4Q+n6DHPk2Pjl+P6DfV8vjaNVZHB6g4JikVC8M9W58XnN8tz+MdYK/v6ArBk606nd63GOlYLPkZkZMzV8QocTZYvielEk8z8yNddMdf3lGQ7nUuSb/8eF800kQf/M79Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IMuit8yB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IMuit8yB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495L585lz3c5Z
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:34 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so3274779a12.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751649; x=1741356449; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKZrDxBZwKYSSWAqYI1nyzOGiPZfFb6S25OWnyP8uMM=;
        b=IMuit8yBturR/mnp8Sxaa1Hb1ytN8+pDoHHBuA78ZTxI3fmQJOX4kN79bTOO/GLw/W
         h5TGX34P/khvD4IIc5En9zP8qSbYjC1x24c4jyttPaVLmZXjbmp9qsEfLdo5059LS5nj
         lNq91ysbXPGuQaB1p6ZAJb2J2qC1UhyduWeb7w6SQcA+ue3pejyhK0CNLArPh8Iq6MN7
         9ajlm+Aj8GstTxLXeyugFxoeARihjPcHbdC3X2a5HPzs6BehW1xzEmjpJ5AeGZ73gCCb
         +ZHH4RnMqzFEoF6bVtMA19wJFBqsZ06v4+/wACYHd1MnO71CbvvanYrYmnZs1OQv629e
         2ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751649; x=1741356449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKZrDxBZwKYSSWAqYI1nyzOGiPZfFb6S25OWnyP8uMM=;
        b=BCWZzF8f4SCC42JRijFKzlKRinFqXfS+GPFoYHX1/O2p5ZFdlUejImfMLzCwyFi04G
         2jN1yG/Rk+Xbxw90jfD+020iSiS/H1dDpG27qqWZLx3hgDf1lE4nQca/4mtlcC5X5RIs
         VeVrRncX2hhF5glQ77jYhJy33iIif08wIoGTmQvQwkj9HWilKLPuW1swEDXIYIfccsxD
         eSjOorpQF408OJLLZOrgzxWHEtE/ridMux+YuI59vdOK0WpuyO4PCKg6NUHKY0GwC2Gf
         bPJW93JgV05O9dRJdCVRic2075eXnfBhR+JEeKGNC3XlDoEyJ3LNxdiM8fod9SUFAAIk
         2XbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJsaBnRegsPjLWra3RxNfd80UDDP/wttomqx7p1/mX0KqLwLXIKIJJm6R2zfqRV2XSvuihwmvUvJYQkQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd5HVASld1JJz77rdXlIn1B34lx/Do8nkI1t80WVLiHb4bbCC2
	iAU+6zzpyGzErgsKzsSzJyCudDkZUvXNOAAJkKMsgKpg2wKNlXZtcNxLM2l/VCM=
X-Gm-Gg: ASbGnculQBprDyNbLJdDSRH9L6HenRZHV6r9cd+TnVeWoCJ7SZkgXoxmmt+lu46CvFC
	cDshb6zhSH/iXtJ5GnAXY4P0mFNM8Z1C+CA7Pq+hu3met5nqsoHjhJ7StGGxBbuP5O7xYvvMzou
	qU3QjX3ghBkQUo3iFQ9yE2yuhonmsT7M+ig4waSX48jRC/kpzOG/biTdVz43UpczyUPeHeEBin8
	DBzCyvip2dd7r1c8qwFOz6EFN4QVHsjHW31Bd0tL2RaapMb1vzkqZxMaOwJtPrys0qvUb+POe2O
	zJGZ+MnNlmGtU3oAUdLhS3DX01AChEgLseviuyme1ADH1OFjiLYSbOESwop9fmi0bUTWOOEYELN
	NuTEpQQpFuw==
X-Google-Smtp-Source: AGHT+IHq59q43U3ESaHrkdTJX61FFZSQWYbph+vbGLJu0Eb0VqRkvBLNVX+MfvKgdS008nj52Al/2Q==
X-Received: by 2002:a05:6402:5188:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5e4d6b83d0emr2632501a12.27.1740751649255;
        Fri, 28 Feb 2025 06:07:29 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:28 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:26 +0000
Subject: [PATCH 13/18] rtc: sd2405al: drop needless struct sd2405al::rtc
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
Message-Id: <20250228-rtc-cleanups-v1-13-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-sd2405al.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-sd2405al.c b/drivers/rtc/rtc-sd2405al.c
index d2568c3e387659dfea598cd2ef6bddc5c076cbb9..00c3033e8079b5f10aaabcc7a1d3f19771263a02 100644
--- a/drivers/rtc/rtc-sd2405al.c
+++ b/drivers/rtc/rtc-sd2405al.c
@@ -42,7 +42,6 @@
 
 struct sd2405al {
 	struct device		*dev;
-	struct rtc_device	*rtc;
 	struct regmap		*regmap;
 };
 
@@ -167,6 +166,7 @@ static const struct regmap_config sd2405al_regmap_conf = {
 static int sd2405al_probe(struct i2c_client *client)
 {
 	struct sd2405al *sd2405al;
+	struct rtc_device *rtc;
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -182,17 +182,17 @@ static int sd2405al_probe(struct i2c_client *client)
 	if (IS_ERR(sd2405al->regmap))
 		return PTR_ERR(sd2405al->regmap);
 
-	sd2405al->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(sd2405al->rtc))
-		return PTR_ERR(sd2405al->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	sd2405al->rtc->ops = &sd2405al_rtc_ops;
-	sd2405al->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	sd2405al->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &sd2405al_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	dev_set_drvdata(&client->dev, sd2405al);
 
-	ret = devm_rtc_register_device(sd2405al->rtc);
+	ret = devm_rtc_register_device(rtc);
 	if (ret < 0)
 		return ret;
 

-- 
2.48.1.711.g2feabab25a-goog


