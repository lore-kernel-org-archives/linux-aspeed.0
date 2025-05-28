Return-Path: <linux-aspeed+bounces-1262-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8974C3ABB2
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:42:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mKL3QR2z2ydW;
	Wed, 28 May 2025 20:42:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428934;
	cv=none; b=B6uriAsyWcLv7gun6Vrw78swt1qqzbxoBrHxFww3DEBO0qQKDsCZ3VofBZipDoV9R2PiSMru+At98QI5xdzS0qKxdKmWKNdXbTg7ql33Z+vCSnV9TXhDQ6YKmseyIeAG8P5R6vg7NtXuxSdnTdZ6SX8er0OafVqoWpvjKCDkKMh5QeSIsYWwaWnXr5KEWRW8tPkoMAMynSuNYnSnoGPG7tEM8TxqgjfP793nHXZNpJ/Xb8ma1pQWJYCjgECobeNqiTd8SB3k4MR6h5um4liZzy/2AWjdxX6YrbfPjvIGV7tKhms19iFWjPi4qXataBQTMBaN7HS2BuNQ3RhbmaxUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428934; c=relaxed/relaxed;
	bh=qdA/ig8nlywJbkEyEpBGSWcEGO8vU+oGS07oZJY25lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lke+4hP3WsmN6BZC9d4AC3/cz/7l8jtXUoXbS58wTJQJ1TkCu//ybIJbAY2YaUuKlZopXA4g1ZTi0hCKeF0AGRfLB4brH61Y+hXL2gFltZGzmt8uIc2ayfCCMWu7B6oCC412mpX17dcEDjIz0h7JPBLPOtPLbrPzD9yie3DynwenWg/Ycxr0DqQkxHcj35F4/nFQ085R2WwjHDaL0p8CVcAA3QwyxpTu4AqAdUfKoYkfTgExt412Jk5YBx8/kIZn78JZcbja4zuYFXXQPIcp0+YmXDx+GOp7bpwVf+UUCRDLPIN2UqKRm8etJhz15QnBDIz+ZMjJziz7PVAOlnvyMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t6ppRBjo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t6ppRBjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mKK3Bzfz2ybR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:42:13 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-442ea0b3b46so4584525e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428931; x=1749033731; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdA/ig8nlywJbkEyEpBGSWcEGO8vU+oGS07oZJY25lE=;
        b=t6ppRBjoDhrtZ3Cu7g3Pfy3ARqU+eTPtopqERoW6yid2iXFwQHq7wrKjMN/vsvImyg
         z/2AzYU88zY+vGcmj9H1z9J9dF4F7zKOafbaBLVffxFz9003eKWdADpRbj6os84zOJp4
         0fOeQe6MivLCy1aHvrMweu0y38UVThYZV+lx/TaBiXS7iJnoqNzP4TmPt+w24D8M+eL6
         X6ys4Y8YI4rWS7f1gptKZB2Xypb0wMhjWexk2HOk2H2TySdQQh+KzyMszBsOJXxxIZ/K
         P/ipH8MNdC48agzDtQPw4hNchnERdeoX+G+AM2KVThD88OJhHp2T4zjl5y65zTg7bmCR
         AK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428931; x=1749033731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdA/ig8nlywJbkEyEpBGSWcEGO8vU+oGS07oZJY25lE=;
        b=WWOfyWBzUjfDElyvr4xroNmOnWqp3/PqAKQh9meej84Y89QL4d23L797LuQyHm/4YR
         3Bhs12c9xpPPyv2uD2uAsuuE0Ly7m0ls8AyvglU8rV+PMSfJxCol5Tl+Ad98WWLybjx9
         fAla+CkO0EswKHAzGBUrUqRlTmleG6aGRH1M2pBpvZ1t0CtdHKhfIcTyU+0fDjzEuahJ
         ujR/OvAD63pdKIMhnFhQzulObm9W6yYEB/uejJN890XwSu5kQ8L+Lq1EJVeN95GzM7lJ
         HSFD66oTSQ2tB9QXDExDVelFqHYBxI3HuohY6yFK9Xklxf1bKOel6ucM7Q6cxKsrCblW
         XToQ==
X-Forwarded-Encrypted: i=1; AJvYcCW55RZ9yY/y+E81hfpaxUXv24OKOvm6TNlFTlU4ah08bJTQSBTmu8eybqhaoddZJcBaTl5dS0UOeoVV1l0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBcxNYWKVC6tm/vnyxHzRlWaQsmJVngLhsiT/ToYfX00j47h+u
	UMHyeBaT4jYqIzpDi08hnzwYmcEVSF3udi4Qv9J5TVeKxoVyoYH/lRmfq7JCI619U7U=
