Return-Path: <linux-aspeed+bounces-888-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA08C282D4
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hw14XH9z3011;
	Sat,  1 Mar 2025 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751652;
	cv=none; b=fk5aeU2SNVRRZz4XkhClrYe49i6GMa/fRmcHLtji7+nS5zsWTh2Gv9yVfzKfErVcU3FpORIucffgQGQwgd0tgqCPqk3u7+KQsPAJqVWH32k/fOZovT1++VjV2VVe1P4iRDWujK9jp1Qgm40j0+NU/DzcGTiMMOixudrOqwmQ/Tgj90vl8537HXRicTc3YkHtNZVgGFIvel3vfcqqBlM1F8SIKFosrvq5uA23smxVc4FbHOurKqLk82LLR9Qv6S4xxE1r7fD2Hpa204PLX3GtsK6xLO2G/kgE1kqjWQwLzMj3V5hr8BzmCsMRJV/jkmwiCaG6c3bi19cCt2+2QTU7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751652; c=relaxed/relaxed;
	bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMeMxHjx1azbQGcO6tU67RK3JTLBaqE+kZtZcAm+juOY1zbKwDGILvMc1DSQ1laQVYCFKL/uU/9Z6FLGqAprW6Iq0pUZq8N7dvDstY5OqOjCS/g2Ss1nn5S6xynggGjdBuFiBd2Aoa3NT3Sf9VtCcx735jpVumVcZT0Pl7rHyVmM1Q7ZEtlTmDtSLv1gjoBcwEsAB3+07L+YjtDOlXEPqKnYUx1G8zVRZMCG09LyL9PBESliLstx97EV1RixcXOzfRksye91DAnklP1G2vbg+f9c+3DFhM+g6q/+70sN5CapBWzxMBbW09nGmLFo4yyybqmt4scCJ98+pEYFcV9ePA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eabPqLi8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eabPqLi8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495H32GCz3bvd
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:30 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-abb892fe379so301487366b.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751647; x=1741356447; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
        b=eabPqLi8RzRapWFyGJhVDGj8dEERR4KNgsYygLjndw3paHV83bXMZUt/a0eipDhr6A
         H2b/nw14CdrE04PAr94AZyQWkwTwK5/BJVrwols+8nUuTb0YY5LuhHinDyjd/KjRGaAv
         4c7H7nr5kUr9O6VGcXm0Gr3GGUedB6FvsTk/vYwKHobH/6qwVFvJl3mBwlRoRl9EIjem
         Vs8kGd98/sgnNL0SWmnACaDEXQhGyzjwzJMVz7NbQ5+cEzESfkIOKt2ZU7SpqEawQR5n
         UdjaNdgi+nAhzX8eZOIFqAx0qbEg8y07fX8yGwMCx+39zZHLvAUTd5rUvFEouRtcirR/
         wtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751647; x=1741356447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfBBNFFxoATgsY5PG9x5TDiO1XW3it+ha4dH0f4d6kY=;
        b=NOJ5FH9282ZHIWIhKjC1hY8uGCDDLVzU7CsK2jtTt4qmUILfnf7u61GvLbM347fAvU
         N0zfwkAGLFk0kwX39uRFRXfwDJ30EDkG/NdrpNBGdqP66/kZ+Jtvl1mQKRqqJNiydLze
         L5QlrcquhAqw55qqZPC+TKhcsItdsFlbTDuPqMrHd33o0rF2tyoCOChDSEeyqjMK0Hx8
         gwWKIpNpVedpuVaeLjg9BARZFscIC80uJYCGXpyYuThIigGXp7flEbNhLHWcuuap4mg8
         ARkzgkVZjGeulNOJtldcl3YQ2A6IkZdha5O7KEo3PCSQ2CPEuLZrhg9HSRffW8cBoxki
         Pdfw==
X-Forwarded-Encrypted: i=1; AJvYcCUDhDLbDqC60/Q4AISc7rdQR6zaE7PnDHci11K9JYMTBTKQQt9jyzOyW2gwHTRv2/RKEp3ifcyPAsxZVi0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHlc7hJi5v5Z1fZHJ9lcINMryQIAOEAkqGqMw3O7MevGpuqevT
	pMtXFzwBFxp/PbzOFZYXNpyGXSrvr2p/a0/wenyH/8SuIB2d7ck3ZncYy+OVK1A=
X-Gm-Gg: ASbGnct6SJtNcm2rPKk/z7VS6wFiiRzv1JbkISBqakrx+CalZIuWNqbvW5OHY6Yf2Cb
	PjkQ5exxoeL9xgpSmuIX4Flze5yX8lI73nr3EJXd9okW0cZ2Z8tSRvm1YAKjAy5mGMsm4ZyKJMN
	cl240BSEd0nnJS2XxFGRaKzwc0YB3rVGatq45VJNQY4il/RSPCOWqr6Eo6bn8e53xKT265Z/EFT
	z3knFv+oV1AryM4ZqABw86xKoKRsdv1vWERe8rvULQJnCUvKJYLGyzMUzjt87P3fd7mEefaGpqx
	90sRmPzJ0RPp5VU47a8yPvdGkoSutcogOqtm859qGQmmMDSIpWiOuqGWAgvC/CeLgjny7ITJJ8+
	OmPVwfrPZXA==
X-Google-Smtp-Source: AGHT+IELhJPOd4W0qPAgNgABcD5moXsKlcKW8ZKlMd0/6RuVXfSWqRkHz67gqaNmak1AZcnDjWmnpg==
X-Received: by 2002:a05:6402:50d0:b0:5e0:818a:5f4d with SMTP id 4fb4d7f45d1cf-5e4d6b628aamr8322653a12.28.1740751646827;
        Fri, 28 Feb 2025 06:07:26 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:26 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:21 +0000
Subject: [PATCH 08/18] rtc: meson: drop needless struct meson_rtc::rtc
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
Message-Id: <20250228-rtc-cleanups-v1-8-b44cec078481@linaro.org>
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
 drivers/rtc/rtc-meson.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index db1d626edca5fbb590f26c1cdd0774d350244a99..47e9ebf58ffc2f2b6c65932f8ec3773a213a62ef 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -59,7 +59,6 @@
 #define MESON_STATIC_DEFAULT    (MESON_STATIC_BIAS_CUR | MESON_STATIC_VOLTAGE)
 
 struct meson_rtc {
-	struct rtc_device	*rtc;		/* rtc device we created */
 	struct device		*dev;		/* device we bound from */
 	struct reset_control	*reset;		/* reset source */
 	struct regulator	*vdd;		/* voltage input */
@@ -292,6 +291,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct meson_rtc *rtc;
+	struct rtc_device *rtc_dev;
 	void __iomem *base;
 	int ret;
 	u32 tm;
@@ -300,16 +300,16 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
-	rtc->rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc))
-		return PTR_ERR(rtc->rtc);
+	rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->dev = dev;
 
-	rtc->rtc->ops = &meson_rtc_ops;
-	rtc->rtc->range_max = U32_MAX;
+	rtc_dev->ops = &meson_rtc_ops;
+	rtc_dev->range_max = U32_MAX;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -365,11 +365,11 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	}
 
 	meson_rtc_nvmem_config.priv = rtc;
-	ret = devm_rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
+	ret = devm_rtc_nvmem_register(rtc_dev, &meson_rtc_nvmem_config);
 	if (ret)
 		goto out_disable_vdd;
 
-	ret = devm_rtc_register_device(rtc->rtc);
+	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
 		goto out_disable_vdd;
 

-- 
2.48.1.711.g2feabab25a-goog


