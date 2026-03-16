Return-Path: <linux-aspeed+bounces-3682-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E16CF3029B
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 03:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ0Gb2SQxz2ygf;
	Mon, 16 Mar 2026 14:01:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773630071;
	cv=none; b=IzECP09ulkqvjCsC2yek+kMEhSSSr0fCb5KGfW2XlQ95n/2p8nS0zyE+QVuwPG3Uefmbr9nzwoZsuOjYyOWiTZLjnehzFBTuKfSiGFFJ0Y7K1lxhGjG93w1P3X8t6FioFPJ1205anpEgv0HNNEPH1NPpbm4iOliROWPwQ3pdZqejxanUsiJb44UddyvL8RP7M4x4+sVB2MHut1E9du5wopZrnI9h4FWwSbLulgAkhQTi9P1b+w30Den9SbMue49/DTeocTF19z6rZVIBIxpQN9L1o8CuIA+bQ14WnYLjQst5Howc8yvb2p8QKsTFPHr7i5Er+5YhlNm5NvG6oS8ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773630071; c=relaxed/relaxed;
	bh=myNJ7+etw54WAWT1BMNWvXj3xvpTZxjGHfqbbRsc6HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZcohB0mZFrxwEkty4xEUFSRYYy6p5RwtnzyYfRJn5f2/KE3Osn+Cch9EsNcluAmBO1Q+hQntT0g7x6LtPr89Ktd0wpEkGY2gRA1PmGXxY3lzgQ5FwIbMevm9pw6rys/c1C2umetX/gKUFpAosDn9Opt8hB8k13syT3JzeiJug+DSlYvDtUi8wzkTGyD3fizObaCOyPpTJ9yGTZ93HKFB21apIV6ZiTh967mDd4vczRQe9t/6dqQUZaYD8PWiqUkx19r2N9sAAAHRxEMLsO/ACAvb/NfS04j9u4vsfteelnv6sPnKjSGM2OzL8VfvUjjxGWrKwNShacXzOuzONHnkHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ0GZ4fQtz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Mar 2026 14:01:10 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 16 Mar
 2026 11:00:48 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 11:00:48 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 16 Mar 2026 11:00:48 +0800
Subject: [PATCH v2 3/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
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
Message-ID: <20260316-adc-v2-3-21475a217b09@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773630047; l=3044;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=NDFWhGINrDRsy3G0bfBO0q4ZxiMyFTtoWTFlKzGT8bg=;
 b=8+JasgxeNNHI5TmBibZAQ6o3VSNdAtCoMXPHE46zCX4x1ALdv0eCR3VXkTeVQYfJuIc07K160
 P2qmexYd5iSCsN5gia0/OnQHF3m7pxjNAjBii10chq1nZ31mI2AqNnB
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

For controllers with battery sensing capability (AST2600/AST2700), the
last channel uses a different circuit design optimized for battery
voltage measurement. This channel should not be enabled by default
along with other channels to avoid potential interference and power
efficiency issues.
This ensures optimal power efficiency for normal ADC operations while
maintaining full functionality when battery sensing is needed.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 81a2dd752541..ab173d8542c6 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -148,6 +148,13 @@ struct aspeed_adc_data {
 
 static inline unsigned int aspeed_adc_get_active_channels(const struct aspeed_adc_data *data)
 {
+	/*
+	 * For controllers with battery sensing capability, the last channel
+	 * is reserved for battery sensing and should not be included in
+	 * normal channel operations.
+	 */
+	if (data->model_data->bat_sense_sup)
+		return data->model_data->num_channels - 1;
 	return data->model_data->num_channels;
 }
 
@@ -315,9 +322,26 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+		/*
+		 * For battery sensing capable controllers, we need to enable
+		 * the specific channel before reading. This is required because
+		 * the battery channel may not be enabled by default.
+		 */
+		if (data->model_data->bat_sense_sup &&
+		    chan->channel == ASPEED_ADC_BATTERY_CHANNEL) {
+			u32 ctrl_reg = adc_engine_control_reg_val & ~ASPEED_ADC_CTRL_CHANNEL;
+
+			ctrl_reg |= ASPEED_ADC_CTRL_CHANNEL_ENABLE(chan->channel);
+			writel(ctrl_reg, data->base + ASPEED_REG_ENGINE_CONTROL);
+			/*
+			 * After enable a new channel need to wait some time for adc stable
+			 * Experiment result is 1ms.
+			 */
+			mdelay(1);
+		}
+
 		if (data->battery_sensing && chan->channel == ASPEED_ADC_BATTERY_CHANNEL) {
-			adc_engine_control_reg_val =
-				readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 			writel(adc_engine_control_reg_val |
 				       FIELD_PREP(ASPEED_ADC_CH7_MODE,
 						  ASPEED_ADC_CH7_BAT) |
@@ -331,11 +355,11 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			*val = readw(data->base + chan->address);
 			*val = (*val * data->battery_mode_gain.mult) /
 			       data->battery_mode_gain.div;
-			/* Restore control register value */
-			writel(adc_engine_control_reg_val,
-			       data->base + ASPEED_REG_ENGINE_CONTROL);
 		} else
 			*val = readw(data->base + chan->address);
+		/* Restore control register value */
+		writel(adc_engine_control_reg_val,
+				data->base + ASPEED_REG_ENGINE_CONTROL);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.34.1


