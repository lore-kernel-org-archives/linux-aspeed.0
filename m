Return-Path: <linux-aspeed+bounces-3422-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D91D72361
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyCHW1q0dz2yFQ;
	Fri, 23 Jan 2026 20:26:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769160407;
	cv=none; b=WGGbVElH3ycmDHn3AYQh4juZChzB7KJgfjVlINrZwrjDce3N0ICNkS7MakXBDQksKKYIvxGfrllP2jEIV04VB6jSesSvmn/E8d02Ds/ufwNngXcz5MvwNYtC0MC2BTF58ay4VKtdd723cR1BHOFwxRmKmNowxZE9KQrcTDaqyj0l4ezH/59xEb6CMlTvsOSczVLjDZf4alUEvz84R5okijSlrWY1TNWBhjGvjNDGeJFECGOr+5NeOXmmqjQ6jloP0WMmaIGp6/rQJ+PRCAGsjtC1tMYyjnEFq+fka1j3Qndb1mLOcTmYv4oNmMw845rx7QICNH6kKrCBny31d5u1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769160407; c=relaxed/relaxed;
	bh=8rH2UvScxY/50rVLThRvAA7TKLScpgIC4XO0GLHyM4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TOteHcTui6wlG8/Qxh1pq5YG6OmfWOrZdT6eRPMnaubIlt5dXD740znw9qL0FF55cQgCG7CI/jsQ6qwjkI2uvJLUIBYCWiYN4atzktw8v1W4gVdYWA4qQr/8AfxM4cIU7USRUQDvK6tG7pg1Fwg5pYcLRhk+Fzk6zFwN6P/hv/emYdU2moc0AHVaj/y6F7NHf6rCffofL5KMva0r/+wuG3OlMTmokPYQ2dMNPWeERz0waIp1+eSpkel91RbhtrVT9sbfGJUQpZX+LALuzGCwUgp5y9wHtLnQ8T0QOFoPxW9PFZenLKAoNVQgtrHxTbTmSnfd+IeTf+j3rX5fbBWn9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyCHV49Kfz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Jan 2026 20:26:46 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 Jan
 2026 17:26:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 17:26:26 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jan 2026 17:26:26 +0800
Subject: [PATCH v2 1/6] gpio: aspeed-sgpio: Change the macro to support
 deferred probe
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
Message-ID: <20260123-upstream_sgpio-v2-1-69cfd1631400@aspeedtech.com>
References: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
In-Reply-To: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769160386; l=1736;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=FTZzog1cghOkYQGpXnNtMtKiobZwLYO/6gvXhdqdfb4=;
 b=wKbf6vtm34F3bElj6iOkpuUp+S+jsMo3UdPcDnjnNF4IqHIRoFFFISw6vZIdQM/oYix7J6q08
 dpN2LDBi1BYDC0WFVJMRqJui7jZUWtpQnF4vHxc9VT+tFrZbTazV81Q
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Use module_platform_driver() to replace module_platform_driver_probe().
The former utilizes platform_driver_register(), which allows the driver to
defer probing when it doesn't acquire the necessary resources due to probe
order. In contrast, the latter uses __platform_driver_probe(), which
includes the comment "Note that this is incompatible with deferred
probing." Since our SGPIO driver requires access to the clock resource, the
former is more suitable.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 7622f9e9f54a..318cd0e39741 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -516,7 +516,7 @@ static const struct of_device_id aspeed_sgpio_of_table[] = {
 
 MODULE_DEVICE_TABLE(of, aspeed_sgpio_of_table);
 
-static int __init aspeed_sgpio_probe(struct platform_device *pdev)
+static int aspeed_sgpio_probe(struct platform_device *pdev)
 {
 	u32 nr_gpios, sgpio_freq, sgpio_clk_div, gpio_cnt_regval, pin_mask;
 	const struct aspeed_sgpio_pdata *pdata;
@@ -611,11 +611,12 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver aspeed_sgpio_driver = {
+	.probe = aspeed_sgpio_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = aspeed_sgpio_of_table,
 	},
 };
 
-module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
+module_platform_driver(aspeed_sgpio_driver);
 MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");

-- 
2.34.1


