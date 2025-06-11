Return-Path: <linux-aspeed+bounces-1367-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DA4C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:15:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFkj64bmz30Bd;
	Wed, 11 Jun 2025 16:15:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622507;
	cv=none; b=j42GKdo5XtUZ3Dx2/TUQXbTHHBGgxQP3YV6VXEBbDZW7JYkaKlvLmlGrA4B9kQPXdsLfVfwx4/FhgcjR59sBKMoLk+WZH6o9sgqm+fopmQc8RAQKbC5IzhlQ2uIebCltnEzMdu0GakTM/IBz1NpKVb9RuuE7gN2VydoesXi3rhlwgjrIHmd8NmUbsBYH1sT1YIOUqZafnCQ6viX2XT7ps8EndvYmMz3G8/UhVp71QnMguVRVCPySNfKkOms7sx9P4FlcHGxGXqrYGzMASOTUEvjSQw4dR4Zosdjvhlf5RLam/Io1fzo2GeN9bbOHj+fFeGqPHaUa9YiBgdkpR3H33w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622507; c=relaxed/relaxed;
	bh=k3Ze+vADApZQcXHHJvnQw5idboAhTO4ZZm7oXpqIyA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=krgurVKOrtegIrhmMB6DNbldJQAP/bbpog/7mnnGi/Pwd3Z9D0JSbVg49lgznbZuBJ7kaOCOsl1ztBrLVfOA5msXjb5RaIMnSXe83FIH7eT36tCg6nx/np3KRuqj6ZhQQbjU3jCP3fYjGg0xnKouf4sHmpeWPgV84lZ2t/OiywlfxcbA+5kOCoKOXylDpG5jMgSE1F3t+Fc9pLqTTpoQAAl4HG3V0y5VAoxsb+C6d+SfA7GlrDtf/wzS64xeYwL4noYV5rjLvAcMdFqG/uz3R0F/sC+GiyxhgHO7KlaMBs6XzxiPKrwLna4gpCM1Ojh6gaM/tRjrSshsnzqRN2wbcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bcxkc8Zv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bcxkc8Zv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFkf2DGPz307q
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:15:06 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3a4ef05f631so25059f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622503; x=1750227303; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3Ze+vADApZQcXHHJvnQw5idboAhTO4ZZm7oXpqIyA0=;
        b=bcxkc8ZviOwvqAeQfKG3bq2qLXHmxIgP8Rz0LKQsMkyvcNgxxUW9wnJMrwrEEAfhuF
         8JD8L5rowkK7iG/QrAmYcWaIfF9iElyCqjhle+yv1il1xxNot9XeNbxYaxopRyiZnUzd
         k0ZXpeLPxpHlVMO9GtblycfBCxorY0cCBh9Ps8HL0ohupewtX9nuC0m3nUlcwIHn1PJn
         jA2za8NgtpM2CyKM7r3Bqqb0iPbbbS/MHeN3DGJlFkzv62rInZCULcNPPFMyFWEp4BA0
         b52xPrtHnEZpa3GGbc+bXF1CL72QTUa3xViulM23Sfs+imAZ2suLSS6BZKRLes+ZfELa
         QWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622503; x=1750227303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3Ze+vADApZQcXHHJvnQw5idboAhTO4ZZm7oXpqIyA0=;
        b=Sr8KscrZwwPqiaYx3HZ7KRHk1uPO/huvLWwTRe+8bPw1Gy8/pKpWogyrBWYwzxMk8f
         5mqRdCySG2rPxzvo9RvWwmVy0aTqGRjeuGsn39AfjvR9KZb45Xdh4UzJscpke5nsgjEo
         opOF2Ijhq+zbOFL9iBQgzG3yLfHzuiVDpEFh1gMGsNBiQWdsrpa+FT2RWjr57bHSMrPz
         QvnnoA4eRWIDYIpK0vjG2CQCKXhSNrRcPN0OLDfuCopQ3vyzchFjBZum4YphInedzJ/9
         XyOPY9mvkbetcE78jmNwCZgG1SajpZa5nhG11lJGgqfIEhsgUfFKgEbNcFDeRD+j3bf3
         4nMw==
X-Forwarded-Encrypted: i=1; AJvYcCUwdGm17oF4NMR836geTsBcaOIwIJVhVJrLX0LGCKv6dYzyyg4+emLYryRmqhpsGk9UowQkHGkzEA0Tu94=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4DtLdm7cYCU/BjYH3gwYySVdvHeq+d/cWIVzI+NHF6fAVH18W
	Lu5Jh1YVFkcNffN5kQZw+HbzFeYnkep7y7OO+IdtKFfykmdRqUd20xp3D1PfSn3Nayc=
