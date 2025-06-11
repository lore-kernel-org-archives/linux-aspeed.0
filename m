Return-Path: <linux-aspeed+bounces-1355-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B986AC677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:14:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFjq3Ndcz30CB;
	Wed, 11 Jun 2025 16:14:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622463;
	cv=none; b=AAZG3GF2qnSBqhiD4yesl2mmOzIbXDrVYeLg6tMwVq/lGuYWrMoJStZolqDdi2DufFMBOmZaPAOrwdwv2H5BohPGhc2PfDQSKGaEsUvIe2JXUukwXnNGLrwBSp3hZWmqT6zyHClmHLqbaBtrEwvkjpP7Sz9qPZglFwUcCGQzUMTKZoHkRhOW+aUawOuQoShlGSlyzhlXOePnSSS9R64CGklpPADyb2eR0bT1LWoDULWvlCuoVOQoXe3BuvmdO6P5wNHtL3ByvKdXeUQOQrio57ac/6qs9mV6omfDuv2d58Y5qiY3XH3DjqmpBgtVQF0r+0iYkFwhRin1VRspp7yjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622463; c=relaxed/relaxed;
	bh=q86QDWzbyqUrHwy10F9ZLVZs4bIWtafdYZALzNzfzYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAV6FsWEOng082N9WblhXRgAxpdUrf2Q45t1oQN9qmXpar/wWal8Rp94ShEp/X7QsFM69zws0JReKbwAzGJyI3midfRYwwyRD68t4r/sZeaTDEkeDhy7TANs8uA1ucdFustHJnp72ObHxvnFkLjkuvPjuxjUUOCn+Oy48+s91vQFjsNa4VQlTVRiGoAtAGcYIA0AGO4fPrC6Jp8zSLKSTiEiArOZ+b5r67v5a3noAPOzZqQolvnBsy0lP9Y979xyZdqtCiAHszBR3CgRfcO+3w0wtyy4/9Th6ortdF4DFETk4GURYDlifGIl8YEIa55fXc5HQab5RsVLiiT2mz2SgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UTXFGfRZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UTXFGfRZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFjp4QH9z308b
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:14:22 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-45306433f71so247115e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622459; x=1750227259; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q86QDWzbyqUrHwy10F9ZLVZs4bIWtafdYZALzNzfzYA=;
        b=UTXFGfRZD/beQO79hCyKDKEMB2vOCSzA1gd8FHEnTj6F+XWpzp7xhg87UKr2QvZC9H
         AMaZjtIOCiX2+n3MJFpQtAScvrQgBnQTIyUSKiA6Y5B8/ZVaUyBDwSoA0k8oIX3hy5FS
         ji9fVxYy6QdnziAX4c477ivLKhb87mJ+Qd03CBIbpZDzIEZKOTlFob4jnI9CmOjUoX3u
         RngqxpPcRgGBUtBzyGJtpqct2ZXdhA5QB4zLGtJ/8sjR4fAE6y8XTtNuO7L0f/L4gm5m
         i+hIlsjLGEBHuSPENHOivLu17PlA40hFf63nE0ckS09hlFP4UdXVOKY0dvdkmEjtTI1c
         CyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622459; x=1750227259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q86QDWzbyqUrHwy10F9ZLVZs4bIWtafdYZALzNzfzYA=;
        b=F7YZgskBss/PvBPmDTvuaF55zQW7e2UMNNnNnpeOyT9cmtfCzKrGlXdiFq8plfBPdH
         MWYSMSmrdpsyfhaxaapi7KgSAkXIRNFdCjr380Tk2jU4icIIUUI1WX4cyj13n3z3qslr
         C3uWc85kC54je7ZvtaG53roDL/xbHap0lnLvIKxn2bzCtgVZWvQTdCMOPKXj0doIN2iz
         5pPBS4ulLLNab/SwmApVLEzaN2A+WKJVIGw3QfMXzRELPpiF7Ey9MU0KDZbOjPIugWYl
         P1rngXOGmcOOReBEQEwjOefp1ZenH5UZTLlEKvv72xKvzn7vmlh/ppT1JO6ipVGlykAn
         LTBg==
X-Forwarded-Encrypted: i=1; AJvYcCVRhJOHbfe7Vc68ME0Z8T20vPZ2eUkr4WZFS11TDGzqR4XjopvA0J+y4MFcvxHEW5rBNpxwMgODt8ShpGA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXd1u7wtip1kGsHVUSZwQw4Hi++oXYB+23F9JfX8A+vrl3WQiQ
	HKqME37dhvts3pndvEs1KMvHTsuH5me7Hn9dSuQZgmTOLfOHU5V0EiHQLWqBAr7i3U4=
