Return-Path: <linux-aspeed+bounces-1360-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E267FC71134
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFkB4NL6z30DP;
	Wed, 11 Jun 2025 16:14:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622482;
	cv=none; b=H+eOBY1ap0HXMo9Ib9GmZpolvgjIFJg73jQpoumxhrmbXhAVw2VgAPFK2qDpmk6joIcDNF3igqLWyUOPk5yAK9PJDGSPi7k9z8HF8tcKPLcoHSWoETGH5REKTTR3JzY0YFFUaHJfNcnni1HI1e9JKQrhRmA+DRCYnwPcxQzz+6K3DeuQlOY4du+OJdSP6w+1jSQ/F7KqGG6nXoEOri0ZGBtPeKZTRH8yj4h+wjcWKgJCvq3w45KHytV6pBz7Opz6llsU//Ij/G/nQ5ZPEyZM88E85sEz/VzJgcqAKJfHaLew0xVdH+R/cfmbR6dMGlW5Emcgdso9+iN4mdnkrzocvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622482; c=relaxed/relaxed;
	bh=TE7gPFs8Np7Q/FF2lBSclyxd8XnUpnZDt9gHZQ7ecXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJrGBoKdY3YWkl3GWrX2aOFe7Xygs3x0K1bHYFUwf767meS7rA1LYXxrXIXTB3MkNBshMoJn6a7BhlZdBxipBDAgY3XZgyWP7C3EAvhUOHYloKeHnazSwNlBKtmetZyl73fwom5ZQNT/Asp55Na8XiPBhDGFSQeTMSAnYhGNAiFviOwGoYvwltwnOqj48z8xMQl/N0zg1UmMEba8MWxyB9xCiNpVYOmH6SZiTR73SCzHn5P+uN2ABWv8EfV/Su3APkrtG0y3e8z84XMMJqOgvZCpmMA8/8RyfVEXvAm+xJ7UCmMGwyLxBRdOGVpMurCpL6QEyqmINp0MH7AJufdlJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S5amG661; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S5amG661;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFk94JLFz3089
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:14:41 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3a4ef05f631so24985f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622479; x=1750227279; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TE7gPFs8Np7Q/FF2lBSclyxd8XnUpnZDt9gHZQ7ecXc=;
        b=S5amG661EvmFJzwxFNeQ80GI9R7AY30ompekx3WdbQzLuMNRkDNVPOoqKYPPCRtbjh
         /Vqpur1Ma8cptwUxEjDxFQbLkfKOrjf/7J61eR9WeSwE+Ln2k0JqMoNvFOHTbKJ3qvSB
         kzmY29eYL9BFOUrF72ip+HKIFGNWBj+T6+bpUyIWu/iHVz8C2zrOCE1DxLEDsedp5RYw
         OCYs5UeefD/0RcAC0sW/L8fPyHd+67NFGMRScISI5glXqng0XW3zUibS1t7bsFmBAk6g
         bNWGo4sAXUSgLJZbegz3IwTsJVxPYgd7Ik0/ZXi8LKZU50QoaE5P5NrW22CUHdvkxsvS
         bnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622479; x=1750227279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE7gPFs8Np7Q/FF2lBSclyxd8XnUpnZDt9gHZQ7ecXc=;
        b=ShIVwjLtFUh0+GlZ2vC7UmUFwxlLmqzj2kK8byBSRzN7lKk1CdmYgd9EiJCSVUDodA
         qszhLjDAW5jqE5bnlSTUvxOQjKyQLgb1Ocg/J6OkU71GURY6Vrj4er7yW+VZpW6tZ+QO
         bG1FNIEwWarUxV5aNg9LZUKcbXIMlQcbSDHsM3ChpQoKUveZY7uN0jUOab/6pRQ0O8vH
         Dr2g5g4nv0xOKHwZHuSTfBGvMP1/8GazxNmmIRgn2vrdZU+lkpytnrXYh9mLkX3Hv3tv
         PhBH0gZoAaGE5dmfTql6uBS68r2muNOAgGt5PouCCUbsZKJp6Tquoagn3XQdCnkJzdUy
         6s3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/3uOsBFmaWhaQURWp8Bje+qMjtMVXIxUNtj2zeMP5PWAggvM3LauoQeF95BFsvrGcEI+Y9EqpEsl3vTQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwvelDCCA/gMI1G0IM63fq3nbCtFd54gcExNkfQ7slV0NGaXm8
	3M5mqeVs/0uWbj/OlvcOHzfk4qV0PfhEgyar/7nIt5N0aQbjPIFFyx0K14XT+Mt/6DQ=
X-Gm-Gg: ASbGncu9ZMFNfEPIrdky8zWEEARZZc34rkjvg47crj5vvjn5rp8k4DrejO3EKKiKg6s
	qt8B95gj7P2QT4D6dJ9rxkxxRuYSXbSugzSknYHnfN0N6iaN1VwQlJ5CpoDLigGZwfwQ9GzVWae
	XBPkJY9dQ/nOZIGbY+Am4IeStMMu0yVDVj30R4PPX7O6FcBzBcU505uWV8NKsTcnI4O203HFfaL
	XR0vaEhCECEC6Oe5nnQs4zGN6t0Oex9/Y49hlhZn9mbmiGO9DQm00/rnJ04ruf0smp/OVGisEV1
	6ehdlPeHhZyiMPX53bJAvnvxcLqGcryRtdJtWjeREOYzDLjO1huBUfFuCz4vbkZmCUrrBD0KbwI
	egGHUTFY=
