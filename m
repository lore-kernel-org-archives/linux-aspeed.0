Return-Path: <linux-aspeed+bounces-2797-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25918CCF9F8
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2S4c5G9Hz300F;
	Fri,  7 Nov 2025 03:16:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445808;
	cv=none; b=i05yYHhEOkk66kdF2X7WTGdLDZk44BWMt+zl1K4q0Gjs/I1LdKaZk1GzgQncW9hnl1+hlwwccBLLQN+gBr+zI0qkLg0hsFrRtM20/1iMNUfGbkGmosG7qVCvlaaW5hcNTfYIYPQOfZFsNCQy4CenGq6FxDO3QxluRxEhu75QkuXjl5WoqzFHg/cSLcfrue7JJAwb7R5Ek1HDcUqv5QU6nVf4/GNh6bNlyd0g9Ea9pP9WZv4JuBU3q3eqlYjCSLeSndu9vKKANfznVnGiKXFJfQS+zNQMb7/mMJ8w0/i6qrqhR6CNJ16m5fVteAhrAvti8zq4TLU8dT6Kl7aLOD9y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445808; c=relaxed/relaxed;
	bh=LNxxLoSaj80bOvxwS+x8aO/LQaPqTkbFKbIYZM/ccx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/P4Q1kXq9FUx5vD1OcpGzOoc/QcIygr7fvi0QSTpMRS/T2X8V5H8jjVe7tuqELQ5gKubOs1uzZgHM5n2GOe+p1/GNKQR+6r36RGrcNjOQmjsVjj5JjBRrxLSUXNvAb88PkXL+JmrQw0FaNLZcu+823qF8a3sDCokD2rfAkdPQTqUNSQZgbd0KJTGSSxvmiSyFCKm0DQtEhhvjtgkKzSEO2q9fFBejI2HP0JPat7FmsxKVmtgmQbYpg/sfSSGUtRhyU9B/5KGzX/r8WT1LFxBMP/0OTbe7nweG2HwHkSih1CWAmdxkNBwyMTxwwpgNHwzhaEjqv42kisfHRGVJ+x+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rimo8knz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rimo8knz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2S4b52sMz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:16:47 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-640e970598cso210811a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445805; x=1763050605; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNxxLoSaj80bOvxwS+x8aO/LQaPqTkbFKbIYZM/ccx0=;
        b=rimo8knzwF4m2TccMJ7Je6OMqwP9tGS9nFtTMW0H4JklS0vfPMKgX3UKr/PUhWSmIf
         ctnhpRDGeqdTiH0R8SYJpVnToUfKIhrsHGMminAPhxHgH4rp3z/fy9yN1tk8sPiGTBoe
         EwtYIqmXSnWsJfoa0ED12KVjb/Iapu6sY1l/Yz2VlCd4x990NN5hwL0zIgztirLbfmo1
         6RqB3Dvxp2V8kOykp8+o+xCq7M7LTjNdbYbUPDiBLEx8YWinftPXHGVKKxmuOfn+fKH9
         rcw/tpXPjc8jdgWNwVBoFLVqIfkobw6kmPu0a2yVMEXJrFwL0nQmok+chb6CONa5QBUX
         iS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445805; x=1763050605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNxxLoSaj80bOvxwS+x8aO/LQaPqTkbFKbIYZM/ccx0=;
        b=kekxnpPmkN8kKWYkLv8UeXaFbhCvJlrzJsgz7g/rC4nuc3ijFueeVYG90UFEyw2aSE
         L80sDFWsfpU2UmTByPBZn0dHxUi87iG0rBubGrXaJ5IL0gaNpviSYNrf9hNOo9o6GPRf
         wy/NYQzObODCdNmHdqeANMpMATbJPeRaaMa/gfgkJkVX01zdN9q4DsImNxEcH6TZ77af
         d5YrI/8AlmAf5lnfR588qKR8G0CTzQu9YnXSC0SgbOrGVdAfKNfNyXBySpRpuST10MlO
         M3D7rj+ZGEUDMa3SIGfPGV6EPYkJnrfDfxjNljMp1K7yofO/+v0HgPESau6E/5rhPiku
         qitw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgcOJ5qPyMboUIros6yRliScUSPgh2b0xvTTKFuVlJvidZT3jl/Xh16zQgsGhiSU46MTKHLCCJSEZHzI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXuYjCHNvBvCstMq5bD45/aEeyBXRv+nahA5w+V3M+ZOf9L7At
	DA4xtsxoPbkrHz3eEcTHrOfAhoOckhzq/JvIHxP+GFvUdXzm3BJEJHaRGtguSn6wsqU=