X-Gm-Gg: ASbGncvJVk5cFSq8bQMX1Utly7kQxMdnjbLStUZ6MmWbSOjpAoJQ8l2ssa9oQcgPv11
	/HE9/H3pwDciSCxgfqlr4vT72LkM/5jK8nPFOrPPN1nkkLVm8HAXXAzjHkFpTeSfBsa0NsTbGw/
	YSUR22qgGY8gxV7XZhiMl1Hd4PQ5PcRs6RcLJ0jkmeQk7A4lspAcCrtmi3vKCSmlWu5r/i6CLIJ
	oyFagSJ6nP+Aq1cdo/c7CT5+zoe3dsv5iEPDuinnO6LbrK34aTjnDLB1kv5zDN7srIvrlQGckjn
	zgFu8nFYC2fvsy/5k3uCzHc2HO12N5gP8eWoy0OFD2/Ia+b2D1YhVtlCZ9RiKMyaEBLthqlcdAG
	MTKZHax8=
X-Google-Smtp-Source: AGHT+IG0MrurMqwANRNDslKVkh3dKprU9y6IrTQpViebfAkp6mB1Umn/L5OKQlg735b88DTWJ/T9nQ==
X-Received: by 2002:a05:6000:288e:b0:3a5:2dae:970f with SMTP id ffacd0b85a97d-3a558821396mr547873f8f.13.1749622459437;
        Tue, 10 Jun 2025 23:14:19 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:35 +0200
Subject: [PATCH v2 03/17] pinctrl: amd: Constify pointers to 'pinctrl_desc'
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
Message-Id: <20250611-pinctrl-const-desc-v2-3-b11c1d650384@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NNpY2A6LBp263syvyG1Ecsfx8CioM309dnOrlcmWHKA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6hdhqC2eDe217cvGUZMEh1W/4vld1oNnYW+
 YkZbRVX0u6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkeoQAKCRDBN2bmhouD
 15CoD/4hfYjkCZdVyazNq2ibT7AGxKu+nI1YPoMthyyZMz5plU+l+nNgmymy2NyhFPLVlkvCK4A
 4FsvS1iJn3Dkr+y2bC4QBIUT6dXj23C/I9Y+3v2Xg6Hx56dWfC6oNqEvF+rYuLqoJpq7A4T3RPj
 11snIaP0e4JrVwiKZh0u+TcJM7WOVXMiQmX60PHyUR1rnzJ8HXuhCqTtE+RTBK6gIjHFzZGp5L9
 q8UgvNJTUf5z2aiIeb1m20vw8f+zaUsHEVTBA5pQfrzaP3VRCuXmtWb9nRDuE1Q5btLjbaAmtiG
 9eaROFIx5bFOf+Sg9Ok9Gj2Q10AZYnHmnkoy4IqVI6kGx30tO/SVz/T3rgjNol+hXAQHI1hLcmk
 XVGVC16NfQipwhxK+aPcl2ywGautuFcWgIHKgPcVZZENQIcSUvtYzB18VACNwO+5ipDcASefqro
 QFP3fiWL3DaMswdeQCBUr36ds+srNu1ED0hRChkBFVsv/mKeJCXpoy9aEwWCSVtFi89Zld0QFFX
 MVKlitmuZXfSPnxmXiQaGaYXstF+0Fj4VHKYg2U27Irx1aunnaZdNwgPgX5pSPhe9Y4xoUm0xrm
 2HtZbv19j2BQ7vx/8hkKMv2025M8QDoGlqAB55eUy1ppAZx8gZ1ZQyAOOBIcShwwTyUgeLGvELM
 hElg3VcQFmHOyDg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Internal functions obtaining pointers to 'struct pinctrl_desc' do not
modify the contents so they can be made pointers to const.  This makes
code safer, explicit and later allows constifying 'pinctrl_desc' in
pinctrl core code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 5cf3db6d78b79af9ac5e7226de239a0d2f9aaacc..85617cfed2299e131c110e9d4084370790106404 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -872,7 +872,7 @@ static const struct pinconf_ops amd_pinconf_ops = {
 
 static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 {
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	unsigned long flags;
 	u32 pin_reg, mask;
 	int i;
@@ -901,7 +901,7 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 static void amd_gpio_check_pending(void)
 {
 	struct amd_gpio *gpio_dev = pinctrl_dev;
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	int i;
 
 	if (!pm_debug_messages_on)
@@ -957,7 +957,7 @@ static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	unsigned long flags;
 	int i;
 	u32 wake_mask = is_suspend ? WAKE_SOURCE_SUSPEND : WAKE_SOURCE_HIBERNATE;
@@ -1001,7 +1001,7 @@ static int amd_gpio_hibernate(struct device *dev)
 static int amd_gpio_resume(struct device *dev)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	unsigned long flags;
 	int i;
 

-- 
2.45.2


