Return-Path: <linux-aspeed+bounces-1263-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD2C5AD49
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:42:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mKP310bz2ydl;
	Wed, 28 May 2025 20:42:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428937;
	cv=none; b=ffTiGjqL43BZoIMyah/NwFFV8hSrdrf5rJqT3pHoQFJ++FVUIkbCIR/52O8jvlL6RSqj/lKsskHYVXqj10FsxKM4yLnmlH64BZvN4my3xO65HGDnSKQazkF9NH9wg6GO8TgludfYMs9w0kONjeySp9L0+RP3drn6zL5ph7GNQ48kuopWp6ipFoqHvgC0a5zNhnzzb4YlSIQ/2ngL22fEmuxcANss3k4dj03Lk5qXE/3225tB8jXPeu9AGjib78z8hGK4zir985KkB/Gbhd6/tV6kO8CLHDw1xm+HGMiJ6mM45oNIeIL7ZgS7kPC/b4L5GTujvrSycJFN9zcsjy/viw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428937; c=relaxed/relaxed;
	bh=sCzXGrMy4mrth9Y9XnnMqTwemBq/IlPbQZ3QBo3OiYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNQug/jJXqMLUbCb6AHr0fyNJ5Yoo0Yoxw/dY1ue6HG3+oP/byaWVIQV1Z9EeNGUEfXXQpOEsPCVEj/ifs70rNJKOWr/UTMhZBsg26fjyA+4TMpSA37YscupPH8xmCMw8uaUsNeMpThPPjQrymXiNFyhgvqY8UryEJVjLO7+zHX4g8wZ3gv+2uNpp5L2hy//L7aYXEHwzzeXPyyKGi/F+RDdY3CE8XebDP5Wws7tP+VcshcH2lNCdiLDTrTiss75wD+KKaCp5LoLf8txTmCaw4Yp1sl9/XO75KwelBEEOdRiygAC1Er8CphF2abL3pkdbZKeIE6nIWNFybjGQJ76bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pgr8rXW2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pgr8rXW2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mKN2wNzz2ybQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:42:16 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-441c0d8eb3bso5762045e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428934; x=1749033734; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCzXGrMy4mrth9Y9XnnMqTwemBq/IlPbQZ3QBo3OiYA=;
        b=Pgr8rXW2/NdHSV1j9eOT0VUOyDVaP4EGJPdHPGpzd2uoWswKx+0zJyjapvfi/E3Va3
         VydpibMwvP8dDnbZfohzmBnjaGNPNxtxHAsaLPiVD8aFegnLeI6oTDh+LlxhF8d9ffVg
         D1JcggwhfemlpWG6d752yvJHcNTOlSe4mXfmFOvUNiwFiOMcz7U5ZTBIQHqdEfSWo+f7
         /2OkB2RwW6J5ASOjoZNjL+X4/cHtDZc8ANnfbjf3XYR1WU3kROXCakc0IXrEyJ9qlw3p
         kKQ/u9dYgznL6sq6jBosuFk9qFJY4fcscFTMDtJ3T+yr3vl/PBB9xLvln2zIyFO09x5F
         8Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428934; x=1749033734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCzXGrMy4mrth9Y9XnnMqTwemBq/IlPbQZ3QBo3OiYA=;
        b=fj3EX6MB0e59OtK4g97RCH3LAzkZBP4Xc4g3kGprLax0r2pLBkiwvSECdMyzqGT+11
         SeKGYA6Rpq38fC2//YpRmdNm5UeKZsMsqGHXp0k9uc+SB4hsrVejrNtPiEAKlw54cxEZ
         +fMHh1NGY1iIcJoNjyVA+38A2aA40Yo1ldqpUNpwa6LFIgOZ7VU7WUI1dBdaLioTMXTw
         wamlTcwstMXLg2dsYL8Yjv1dYvLR74HMDQfPmvnx/Wbb9ZnWUWjKBpfWh6tAvNcQmgyL
         9gVM6T8tHbpU6bluk0vPpx3Lhkt3/EJLFidCMH7YtHIoOb9YtpvLav8Gb6uAbgngTpR+
         sCgw==
X-Forwarded-Encrypted: i=1; AJvYcCW/RfmZu2+s8V4szC8U6RwXMsMG859o1rA5cs0WTAAtPzh0jdk4mCih8XYa+aA7Lu0qIGPNKYi1WKyVa20=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/wAwXPsssBen93VfAizwrfL6QV6uDC9UFM8hwwFNyc3bMChpx
	a2DwPRJajA+Enx/1mPaA0fMnDOnm6+0wdsYSIAwPDJ9AJxW/yL56+eCam8JC/qVOCh4=
