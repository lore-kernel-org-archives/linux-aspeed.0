Return-Path: <linux-aspeed+bounces-2943-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD90CEBF93
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 09:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9f5D0wh3z2ypY;
	Tue, 18 Nov 2025 20:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763457136;
	cv=none; b=MaFmA7gYnFcJ41gk520XI09HcYwD2mYwS3MzsKOjEkqmKiN7EmhWDQcEdHlh9NRuge7U7DKtaNLVX9pKPn3UxDLI86qdTYMiZ1E1b6CFR5rgTA++XupL9gfbanImfZV6NiWZD+GMtJipqU4IL7pA3rS57KgXmoUQMamyHvRp4D1WHPajQQRRuUQH55TY4I/KIluUuEt9keULUwPRakePmjOX7C+hwiR4QnmfWMlu0M6eR+YFSldEk2Bohcy7xPsFxUIp6Uu2bMuocQf9mZZ/OwHcQkBQkZMZG3ej6sd5bGSbgore0olnb8zN8b1WaQXjYWUfOi1fQPQr1w25/d1UjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763457136; c=relaxed/relaxed;
	bh=LSv/toN8LhY0dPYfxd/+apT8J/RWyA9BoX5PvgpGrmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R38fwbNqknHBNm50sHUmkY77YeH/AvV9KMUnr8mV3YQmJQDJsuW/FqsF1QLqqKk4SFhdCsL8CYcwqfi7DplEERpZtpcIJeY4CyxskKy1hQS0oy+eI8q2lRhJggQO5SgLbD0UQaW905oGVUW/RZT+p2EJt+POtvRjQlcc8RWOCSu0k4t0FVsv1IhXl4Pckpd8tlCVNBDwXuFA3ugbVuWVv0jdl9vKe1xG/mh21CzcRxIcd6P9RgrenYO+MoKHjnLnX7TSM0p9MNvnTpxkwNVaXJ+U3xSItTLM6v1s3Zs73A1Jyd5lPY3ahevooFvpRvvwhAz4tHRmHpMpqeFnQdmM0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9f5C4P78z2xnk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 20:12:15 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 18 Nov
 2025 17:11:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 18 Nov 2025 17:11:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 18 Nov 2025 17:11:54 +0800
Subject: [PATCH v2 2/2] hwmon: (aspeed-g6-pwm-tach): Add AST2700 compatible
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
Message-ID: <20251118-upstream_pwm_tach-v2-2-4d9bc13d34f9@aspeedtech.com>
References: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
In-Reply-To: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763457114; l=856;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=ej2x2zXWoa7QtHmm0Xcp6bZn7Ld93lchW1+uF4w0usU=;
 b=HnxO8GIocP2qBsRGLBMEi8vf3FJlYvoCW5pB3v60VhbJxGm37cTh5O2iarpOooBe9rEzus7kj
 L4wG2WFuOmhBrsfpRo7dj0kDOf3agmQp05Q11mME78z+/lHOu1sltQj
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


