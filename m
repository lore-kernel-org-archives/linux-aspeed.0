Return-Path: <linux-aspeed+bounces-3585-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0ECEB3659
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Mar 2026 02:38:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ0Ng28wlz2xpk;
	Tue, 03 Mar 2026 13:38:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772505523;
	cv=none; b=XFpX/v9Q9T8mJDGwH9NnMIU/jpauyCt8q6Kv5YM9Pmbq9y/WKuxzV0LV4NZFppQZa+0ugVAbEL6KYzZsB2sYyRRFOkZ8iGhxK6rESlrqXFr/RkGG/EI2Cc4AWnzF4jkrI839mWs6IEihmSSqeZvUQvb/SQ9UhGoWz6Te4SjwSMGuZiu0BUKX+uJG5/i+o6yBwcJZWfus2JmEJsERfWkrDpjPLXMf++LV0qBB8rvP3f+tHjLOVylH7tagqE+Y1+XkKKz2fKahsco+gd5boPx1ud9k/RYfCBdY47+kkc31lkbQFHdMTDORAtMGDkTEc9Ua4netJniGEdYq9hq+zuSwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772505523; c=relaxed/relaxed;
	bh=la8uvUv1qO8zP+Ss4g/iC0LJ7sZtMGgACg8BJ3Lah6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GsPeh4XFVc22a6Knj/9BSi9F4DJMFrpUsHAJ/twrc/HVPVHxgSlrI16nWYgmepjsZ0CT1u8to32G0qkXZUTsW3Fa/NnathZXThMH3fUWBeMiLRiu1CSLrxlpK9WSAN49lmrzrAUTkY7ypSsn3JuqI0frBwVPxsMXnRsOJEB1AlibvEcUx9M0qv3pKfCMPtqDDvrDfepdVUAo5GYKIBSoVOP8zDl1aMxphM5gPPWvSwR3IfQmB4tH4tKD2uE3T9Zm0r2sv5JluUeo33cwBcO4jK+/+K9Oy7gsJ0j6n2YbEL/CG3VSry55Ta84xvFV+NiU+Iq9Y74wM8bXFs0cokl8+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ0Nf14W2z2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 13:38:41 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Mar
 2026 10:38:25 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:38:25 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 3 Mar 2026 10:38:26 +0800
Subject: [PATCH v3] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
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
Message-ID: <20260303-adc-v3-1-10570f23d3ce@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAKFJpmkC/zWMQQqDMBBFryKzbiRR0xpXvUcpJSaTOqBGklBax
 Lt3KHT1efDf2yFjIswwVDskfFGmuDK0pwrcZNcnCvLM0MjmLFvZCuud6C6ox+BDb5wBfm4JA71
 /ldudOaS4iDIltH9XK9n0Unc8tTK601xSYqR5/jxKtnS1eUP0Bd1Uu7jAcXwB6v/QJ5oAAAA=
X-Change-ID: 20260303-adc-47e5bfdf89c9
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772505505; l=1172;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=vyRSNAFGP/y8QafqAEY2QSHcXxBy39wt1+hBkhXUcbY=;
 b=21ac4yo0r6x7x/tJeAkxkZ/VU17Pf2KeA7eGaRWUcCnyEzaf6AgHmYvSx46CZcRbHG9+9xTDI
 iIB0a/DyuZPBd77hGpNz0mL20hh8AiqGWmJl1NIBVIHQH/1TBW3bccp
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Fixes: 1b5ceb55fec2 ("iio: adc: aspeed: Support ast2600 adc.")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v3:
- Added the missing Fixes: tag

Changes in v2:
- Remove Gerrit Change-Id's
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 4be44c524b4d..83a9885b9ae4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260303-adc-47e5bfdf89c9

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


