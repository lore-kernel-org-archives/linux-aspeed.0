Return-Path: <linux-aspeed+bounces-1251-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D99C5AE59
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:41:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mJh0BSNz2yZ5;
	Wed, 28 May 2025 20:41:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428899;
	cv=none; b=oSi6yUGZ2HRvTY/9R3zdXZC7c7mVEz41xkNNx9MaTH2w6Mga172o2q/G4r2dmVfjRhgpoBFp9MJ/RPpSl8320URsCEct0B9CQkauK4l2WhczR0Nzv02pCNMaqeL4V8WVZtrpXtK+b0FGetPP0gpKx72IEMdjzgM9/fFX/jUOrGFm/9hwPQcugxAQ3AKWP/C206H79cjeTnAPfSFK7b0i+AW0SxNTwULoYtVn3U/VC5YC90NngoNNYJli9hmWFKSXghWg9prv7C8ED5vRkkGpbhX9GMEpk4C/0JygRukEnXWaxuNo1cc1Xm+vw4fp6hEPaREacBEd1noahVprTbcJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428899; c=relaxed/relaxed;
	bh=7p6g8nrYLu2YSRDRFX7+ayHvEGE7eEHjSKPeWK9MLgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM/orLuJgYfv+S2cuDXvlEJ0NhqsEPUMKZE/oftlwfb09cnwYd9aSa+l3YKzSZLxzi0gaXpIi33b5Mfzms1lHM9xUGO4wLRBpXYaxYEdUZCKXkmqLX4v44sKDBueqkaleCK1d3+cK/aVMPiMgmBWmeQh0fChO4UJ05U7rft8QZ5MPrwuTi5I/NBB3KxDt5FwDWrSrdBvHtvJ1mcdlyofK6AN4D8csrgKpqjNZZxgh4ss3/6I38NfsysRSdaGXcDi+qmjbM5yXdwQPWnLdyv5fUGRsX23OnDhXeeV+t24KCvbt+tOG7u+unr3Zmqs1XYDWbud7Ao/rwg49uOd/frh0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fJZ7ta8D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fJZ7ta8D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mJf6xCPz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:41:38 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso162038f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428895; x=1749033695; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7p6g8nrYLu2YSRDRFX7+ayHvEGE7eEHjSKPeWK9MLgc=;
        b=fJZ7ta8D/ty7tDMTsrx8e0QMpIWzjle3Yr5n/DiZv02XqpUc37edtAUxhiY2CeJ+0J
         lLPb5QtMbHN/mEOxvIGUTCjp46BC9UQE5/JXnQL6NH4sYF7Wtytpe0+mlXmGhIPBrdLR
         iCJm6cBIApN3BOezrSePfbbSDPBqevw+sVIQCIsp7IprDWAE5bJdaoasX899Ll8Qze9h
         kCQ/1zjZRvAOdP6BLwmYd+gBvm48Gn0o3vtKPGq+0VF9S5BWovjlWTJ0vM7YaljgOyKB
         fSx6V9d5RvVvXTrB5P/Hu58RobKCmOhv8G2CqC8NsEWZzGh9CGMJY+4D4c0c+Ze7g3al
         86hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428895; x=1749033695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p6g8nrYLu2YSRDRFX7+ayHvEGE7eEHjSKPeWK9MLgc=;
        b=xHsLP/atW9npod5XoKsX1dqrnu1vMRUteXUCfeTZGrhtHm+GJAbOuhNqWNyvnNHOWD
         AMVz+aYZa7QRMuHommtqVAZV/aWcAulUW1DeDjQi22xjGvnWJgB8rVHRgLfBaACpsBOY
         mzVjvA4HzPwrn3terZ1BgTjW2gbbbXI+c+VnxIWRjTwrhDpktxI8rfvrcqhLD0AYsyr7
         J9c1yAsI0RWaKC7v0Xh8oz777zH6S08wWNyJ7eVb9BFfeQrfzkaY7OywDefLilxAQQiU
         VAlq5IqxImhJp3SBbloKDZZfzKRRpJ4Z6t8i0mxK4bloWnGZu0uXZY01j+OYxW/lIyDW
         B1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHD5SYf/MRdmOj9fxqIwzAPX6HV/qjMz755BYT+25IJho28yznrwxHfr5lklu1W14xb/ZgEDQStXjzgrM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdaPE5SumYX0Q7kS+GjsdetelPSAAo9zNMOJQ8R7YYqag8pljs
	xK6+gO17bp7Ihi0JxUdHk51/ZBZmDmdJ7mlSqin+cwQ6NjP+a2QPA0IlbUSorfGA4v0=
