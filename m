Return-Path: <linux-aspeed+bounces-956-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4609C28B21
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWv310bz3c1w;
	Wed,  5 Mar 2025 10:36:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107943;
	cv=none; b=IGFfpO4rj+sL8YQIM5kmcqYPZttkoY0eYftKpdHhMGNxPgJuteAHhRhRqryT5eRoK2O8c4VrxBAERj1Gwf8cEdVyqFInc66y1ZKBc2OJoe3VTKtchgbrlqQIPuT+frw96DYwYu6awjTCbEBYHI2+MwjRNIV1vhn+GfY7SWcDLWk3h+EcN6dd5AJNUmTMHCYgQ8MEkMIGGE4r6v6fw1yOzleI1NKjIffQlQGlvheJ2xr+MgqgvVMqYm6rXd1PsMLhvx0tOY3tV3/WmaNiaePZOqGkDm7yA0P0rNHs+PSFN03K5d1ArOCQZBGzm9vUoLe7gEyDVkHCQ6mCDDxEPVOm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107943; c=relaxed/relaxed;
	bh=hsaGEw76ofDXd3Q1RIPfSv8CJUvwC0w+ueATTj/NegM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hr6KLg4/W5P42BeosY4Xwo7d2ueLBaSD4SEuCBs2Kpw2cMVymi8xPaMgoFo519WAI30TO5mOjKRUPfTpIAsDF9xik8lWQOHcwCFJSccf98byHXzs+yc30HXWMojgdFuRzLXJq/JN9K3kX7u2LMyOpBB2CNyiQfXfz+Ef51G5oWHUhbIBQ3sUnnnTWR18WTXD9mBJxE2WG43ig20OmIOwEMCwzyB2WlfOuAj5z0sl2b32dHCulhXlFQ74plRwMKzhx0+qgHmhGNd4TISCAk5ajRxA4GfST0yoYm9asyQVTlcP5c9MDQjDr0pvqaikE4ZX1d2xsCDOnaYG6hikaZYVIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n9Ntyz9D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n9Ntyz9D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs31Vqjz3bpm
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:43 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-abf48293ad0so587728766b.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107940; x=1741712740; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsaGEw76ofDXd3Q1RIPfSv8CJUvwC0w+ueATTj/NegM=;
        b=n9Ntyz9DanZ597d856QF5TUBIfc2kTJv+g4XU0WKjUKAhQIROhRBnQTg43PKjrd8qq
         4ZSDY5WAMltP7XTjA5Li/Qz2xEq/X9otKyVngEWAUxA3cTQlBOzflG4DRfHnq+ul/y1c
         ic+X5w9M6hlMxcPLsEIphIp6mmoW7OdUePm4NsqXA3TO230L+jI/J5oSTgD2VjVj9Jvm
         evsIovN1DLr1mVN53a0lobE24CHaWxXMzDbuj/MofpqbPD7XgxY2FtNCcxMwV3ESWfDI
         ipGMLQ/UEWIQPmMkbD9k28gcHrB1TVXVrTuSXM/DHRV053O04+1pnxvzpbLnZYVJzJ7F
         0NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107940; x=1741712740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsaGEw76ofDXd3Q1RIPfSv8CJUvwC0w+ueATTj/NegM=;
        b=Enwp4vmUXgM2PBF8MoVjqEMyV7ectSQnYFbJMnBgIMyQyzJtTsXuQwgxqlyUXqtEbQ
         cjf985dqs657Q7OIUVt1rudrCcTxeeRB+dOg1HDJnh9WGB71e7yL8mBWWKObelZ61c9D
         esTZfYH8FjfjC/2rb3sPb2ilAOVix4mcvES2Lx9LgSBM5A+3fCwn2XFDQEPKBXjIjlmi
         MPt+FZPh8ObqfQe+gt/Rl8mlc5r7xKrKd8EbScht7tAzTh4ERub/4CSrXabJuyxhUdxG
         kbVoELsGpu/WGSMPC6PwM0hpKgiJXFSE+TzbUn3rT9+7mWopaSU8h/gUPiSkuf9SXJ/T
         FDvg==
X-Forwarded-Encrypted: i=1; AJvYcCXq803GoBentHK1p5TC/qFxzbGMZ+kBfQBR68fAxd69OS3vvwB7WyphDtxTkeORjkdnqC6CgYzFcapF7Hw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyB+t5uiJcrhEP4CYXhtrCImne8w6QbtKqzBwrrBIu39PCVSxc
	5vsJ/avKTQwknYS38iG3CzBAydB9UxN9xSvcDDhQH6vKIZNunTEnDpVeTpDDkik=
X-Gm-Gg: ASbGncszHNZQvO58G/KNv0QFPXk89WnRBVpxuNHdDhwwIZQsaopJidXiAcmE66M/y5c
	uePVIKhjNOr4OAqfW5yzdLcTovG6s2OoiTtUifRxTu35XzV2Mk77lmfi+URD0EsCONCW7gbU56Q
	qClhrIYB3oUruY1DXthqP4Ee7buBx+DM3ytz/aE2OFRg82iO9R1myNffHzdeF+SsngZJPqX8/YC
	I8Z5CZWyoOja6X30Hxcvs2TPnR3qaywU0VdjpCnMUp+YJwlWXNRv7v/VXZ7u29e0qdP5WTa+HnE
	2wH4ULqF75r+Tn8GV9Y7dntt532P5Q8NQmJQyS2h9fFqBmZURloqtwtI7ZoJl0jIaRZ58g5j/33
	Xaq7kiOo9arWqA9FqHt1hG9u4pUcK
X-Google-Smtp-Source: AGHT+IFl6TTi8U8Sph/F6W/xnjfer4H7R9+DXzK4OCCEVcy7pkMVR63rOrht0Su/bmOb+eKFGQTbhQ==
X-Received: by 2002:a17:907:1c8b:b0:abf:38a:6498 with SMTP id a640c23a62f3a-ac20db16fb1mr2300366b.55.1741107940186;
        Tue, 04 Mar 2025 09:05:40 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:39 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:41 +0000
Subject: [PATCH v2 13/16] rtc: sd2405al: drop needless struct sd2405al::rtc
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
Message-Id: <20250304-rtc-cleanups-v2-13-d4689a71668c@linaro.org>
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

Tested-by: Tóth János <gomba007@gmail.com>
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


