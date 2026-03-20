Return-Path: <linux-aspeed+bounces-3724-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3B109317A
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 05:47:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcWm60YT6z2yYJ;
	Fri, 20 Mar 2026 16:47:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773985622;
	cv=none; b=k18aGIlzfJM15/U/UwDTy0CbPF+6q/9b19Ax7fB1XKNhlv3HSmhjl8xVMlkwkOo0SvDLmQCp0ckMCI1P+1odHkC0LcAqD2ozBDU0EA3f8hIMYMUwsto0ODUReNDJwC357hinXiInORNVXkpRuhShsFxORGzZA9L17hbbJd7wVGs7KD3lo6t3EqzK9NSSDbgnTe7jATaAk3F2a6PgUPozglNF8ntUB3UnDld55gPKBv6LgIUs7Z/angiXAiTVk9Z/erG593AecB/+114HBdzhG8am6OKVzHOCZFzQt81gLyKmIoL1jtPFwtT00dCl5xiTPt3Q9WKmObF9h4b1vQMG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773985622; c=relaxed/relaxed;
	bh=5b+AvpbAhrlw+l0BVotlT16dih7xoXzrmNNvcHP2DhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xt2rJJV1jFycYuFRKvtk2f+vwIsRVk5fFK8MSgpwlfix38ULkJFGyKTfmaohJOFNbgHRKqxwxohmm0a+bv+zBIUGgkI5hd/Cy+i8HKJcuAatOUgJb5nlv6iXBp+C+05R0CY+fe/ZjnQto8yNtCCZqr8YDFSKabn2g4d3Mk2wPFHO4nHLKOPES5ujhBt2NcLdjHKRqAS9Rwbz/kB64FjAv33JfjN2UR3zejM4eTmiCIE5xwywpCJpyBr6vNtZoiA6s2y1gC9y2duwb+haKqV7Sxr3w3F/2oAeLcLT/GFMeZJrXf/2aQXfwD86HhHcmWHuW5zI3mrXzpW324iPqGgzvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcWm520fRz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 16:47:01 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 20 Mar
 2026 13:46:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 20 Mar 2026 13:46:40 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 20 Mar 2026 13:46:36 +0800
Subject: [PATCH v3 2/4] iio: adc: Enable multiple consecutive channels
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
Message-ID: <20260320-adc-v3-2-bc0eac04ef7c@aspeedtech.com>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
In-Reply-To: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=1731;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=NmmhJK7uvUVre1uvvr5Vjz5lKqP/DkupFhrPhytp+BM=;
 b=gjpKlIm9OA6WHPNLApb+1XgFzo7WUdGq9UT4iOA2UGLsak9TbZYPWpTilmInbAtps5oQztHh0
 5xUT1/v5ZAlDgV06+pcVwoPjla6BPWGia5EpXe9BoSVfqmeYFm13uVZ
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Add helpers to generate channel masks and enable multiple ADC channels
according to the device model's channel count.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 8eebaa3dc534..3ff24474f394 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -123,6 +123,24 @@ struct aspeed_adc_data {
 	struct adc_gain		battery_mode_gain;
 };
 
+/*
+ * Enable multiple consecutive channels starting from channel 0.
+ * This creates a bitmask for channels 0 to (num_channels - 1).
+ * For example: num_channels=3 creates mask 0x0007 (channels 0,1,2)
+ */
+static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)
+{
+	if (num_channels > 16)
+		return GENMASK(15, 0);
+
+	return BIT(num_channels) - 1;
+}
+
+static inline unsigned int aspeed_adc_get_active_channels(const struct aspeed_adc_data *data)
+{
+	return data->model_data->num_channels;
+}
+
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -612,7 +630,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Start all channels in normal mode. */
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
-	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
+	FIELD_MODIFY(ASPEED_ADC_CTRL_CHANNEL, &adc_engine_control_reg_val,
+		     aspeed_adc_channels_mask(aspeed_adc_get_active_channels(data)));
+
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
 

-- 
2.34.1


