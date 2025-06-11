Return-Path: <linux-aspeed+bounces-1354-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D5BC677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:14:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFjm2FmPz30Lt;
	Wed, 11 Jun 2025 16:14:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622460;
	cv=none; b=dQLCdzqQ6RVpSCkMtXxgc/bdj9DKAhF4DDmBrrzaUcz7OAvFKQSuiFAQV6Y6McU3mYBvSkWtd9pZyymZEGoUc73Y49ylL1HTe9msdr4iIzhmsOP77HiXKAzZxxyPMyJtSN7MwwP6MSIOX15cPL2oiOAnnV9ureM2NOrwD/7KVpedk8TnT/pWQe6/QSLO+1g9RIZZyKwZJHDkH7S3t2BNUsAaGIERjYcd+NVsNzZUSAMyGmJM4pYsE95uF1FvtpJNHzZUJbopzarBzzMfxTex9fgmKpACPzyiVouei12qhkSfp/hOkSANwemS7i5AtkCHke/AVQZ/fpZHjdqDaFPqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622460; c=relaxed/relaxed;
	bh=LmGTr9Avtp+9E1jrxJpsP4+QY45B/matmjkDOASukCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Se05cg0NSt+fTLfGxIL4djh7b8fELsz4PSN6H+9sXizXmxJE5q63QaIql9ugidDMWgQ88qJO0NSTzILT5iOyU3Zoxvz7OjxcIAWuNUIxdYS1zLBudLrItpRDXFYIPHcNCveet8b2f1GySX8KZo9SdmIs1ZCwTjc7636EBLjRMaFSovoD5I5KVWniM5YIPinoDDEzZ8kTI6+Sp73wJ+VQxj8IUe0T39xzjNimUE1XXeckiPEAcagg9BlvwXKzFWPRtarF/z+UInR6wkDcmBfqyf+85IU4KJgZFMHwt0hXgq+cU60AipMMN79lMU0Re2F690LJRogH4jjvGjMUp4hx6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qsFH/z8H; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qsFH/z8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFjl2QyNz308b
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:14:19 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so27436f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622456; x=1750227256; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmGTr9Avtp+9E1jrxJpsP4+QY45B/matmjkDOASukCY=;
        b=qsFH/z8HQNfdCDRygEJhHmSCineVz+3MVts7gSU382cva1lvApXtZcS++N2XmrWQL2
         VX6QmMH9Kca5KRmkFdBM1tjrZlbVeSNoiKC6ts9F+WZjOtDW3d5vPco1Pb6XsBb/f16H
         2eW0ds+qAJgTXujsVEB8IUP69yHuM+P/LIrEO+8GK0lLXq/Vmd2d4D9hixsX26flsLpZ
         lYLO+rr9tOc4ewLD/9x5onKgwca75nmmpsAolFzrbERrIrHsZpmjZg1rdqdLLPaWCzQW
         JD80tR69f78aKWyqkz6Hh8GEGcw0wg1//Ma4Fb3gIMZ8QaRIZsMNy/ua3pPAMzvCbt1S
         9wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622456; x=1750227256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmGTr9Avtp+9E1jrxJpsP4+QY45B/matmjkDOASukCY=;
        b=ucoYGv6lEDhIqyUIxM2i6zOkM7h1vRO5j59TSUq4oe0BzaivkdXVECdLc+8mSZ34He
         0c+xpFxWiZ9cC1ud5N7EjAPpHAD2cMadCEiUEG3PD7VYv9p3ZE4bGhgjZCjERIWGjRSP
         qGisYejtcbBkulVbZq+jGH/5vmEng8XSh7RrlnLV1mbOR9rfo0H8yX0OyCn9ud69WVTQ
         mMNU2jiNerJxjJuMJNOXI2jcpox4OfYyXs3d8vYDXcgmypATlO90X9Q6NwWKgHovgqPS
         1ztHh5V/6OhVEjUYNcEep4MAPR2UhipeoJ00OEu+cOjdz+ou1naBNTAmE0v7xMvMp43/
         ATQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzLoKwUdP+6D1xOoMmP2kQpjBVm2zQG8Hi4ErV69MVtf09csNlSDUt20cdYSgBehWoB3Bn1QkRF9m2i5A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0tNn6BCexPlz8OCCExZpnmpuassutHI7B+nJt/lhGo69eMEo3
	eIUHQSkkCg4PJToehVWK84p1Q5Jm+tNvCuivaI8H6ql8RIJQOcbSXfmpx1YlGpQMZ9o=
