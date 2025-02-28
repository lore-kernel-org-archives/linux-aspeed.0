Return-Path: <linux-aspeed+bounces-883-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F2AC021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw02ZY8z3byh;
	Sat,  1 Mar 2025 22:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751654;
	cv=none; b=NisxFUuBDouVO/Qfpm2KLA1BNG+XFnIAsNLTEt1dW0qrgmeruCfTRe3FmUKueq/Z+s3O38dyj7DBvgvgX4VOioFI0BY8BLQ7fmue/GwgKZpuaTA4T8LK8U1dskOu5SJsOFyngmCyOdFTYEAVW2VW/kRrZly7Ym/CCABWShzXOEa86zcnnkV6zCAiNmH8Ip0YwAZgFzYPgShDEUXvmsSIx8V2qb/joWNimnIuharcCfFPG/C93jpTrv3PJ651E4AZN87RqPAUTF2210zvfzyDefUcTGeDeM7SStx99AaP5DF9Gxkjp0hprdTaj4BiUIKk5NiqCkJODMr1eW13/pfAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751654; c=relaxed/relaxed;
	bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gp79tPRbP52NdljrBy0G/vOhvMcrgZ8XcHEA5cDDaEIcI58i4rYgtvIpsJFzMf/L0glwGy03mB3P536BRaxMi0atVKHjyOovq6BIxDTonk4wxJ/+3XE+pBCxCxQc1QMEg8NB5dA5NZVvWdwCuuEw0WscUGVM11emwnjvZ60kwU1HM2ZC65RCLJpmO9SMEDPUazihfOp9YLTNq+8mDmEe/dkVp0qNn038/GZH9KE4CJbkud/l4pVdRgSP/EBbr2yaeG6brqAw/ANzZ7/CcTt+Yv21Ci9qqH1sEEt+CBXJ5cSXo/es4NaEor0myJPxyCC7CGk3/7CaIj/wsutoYwin5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d4nFaiqw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d4nFaiqw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495K4jcrz3bvd
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:33 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so3512930a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751649; x=1741356449; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
        b=d4nFaiqwxnEpUUlyL+wT7GXCHgExvP7vjZ6+ntxrKUSZVcYr58jQpMelowrjPoeEka
         1Ygc95cZnF9hkSvD5nMLePegIKG5/QXpSJ0qq/mcnYmPkJ6bmxNgpq4knzZiJUtWdF9k
         6hUtwGpLyaN5WHaMVTL4TIJM/EqPqS80pFSreuprI05MjsckAneDpZ/1gG5u5uNepFmJ
         9y0uAJiSY/CQPsiUq+8PU4/tWG5xM8Wd0qCpCBO93dylYthGILwEwp65b2AMjSe1FZrL
         xNBma1nQWWifXNuQy3hqlGQXj8truRhDOUjYpqWwgLIwjs6tJNTNMECSQkFfTwEINeTv
         keJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751649; x=1741356449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka86PnTxcRg56Z11OHXTxcAKX5oZrUWInphsB9KYtsw=;
        b=xOzj2sdvUhAw30r2eu9g9ZNLnbda06E1d5zoe6ZpxfaOyaJLG3CUIooNYpkCsM9Mo9
         9AuMLY9Hjzl1teqaJQLmtohKN4GTwS2Bmh29MnDWZgWfZgJcNGpmVdVdQ/yrXrNUJrSs
         zKZ1GhYC1qjo3y6mRWA9GndrhvF8Ae/6/ahLZMxWuAAQKh97s6zXGHNzZDz4zn/8XDKf
         lQsgTghviqZL3OtAl5CMI2dKlbORxxnY53pERWFC0rlOWxENgPORlW4fqTZP2tLDoCHl
         unYoH+2ADtLlLgmHK1asH99y2FaW3FKY098X7x6eRlEWXQncBZYkt9L/txmKnyyJvuWa
         W37w==
X-Forwarded-Encrypted: i=1; AJvYcCWBC1D1WBUFqwspBoKPn/lWypUHMbiDJ4+g17M3b84Lenw6C1TQcSzs0RlDmJvpGA4Y/rUWOiMDrAJFQsQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwwCCB9cxdDt0NFmg38werBxa1NhU+f7ZbUJVeBXM8d8pKGDZhf
	CX7hy3bYz6oDtiUDlLQJKeTFEp1mBzsjegRVLHELOXD1W5Ccq8hoQieNprprp/o=
X-Gm-Gg: ASbGncvmyCTAetTCK4rmmOqEEkzc3VWoyQKtfgsfWWiSPSHBMt5gwyfjJeVapQbyzE7
	z9iuV5yFqdagqxe/z1YAQV9zlHYDBdcpQYIgiO6pdcaMyFJoHDJK2HVPGz/Krdk/36uKPx6ouhN
	GVWQLOhktdqJcEmgvH0d/LJMr7cZJ7UzDoI2c9VHTSjm75qd14W2yut9coSXlzrPnaMasuRn8MU
	wdPSfSZulAUJ7UYy0rBvIi6a5onnHG7yXv3pehi46ZkF+3LcPcXE/pbCsjs9CJmFnr3SP+loVWA
	AbW6jnDjrCqBsIVPDOdZHqu6HOq0uX86lonIRIgcITskVl8LDKNsAk5OYGCqgTv8bWImGeA3fQx
	QhZaxiklQkw==
X-Google-Smtp-Source: AGHT+IF1zdUSX6ZhtbedenD60jZMcHzIIU2NhAe4k+oRQ6Wt3d6uE7nze1qy/Ap2/A6npGSF7Q9PVw==
X-Received: by 2002:a05:6402:348a:b0:5d1:f009:925e with SMTP id 4fb4d7f45d1cf-5e4d6b1869bmr2990380a12.16.1740751648743;
        Fri, 28 Feb 2025 06:07:28 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:28 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:25 +0000
Subject: [PATCH 12/18] rtc: s35390a: drop needless struct s35390a::rtc
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
Message-Id: <20250228-rtc-cleanups-v1-12-b44cec078481@linaro.org>
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


