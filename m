Return-Path: <linux-aspeed+bounces-3725-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B59109317B
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 05:47:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcWm712Wqz2yYy;
	Fri, 20 Mar 2026 16:47:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773985623;
	cv=none; b=mbpcFkvQkFOfAJB0Lxlu8ouEi6V8ySLIdAQL7TRuUiGGnkeie5nJDJq7lS5sKnSEzQFZvNzMKAQMpr9irHlpfz50x+MaXbCPn43UxWmMwFp1KoVrBAydJysgTeUaHoik1QosnDK0P10lk92AnWW5EDQJsw1lEb092W64chRUmr1qGchJjmKs1JOENcB7kfCDy4lw0Xg6BcxSKbMXKum27XPaTPnjCX4kFSPzAtC8X4pOt2y/efTmOATOW2AmahKa/3GnAgTh+0yJ1oECdLnt1WsK37d3sMPJZWvDnqM0ZliLSKE3CVQzFn/E61Hq7o7cSo+jU1zy9n2pu4ysQY9kZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773985623; c=relaxed/relaxed;
	bh=SvSTDyofL5iioxfNCLKmnhWMhtnqQgsSITgCmDBkZh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ll8bZKcQ91D9XzKAc9noVGXTI8H32jmdPkdc+gT323T0dSN8mBwhWqoRgKVYrlF1cprKsCp931+IFWpRUQU+885FfY4QBcT8f4mxixblF/IPq/u0/zNwBX3U2WA3uxAW0I77Q/iQYmsVp/0tMesEM+TrwxP20whVwDIQ0lVNw/PfUJfGm84cAU7EEgNQHfjPq5UVOW9yW7KVyFcfSxpAMwHYOvAkmfcpESbeHpw9CRSECY/BvVZz8ziE7YuveUOwWlI9BdaMf4akz5Nm27vCazWkwQDoqOkeJH1ZYZFEZiIvgrl0LB6tnurLFYys7cqzgxYyN7MSZRIXIvdwLNjEiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcWm628hRz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 16:47:02 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 20 Mar
 2026 13:46:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 20 Mar 2026 13:46:40 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 20 Mar 2026 13:46:37 +0800
Subject: [PATCH v3 3/4] iio: adc: aspeed: Replace mdelay() with fsleep()
 for ADC stabilization delay
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
Message-ID: <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
In-Reply-To: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=1623;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=nns6L1IWBrZoZF9du3xsZHyx3aa79UG/Vd6Iwrl6+E4=;
 b=Qc5vqncqRGLGuLM3Fsty10mqFKuRhZ1K7YvVPDSfqOOI7GdSgN9c7iYBIUjuu+r/PXnsiWOSN
 xvgaZ6SBLT/B4iMZs8MNxA6NU+aeBkM4p6HjYbiLcTYDEzWDGEZyaYw
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC stabilization delays in compensation mode and battery sensing
mode do not require atomic context. Using mdelay() here results in
unnecessary busy waiting.

Replace mdelay(1) with fsleep(1000) to allow the scheduler to run other
tasks while waiting for the ADC to stabilize.

Also fix a minor typo in the comment ("adc" -> "ADC").

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 3ff24474f394..a1a6296d3003 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -259,7 +259,7 @@ static int aspeed_adc_compensation(struct iio_dev *indio_dev)
 	 * After enable compensating sensing mode need to wait some time for ADC stable
 	 * Experiment result is 1ms.
 	 */
-	mdelay(1);
+	fsleep(1000);
 
 	for (index = 0; index < 16; index++) {
 		/*
@@ -314,10 +314,10 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 				       ASPEED_ADC_BAT_SENSING_ENABLE,
 			       data->base + ASPEED_REG_ENGINE_CONTROL);
 			/*
-			 * After enable battery sensing mode need to wait some time for adc stable
+			 * After enable battery sensing mode need to wait some time for ADC stable
 			 * Experiment result is 1ms.
 			 */
-			mdelay(1);
+			fsleep(1000);
 			*val = readw(data->base + chan->address);
 			*val = (*val * data->battery_mode_gain.mult) /
 			       data->battery_mode_gain.div;

-- 
2.34.1


