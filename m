Return-Path: <linux-aspeed+bounces-2718-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9ECCFA05
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 10:52:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0T1v3ZwCz2yrm;
	Mon,  3 Nov 2025 21:52:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762167155;
	cv=none; b=jAMWHQdpovla7vH8G4VuGd5EpancrMGFPbrwzsDFQJWwSy8qapprpO/yeoM8leww4I4mvF0Q2m4TM45odKQr/DVPvw0BBkFsPjaLC0zQqOYhKy3mFIsL6U/7D78nMtR9yPTHM1bUCN+8phyWzmz5jO32Jjc5FEeGwRfWq+rMObw6KM/samduqbFK/QoHWHH8EenqmI6GCcd7RpHAmsNRLVxOfFDv8dJnP/XFcdIIhD9/8Qr23xNogM3N6uMfgmKcNUONImm+sWv2AIyeOohqGhNVtFZ+6/5uKiirWZx49qHEhh7tLE5nhm05nNFkqlzT3Rbr+vJmn/kg1Fhr9dnNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762167155; c=relaxed/relaxed;
	bh=P2iXB5W67n7YO4OssVtAEv8fDCZhOHZ+N8v9CZniUss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQrIrJ7T7WZIM19K3GpsNXbPQC+0IgYxsaQovqx4SzA3r5vhXZBGo2J3utwiWyQskpwOZDshwSgLHAYaK0VLP9PvdPyc90eR4JMveAAw0fiDJABFBY7Xgu5Uka186AlFoG0uE1LpeLC0/hiKvvN03yfiC6PBkESu8dV9IplalKVv+bYXkH7ksqb73XDbP3HdLPTFHbP4VVxFW8Xyvxb5Qp6KPPvpmPrmwQKK+3CUO4NFbo8sXa8avkEaxb56QCZacSZwV5XPonxBzPKLV8pnTfL/bnb5KA7FWLEMUQNLiybrJgVa4QZ/zmNJoSTlGQ+3jP47P/v6GPI3xtjXLLgz7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0T1t6lrhz2xnx
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 21:52:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 18:52:17 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 18:52:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
Date: Mon, 3 Nov 2025 18:52:17 +0800
Message-ID: <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
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

This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
they are functionally similar to those on AST2600, the OTP trimming data
is located at the same offset (0x820), but uses different bitfields.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 8ab29948214a..9df6e7f68f19 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -646,6 +646,16 @@ static const struct aspeed_adc_trim_locate ast2600_adc1_trim = {
 	.field = GENMASK(7, 4),
 };
 
+static const struct aspeed_adc_trim_locate ast2700_adc0_trim = {
+	.offset = 0x820,
+	.field = GENMASK(3, 0),
+};
+
+static const struct aspeed_adc_trim_locate ast2700_adc1_trim = {
+	.offset = 0x820,
+	.field = GENMASK(7, 4),
+};
+
 static const struct aspeed_adc_model_data ast2400_model_data = {
 	.model_name = "ast2400-adc",
 	.vref_fixed_mv = 2500,
@@ -690,11 +700,35 @@ static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
 	.trim_locate = &ast2600_adc1_trim,
 };
 
+static const struct aspeed_adc_model_data ast2700_adc0_model_data = {
+	.model_name = "ast2700-adc0",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.bat_sense_sup = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+	.trim_locate = &ast2700_adc0_trim,
+};
+
+static const struct aspeed_adc_model_data ast2700_adc1_model_data = {
+	.model_name = "ast2700-adc1",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.bat_sense_sup = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+	.trim_locate = &ast2700_adc1_trim,
+};
+
 static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
 	{ .compatible = "aspeed,ast2600-adc0", .data = &ast2600_adc0_model_data },
 	{ .compatible = "aspeed,ast2600-adc1", .data = &ast2600_adc1_model_data },
+	{ .compatible = "aspeed,ast2700-adc0", .data = &ast2700_adc0_model_data },
+	{ .compatible = "aspeed,ast2700-adc1", .data = &ast2700_adc1_model_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
-- 
2.25.1


