Return-Path: <linux-aspeed+bounces-2556-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767ACCF9E0
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 06:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs0Kr1T2Wz30Pl;
	Wed, 22 Oct 2025 17:55:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761116128;
	cv=none; b=WdK6aMLaFvQnx+LCqVAZYXr/Yp/GIdTlNgy5+ecRQEQzeE83CQt41qJMA9Eb1xXzTjrotPt8wSCKqRU18lfzf4mHSLc4d/vhMds7Q/XWIZmJLmsQdMEtGm2CooYHEUfuPJqlBIa19cUJHzy0rcvHe8UGTbqbNi1uFdYDgxfh9GglUoK+ScuDmL34bbRZXYuJ/svCAjISjCLjqvJf+MEfibQXX/M2mnOitJYMCyGTZ5zvB2raNilnMxsB9vyCAChFMKXDW2gHiuxW0t86aVJKZrIUYNX1y7bquVQUpwwTegnF2KGHexTHmgmaNAMfBhTgZd7lJAj/eClYC3IV4SLsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761116128; c=relaxed/relaxed;
	bh=poKoDk5JsUNnSl1nvbFWT7ZRjSjAmaJktrcHmAUIWUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+FVqUtM7M/rXpyxT7ju5eF7W+pCgzQy0zzbXLudkPnZDOg+4mNVKW9KUeSYknt6YbE8Zfof+WjXjuz2zf5maHrHLZpGnXchWsLdrzsD9U7yrBN2aV1qiNn0nuDvyWmN234rIgu/zhXgy4bjGEHlIZA0atumIgCfRH46YoOYQn5OfCdRBAaBHhWRgh4i3EmGpT21fVI0MDzqLveMphiTDYptPp68JfQdEDEsTOPJNE61uX0YT10sZ7HPPB5KQ+3gqIJMc0hK5pXFjw50pIcAfpoTUZ6srKLTd8gXjChRU63dv5TJPK08NuWzvBtUpVnEkKtDFmxd9e9aJCWcyt5kNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs0Kq56rYz2yFT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 17:55:27 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 14:55:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 14:55:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for ast2700-intc0-ic and ast2700-intc1-ic
Date: Wed, 22 Oct 2025 14:55:07 +0800
Message-ID: <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 SoC defines two parent interrupt controller blocks
(INTC0 and INTC1), each containing multiple interrupt-controller
child instances ("*-intc-ic"). The existing irqchip driver
(irq-aspeed-intc.c) currently only registers a single compatible
string: "aspeed,ast2700-intc-ic"

To support device trees that describe the INTC0 and INTC1
hierarchy more precisely, this patch adds two additional
compatible strings:
 - "aspeed,ast2700-intc0-ic"
 - "aspeed,ast2700-intc1-ic"

Both map to the same initialization function
`aspeed_intc_ic_of_init()`.

This allows DTS bindings and drivers for AST2700 INTC0/INTC1
to be matched correctly, while maintaining backward compatibility
with the original compatible string.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
index 8330221799a0..a40b406dc8fa 100644
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -137,3 +137,5 @@ static int __init aspeed_intc_ic_of_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);
+IRQCHIP_DECLARE(ast2700_intc0_ic, "aspeed,ast2700-intc0-ic", aspeed_intc_ic_of_init);
+IRQCHIP_DECLARE(ast2700_intc1_ic, "aspeed,ast2700-intc1-ic", aspeed_intc_ic_of_init);
-- 
2.34.1


