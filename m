Return-Path: <linux-aspeed+bounces-1258-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAD0C3ABB2
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:42:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mK52gmGz2yZN;
	Wed, 28 May 2025 20:42:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428921;
	cv=none; b=RK1JNzbinevHHU/0DRT0PDvnDrDWvlDCwG7ynhZ8iyFNmlT32vcCRd1Fgstqi3VVozNh8AFHamAqDWZVzlp2jK9Xrx1FyaXinavc3ZBppwIaGf8iHEc1k9T26Qooh4oZwIEMhDdgKKQ5K7jCKGWXzO2ukUC1ZErOK9ASviCIPB1n/FvFfjh1seHsRKe3vOpNA9JYp6FoJTOYtgZuOBY87y9q2nWdGd1gTzlwWwYwibCY6RRcyYjfR9YjO/4NIenj3moCAyp7zRl4CBXsyTyVUx5Y6pE1+w7D1Ue/MDS8zOs9p0qGR2F9cFt3SNmAKre+K5kX4aMh3tN65ewpwtzwug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428921; c=relaxed/relaxed;
	bh=pf1YR4gqV6lGcgRNt14+w6xZNohisJw9ukNkMtmqRYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5va80JfLrzhpGQC/TPSJWANJmBBpiaZ4t0aOc6KOo+E2YlZHusvumzf9INdgpHWqvDi0KnCyKgOzorapgZ3lvYfwc8g5+jdF55klCwmAw7IjSxz5pjvPNvBnWwVTR3vZB2eQVZpsjUkgyC7pQoP8CUVULTRpLwQZriCyPIBR+ARiVrjIRpW5ZetWkzj2ez/l54D8921vGUHAzscA/8Tm9T7m8rfi/BpKe5a5Vs/SGhVvJobodnaQZ5wkLewKaO6rFQRTC09XP4eGjWbIo8VOFRWORtweeM4G7VC8uBtQ+/Yly9XDo2sTB3qcazMJ2omZx1LFBiBwCQkYHRh3sykIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKCo/HEU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKCo/HEU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mK42yNQz2ydl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:42:00 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-44069f5f3aaso5069775e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428918; x=1749033718; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf1YR4gqV6lGcgRNt14+w6xZNohisJw9ukNkMtmqRYQ=;
        b=uKCo/HEU4nYbdS1YVrIy5/Ub/os05xiEZ/614RYkUOskJnBfeAiRgWg+qPjwVun8Ce
         jdUBSRqOZfj0G9DClkmlHtjTiPRD0vLwBQxYdgTog242pMBi4XYxG9EcAAHYkAJwNdr+
         wBTt2RsFzSRTzFIu0ALrr/RH69GgMWUTJQJeXHh4vMPQ8H4EbdLB55XehKgfuCPTXWNJ
         kJQoYSnI0MhR0/AAwipg94iDi/0+zI62AXtKOajWxIcB0rukEYkgxEuoM4oLzzj7eejH
         T1oHqHg7FvIQURq5asRgoHDANHOlYsoFW+naJwtA3oFMe//1zGzmsdiwysjRCDF7CFWc
         5ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428918; x=1749033718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf1YR4gqV6lGcgRNt14+w6xZNohisJw9ukNkMtmqRYQ=;
        b=iabLRs86RyjugKRbgEpXtYkbE7SjyamKMG3sdoDHvTO2rvutosW+iXguMRxWGGmaEz
         SkSGL1vvAYHY4XCTmnC6AxNOn/1qO47/XT56GAKhqqjANNktzcB9M4TZcYeu6TQkujMv
         DPZfCDQF8Krpci2dHx5ig11Y2O2A7jC/nLRMmad3yTG5bt9/0vExw90MPofZqiB2KQvj
         +d0nzTLY8JevY1r1qF53lfxM58AoxUyiJqxhq9ZlmCCYYfjMB0T/GKFmqwVJ06j0Al9R
         1drGvYUunExB8Zz3Mx8zmv05qqKvM/cke8slqS+/++18w4D6r8l2l2XLfVng6LvAAI2z
         XQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU58iAzucdgFGK96CxjmzWQ+4phsfEbn2+iv/1Jgxark3dErxlCiyzSigGGAzySw5wq5F/9bMx4f9SEQ6E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxh3MnWtVuaevENKQT+w0KjckAT2nwjaQzg/hDgcFo4RkCJcneh
	2V2RDEsysLOax7Tcs6f71rOlMEAEjHV+svakY4RJdEDHm9BHjH8pW7AQEcS/+GeTa/A=
