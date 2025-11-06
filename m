Return-Path: <linux-aspeed+bounces-2796-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E28CCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2S4Z3cqPz2yvk;
	Fri,  7 Nov 2025 03:16:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445806;
	cv=none; b=GELRGcCtT9b+6Jpi+b/BqZrxbMlZ7YVOxxaELzs3IUo0NmUdhc1Sel2BSbB0mHL47FP5Nu5rjiAMWR5k16bQwT9/DKmgVvHFWbQhtBRJ3TkfsjH6KvkrR5Zne5T9Ln3V/Y2yljSTH+a7GVk4qtXqIfreKJ68gMyA+6sDZ+FGZP900zIEHjLfB6+bST/e77h1PGIr1OpouEqcyTH3bzG2ZzxjKfsvtwaAM5Fmk9k0/mH0eliQKy+aBtZjgb9gBUHPji55gUCD4Zpy3h+66juDNYRUdXWqDkrHR+hXGeXAtbHKDLAiQzo3FlToEPNOEMtIXZBhjIZmVr/Ga9X3S3JmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445806; c=relaxed/relaxed;
	bh=bB4z51LIflJklurj0g7UdBUTO3OdObbc/NJxwgKEh/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNQpTRxHFuxS55HXk2MRJR/hvwPdsoVj41vDhVeJGoqVS6l+QxXA5iKwVBVBJQgRKJd4n84c7SKbyXnVeRzDCwqtc7tRiXNVCVs9HLv/7zfbPUYEbQ0Jfu/TuV417yJrHZs46dlC1ogtz/XhnH3ynvLiiKTlcdTm87F/OU2Zvy0+LJcNcbDq+UIqEWz40wgxHr/87vyIbBspPAyZ4S5G2ZHIC6EIeMAoNf3fuXssYBFHe51inXmKuBMvBlx5A3DinSAJRgn6oUJtUH77fkfF7Qo3pp0dMOfX8g1dOp6TMPFwfjiNjOD3KyIiFyIULIhOAYy1Zmv0jxdHA/AZr0KZxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b9wad8v1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b9wad8v1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2S4Y3V4rz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:16:45 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-64075080480so189815a12.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445802; x=1763050602; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bB4z51LIflJklurj0g7UdBUTO3OdObbc/NJxwgKEh/c=;
        b=b9wad8v1J0bV12ESXokREzVwSSVJBLwwD+aiyK05X/LmAYc9/OHqkzdv6PDUJBrdW0
         +Ml4KYoKmi2S44oQgtUZpWlHDutump3PXd7rJxABfcUaz/vodd06WpKCJOXhWFzAZXrf
         ZcaELmE78LbZPVCXMhr1pTG7TH/NGR227PheC0p6qrewQjCu+GKsXea8zycrE69CcUsK
         Bs/o3m0iMHiCodAPE4e46/3q86eioWxA288bbhjufr6Ouy696bkylXYmxn7ElclWkYyN
         DNqpFBqQf58ddbh9A2cdOo3nPwZmBWKvVWJpHp+V7zmzwou4goWhcJAK8JcXLaYFQdjp
         SPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445802; x=1763050602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bB4z51LIflJklurj0g7UdBUTO3OdObbc/NJxwgKEh/c=;
        b=KPVTHaCf/8KET3hqcAaoRfNZmESFRkRSbXJ1CfLgl3u549mRRyAoBTWUKdjbdA5yAm
         kBkBQz2cSQ2a82NBS6LO0FtiI78p/5xcg59udKrdgd++Ei+X4Tuo34kxphTihDsqOsSf
         LRSBImPoYenK7kfXIzo+xZpLeAaZ39dIjFYk9EvD6CXrIYnw36nXYWi8XSfEspPSfRCj
         qersXEdTUSVnhxy3fd4VPHqVbbbOsHHP6F7l45RNdUCS7GhpdKMiQC/w1rAsZ5KJL8pV
         EDUassHKc0c2KilH6Ua5/cJbLtPiHR07zxAY8KQ9iEppq7kLAIMGLInxe2S+CpKHzjXt
         BZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUCzIR2aepxTCpFxAX6iIvuLC8uiO7CcKSJwlpQCWVbMevplhxfHZ2kKHP3T2xAI2cfzYWIiV/oBuCXJYs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwipfOLMmAj2bHl0LhZNLMevhQ2JXR7sOD4zD+3L8MFgwYoZiSj
	t0MKeAVVb894niEahQI3SsBGJXKmozvo9a4btK9DUvLkyHJDUk1+C9UYeWvPafM99/0=