X-Google-Smtp-Source: AGHT+IFn+w9wTXPGUJy/sPilC/NQmEX8xSLBnguhN63zZeVVN5Y9q/yoed/8bnPWbjxQrrKvoL0/ug==
X-Received: by 2002:a05:6000:290f:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3a558827131mr509857f8f.14.1749622478587;
        Tue, 10 Jun 2025 23:14:38 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:40 +0200
Subject: [PATCH v2 08/17] pinctrl: bcm: cygnus-mux: Move fixed assignments
 to 'pinctrl_desc' definition
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
Message-Id: <20250611-pinctrl-const-desc-v2-8-b11c1d650384@linaro.org>
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
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qxDFEG/2cjWrKLnKXwD75upSffPn/RaY6zrSF/H6Qbo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6lg4NYzThC3P0VBNILmPNpLI7cOGxxduFw2
 79gOSp38i6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkepQAKCRDBN2bmhouD
 154dEACOMm3Rp/o7Yal3hsY5lrUILoLJv/3YbR1poy/Hntcal7lfWiRxrgpOmbhNAJ4gxXsCS2v
 pQvdOFDdKXryzGo5sBlbzlSZ+llGXe7xIMFD3ccyG7miWv3FoqR39Ss09HtlDLb/iY7lCYUklFO
 X4CE6AJdiC+cVyMjst1ORlZHYvtSmj84z8M8Xw7fjQpmfx3jwpMn8Xk98GAvBj32k1bffAnVrdc
 0dQ73IYkIqj1S30dFyPVw8jVo1NWaH7C4LOHljvBFAS2RWUlzu6GViA0z3aLYJlleswzhWiXdqQ
 2uggpYru6C02B3JBYWRsXiE9lcHMWwJdL8C3KWshReL5zYhV8hRSeuIcHkZjviIb6d7qLHswZoq
 BBsTpZzFdVstw34OgcD5V/WAGmnWxNMppVq42YTfT61ZSZo/M23EkrRVSOAtgXoy2FMcc5QNhv0
 xSBOHIUMCmzDYd3Jdou3acpCxF89InjFKRURreHYhf6ZDMV6r+Jwq9UljYzaJZ4HR0QsZZRunEj
 bIE5rRF/VBlRukZG9fnFQwey+KBFAhAYMQij7w+xJpoqhxqpyvWoVmvYHH29AzUzEaag4F/cxdw
 HHEQfjUS0EaLxw4ayenSuMFm9PmgmKlxXXS++io2JONMtPpSTwwKvP3qPWz7NuuR8O+m9h0hb1i
 HbUKb6deG5dGoyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .npins member in definition to make clear
that number of pins is fixed and have less code in the probe.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
index bf9597800954affd954e45a4baa01da4d5dbf420..e9aa99f85e05944a2a0cb9a3e6245c707dbc9b3a 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
@@ -903,6 +903,7 @@ static struct pinctrl_desc cygnus_pinctrl_desc = {
 	.name = "cygnus-pinmux",
 	.pctlops = &cygnus_pinctrl_ops,
 	.pmxops = &cygnus_pinmux_ops,
+	.npins = ARRAY_SIZE(cygnus_pins),
 };
 
 static int cygnus_mux_log_init(struct cygnus_pinctrl *pinctrl)
@@ -935,7 +936,6 @@ static int cygnus_pinmux_probe(struct platform_device *pdev)
 	struct cygnus_pinctrl *pinctrl;
 	int i, ret;
 	struct pinctrl_pin_desc *pins;
-	unsigned num_pins = ARRAY_SIZE(cygnus_pins);
 
 	pinctrl = devm_kzalloc(&pdev->dev, sizeof(*pinctrl), GFP_KERNEL);
 	if (!pinctrl)
@@ -963,11 +963,12 @@ static int cygnus_pinmux_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pins = devm_kcalloc(&pdev->dev, num_pins, sizeof(*pins), GFP_KERNEL);
+	pins = devm_kcalloc(&pdev->dev, ARRAY_SIZE(cygnus_pins), sizeof(*pins),
+			    GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-	for (i = 0; i < num_pins; i++) {
+	for (i = 0; i < ARRAY_SIZE(cygnus_pins); i++) {
 		pins[i].number = cygnus_pins[i].pin;
 		pins[i].name = cygnus_pins[i].name;
 		pins[i].drv_data = &cygnus_pins[i].gpio_mux;
@@ -978,7 +979,6 @@ static int cygnus_pinmux_probe(struct platform_device *pdev)
 	pinctrl->functions = cygnus_pin_functions;
 	pinctrl->num_functions = ARRAY_SIZE(cygnus_pin_functions);
 	cygnus_pinctrl_desc.pins = pins;
-	cygnus_pinctrl_desc.npins = num_pins;
 
 	pinctrl->pctl = devm_pinctrl_register(&pdev->dev, &cygnus_pinctrl_desc,
 			pinctrl);

-- 
2.45.2