X-Gm-Gg: ASbGnctGx+IgMV4K4yqYQWVD9oYnCBqbt4EolVSbmo3llRNHfoSZnodRMX86liLni8E
	Om0OkVa69dnU1MgcixRHG5MSA7ijS2m5qtbVWvTepPyX8ROinAoqbsDeqtLtP67ZwOKzdnJXYGe
	EVCfhMFolZwtzdKaj7twISzoKL6kzsAcgXhTOAmu5u57sj7s8D+e4YJ4dVike7RACROlaS6WVA7
	8e6gG/qMzox5fxXQiZj9WMHpJ1+25DPaE2rbyXWiVsWpbiCkmGuy3ICJ7SYBFjW3plYvsmCh8d1
	GmwUAUeuMMsxG21hBIoox/M2M0mU/p6HJjhIk1UXG1/zQ+lz6HXVo35QVSmU28D6BjaY23w=
X-Google-Smtp-Source: AGHT+IH1zOEOLeCxje+RyhJLL9R7to4LG+S/YoypX4dofkpM8V4nOT+IYOSlqNv+mgg8x3vhGGPHiQ==
X-Received: by 2002:a05:6000:2303:b0:3a3:75ea:f9d3 with SMTP id ffacd0b85a97d-3a4cb4addbdmr5341295f8f.11.1748428917518;
        Wed, 28 May 2025 03:41:57 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:41:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:41:04 +0200
Subject: [PATCH 08/17] pinctrl: bcm: cygnus-mux: Move fixed assignments to
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
Message-Id: <20250528-pinctrl-const-desc-v1-8-76fe97899945@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8TSMAdNwJJ4cMP69sWF06naMdDsc0YKsL1F2ggY8MtU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhP4ba+/mFh+oFgO6EmJOLE0PvaD+UB1YrZI
 JEnxOp0UJOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboTwAKCRDBN2bmhouD
 1wZUD/9bA+sdZ/7ZzrhcN224T33+HyLau7J4D7YZ4cKaBQB0U8+Zw8EsZqd4MTQZ6emR9L2iOku
 vB4WqG5e+8Z9LIfvJznXFBRZIVYlQMVs4gKMA6n1IQK+b3fdbSKyrWYxGzgWg1qHRWfrn6gFq8V
 qwQ3u4tXG8zk+5W7WCD/WmhtFm8AjfVPdLdTzD6BTNO5/1O3UECTfd4bdy5uAlIjjeeaglJ6U9x
 TfGg4iHSiUave8A4vNsJKpd2jh/UHo31b0ZzfwImQA+f8HM2q+iJGrpHX3CyIV6W2b20CcjaITi
 BVPzXRwFn1atUdyNm687e7TwfcAjztLBlCv8F8SICMdzeIwhYxkIJwrnzyA/XJKL8VZDWTgHXCG
 K2DF/qGfjZ5NgbqxaZoqwf1DAfB+eqty4Xax4UbJTIBeoox4mmxjYZGajNOOihw9gH0KKvHsj26
 zBwOdZRN9WJjBF/BLwvfGx358OA0ejwj8JIbMzzv7XPnPz8YhtHemtM/2Q/BUcu49g7M9Zn+SBQ
 kXnJY427cgGJL4hSfheW6ucWUtyWdpu9qP9QkoTJviZEn3MuNR1TyXnZlNQPQziFWzqHoSJpgWa
 B1C0T6yk8njHeARq0LwxzSDnTjEtcAmRHwCS5FH+LfTz1zCNy8ZkWDkhOkDAGNbKgggkp4iOtAa
 Y4YpkDzEcJUCemQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .npins member in definition to make clear
that number of pins is fixed and have less code in the probe.

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


