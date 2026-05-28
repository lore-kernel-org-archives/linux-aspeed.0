Return-Path: <linux-aspeed+bounces-4144-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D672DCD5BD1
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 May 2026 07:42:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQz2v2yxJz2xMW;
	Thu, 28 May 2026 17:41:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779954119;
	cv=none; b=N/zJ4ZMBaB/OaikuEryyrZMp8YLecKG0CwK58UNJGDn/lT2rjRJsQiUqczqYnK2bR24hppzM7lYX2vOEUV0jgvmrM+ReAZ7YM2FIf2JC7+oIErzvGpy5KDO4tojQZboMzaCBqOo2Bc1odnK1xDqjK6Nzlb3KNCyl0OeDUaIzYZFQrLr2jE8RqtoaURUE4cgyduuzfUsH/h/WNeHt1CvLINBddq1xSYbKKzy5dZtBs/lR9l04eVVazTNWdvYOCxi4Qn81qFyVlAK7VR6ipo5vLsxFqGUs4RaKhRcYr2aV09K7hO1uWtof3mVq2pDwT0XZ5JxdMNUXYEWttjcWnaEt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779954119; c=relaxed/relaxed;
	bh=HvpfOCxBkKdPdAFXCgtcFIm2G1XIooQZ5NeAaiyQ69E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d1Dw94vVr9Evutft+3lH7DtyOkHWvMmpizQe1GgC/lrQWgXIepA7JzI0RhZPHLwsK2wg9Zyvp5730CjHkgkVbbFxPFMRR57EoMWh1JAfhBMIra2izNOM4C5qqKY/C89h9P9VdMLMbeA0U9xpIpjqfv7sCeCW4kOmfnFfOQdN7dBFHA3CjzrqNQcezuz1mAlHLS7GsdN16meQABKpwQ/Wy0SmPxLK/ImarvU9fWVXLm5wnNe5SS8Osg7s7fySujEKv2FaekgmJLcoQFPfZwmkR8l8IKD4aENLwDJQTID5vNj06QpVhzvZCfMAJCAtTwcMyol2sdfmSRSyF3q/WVSRYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQz2t3yK8z2yFC;
	Thu, 28 May 2026 17:41:58 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 28 May
 2026 15:41:37 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 28 May 2026 15:41:37 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 28 May 2026 15:41:37 +0800
Subject: [PATCH v30 2/5] i2c: aspeed: Read clock-frequency via
 i2c_parse_fw_timings()
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
Message-ID: <20260528-upstream_i2c-v30-2-5d4f9adc3530@aspeedtech.com>
References: <20260528-upstream_i2c-v30-0-5d4f9adc3530@aspeedtech.com>
In-Reply-To: <20260528-upstream_i2c-v30-0-5d4f9adc3530@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779954097; l=1911;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=hbcoVNA5J1bXCVOt2Zyea4rZOSjPJ+N0iRWHM0ixkfc=;
 b=gsEAEdAMg6ck7BILVXtkvLp4+x/SBtdIry5jRBvDvmGpqolpVUJxoP/fpsw22To1Ebn1gc+9i
 smg9HKz/KRKC80eKp9el0e/KYQuiLGhMaBtwMUxhFRyFg1VskPtGb0x
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Use i2c_parse_fw_timings() to read the standard "clock-frequency"
property, and fall back to "bus-frequency" only when the standard
property is absent.

This honors device trees written against the updated
aspeed,ast2600-i2c binding without silently falling back to 100 kHz,
while keeping existing in-tree device trees using "bus-frequency"
working.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a26b74c71206..137889e57ddc 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1000,6 +1000,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct aspeed_i2c_bus *bus;
 	struct clk *parent_clk;
+	struct i2c_timings timings;
 	int irq, ret;
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
@@ -1025,12 +1026,18 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	}
 	reset_control_deassert(bus->rst);
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-				   "bus-frequency", &bus->bus_frequency);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Could not read bus-frequency property\n");
-		bus->bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
+	i2c_parse_fw_timings(&pdev->dev, &timings, false);
+	if (timings.bus_freq_hz) {
+		bus->bus_frequency = timings.bus_freq_hz;
+	} else {
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "bus-frequency",
+					   &bus->bus_frequency);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Could not read clock-frequency or bus-frequency property\n");
+			bus->bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
+		}
 	}
 
 	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);

-- 
2.34.1