X-Gm-Gg: ASbGnctWi9aA5W9ApTbeNjlOZq+0opWleeIp1el0TR9f4EwW/iTW6ZZeZJYb1ZjTmQ7
	2Kh+CwghI+qwyTqLgfgKD6VH0rxH830N9/xTA96OrP5bgw1juNXKFInnQGLfRkd0QJfwvcWBDf8
	/MZjKpM6sPgZLLm52qjOWU27XRyDd9vRoRsn3oGWFc9fDInVRquomW02sd52rVcy0vNxo66yWh8
	rjoeUc0EUDg/xuvpZb5XVrl6pJtxjd3wS4mkNzfIIeGY6hEnfGaW/zXsK86zWmhLumy0Tp9tcc2
	/rbgzkHhU58l6kmaD83VaVAQOaAosM9INqVqcoOFQKa5DvLmMNm12J5/QjOnOKVAV85rq79ICUf
	BiesOudM=
X-Google-Smtp-Source: AGHT+IFam/Q8ke2FDO4E1F/HTitp0FP+gKJ3/gukW0/Bc+eEcP61V5NJDu4WYFt0kcJQLnkHsxn5Qw==
X-Received: by 2002:a05:6000:290f:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3a558827131mr510215f8f.14.1749622503270;
        Tue, 10 Jun 2025 23:15:03 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:15:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:47 +0200
Subject: [PATCH v2 15/17] pinctrl: pistachio: Constify static
 'pinctrl_desc'
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
Message-Id: <20250611-pinctrl-const-desc-v2-15-b11c1d650384@linaro.org>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
In-Reply-To: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
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
 Lars Persson <lars.persson@axis.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UtgeU3dDjW57LMOT846YXV02Tw4GcYGErdMblZiJj2Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6rl3kHrTfHT+G/WppDKwo9ZAF99RmPNy2e5
 FK25/IXhjOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkeqwAKCRDBN2bmhouD
 11zjD/44mTi6E0UEUF+WOA5PYfQSA3YrJhhb1gdB9LJEaYmqZ5heGdhEkd11b9u21M9uM04L2ZM
 omR6mvdKQb/PUr5s6pB4c+fvGy+edBch7wENWeAZTNkmTv3ucsbHEXczrgo33adLBv5AsrWXetE
 4z0tcvt9p0PZIwyoJuxHwgjWE3/oYJIHyfJmzOYXZdd9kRuIIYlBE1K97q/hOmQ0VG5MfdaawBc
 /Ld6CQJ8SRFCASzKJe+9jRrxsHoSLW/JCnoA0ZQFUq+Yf670EaZbzi3k4udIwkie9Hv1PUhPzQL
 loPBNXTxubGL5cnqEnKpoMKPSeage04tUhOnjnUQfZX+m1dUP2EK30OskgV/e+PJGji5xsLvoEE
 AzTFaWnBiwlGVii8+4/o6VagcwsLWxudJ/khpn3Bp9gnvjFXoYjtATT6dIL3qzKWKZIqaFO0ZNl
 898lFaYQS0Zi13pQngS2Vv880F3sQ36GsZjqEpZUXgHMDR2vprhGNNcHLTPoEkv3tOUFo7davtm
 vdJl53vfkJM26COh8m75lKvxQnXcCBYW8zSUYw23DN4X/qtIPpGhEyuNQlUDiE14kSOsydQ8l1V
 72P5Y2/V87/GZfYMvLdj5X6bDG43/wT//B8GiRvoSxrL/0k6zXQudwTV79njlMNb5+Yxi83QZqi
 f/UtiAkNVB3+pSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local static 'struct pinctrl_desc' is not modified, so can be made
const for code safety after moving .pins and .npins assignment to
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-pistachio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index e7bf609609617d6af2f10a3df56c62e3bfe2dcd3..7f8b562c81c9cfd1ac3a0bd50018857450bdf609 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1156,11 +1156,14 @@ static const struct pinconf_ops pistachio_pinconf_ops = {
 	.is_generic = true,
 };
 
-static struct pinctrl_desc pistachio_pinctrl_desc = {
+static const struct pinctrl_desc pistachio_pinctrl_desc = {
 	.name = "pistachio-pinctrl",
 	.pctlops = &pistachio_pinctrl_ops,
 	.pmxops = &pistachio_pinmux_ops,
 	.confops = &pistachio_pinconf_ops,
+	.pins = pistachio_pins,
+	.npins = ARRAY_SIZE(pistachio_pins),
+
 };
 
 static int pistachio_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -1474,9 +1477,6 @@ static int pistachio_pinctrl_probe(struct platform_device *pdev)
 	pctl->gpio_banks = pistachio_gpio_banks;
 	pctl->nbanks = ARRAY_SIZE(pistachio_gpio_banks);
 
-	pistachio_pinctrl_desc.pins = pctl->pins;
-	pistachio_pinctrl_desc.npins = pctl->npins;
-
 	pctl->pctldev = devm_pinctrl_register(&pdev->dev, &pistachio_pinctrl_desc,
 					      pctl);
 	if (IS_ERR(pctl->pctldev)) {

-- 
2.45.2