X-Gm-Gg: ASbGncurIHJeTGrdMgi5SL6ANbGay5DnLzrl0jsy42GoxXzbNbf4zvrCY9/QVOFip8v
	4Zh1xmCU/7HMeogf1aVgHTXAfoioUg/CGWYbrs4ZRScUip5GL4rk1vmyXt1oxU8VAtCa41H6Hxm
	SG435bHoxBJgVZClTpfOby4+6UrVZ/wznwgvdOr96sNhqZYEpg3D5TW+nxUkb4yrwPezRs+wrpo
	X69TK2/fx2fUYrLuKNCrGp+rZ/sXldD6a2PrM+w8Dv0woD+7/uQkvKMJebLsai4/pZ6TmFxW1Xb
	5Yxc9OALgeseiFIDpoAl43mZiaJBJLv02ubMa6zOkEgBQ0x197Ve7wK+pWrAt1Z0Hy2osJfNP9U
	WuG2/5LAubSQaE4sfqQu42kkS+7gwc/LU+NnHHisJ+pvydKVyVzsZjzwMCUwUfoNPBsNiUV6cYz
	k+wkSzS8lBQYTh7bI/TKUBqorrLKM=
X-Google-Smtp-Source: AGHT+IGxqQY1TKHhlv59jD9rXPj3NM3yoBtmJAbJOzQqYLTcCXhQ3w1hdyfA1R6qDfeGfCwDVofBBg==
X-Received: by 2002:a05:6402:35cb:b0:640:9b11:5d7d with SMTP id 4fb4d7f45d1cf-64105b79e3cmr4181740a12.7.1762445804550;
        Thu, 06 Nov 2025 08:16:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:28 +0100
Subject: [PATCH 4/4] gpio: zynq: Simplify with of_device_get_match_data()
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
Message-Id: <20251106-gpio-of-match-v1-4-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KyCK4WaX8DTPr8e9FQEpVrY1lPGKIUEEeXomozdcgIk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMnhaeYJvXX2uO3vKVe9JEZmeNPGFfrC9cmTl
 8PnkWe0SIaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ4QAKCRDBN2bmhouD
 14SHD/0RJ4iQBsacOdNNfDcM2yGY5n7EhMle4k1LQGwzgE8xaJZd0bNJ5SuXB7KiK8M0d+ncBIG
 Vpgc5uJxPllzlkLTWU57w6XNurghRyy10l5bLnj3zVPqE8uDm8zaYb2f2KCLUY0ZFHBwC6ZZD0S
 EywKXF8tXCNuyHqUd/d2gc/hufQSKswUKOk0awanMijo9zIoPIAvdWP/68XTrDaJrUggH0VLWDA
 DirP1LDVncWKXiLonYBU0Dzj+E6zW9e09uUsKpYlzqLp9X5b0nZqAky4VSuFbrlQOTYP5qOQYI8
 6mcG6WQJGAQizQ5aDwZqz9BVLYC5A4wUFrZEOzZITZlVateMtaA36tFKB9ykvpXKYOtZbyDNzrY
 vF5L6KKkjCRSQMKv/97axV9dFeuK62nPFn6zCzJhtfuVW2X5gl/S7p4SKcVW+XzIb9B9Fd6UgWP
 xPUerlWtE7IzxdDyf5dKH0FnDkSm6SsqecuZaHZHyj1YvZOa8P+CK9o5BudRj9cUprLWEckBgGh
 vyk+OrhUR9i6hakDiow8oUA49HjhJCl3AAtwwFm9u0lRDlNi1XKdtGXrfZWUXbgT+BcW316eDTy
 c8bwP6f+3kHFzKoVOnytycrNZ1R3CfM400ReIYFDpY5ucGP37m3DcHa3ZSoiNYwzWaMPxuK5DhU
 Mad4nYQwDNFnyyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-zynq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0ffd76e8951f..26071ed1bf22 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -904,18 +904,16 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
 	struct gpio_irq_chip *girq;
-	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	match = of_match_node(zynq_gpio_of_match, pdev->dev.of_node);
-	if (!match) {
-		dev_err(&pdev->dev, "of_match_node() failed\n");
+	gpio->p_data = of_device_get_match_data(&pdev->dev);
+	if (!gpio->p_data) {
+		dev_err(&pdev->dev, "of_device_get_match_data() failed\n");
 		return -EINVAL;
 	}
-	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
 	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);

-- 
2.48.1


