Return-Path: <linux-aspeed+bounces-3679-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40180F30298
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 03:01:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ0GX4Zrlz2xpn;
	Mon, 16 Mar 2026 14:01:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773630068;
	cv=none; b=jlZATvPyU6pCwiFplzQTRhe3TQJrtXLP0RyTAUXOrstQlBG+VPWUiq1D5L3hiKYdglp1j3ykbiSw3xYbhTdc0dZwXj5zFrNNPRwLMN+YCkzGhrYZme2w7ocR/rsX7OsFzZwMWbrsSlZAYDruiKC3LubSu3CxjctQrTkVWVEjZAefkJ48jFBqfxfY0eLGl1o6H/+Pv9wEoXjx14flv3OKUM1eP9fURfIJ7+VpgH//eQT9/Cwe5TY79vGeWu/ka9ne9yjjw5d7sQRNXoUdFgjlMHaN5YZ3+R4IvQhdQzuaP+HtZ+y/ETwyaBi3ZbwIw37cCFluhN+zt8EDMSxE8kPYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773630068; c=relaxed/relaxed;
	bh=l+pTO17fQOg91UmfjghvNpCstYpEP44DkLaSD/o08/g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=g1prrpTJVUSx5RPLcIfm5MmpPu5DaWLFY/hLhy0L6uMTPc75Quhq86FPR7tR+AJwY63aygBk6UmkXKwRRU7I06X0yrkt2shqKDnb4JKMM1xVH9mU3x/XsV9YV8OipDNIQsJBIz4i6AYIoFnKBiDXXmBfz10wKhN5IzAvphXxnw6T9erWfLBu04aoZuGKPJvZes9OBlrYhuUVJFTzWLWVCm685gPuAwMvxTnWCiVlkTX5FFUI6QdLMQFqz6ZPdvBeu4UnWYPMR5FyP8KWqcF/18GTrB4/t2FAECyiBV9d1WTrW1fEh6bqyw1jcHpsdJdi0A1MKVcJQS7GJz7AX2sniA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ0GW5H2kz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Mar 2026 14:01:06 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 16 Mar
 2026 11:00:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 11:00:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 0/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Date: Mon, 16 Mar 2026 11:00:45 +0800
Message-ID: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAF1yt2kC/1WMQQ7CIBBFr9LMWgxQpKkr72G6GGCUWdg20BBNw
 93F7ly+n//eDpkSU4Zrt0OiwpmXuYE+deAjzk8SHBqDltrKXvUCgxdmGJ1EJ0eHBO25Jnrw+6j
 cp8aR87akzxEt6rf++0UJJQbUFJyhi7XmhnklChv5ePbLC6Za6xepgHuEmwAAAA==
X-Change-ID: 20260313-adc-479b0ab09bae
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773630047; l=1657;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=7n3XWwQkTSTYZWTGs/j2GKQm8DXZDI2s/DZ4MDmppHY=;
 b=xvKCj0NDWh80XBGmiwTSZxyraKDRRfynknLqGlG7iXkL/veXU8GCyWp8kw8rfs9DUjr0S5ccP
 RkU9xMn/VTLCwbEk9pEMJzSI5+c0bkixRI97lp1vxZZVaIddC5Fx+4/
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
Changes in v2:
- Split the changes into a series of patches for better clarity and
review
- Link to v1: https://lore.kernel.org/r/20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com

---
Billy Tsai (3):
      iio: adc: Add battery channel definition for ADC
      iio: adc: Enable multiple consecutive channels based on model data
      iio: adc: aspeed: Reserve battery sensing channel for on-demand use

 drivers/iio/adc/aspeed_adc.c | 75 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-adc-479b0ab09bae

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


