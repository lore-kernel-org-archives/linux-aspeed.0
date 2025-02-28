Return-Path: <linux-aspeed+bounces-889-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A802FC021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw14qPrz3c5W;
	Sat,  1 Mar 2025 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751652;
	cv=none; b=bfaXDEAjZHIMi0ZQoC0f3cJtKyagAHqJrfH4NLw338mf2W0tDhGKKa+CmOSanqvsjh9Z642G7qkcP1VL2ECOcfdynFoOQgRdYu/pGZGUn2/o23Ishb87GqTYC/fLpeFk1o5lP/dl6U8ON4CPs2R7bm4KMCVFtMrconhmeFYMLdqPN77OaJp+Or0kXAgqgT0UKl1e9JbT+lPdNdUCnOIKruxmpAwk10tPXNiNlwy0U1MMatPgiv76raL1HZrg1e2HBUABzkaKABggwVmuobgPpgwOqBsyYoMiQFoFkEoLg9LjJOHHfH+i1XvY14/Bl0tCLZTou40H593x8ysRx9Q7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751652; c=relaxed/relaxed;
	bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmpy84mNd86k9wJVvJdRMnqv4YVWdQTM5HqQaEopvpyPggbabPPsiOLwTgmQX0AYOwlDZD/gLFVF2VB1eiXkhTaHlUr4Br/KbqhBrOCVV0zvvgqwMggzd+PJjxIr7MzFd1y5eLMoBhcyzD86mn6FEAo6uTK+yuYbdlklmqHf/vcGoIKIjZ3Eu4qnm/L/ovaDzZAY1LZj+19/3teAgD/2ainM7BmtYg8ldZzbr1UC0lnmrrhgQbMjcAe7LpcY33bueZ1/AEa8Fitoaz2XDI6oYoyPdz+RxbTZ4EFFbPplTyMp6jtnlewtCedYHLdytUB53rWJ7+6q0UEwNfcqY2i5fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ex/ZfRGf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ex/ZfRGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495J0m3Vz3bw9
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:31 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so1068038a12.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751647; x=1741356447; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=Ex/ZfRGfLGz4kQlfVgaU9MQk6u033bBktoW5qX+Y7ttZntjs/TqFtqS8/1nxDJkBbv
         wPlYV6Fd7ELDSArly+n1dN72LgoEzyUb9Jsrnsx/iyZdrVgu+73dnjVBEkXcJk1/oQs0
         qhk4ajnoXLXBgDYJIcuY+wQCw/mvhmPiD/SK1lX7cUUk71nlRJCcSkvEK1CJ7tLRivG0
         xxn6OBxQ2se4YlJrBG9OkHQxMPkb5cqfD4V0NkAwdkWSEOQjajPwoEr80Xt4xNkVvSF8
         /FmBkPu0m3JFEp/LS087HY4mCmc4cXzyF45wmV2I5El2+5txM9TdzxDJXx7Ao1tgyRG0
         ONVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751647; x=1741356447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=BPl8HVcUtzSMf+j/ppv7Z4k0anq85Mis9OEgfugNhzWLAnLtz7zW4YJ493yz+n6hUX
         n3GS+qF6Knv1hS5EgUlKn8RO+BRo1d7e2L7Csj390bDVX6jdDZDpPfuA0aXgZpTFaiFq
         6ERTqzT7qOY8DZBdJfGU7ytnp7vo/jf5DQIcB3eQeUufQoA16pvZtkqowY9KuMisbLl2
         2pRSpIzqO5ZwebHABWNLiXYs9UKC83Dm8kBQmQPv9/BWgP+CGi1F+LexLgrRxMrY957G
         2pWULzM4ll1MFESl6+WqvsaklbkOZUPhO1q5qgSukW4AouLrhB0tUthsWKpHq/RKb4sf
         sACg==
X-Forwarded-Encrypted: i=1; AJvYcCVroKFWi/iRHJwUIKJR5hRSDI17oJyXGKb1LWvHXnARsXj3xtfjHKc3Kj9qFZd1vyEyMshdvjIL0s5zip4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyr5zkghUd+p4T1m1h6P/AO6i4+UI62rUqVZrMahmye8sFbADXv
	/vLj/pTzKF+qaV8yDsf47KIcltRAv/+AVEFX7cpMvl/dqul+0rl16w/8aBEU+54=
X-Gm-Gg: ASbGnctdmDisncIpzjZfyxmdwXsbXjbwMu1hjr84AweT0wmg10Dyo7RcSwDyIFgVOmP
	lAFl3KTJC3+Rz2yGfobbpPDv/H7d2UruoEo6smDzh01mVlDJT7FDrnruqkytSAPPOZvf75/f71K
	JBFztymO3E+9s083ROtLwNJYQbpRjF7Q2GC+K+TLpuG0iRNv8iuUY211FG73FNULN17NZKC1LLR
	zhZXa8hN848fJoFJ7pn+1GW+GnaN2KNUaBS6gWTm0ArP/eUpXrtFjOq1ysDJtNwGWZ1PWbJ14Es
	9gtp6nlQGrlVqFy6xYt76NEosHp7+pTsFhLwJhsIpm3Ag38zl4CykXGLZXWDjgqE+0U5FDAiBaO
	br83jsiTMOA==
X-Google-Smtp-Source: AGHT+IGZCKi+h7liDGF2k254zFpRo0bnTt6a/BEgRPyIDc7kptNekspya74S4whe/rs/kwdpZDQeGw==
X-Received: by 2002:a05:6402:27d1:b0:5e0:82a0:50ab with SMTP id 4fb4d7f45d1cf-5e4d6b6240bmr2836488a12.27.1740751647311;
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:26 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:22 +0000
Subject: [PATCH 09/18] rtc: meson-vrtc: drop needless struct
 meson_vrtc_data::rtc member
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
Message-Id: <20250228-rtc-cleanups-v1-9-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-meson-vrtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 5849729f7d01d7ec7868ff3bbdc5ed599aaa8238..7d38258cbe376e5a1b2af6250cb6d04c313175fb 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -13,7 +13,6 @@
 
 struct meson_vrtc_data {
 	void __iomem *io_alarm;
-	struct rtc_device *rtc;
 	unsigned long alarm_time;
 	bool enabled;
 };
@@ -65,6 +64,7 @@ static const struct rtc_class_ops meson_vrtc_ops = {
 static int meson_vrtc_probe(struct platform_device *pdev)
 {
 	struct meson_vrtc_data *vrtc;
+	struct rtc_device *rtc;
 
 	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
 	if (!vrtc)
@@ -78,12 +78,12 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vrtc);
 
-	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(vrtc->rtc))
-		return PTR_ERR(vrtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	vrtc->rtc->ops = &meson_vrtc_ops;
-	return devm_rtc_register_device(vrtc->rtc);
+	rtc->ops = &meson_vrtc_ops;
+	return devm_rtc_register_device(rtc);
 }
 
 static int __maybe_unused meson_vrtc_suspend(struct device *dev)

-- 
2.48.1.711.g2feabab25a-goog


