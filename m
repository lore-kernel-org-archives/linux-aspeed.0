Return-Path: <linux-aspeed+bounces-3681-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F10F3029C
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 03:01:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ0GZ2yrBz2ygd;
	Mon, 16 Mar 2026 14:01:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773630070;
	cv=none; b=cThqPYi6L4ToUlsn9HsAAKFc45ntgBbOLmKSM9885SR2eBvz6aTSgAh6ErTqYKnzfGjb6z1TVJzeVQZcONM66Djut5jPnnGMqL34HFz6kKGV3uU+8n+/bYae/YX6M5QkDt8yvojTNrUwCVUUIVyZyHjKORdnmVMpiYCnbfug4IgNaaEqwEv4ir9gWVHTwu0pachOw2LtTOYzglSgnMlXhan1GonLAmuwIW6BwaTPmCcvaprU5zIW53TK7pEeElnEkA6mvsp057s6TXV3jMfQHpOPKxp7av0Y1Pw1CW/MucE+E1uUjlTCc86PVkW8YLOiSnlmQZmp1f+046Xd4HgO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773630070; c=relaxed/relaxed;
	bh=bZq94bRpo7cGkttwyFmGsJCg1SQgg/xbvhSZBlF7Ta0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FcDNv4NWxsn/AfRa+vwx3AMincTI8WBG7LS/KJ7vOo/bnIj+Z2gmWdBrRM9g6Y6c9HfakEvtMPDenqiy05NlxuLHdHo18VrLrVL1TqhUXoFycit4fWIWEN8fqEWXVgPKS3pPmpV6Gqn1nn3mQux6VoejKOPzbWlRYUugndMbnCMHpDykvj6S5gJBZNLJYfXuLwPfZk0CKLrmbBJF65toBfg5iAPz8FxCR0qtIcTA4ydnjfbcTJ4PfQnn85hY1DuztPqIUcwtN7UE5iIRFCwsE/VEdQ97qIjTpc5AWYlGOLSNcylG66lSAjeTCMRV7ls6AH+PHYjxm6INGBq+au+FPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ0GY5C6Bz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Mar 2026 14:01:09 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 16 Mar
 2026 11:00:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 11:00:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 16 Mar 2026 11:00:47 +0800
Subject: [PATCH v2 2/3] iio: adc: Enable multiple consecutive channels
 based on model data
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
Message-ID: <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
In-Reply-To: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773630047; l=2441;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=rESyvr9FI4k+pXWuBtBd2BjqM1Hm5GV8Bt0NdXlFyLU=;
 b=wCLeoY6AJwRWGyZ1g6zFZX4s/XiFltkM0W8fkuHXuM4R27q8k+whENeJ0ChcMS3z7I/N2jwWp
 DVR6/UOGxzzBOujREyHpD2AHRU8pjL7ulY08ZsbltKXMEKLLN+gHfFl
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Add helpers to generate channel masks and enable multiple ADC channels
according to the device model's channel count.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index af9a95d31d81..81a2dd752541 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -72,6 +72,29 @@
 #define ASPEED_ADC_BAT_SENSING_ENABLE		BIT(13)
 #define ASPEED_ADC_CTRL_CHANNEL			GENMASK(31, 16)
 #define ASPEED_ADC_CTRL_CHANNEL_ENABLE(ch)	FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, BIT(ch))
+
+/*
+ * Enable multiple consecutive channels starting from channel 0.
+ * This creates a bitmask for channels 0 to (num_channels - 1).
+ * For example: num_channels=3 creates mask 0x0007 (channels 0,1,2)
+ */
+static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)
+{
+	if (num_channels == 0)
+		return 0;
+	if (num_channels >= 16)
+		return GENMASK(15, 0);
+	return GENMASK(num_channels - 1, 0);
+}
+
+/*
+ * Helper function to enable multiple channels in the control register
+ */
+static inline u32 aspeed_adc_enable_channels(unsigned int num_channels)
+{
+	return FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, aspeed_adc_channels_mask(num_channels));
+}
+
 /* Battery sensing is typically on the last channel */
 #define ASPEED_ADC_BATTERY_CHANNEL		7
 
@@ -123,6 +146,11 @@ struct aspeed_adc_data {
 	struct adc_gain		battery_mode_gain;
 };
 
+static inline unsigned int aspeed_adc_get_active_channels(const struct aspeed_adc_data *data)
+{
+	return data->model_data->num_channels;
+}
+
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -610,9 +638,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 	aspeed_adc_compensation(indio_dev);
 	/* Start all channels in normal mode. */
-	adc_engine_control_reg_val =
-		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
-	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
+	adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val |=
+		aspeed_adc_enable_channels(aspeed_adc_get_active_channels(data));
+
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
 

-- 
2.34.1


