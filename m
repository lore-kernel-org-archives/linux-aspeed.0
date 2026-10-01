Return-Path: <linux-aspeed+bounces-5102-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CDCCA5FB3
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 09:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwRxX3YX1z30DZ;
	Thu, 01 Oct 2026 19:50:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790848256;
	cv=none; b=imwayHZCm7Pr2q4dbjJwTbmZUnqfLkBOdEDz5Hmovx0f+IoTKdWGjG8snHz5qYT/ydUppHdGF7pO2pzFWdRsj0rwktIsqitDuU9sL7XGkO+NA1vJgfaytaw/5IxPq/25iT/JYZn5LyY52yRp9Lx0ABQycWj16xyxzbQ9SFI+P2OE4ViQ8tZOJWUFyJ6Vl7gMtDk8nBjfT5++d/JwpOZ4VbTEx8YLSWKtCbngE0rlGr7wqOAoXsCPzCfZ4xhw8DmyL+JnxCHv3DO+H9LuDprPM2scMwLa6ew0fBvv9ruw5jGmX/edHrZik2JOvh7T2F2NIVmbjJhb74T75+O4A7RtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790848256; c=relaxed/relaxed;
	bh=KLBitSznIAHwXDFMad2HHJpJEda5k7QtGpbwtGIFOe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iQ68/AMJ+jeEpLX3cqIof61/AhTNFR8lPbtcokHU2+4y1tRmJ7NEQkWu7fXlecRYwKwE+SW9hw4oHdQZ4ibbw5rjZ7a94cy9qBJoP1W1rC6fpnx602SZaTscadffR57oboTWlmqS+LlRU7cydscbQoATGT3lv3d8NJc8sVm0LsPb5iei0imGyWUd7XBSm63m70h9dP1xzDPrHngRnmc4H55k62r+9S6bkLnEJGbaiWJ3QveMIBdILCEuE/5STkRzPSUhpgdBPjoOtJB5KrVHHDZtlJ77ji0/S32Bzzk/WDqY2W/lzSySJfSOkyv9qQebD6Mbm67382cOz5pUZgOwYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwRxW5bkrz2y2Z
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 19:50:55 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 17:50:36 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 17:50:36 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 1 Oct 2026 17:50:37 +0800
Subject: [PATCH v2 2/3] iio: adc: aspeed: Use syscon phandle for trimming
 data when available
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
Message-ID: <20261001-ast27xx-adc-upstream-v2-2-2f9c15cc0064@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790848236; l=2265;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=WPV7NQJtWwp+T21EUXVF/dzCgqf51s8UxhpFwh7ZoXM=;
 b=GuhPfngoLDUhxj/NrRURiCIE5sY4k3uh5xIcOmGYiTUHHZ7J9ppGESOV3PfoUGajIWhTs3zQH
 BHxP83KNmNTBizuDP5U/emEeNdQ55Pi9OKy2EceZZQeUsF+oT5+zGwO
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

aspeed_adc_set_trim_data() locates the SCU holding the ADC's
reference-voltage trimming data with of_find_node_by_name(NULL,
"syscon"), a global search that matches the first device-tree node
named "syscon" regardless of which SCU instance it actually is.

On AST2700, which splits its SCU into "syscon0" (soc0) and "syscon1"
(soc1), both nodes share the same node name "syscon" and only differ
by label and unit address, so the lookup always resolves to syscon0
even though the ADC's trimming data lives in syscon1.

Use the new "aspeed,trim-syscon" phandle property when present to look
up the correct regmap directly, falling back to the old global by-name
search when the property is absent so existing device trees keep
working.

Fixes: 9d8b88ffb773 ("iio: adc: aspeed: Add AST2700 ADC support")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 drivers/iio/adc/aspeed_adc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6169ce28261e..bc7b576b9d6d 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -206,13 +206,21 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 	u32 scu_otp, trimming_val;
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
 
-	syscon = of_find_node_by_name(NULL, "syscon");
-	if (syscon == NULL) {
-		dev_warn(data->dev, "Couldn't find syscon node\n");
-		return -EOPNOTSUPP;
+	scu = syscon_regmap_lookup_by_phandle_optional(data->dev->of_node, "aspeed,trim-syscon");
+	if (!scu) {
+		/*
+		 * No "aspeed,trim-syscon" phandle: either a single-SCU SoC, or a DTB
+		 * predating the property. Fall back to the old global
+		 * by-name lookup for backward compatibility.
+		 */
+		syscon = of_find_node_by_name(NULL, "syscon");
+		if (syscon == NULL) {
+			dev_warn(data->dev, "Couldn't find syscon node\n");
+			return -EOPNOTSUPP;
+		}
+		scu = syscon_node_to_regmap(syscon);
+		of_node_put(syscon);
 	}
-	scu = syscon_node_to_regmap(syscon);
-	of_node_put(syscon);
 	if (IS_ERR(scu)) {
 		dev_warn(data->dev, "Failed to get syscon regmap\n");
 		return -EOPNOTSUPP;

-- 
2.34.1