X-Gm-Gg: ASbGncujeuGgQzt2IGh3fa0pcSo2mL4qk9CvgYCJtDxAGu2eMRKSlxP6c2HQIBi1V/p
	aoPP5iybiqGRjnda+6FOPjMj48Op49e6agbABHHOm/KUeVhOFfExLUMpeoPFWlkbaJ9XQHVWtlA
	TQpLOgV/VL15RaSGpfDpG9BzAyCpksyK61BDs+2dq9CbB3PgHUKTiD0HcjZYZkyJI6CFWKYiBAO
	5RHLaCrrVPcQurU3pp2BDqGaIx5P0rg+EaxBMOMdAX6uN4yAnW4oUzAfTuBDvwRKEGwv2jwfZcX
	x9zZEnPvgSzmm36dFsKTDDrYPafeP2WZMdavpHuvPDNIVRAY0NADFUYH5i458sOVykjmJjIh0w+
	a7RxNKw==
X-Google-Smtp-Source: AGHT+IHdcQ9yFIlwP3zJEBCO4eEnwvHp4vt7sag5E+m0p9zZBnLpwpM4OjjEhLuG3z+TywmxNPkmLg==
X-Received: by 2002:a05:600c:4f0c:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-44ff407200bmr6539815e9.5.1748428930677;
        Wed, 28 May 2025 03:42:10 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:42:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:41:08 +0200
Subject: [PATCH 12/17] pinctrl: max77620: Move fixed assignments to
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
Message-Id: <20250528-pinctrl-const-desc-v1-12-76fe97899945@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vXeTXdr0B9QOQoZjEzmtipvrdS/pdMRjTxQFNr/h+bw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhT4xTFSLShiMHGrzurn8k/RWLwBOEg/kTfX
 2gUx5kqw3WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboUwAKCRDBN2bmhouD
 119uEACKrgBEySfxytMKjgXas+UOwi3IzZ36tTWGAtahy8quwEaS8yKLMXGH3UR5R/xfiE/qxgT
 K0j8KZQkSSoxJgxu/1dPpRloEO6KFrgMS1JNvrxc535yglaGGAF6dztV4S0X8Zw47lxNkSI3oCf
 kmg6Jop17f+7Kjbsu3oNHrrdaoyBSECGDQxfjPrG1OK1828Xa1Gs20NH8vBU0CQOtNFmjAg4W1q
 rCrbcRJkrSV7L68wgkZcewjkW+uCHpp8xfiuky/X+XA3LrnVkt3ZWvvtx5EVrBotsW3c605oGMm
 aIh39HoF2i+U+c1KA9+kRRkUESeOM0m/NNik+1C01XMxfvb6mtTvGtL474OCtItf1zazpXvoj9T
 ygvQC/oprYke1uID4uognq5UNn/OdoNvQJk6tbxBkAwR2epz1lboNXHXIe1MMdo+aFjl0220apS
 E2bXflnrkOr9/PrUbwkSiJxaLcUHqAJCywLcj/t0mPNa791g/BPtMYNr8rDFfZ7XmZyrEPbEJKp
 5XT8mZQD9JIEGYwbw0cQH/vz9kgOs7p47hN4UApEPGZ0HzG/37d9kmNp+Q9mNDbTUfAr5OPTT0V
 Bv9d8JMKPn9VoDFIrtdM3+11ONR/OmTdCfKgP1pqzLvz0HwoQl9QvT6II0t/70s7GaWP8Umrwo8
 X7EdXcYJodX39FA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .pins, .npins and other members in
definition to make clear that number of pins is fixed and have less code
in the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-max77620.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index d236daa7c13ebbcaf7c4a8d1a8bed751aa111c0f..acb945a2574368b2e34659a902c34df8aad193d7 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -543,6 +543,10 @@ static struct pinctrl_desc max77620_pinctrl_desc = {
 	.pctlops = &max77620_pinctrl_ops,
 	.pmxops = &max77620_pinmux_ops,
 	.confops = &max77620_pinconf_ops,
+	.pins = max77620_pins_desc,
+	.npins = ARRAY_SIZE(max77620_pins_desc),
+	.num_custom_params = ARRAY_SIZE(max77620_cfg_params),
+	.custom_params = max77620_cfg_params,
 };
 
 static int max77620_pinctrl_probe(struct platform_device *pdev)
@@ -569,11 +573,6 @@ static int max77620_pinctrl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mpci);
 
 	max77620_pinctrl_desc.name = dev_name(&pdev->dev);
-	max77620_pinctrl_desc.pins = max77620_pins_desc;
-	max77620_pinctrl_desc.npins = ARRAY_SIZE(max77620_pins_desc);
-	max77620_pinctrl_desc.num_custom_params =
-				ARRAY_SIZE(max77620_cfg_params);
-	max77620_pinctrl_desc.custom_params = max77620_cfg_params;
 
 	for (i = 0; i < MAX77620_PIN_NUM; ++i) {
 		mpci->fps_config[i].active_fps_src = -1;

-- 
2.45.2