X-Gm-Gg: ASbGncvlSDYZJ8nCEcmK/vjLsJ0ZSflhersKL36gkOFEzXtwLVxAX3UWpJYmmMNr1cc
	qjeNSnzHR0h+9J4L92Ke8snXD4DX4+QW6bIJgTwpI8Ck3MzsIpsBd708ZT0FIoE9OaqV73GjrTQ
	UIAggYgiJGQPgW+L04UTOwONuDNyKIoUbJVoD/sD/6nNPiW+qkFHT7EMbqiUEbqxGshYFKqbMhY
	A4ZAj3nEf9ZEG5GMR5JK6SIIIrF7BhL8a57RF8P4d5GmVU+ry34512IfalioQAYF02/SRmavujG
	TtNTxAggA7ClNydIUyqCPrY3CsCkWO1nZ3t0+dKQCxy5M/LiIeQ7aMrUNeYvHSZXq+/2hU9InPS
	Q4m/wbVo=
X-Google-Smtp-Source: AGHT+IGuARTYLyF3UiF9reCUirhd/Exv3gey0a/FHP4hXPUPwwAH7XeVaLmvzmzisoq7vXGGNYY6fw==
X-Received: by 2002:a05:6000:4205:b0:3a3:7be3:d0f3 with SMTP id ffacd0b85a97d-3a558820e34mr451650f8f.14.1749622456103;
        Tue, 10 Jun 2025 23:14:16 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:34 +0200
Subject: [PATCH v2 02/17] pinctrl: Allow compile testing for K210, TB10X
 and ZYNQ
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
Message-Id: <20250611-pinctrl-const-desc-v2-2-b11c1d650384@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uGHDfIA31YKh5ahk8efaA6IVYuJLI6m+zDCouPPq644=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6g8xxyHU0HpiCDaPmzEcUGbG3i/Yo/YG0Wn
 7rcaYbUuOCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkeoAAKCRDBN2bmhouD
 15vZEACL9S/hnI46RCXgnSdsn6o+epweo7vg2Ve0a0tgPgDpJPr9sxin7UVOYpBd9VSMJJQoLLF
 aeqFMhIemW0RcumAWboyA4gfV7dVt4MPt/v++UUEhPUE9TwivxEkN5kMfkB1dRF4+MjSjHDuvGC
 ZPBUhFjQCXOgwCVHKydx8vmuJV0CXug08L0YllTPL8pXovkyewDPdTKqQaFhukVSfPcO9IOAgtx
 M5yXLQe29xMW0Qyyul/SVfUXoGYtMZqzVJ6W6dzSnw0YNlMlEQg2zyirVpJ5F+/OHhCzmyC/8hL
 vY3Rtcjw+MHY8cI42dcQDzeoAKALlg2/hy1crOMdKh8wSr6O6LFk7rAOTcWChL14XAoUvJpX+zd
 r0YhSuMLTab6mVHTRRgnXKL1v2XuGeY/7QwPQxo0jcTZpaoreoReVm+cJ1biQiLJhRB30IaCe1g
 tpwj/e5Occ6qRtXtGh73XlrINYyxw5OzGdzDUiTSx1Bd8fBfKqn1ojFrBZU6c0EfEOEodfM1L3V
 sIrLevCzW4HtOtGrGg1HFUXnHrJ5DdHAsk/NQrAi6Yy0jFf+hLnI1SRhJfuSoGrStvp5Z4M4RDJ
 lCsyjBjzLRgK6m8GXnTUqaoCeXd9zcxJxwOmrrtEsnEGDuREqGFpURGacr7KDtTH88JLMKCC9g1
 C5kgftvilxEQjiA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Pinctrl drivers for K210, TB10X and ZYNQ do not reference any machine
headers, thus can be compile tested for increased build coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index eb1b37af81fb81175d22018cf4856bfafaea75db..9b93a11c5755d5e1b239b34d5d66d5717b281265 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -269,7 +269,8 @@ config PINCTRL_INGENIC
 
 config PINCTRL_K210
 	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN_K210 && OF
+	depends on RISCV && SOC_CANAAN_K210 || COMPILE_TEST
+	depends on OF
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
@@ -554,8 +555,8 @@ config PINCTRL_SX150X
 	  - 16 bits: sx1509q, sx1506q
 
 config PINCTRL_TB10X
-	bool
-	depends on OF && ARC_PLAT_TB10X
+	bool "Pinctrl for TB10X" if COMPILE_TEST
+	depends on OF && ARC_PLAT_TB10X || COMPILE_TEST
 	select GPIOLIB
 
 config PINCTRL_TPS6594
@@ -590,7 +591,7 @@ config PINCTRL_TH1520
 
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || COMPILE_TEST
 	select PINMUX
 	select GENERIC_PINCONF
 	help

-- 
2.45.2


