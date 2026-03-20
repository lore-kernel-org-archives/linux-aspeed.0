Return-Path: <linux-aspeed+bounces-3722-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79721093179
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 05:47:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcWm40c98z2yY1;
	Fri, 20 Mar 2026 16:47:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773985619;
	cv=none; b=V935nvNh9jb5nWc87sPlEVarvu+wvfT1mei9aC8CmDcU5yJ2BJjlIp0/YpvoQ1Q/339elWUPRau+2b6P9JbpUuvE3w93Ldc2r7n1b/Q1c1r7wAdhisEZ/kq1Qd1lgiTqxAsNHc/yY2lB3madJlcU6mO0n4JOINJ/flk9OtunsxGt2L/Bpuq0E0oI2+b+AQOVMvChI1yMymufSa0NuuB7d1AzBbMdXtAzS7R3/iFypkbJiTyexRMsMgIEXl08cD1WI/lVCMg7ZWW+iFicsuUNBsZgnf5NTODoRxKXt2zhFkXpEYNOdTdbPXCgE0eikdCAOJAdseGrj+0SBqdCmytEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773985619; c=relaxed/relaxed;
	bh=z4nB0/r5SHjucr91NuXd8v1nM0CvlhwLCD09C5ajWTY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HJWzOjBbzhtNgYoWrfE3BPR3sNtFvKp3PciJoDQuEYc+HI5wF2qhKLDgKzqcg6xqn6tDiJJaXqD7fSyCHqlmj2cGKEcab5U12oB9K3No9d086kaSRZrxxN1/+K+319kiRImv1Ri/HCyuHBeS4e+oMqJlUSBEz2QRNT3GAC6TfcakcWi8CH496OgbhqEmxa9fBTAogMNwHqmV3PgbMv23t6LbrPspsPdH3vfUfrM7VuTKsqzRaTq+ro6n3AYQsWkSugoWvRbeEN2MRoLabUv9pc6anq8YzCrrZ3zMJa8Qyieh3l9GI4prSALlYX5ft4LbzLENCq3AduK416r2+tp5WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcWm306kCz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 16:46:57 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 20 Mar
 2026 13:46:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 20 Mar 2026 13:46:40 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 0/4] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Date: Fri, 20 Mar 2026 13:46:34 +0800
Message-ID: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIADrfvGkC/2WOzQ6CMBAGX4X07Jr+0QZPvofxsG1X6UEgLWk0h
 He34EXjcb7sTHZhmVKkzE7NwhKVmOM4VFCHhvkehztBDJWZ5NJwJRRg8KBt5zg63jkkVi+nRLf
 43CuXa+U+5nlMrz1axLb++kWAAIuSgtPUGqPPmCeiMJPvj358sC1S5LdoPqIEDlJo26IUtj7wJ
 67r+ga7Q9mr1AAAAA==
X-Change-ID: 20260313-adc-479b0ab09bae
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=2152;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=TuilmV9/QzS9Wjm/LIGeDhedU/2KmdQqlz/9Y9KoZr4=;
 b=LbKiP2Kc8E1Fpt+3uxQU7NuAph6xcpB/odQpch9STV5VWWptSOotZFKoCADnPVt+cJG7cwYLY
 bcsmoyHe63PArOvCX/wlP91mZYrX2/VK/goV5PGSQy6WSgh59UGBuGh
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

For controllers with battery sensing capability (AST2600/AST2700), the last
channel uses a different circuit design optimized for battery voltage
measurement. This channel should not be enabled by default along with other
channels to avoid potential interference and power efficiency issues.

Changes made:
- Introduce aspeed_adc_get_active_channels() to return the number of
  channels that should be enabled by default
- For battery sensing capable controllers, exclude the last channel
  from the default channel enable mask
- Enable the battery sensing channel only when explicitly accessed
  via read_raw()
- Replace hardcoded channel numbers with ASPEED_ADC_BATTERY_CHANNEL macro
- Add helper functions for cleaner channel management

This ensures optimal power efficiency for normal ADC operations while
maintaining full functionality when battery sensing is needed.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v3:
- Simplify channel mask helper as suggested by Andy
- Use FIELD_MODIFY() when updating ADC channel field instead of open-coded OR
- Move unrelated blank line change to the previous patch
- Replace mdelay(1) with fsleep(1000) since the delay is in sleepable context
- Fix comment typo ("adc" -> "ADC")
- Link to v2: https://lore.kernel.org/r/20260316-adc-v2-0-21475a217b09@aspeedtech.com

Changes in v2:
- Split the changes into a series of patches for better clarity and
review
- Link to v1: https://lore.kernel.org/r/20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com

---
Billy Tsai (4):
      iio: adc: Add battery channel definition for ADC
      iio: adc: Enable multiple consecutive channels based on model data
      iio: adc: aspeed: Replace mdelay() with fsleep() for ADC stabilization delay
      iio: adc: aspeed: Reserve battery sensing channel for on-demand use

 drivers/iio/adc/aspeed_adc.c | 68 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 11 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-adc-479b0ab09bae

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


