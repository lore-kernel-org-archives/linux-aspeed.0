Return-Path: <linux-aspeed+bounces-3599-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE3F5140F
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Mar 2026 06:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRxjW1XJBz3bnJ;
	Fri, 06 Mar 2026 17:45:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772779503;
	cv=none; b=YWltA8Fh0CKC2WHRmPYv5i3eUkK3DeqrsjvSdFkQ5Ib8osvjl9Z8uCbh9a0YVZya0XhBVGQ3Vc7mlK2HP/tecG9UAU/s3A8ZW0wlUqlXJEmBoIxkVDumKcW/E3Rnaw3WpFP0VMgCf8fdb/wAK++w2V7Fj+vbcl7GIba9GSR0o+9Wv2qSoWjVhQbmozFjDWb5aDjXjdVqUKJh4u8ssLvUp/eenYMLT7hnvp0uErHZe8/09lTwHBV602bAG9OYccIvfNGdxDjfn8S5quHnB+9NYe4Z3GB02fl8Z38noKre7z3PA7BqYZO1GWt9D4MFVFLJfaSWtsMvOC1Jie7EEvflhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772779503; c=relaxed/relaxed;
	bh=weVje6VkStlr/WzV2kfkWiuSUPkbEVkQwhRLMAxr5Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=j/SXB9M+lzXQk9kSeyBeURvX/cYowgRRjwjAbiIsZdyroiAjF6XaFJf2Gioav4ZcJ1V2yln1mRXksP0iN2qATLjupdCMWvDLM0ZQ5S5RMd0U1VNv+1hlvmvF9tYpP8bwhB57XTpHxjf9TnFB4BSUtF/ypIXaABSNVyLTSjmYHu0i3O5mK8SpLdYyyYN9Aj2dmpHjxKHsFxuujiqOY6yR3WS8jyo8T4OjC52fznvu9FPjG1Xble34XjpfdU27qyoWxs+Ykd8+9u32VSiptKfaeiTtT2DWzHim0w7LW/qyPqp54/NWbsXzvG8RCPcAEOKCvaUJTJjswm5Tuwe0kH9i1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRxjT6nHBz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 17:45:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Mar
 2026 14:44:43 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Mar 2026 14:44:43 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 6 Mar 2026 14:44:31 +0800
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tach): fix driver data handling in
 probe/remove
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
Message-ID: <20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAM53qmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3YLy3Pi0zIrUYl1zSwujxBRTE4s0A3MloPqColSwBFB5dGxtLQA
 7d/zWWwAAAA==
X-Change-ID: 20260306-pwm_fixes-7982ad548f07
To: Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-hwmon@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772779483; l=1393;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Hp31w4Jdd8sbOX4FBY/G7j05d+Zg3ydoO83w3jExP4Y=;
 b=09OrdeecveOCl4q7/xzNvFn8RPwEs0VhaZWGUH3DjxtVv/MYLVRvpS5M+R/B7fmZ9Wu/kcLtQ
 7t0gVAB7TCBBGFnoYzwXx3sDDYB8WQH3a8GZW4Y54TPRZDxzAppIi5m
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Ensure proper association of driver data by setting and retrieving
the platform device's driver data during probe and remove.

Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 44e1ecba205d..0c03d272279a 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -490,6 +490,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	platform_set_drvdata(pdev, chip);
 	pwmchip_set_drvdata(chip, priv);
 	chip->ops = &aspeed_pwm_ops;
 
@@ -519,7 +520,8 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 
 static void aspeed_pwm_tach_remove(struct platform_device *pdev)
 {
-	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct aspeed_pwm_tach_data *priv = aspeed_pwm_chip_to_data(chip);
 
 	reset_control_assert(priv->reset);
 }

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260306-pwm_fixes-7982ad548f07

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


