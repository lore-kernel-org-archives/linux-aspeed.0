Return-Path: <linux-aspeed+bounces-1252-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6C5C5AD49
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:41:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mJk1WJrz2ydv;
	Wed, 28 May 2025 20:41:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428902;
	cv=none; b=h5bajJP1u06Cf0wB68cexT1pnXKSztnsV347RrppSm5h2M8TDMu5PPdLIvEoeifgoDUP5SUZ207v5UD048Cd75DIwT6DV+/+3poXz7uJKBMrl3Hoy2eUI5z+9jdcWOQeTZPSU1QjGuq9KJx5Wywpnh51Uy+XvlpoCR9qDqi1bY1H4oNZvn522mkz0Rsl5UcThKZkLuekprvpMS8umcwjWGLmcYmpQaK7a/NfgPXKnlAorqrbU1/SM1f/cGMaGgT33uJFcs8XrAGEVuO2wQ6xmBQP5Z7mNRS7l/Yw12vQXRnUiZj7IeBgf8CTWlhncaaB++ifbd2Nvx4KiaaU5+bPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428902; c=relaxed/relaxed;
	bh=5o7kHuq5fh1nhgrBmbItAcmZQfVjyPSWaEBF50baGeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTZGOCG9xHPF7jkhKITgtELy1mzhKft5SJ/4B0bc+oUnJOkQN2eg8Grn8yc2px2F7xZSatci62lcy2NTVgM+C0A3/h9Qq7ZoStW3zDtdFF/Jfy6KJ9X0OkaXB77wu5A/imSPgsXGdwubisSCK/W/FPeZjxbcn8BO7tqIaoWQFBaT0nCKsq2LmeVWEqnyamgd5DrmL/y0kBFJZRcswizQJQVHp6NlCtZ+fKpLoVagSOBMZ59+5++AMMZ7tFMeKHadxCRaSaOo1xJXSdL5HPp7wW00rEZynd2cTRwwSdwRFdVfdE/LGyLbDKMf0e3qM7ll9Pb0EgKOmuBopO0OeW0uyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s9OFVODd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s9OFVODd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mJh6jxNz2yds
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:41:40 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-444582310e3so4549625e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428898; x=1749033698; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o7kHuq5fh1nhgrBmbItAcmZQfVjyPSWaEBF50baGeo=;
        b=s9OFVODdnqKmToejciCXJc3zqH8frIHJoBVhWVEe/PAAQZIhB1/ZCcbq3MCMsWQ5Ia
         mBlgZboN/GeDJdyoEbX+fx65Yy8L74pA9Togxohy4erFHmXFLFnyu0C94myEM4dWe81j
         oJD9izo7kxJCmkHc8MpUetL+dRH+d7yCuATWi9zxlqMlRxowNTml7zaz7rsYESjEpCIq
         aSBzkEcrFSUEZPU414edQ8Eq+KRp1namnC2Xbr4ZVTCrYmgau0c2Tr2S6xApRqIFSDUS
         z2aXyPXv6OzOJk1+9BSePJQIwPBSTu0wN6ESEoB+dRx/UhC2EM5lBjT/e9BzwCT8mYwo
         LKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428898; x=1749033698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o7kHuq5fh1nhgrBmbItAcmZQfVjyPSWaEBF50baGeo=;
        b=bWv/DvunVBpmriOVfhLesf2OBxXiWoD44yJTs1LuVZ+4BfzaUdplA/HEWdJdbYzjyR
         WOE9Uxgbowp61TwaIoTXxBFTOGTPzQ9GKWteSg4SI5O0KZxthCWI2eCs5fVdwK3NoQtX
         vMElAf3mEDbuGzKMSkcx3yhuYgOS7dbZKqSSw+UVQokbdzCAay1Lf74OaJUq3nnvJi15
         nbf5tV+PbjW75EXzSBmrDoY7qf9pDBiBVGCTcIoLVUnwMq90ucYeYk/xkFfqU1HUHXAv
         0+u1YIi5hZm5Zd+d1+mfQzZcqGdEDSe+g6n+ZvlHuK/qmPUBQZ3V2SPzaHVOhcZq8L8e
         vEng==
X-Forwarded-Encrypted: i=1; AJvYcCVHIcVv+BcxIg3uTZ2Zc9PIht9yA9RCBUaxG8xrJRy0OLFp2Kzvvuv3kslG3sd4wuL8W7+0awYsW2fv+JE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsrAEiGNQQv9IoNz3XsadRHJLBLpw2vSaTIYHus4hkKF2nv/My
	QgZ+R/NeqUjOX8dQLfFmpFK1BhMuAp+xNC0QcLHnS4OA6Qg1hlBUa2OP/tIuaVSd+WU=