X-Gm-Gg: ASbGncvV0ZwGZKbdGWYRBa5E+wijEJlE2mc0mE8ry4skzoUfjOqV7/zMnHHDWJdNnWH
	jKapENEJ1yIu88HVnAjAD+Vuzuo3UJgYLQol5QctPgljFp/oRg0vhlCJS1EwwvuHpcJj7r83C4f
	EP3aildLg+sWHEf3mxKZ1egFkCAFJ5tsbX9vVUxyKnzkypPokdb5g+d+M/iXd1suJ4TDyTYAurd
	BJlV36Db50UvfN3U1PtNl9LMEkiCHK9VjJot3+w47JoPk2FL4Z5slA/SsZ+YfRvlJWCNcMRPOWG
	Hmq8WTl8CYauEQOsFnm+NJ52X18w8YKARuhm88aJ2RAlGCtYyVlqkQp6oZYFCSnCkY71VKbnqqk
	XNS76OSFGJ3STzvuOHR1EETCp8gaOct+btDvr+camzAPzxCBFHm29TasYlRcCcxclbLDklvfCER
	VGY7bgPWqY1w+Mo/VGNQzjL5dhWGI=
X-Google-Smtp-Source: AGHT+IFtC1GinaspbkQnd4wYug5IUHjv3SVNkj0rWIxppV9FyKPtYa1YcloDSaQrqrRVLMWxj8ovrQ==
X-Received: by 2002:a05:6402:26c9:b0:640:9eb3:3683 with SMTP id 4fb4d7f45d1cf-6411f615d03mr1806671a12.1.1762445802063;
        Thu, 06 Nov 2025 08:16:42 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:27 +0100
Subject: [PATCH 3/4] gpio: creg-snps: Simplify with
 of_device_get_match_data()
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
Message-Id: <20251106-gpio-of-match-v1-3-50c7115a045e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8j8xzdpWWGIQJTuLOAuFntqmfK/jylg0S/LsK5+N6+E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMngzkBYrj3JN8lP0o3ovEK2e++MYdMvcveA8
 m4ZPs0/rzmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ4AAKCRDBN2bmhouD
 1/57D/4pRWUnTW5hXv8wZdB6uRuQ55K28z8ZH3FaoCDGOnKAN61qaX0gKcjyK1QpdBM92q8dQlX
 7WOn1TtYWAGTHFqZ0FYGKUVtRg4AA40VNmIBZS0onPYiR3iUWjL91r8g+jFJRB2IsLwSt7sl1Gq
 aA8Xl3cHY3fo+3OVmd2TcZNyffc2f+8zM23RJHTHC2vO2JO7UgyiwzK+D8FukZVWziot6mdGL0s
 Z7BNjDHl8QiwXA4KWruLpwle9ZSdWVEM3zYUXEHb/UmvDvDHtyIhrW/7+ar1nPSXgWNLAys3C6p
 e8aU5fpUXAotF7tV+80nDFZe1fMdKUzUX2y2aeR3ErcwwuH+S7B5biM0GMzctAs/JaADM6JIKVA
 twdMBzL4Gw+dgCByJDc7fyqMY+vu3YtPwyla7Lw8PbtVd1OFaXAsJMEKoBb03X6xoHosdxtBR+i
 xrFfcnQBVxZi8UDPDa8gIgfK84U7Hp/6B4S47THfEkyZuJF511L1ii8URMSs1sPrFGMbCi0jKoB
 9cBGcwJqifeOyVVm/O+r2r9CSMGKdf+pXk2RVCW1CtCGEt4QyVYtucVFqw96bgGmqaJwkp2wKC5
 JdUL+O0Tk9wvaEynfCPgNCQSDSUUhm78cVRhcsmdO40bTXxVrupADbP2q/6asWxvHK/z02SPoq4
 V5KGI9l4mXh3aFg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-creg-snps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
index f8ea961fa1de..cdb103b0fae3 100644
--- a/drivers/gpio/gpio-creg-snps.c
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -134,7 +134,6 @@ static const struct of_device_id creg_gpio_ids[] = {
 
 static int creg_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct creg_gpio *hcg;
 	u32 ngpios;
@@ -148,8 +147,7 @@ static int creg_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(hcg->regs))
 		return PTR_ERR(hcg->regs);
 
-	match = of_match_node(creg_gpio_ids, pdev->dev.of_node);
-	hcg->layout = match->data;
+	hcg->layout = of_device_get_match_data(dev);
 	if (!hcg->layout)
 		return -EINVAL;
 

-- 
2.48.1


