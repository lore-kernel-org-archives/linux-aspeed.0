Return-Path: <linux-aspeed+bounces-2795-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3863CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2S4X3ZH6z2ymg;
	Fri,  7 Nov 2025 03:16:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445804;
	cv=none; b=oS9x527f5alCqnB4pKI3135pSmFlrDIigqBeAfVGOLUX1503sHCJTpDwdAiWPId1H/0vYbx0xx0EZDfe2Uctb0Uc2sA0T82NslXVmFvkP5upeEMTyEqa/nRgkGSmye5SmQF8ZhAINQp7peRsMQGvqrxVav0NYSbwi+rVocEdzDS/yJwRd7PBpJ24ERmX3yTO+h5cBoyQ2zk5CP90ZLJcSTYEVzIB/Rz8R6v4Xm2yq/O9XINuDv6CVdJsDG3xh9VLmVEOuR5MwmloOBF6qlJTbJuimcDTidbr4m1TeoU6DLwDRq7WrchJJGNl+UCXohiFNZnSZcigL223iUojR+WeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445804; c=relaxed/relaxed;
	bh=3fnpzlv5TqPyTNVopTKhYQKTQxoXkISz35QRtVU9Hac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtfRoryyV4qVc34G1YUVbFjBZe3B6p+zf4a7itGkLGSyMu41rRpoGkAbydw5htir3EVGVgJtBB3GdhL9lsBub/MkdndGN4pdiVco7MH54sTL3NXGNNYr6UH8Jq3o7vuFdcl7jxyN+Ghl78AmfdHVw2w6FL0Gz0OhkXskNUp7rrewmN4j/AkUs8+lIKa0fcRF+n4m7VPElfUTdypWcXbZeeteb9RU7reO3j6/S2qdbiXPGIhcbk+Ww4cTf5TpQdg0+t9A+GLJ5yCGCWYX9/hk4gJSou7mZITyjNafbZNcu/hNJpstpno7dWv4LBYGSDcpzV+vzwocWLeGiu+uLTQb0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rP1ptpM2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rP1ptpM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2S4W3pYjz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:16:43 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6317348fa4fso187209a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445800; x=1763050600; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fnpzlv5TqPyTNVopTKhYQKTQxoXkISz35QRtVU9Hac=;
        b=rP1ptpM23VGNuKcBp+x4sDU39wGQBMhm1FsZdEVbPGum4QjV6bP+mQk2Y6jpiFPCHr
         Z9EFMska/My64AFSRYSSy07tv4fH7I6jeyJUiXGRCzt5OeOVi3dS9thwHqRryBrSmy1K
         MQxCmpMGIfS+qDUIu+5JGzjzQjBUEt6QYFI1iuZibbLQJBwuCu19m2Xke9rpmsFwN2FN
         4vD4Fi5ALrlw2FL9cOUfse+0k9WZ8jnQV6aa+D22sxESm7RQWAr71kgmMExu90MFVNO9
         EiGJO+CrGAPHGS6pLKU0u3rcS9AJkM0XdrXd95Hbj+PLbqzevjgmXTTk9Dsfv/o/StPO
         ustw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445800; x=1763050600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fnpzlv5TqPyTNVopTKhYQKTQxoXkISz35QRtVU9Hac=;
        b=GuodeCz4D2h6U0oA6XorRf22zvPan6gKsNnTSKUaahL2viQzr2zF6cbaNpN23IWPy5
         Dqu7A/vllKMwJelWcWx22ywCAu2uv1LJ6ZKJkrE9aO3wEQCoXuH1AB7VOLOB7KGWFPrk
         W/QMrGKRveTc0Vpuj8sldxzjZvU1ruL7bKuydnj9kkMx9Vi4ky5FYRLfH3Tbdt2IeaD5
         x7QfuFpfvu+mLvavUZ0j9OVYwuolJ2510ONQInYM5ZZsoHdy5363ZrHn8mU0tm3ulycC
         0ygfee2q2M8K0RXjHIpR8aLx9+b2P8be+3MZHAcwD2ZzGaTUw0fZ4h2k3RMBriv0NWfN
         9R5A==
X-Forwarded-Encrypted: i=1; AJvYcCUq9DgyZ3IWdgYHEGlcNXFzBw4EAsFp4Prd3P4uvBkohRsZsOF+BC2F38NtWUFFuXFXpv983HGJQLzgo+k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5oXFPDGHVzTkbK8y06OJr24qwq2alc5eLHcAV9T5O5QaZ1qOI
	GGPjAQEAUaU8/eeijlHnaU2VgLC00nXan6K8T9dEnOFywKta1mw8mv3obQpwv70fGBQ=
