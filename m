Return-Path: <linux-aspeed+bounces-2665-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FF8CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Oct 2025 05:41:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwfPW53YKz3fmr;
	Tue, 28 Oct 2025 16:41:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761630079;
	cv=none; b=BzBnZXO/cTs6iyQzMeu6LPSyDR/GzlzGjD4xTadpGnkY9Zy648ceFalQT2wgePk2MPPPqqMdMoG6v9CQTGb3hffyleaT8AdjWp7IKof3sM2Ji1Q9mVw5b8FfeE7qnQGhdCP7C4lyRxP7u8leD616cqGYFCB/u+LqywktMLYaMrPpsfusqq3eqy9JRwBiZ3d65dxMRkJgUAu/6/9tJkCjnYKdiiu6JjJTYfhN+lPM3mu7JgtxGS9PCGeDeZdaE+XdlhidfsEX35rNGzuN5F+5GpTAc5hTaji2a2SdQTZm+B7IeGWMY/ZyLdlrdK9g5vnLj+/IqkRF+tvo7Sj/PNdmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761630079; c=relaxed/relaxed;
	bh=+mIfOpnHq7Ncvl2okapXBd1CISdGuR9CpvlASf+RZxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXa3t0RusJeJ2yY14wdO+PGopIPcuy3meLmPXqK7nGkV9pFj3nCscoK/YAooE/FthYD7w8OVNg1IxxDHmKlrMO98+YHcoPCKF76I7UsWgzpQRpqNfZhOOAusQcGJLp8XHyQnTRn37iMojv3sKqZhBruqMK0EI1MrCkmn0o+U9qjbvrsrm/awtpw80/jun01SwtUyalxY+I58XDIBIu6Tf5+PfX8LcX08vASOMsa2hswB/WHHvUICLlIr/vlJM7BuOiXVkD3FpPooB85XvR2R5sOiCaqVBo3i+QH+b25MDgRNSZK8/1qouKHfcZtvvYcyDxOZ/OCusOyvX6K1w8KaVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwfPV6m9Wz3fmq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 16:41:18 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 13:41:02 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 13:41:02 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before configuring vref
Date: Tue, 28 Oct 2025 13:41:02 +0800
Message-ID: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 1d5fd5f534b8..8ab29948214a 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
-- 
2.25.1