X-Gm-Gg: ASbGnctJwb0SMV7zINPbz3W3Ot+JI7UK2Pl81SLC6lO9MfOJfDLWSc4w21w5Zq0vA/4
	qhi+AA2Sqire9cugXTuouk/l3zAErQzl9WiL9j8I99FEfzuNTy9hb2irFYpKknDamTIAjeOoi2C
	BOAz7WmrF68efh2Yj0Ors9TWJho3tX0rQuToOnbhWKPOHfq9kJfef3D+n4TGaAqWuGx1TmjlshT
	ixUs2vIu5AJRTCIeYym3Mh3Qy4ueTnrxyI0XAzZ5JPqxmsVgYjVjK+aVUVd570teSdGv7yif/Mu
	sYs9HEP0KoU/aR9t0kGx7DcKcS02dCjD8PHhiPV4O9xk80OEyRd0p1RP0j7ArvZux6y9s5o=
X-Google-Smtp-Source: AGHT+IEezznZ4tc//+iyg9VgEejs2PqgHy+UHoiBZ9D2eixnIzEPRTC2rWF2EYyDVV6zOvpBJosC8Q==
X-Received: by 2002:a05:600c:1385:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-44c93cae9acmr51123845e9.8.1748428933700;
        Wed, 28 May 2025 03:42:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:42:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:41:09 +0200
Subject: [PATCH 13/17] pinctrl: palmas: Move fixed assignments to
 'pinctrl_desc' definition
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-pinctrl-const-desc-v1-13-76fe97899945@linaro.org>
References: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
In-Reply-To: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Michal Simek <michal.simek@amd.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dTmy1ylBupLBEHMWc/Z23V5px0USEJlmCJKSN1EAvfE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhUPwoRAjJQz5PFO5DfSHTMd24hsqTzRr2IB
 0jOv1r3k8mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboVAAKCRDBN2bmhouD
 1ynAD/49mYORosdid1df8HmR8x/OWiv0Zm6goccLiqpVflRmzsFrLN+cLFMbhxRMl34fM3yuPci
 b71Zx42gtn/VEKIdJ4nLISvF28thcNbAG/plhINy2OOwfUm060Kcfaafl/ZP4AiXH0q3u3BS5cs
 fRHQErxwUgQBlHIgCJL61LeQp1Whs8/m3ImG8NPjZwnPdezu9Oczth6hm/aG0Og6NB4QdZkVhtO
 5xyGBrnkXFjRo2HmrUPl2PTYkNrTEjBPv4EZH2uCaBsHPSd+ND4J/ajWESZ3Vh0wXEyzTcd3/jl
 dCsZE4KBxpy/+gWzMFnXBN0HYTkqwqwVnkosUS0jsWofWTu/7iijgYxr0xF9ikcr3aYdlxgxGE8
 kkh76EFKdrmG1NbdijJPiOC50b+vAChB+zRdWvfXUBnmWsm0/uJC0Z+ttf7Nxbq4uFdgZVfD95d
 z6ZimmSBL0cf2VB2RBfUdZPPyT2hWvFdDUyrrSsugiugcfo/m1MciUEAKpSK2bk6d7S6K/ZP+Ie
 ydztgCpY5oH2z4aXxETIgUcH2X5Zx4g5H+iwFhMME8VjfrLHe+T6xEeRsGvuWg4C7Ij2NMquouc
 skaEKK7orgbEC9jAJSV1kP4K0sFWd0Zdc431k7p0EaxblWY7N6iELiPx21AVf6/XJYBh9eoI0r1
 RBtd9sQPwZc6f+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .pins and .npins members in definition to
make clear that number of pins is fixed and have less code in the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-palmas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index 9e272f9deb4f8c49f91d2f09c2c100018a7617f8..d69f114e46426c345d9ffe7567a326eecdd91bb5 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -956,6 +956,8 @@ static struct pinctrl_desc palmas_pinctrl_desc = {
 	.pmxops = &palmas_pinmux_ops,
 	.confops = &palmas_pinconf_ops,
 	.owner = THIS_MODULE,
+	.pins = palmas_pins_desc,
+	.npins = ARRAY_SIZE(palmas_pins_desc),
 };
 
 struct palmas_pinctrl_data {
@@ -1023,8 +1025,6 @@ static int palmas_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	palmas_pinctrl_desc.name = dev_name(&pdev->dev);
-	palmas_pinctrl_desc.pins = palmas_pins_desc;
-	palmas_pinctrl_desc.npins = ARRAY_SIZE(palmas_pins_desc);
 	pci->pctl = devm_pinctrl_register(&pdev->dev, &palmas_pinctrl_desc,
 					  pci);
 	if (IS_ERR(pci->pctl)) {

-- 
2.45.2