X-Gm-Gg: ASbGncvItnlj0NntiJVjzq9wKtEwlcEyhmcVED/Y91DtinQb5h/+NhjiirPp7J5LMu+
	HOV6zTM+wDk5PW8yHudd464BV/7eTbXzsPlMxK6FzUMIzJ8yPHYFBzfjFv6FEXKw7HLK7nlpZvc
	Jy4wXPn1bZEsirqoBqh+U6lJFAKQeC6aMbpnwst63KJOqt3XABPNDWpDGlxkIwj2LGpnm6/msmf
	U9Q76VCYnPRs3dr7Ra3iy/SVgO5vHZLb85DRkCdAcp1XNyn2hYFC6mYj5hBrxaqd2CO5G5/GAgm
	sFmrP+u4xf8dHv8HaGc0/YkbCzraObWMgNlGZG/XnG9k7C+CJUpu60xJ8srZV18z4xEHOU6e7Kx
	Dl5orVdxOtJ0YTTz6WAlPbflu6pRsuvl9dMBrQvAgmO2sVxjdfBj9rtQuMxt3cxYXzTlj1GOMnv
	fWYsNcX4Axf7+HpjHRG2GP8pLRkTA=
X-Google-Smtp-Source: AGHT+IG/5tTc7ZxspWUa/B8lb4VJAe+mwb5eciTvDLKhw+fK6fmt5UhwDE0B5Na16xt3VKGSskNthQ==
X-Received: by 2002:a05:6402:234a:b0:640:9aed:6ac4 with SMTP id 4fb4d7f45d1cf-64105a44b67mr3713567a12.3.1762445800269;
        Thu, 06 Nov 2025 08:16:40 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:26 +0100
Subject: [PATCH 2/4] gpio: aspeed: Simplify with of_device_get_match_data()
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
Message-Id: <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZT2hMJMzDp444RtFAMt6NxeIg8ehhxp6qQkq6o38pVU=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGkMyd/IHnLxQ8aaVNi31HhlicsroQ2rUZcgWUqQhqbqfNgTz
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpDMnfAAoJEME3ZuaGi4PXQc0P/A43
 VlDZbJcd8JJgzif8Kxz45G85Cei+azNOhCDEWH00UmdsmhkuwJmwLV+Ajksw1M4M6mgS80zGzly
 5O02OU5dduEuqs5AZNvaL0cVqHiVZhq+YhmANDSBQ0/E3jRTOOR/y9Kzpb9wIJ9YPoNJ2Qtyf3m
 9CiCBFsHGxIT2Asnc0bw2xxxIXDfLJkc0ru5+Hzwr5y0OH6ips03STdfYXBGn82p0xsT4abiVXr
 XW38qszaEhKlyNt/SNUyEhOmddIAXFWNGLymNcCKEUrXEsNJFmCMEbC5SjHYcBkmHthI7LIIAF+
 Xxpmjh52IS6RfKOOLmJEVlRlayLX80kQ9FsGDef3p6FtQEkX9tJPerYMs4SFtxopCN+HF7MixoY
 buUncg8Cw7RYV6DswaMKg4q01FNFuvYAVMAmOTAO1apdaWDsQi40ET5rYH0vkJ1fL7gvPByVP3L
 /uyg6aZubCZd8D55phWmbVsC0kW8hgiZKvjuR7A1zzIhKIxGrx8bpIgiEMaUbxsDIl5G4qxqIh8
 tcABibfodCZr+m12ITCbUUoCgEfmSwcoE57jaZ6Cf6Y0wwzIEnqqP1h0L/smNhts94gcsIoTZMG
 edD5iw8glo6+FCxSFKYbaOvyeqrRYLGb6SNZPRh9N0GGlO3Cch7OoaZuBlidPfbXhcC/r6xtUUG
 VRHv1
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2e0ae953dd99..3d675b63936c 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *gpio_id;
 	struct gpio_irq_chip *girq;
 	struct aspeed_gpio *gpio;
 	int rc, irq, i, banks, err;
@@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&gpio->lock);
 
-	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
-	if (!gpio_id)
+	gpio->config = of_device_get_match_data(&pdev->dev);
+	if (!gpio->config)
 		return -EINVAL;
 
 	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -1334,8 +1333,6 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 		gpio->clk = NULL;
 	}
 
-	gpio->config = gpio_id->data;
-
 	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
 	    !gpio->config->llops->reg_bank_get)
 		return -EINVAL;

-- 
2.48.1


