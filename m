Return-Path: <linux-aspeed+bounces-2965-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8279CCF8845
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 11:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBwgS02FHz2yvJ;
	Thu, 20 Nov 2025 22:12:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763637171;
	cv=none; b=AmbBS8WL4oWhY8hMtrEv5DZ9/tTnEJK/BwiOpeqjUTU2+LUZxJ1+Vz+nWDaUexAwjqE2o4EtdHDaYalv+seC+msbOj1euUJc84Ijy7bGsGkQCQBwXeQ8F5PeLeRa7ihTVhZBqXfXYeJ4EdbOnO2+tjPy9qZZ1qeljjLUllD0CcxQUD1DAvHELN4d1HMHyOekTpTPj04aWGZsgqJwE3JlE44f3icoa9d91YmMUZ+lcXpCjHN6o4eJrcZaq1TreNaCGl5NtwiIVn4SuWtuMvYRXQkIa08F1i3gc1rmJY4z0vf/y7AePo/fOiFJcchQIZl0EwSNUF15faITT9A1s1M78A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763637171; c=relaxed/relaxed;
	bh=LSv/toN8LhY0dPYfxd/+apT8J/RWyA9BoX5PvgpGrmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BcnRRubSxmbtVIXckstXEBlfEDLUxejA6tqX89vqf6QO8bedJAGcaGqna1jLeXrKq8XCR0QFbXNlUMJZIPq2MIbjrw1a5pFEW8dY5oMlOZAbs/+TH43zx6fHWAkb857x0y3yn++Yn2YxhPX6ecALs5U7zKDJwpAh+g1RkRTgqd/BszdIrDFkinF3bTyYjGHABpnq8aeINk47tHQsCQQc1lx3g/JDDweuYDqBhxbZu0ec9b2gEKlsCK0lFA1s+mOhmlqxct/QRpmUP3axaWXKX+HdcgSCntLiKDy+oDSdolTLH74IP1AHJhr7CGk9+XnuKsvwcIqWLn2UKQMG5YCOuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBwgR324nz2yFq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 22:12:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 20 Nov
 2025 19:12:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 20 Nov 2025 19:12:34 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 20 Nov 2025 19:12:32 +0800
Subject: [PATCH v3 2/2] hwmon: (aspeed-g6-pwm-tach): Add AST2700 compatible
 string
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
Message-ID: <20251120-upstream_pwm_tach-v3-2-eaa2f9b300a2@aspeedtech.com>
References: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
In-Reply-To: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763637154; l=856;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=ej2x2zXWoa7QtHmm0Xcp6bZn7Ld93lchW1+uF4w0usU=;
 b=9D8NhxSOyyG7fLbywKVqdjG1j+SQgH267L/XyiiX3zrdd3nPdvt9S2B2UD+K/F7tfAiJFl7mu
 eQwMsMn8g+nDR0affVT6WVYSAiPG6plYrtnArbJqsrQPPzpQqSl5SXV
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Extends device tree support to include the AST2700 chip variant by
adding its compatible string to the device match table.

The AST2700 PWM/TACH hardware is compatible with the existing driver
implementation used for AST2600.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 4174b129d1fc..44e1ecba205d 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -528,6 +528,9 @@ static const struct of_device_id aspeed_pwm_tach_match[] = {
 	{
 		.compatible = "aspeed,ast2600-pwm-tach",
 	},
+	{
+		.compatible = "aspeed,ast2700-pwm-tach",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, aspeed_pwm_tach_match);

-- 
2.34.1