X-Gm-Gg: ASbGnctR8EvLGXLxJBAwzwk8a8HH2ka0fI2T2XnDHh2ig7bIM6mVFBSebgwTL8htM9z
	NnlVo6UvL44ugNlkyKZn+MEBkDsix0iwrUo0wCGeDUgVl0tYFgcwBo5H4kYlMsgf6KRq5JuAmEu
	WAZATuXKj3tSMqVIRAV0Zv8or4boyc4aa7/rNJgsGPcqAKKZsMXH4kkxRnVaNXgCy52d86hbVAO
	LdPS/RTG/FU1D1goyF0LFDrOVmDgmIjnz2vvuj2q/GD2v0LKHPNNeHSvihRVWVkVNWbtvDkR3/y
	4cjyvnwGhECezkAp2bOuyDuGbmj/p7bYdakOIuI25CwO6KZKr6IbfCvpGvwaegv5yQV7VWc=
X-Google-Smtp-Source: AGHT+IEqdF3+R9PvjaaVFg6PDyOWyRZc3HR0H7gqLL2irDsUydaByqxkZ9IUn5cux0xSEgLuwczlgg==
X-Received: by 2002:a05:600c:45ce:b0:43b:c938:1d0e with SMTP id 5b1f17b1804b1-44fcb9e409dmr26120075e9.2.1748428898180;
        Wed, 28 May 2025 03:41:38 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:41:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:40:58 +0200
Subject: [PATCH 02/17] pinctrl: Allow compile testing for K210, TB10X and
 ZYNQ
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
Message-Id: <20250528-pinctrl-const-desc-v1-2-76fe97899945@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ctLoeYbHiiEBT9tiXppJUMjUFh7QHQFzP0xX2rdTSyo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhKnpMXQJB0a7WYDcwZWwHu8C1P+bTuhMNNC
 +EXWDs6a8+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboSgAKCRDBN2bmhouD
 11VaD/9bw31tjR68bxVpvaTyp/6cSym928yjCV9vR7oyl3BoFzh4W/a+7D30PLrsKSbtBC0J/LD
 ZSkuCuQRCTdT/n3XZG0T+ABgncoGE8an/aWUK1QeNySdpFSaEb5IitD03FUnLNTrxbziwX2OSOt
 6Z8A1nYodGD43IqazDQ2Xa7koDf9waLjKZ4MmbB8/+UkbSkzvm0UwGsFauOIvDrdj5PPraBwoo0
 W1X4sxPqQbmIu/4DVRh6oGcHsCwbTyAArmCXRUGcCavGlYBMYD0sfBZ14yAoyXbd+TywqhMmceW
 Tgtkyg/cXJ8JinZQIyzaHGnbQKLMukCGj+sTXlEyYG54GXhLmH3szir1Zsww23gOCwDK/qdnObe
 c/31A7IEOIftcgkxejUbOr2hcAttBy7peOBZmeIe2iHS2xV/0B3z4DN69SNuH7YSD06YPSnBrgv
 BPRrGVkzC6QpojpzpZYG1rdP1Mov2N6Xb6lFueCWghnaWhmNte0hYDoOi3sHyHcLTY1RBqCyKVb
 ghPKA7ZSaMhuw3XFjrTUOHMhvO/Qxo44gHjL9XbyoHVDmw2vtEczKKN6madwPnMdoxroiO8Szan
 PthWKLwLidRlevSuV3zpMfPWxCO8gOal4o4jOif7BkNZmL0L1ELFxabGoZqrimpzXrW9si4MeWO
 jCjZimWjAIxLjVg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Pinctrl drivers for K210, TB10X and ZYNQ do not reference any machine
headers, thus can be compile tested for increased build coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 33db9104df178e5a3148b60c3c6bd153113385d3..77a5d13e899f8c5251987c2c74df1d05dbd59128 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -269,7 +269,7 @@ config PINCTRL_INGENIC
 
 config PINCTRL_K210
 	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN_K210 && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF || COMPILE_TEST
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
@@ -554,8 +554,8 @@ config PINCTRL_SX150X
 	  - 16 bits: sx1509q, sx1506q
 
 config PINCTRL_TB10X
-	bool
-	depends on OF && ARC_PLAT_TB10X
+	bool "Pinctrl for TB10X" if COMPILE_TEST
+	depends on OF && ARC_PLAT_TB10X || COMPILE_TEST
 	select GPIOLIB
 
 config PINCTRL_TPS6594
@@ -590,7 +590,7 @@ config PINCTRL_TH1520
 
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || COMPILE_TEST
 	select PINMUX
 	select GENERIC_PINCONF
 	help

-- 
2.45.2