X-Gm-Gg: ASbGncsV7GEf6j4zOJwCoDWsl/jn3mzDYTLdVXeGzYdd2bYCDHs05/ml7/lKAqcLAjN
	rF4TEQzbBsNY8+JeEAbLH3Gj1UVXupz2iOlCKOb6vcEYnwOf2IIl0Kfcpo0ankFvmergA81qRE4
	T1+O03uhlb7pSo37yVNzgrCS5ZWwyFNL1r2zAd5Q4PZSyXUs8YLBJhW31/E7o3fPuwyCytxUQHu
	hCB3DXkF5iHP2JxL0NfwDAaY++SqYXB2Nr0jBsnkemG7ogpURQlVq/XUqY9ypVggg1+BzAOUcZa
	4rgIzpCJ6Xz6tQPnO2+tQ5vlYQHl7ewrFKxFdlbKR3E5tLQ2tjQ6Ge1XFfHTuGE/w2+XYNEOi0P
	EgpfADA==
X-Google-Smtp-Source: AGHT+IF4XXp1aLCWKB2Y2JNdxIiZKbtNgU9ZnNFVay8r7bVjoBOcuQslbgG6XG2skmv22UHi94V+gA==
X-Received: by 2002:a05:6000:1885:b0:3a4:e672:df0c with SMTP id ffacd0b85a97d-3a4e672e083mr1108871f8f.13.1748428894969;
        Wed, 28 May 2025 03:41:34 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:41:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:40:57 +0200
Subject: [PATCH 01/17] pinctrl: starfive: Allow compile testing on other
 platforms
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
Message-Id: <20250528-pinctrl-const-desc-v1-1-76fe97899945@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zrI5XszXIHo55XzuEzxs+Nt+l2DX90UOcjrVjPXljcM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhJ4yZZSqj6dEPnXTgLNjKYLUIHgwgauUARk
 H8eJl7B4ryJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboSQAKCRDBN2bmhouD
 1+ivEACCJDREpm7C+JuFF39/eQGACEJKolMKPZ3B1qh8VZPQQTidC/Sc4YJsNMf2ALyneQVNJRr
 ee0rzIGyB1dV+BdbrAAaU1luTOQfqd28ZU+hkN12kluq5TtfVYsfjC3qY+xT+s57CmqWJrS8suf
 tF84DJ05p8vijBMGOe4xzZO7or5BqM1JK32hTFyoZh7kOPiI174p0w91Flem3uX1rLg8f2iRGf5
 nPHw4aLV+fgDVeF1lulUpeOAfqHnt0lqKBhpWkowevGEp1PvCHxN9C+zZxjzyVFbhW7DQ7Vtb2q
 ekSrBr/nfXxV1LWbppOeZjsUoqbUYpEBFiNSjCW5tB6Rc2K4ez83OLBVRPG6U/mKcdlG/sz8MYf
 kxnETUB/7A5YgTrEHNeATC8iZ+qcu0dlniWB178PRj/Ohb5p/++wVINLNbOzxqKur1h03+i74ZQ
 lU+QrFHay3EclA4eZmLOSb5rWnnCam0dbD7OAwUxuYLUeB1dFqcULcpDozUjb0t6M4vPm2Opadi
 Y+Kcj/2g3qAtprbL+7BXQPANgJ7TNXpvHXfiUyPvyMmZPuCNkI2SsPmCPNPVAMn0fgSqkoz6iC1
 UKVdN+23XFZMk5MbzTHm838PZoLCCpE96EW79bgbL2OEPv4hPAfZ9GTjdJjAGafoQ+3/4WhNNSh
 y+XmeSNsjaGGtHQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Always descent to drivers/pinctrl/starfive/ because limiting it with
SOC_STARFIVE is redundant since all of its Kconfig entries are already
have "depends on SOC_STARFIVE".  This allows compile testing on other
architectures with allyesconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index ac27e88677d14f1c697e0d0be9f295c746556f4d..dcede70b25660833a158c298d1269d6ecea9dd8b 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -82,7 +82,7 @@ obj-y				+= sophgo/
 obj-y				+= spacemit/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
 obj-y				+= sprd/
-obj-$(CONFIG_SOC_STARFIVE)	+= starfive/
+obj-y				+= starfive/
 obj-$(CONFIG_PINCTRL_STM32)	+= stm32/
 obj-y				+= sunplus/
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/

-- 
2.45.2


