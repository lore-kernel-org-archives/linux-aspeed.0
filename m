Return-Path: <linux-aspeed+bounces-3622-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E8EA854C
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 02:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTh0G33lsz3c9M;
	Mon, 09 Mar 2026 13:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773023630;
	cv=none; b=eH5cIRJDSojdBkFbj3ZeqZBNOWfJuHeOORv7Efxbw7fb7f62WkzlPldNLXyBx3JmPYXDSYQZs1X1Dwt+MKHknUSdAKJO61MKaIfqpIlRfsMa/3/3TQ9/pEhUXz8+laEgWAExvecAgHSgLx/NWmaQSg2EnhQJcQQ6RdRyeE9aBh6NuY9yo3ApviQw6MgzCNnWORGZwGs+QCq2YMWtNF8WmxkNat57LfAujSUBjUp/pmFW+1oIfOO1+W1FPjuzdYH0mZMUFWq/edTGuDEugpYT/VAOKvCyy+p5A1dvkDuJJKmozP7IPlc88nqmjv6L6IrG9czXSKoiSabHCs3yLAodfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773023630; c=relaxed/relaxed;
	bh=wKWvDKTbIUsCJpxdrNNsaynS0NyECmn3rdHITCYgoDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BlPoDgu7nSCEIZTIl2XIaSyXUTo4oHqBhT2IFIBgeb2B4KCzCCXWesJooQjes7O3mX86n5mdy0mi64ZhmTxLpFALkLU77RYAIg0hsKui+9r0mCngLo8mkf3GEY3afRLpJZQ+m0cUhio6ntXBnP5iRoxBNLjvsnbo9XBxnv6XIYhed44f2x5UJ83fxqkgOehv7HaMj2nCJCOF7ojmNc942lxFTdzY193l1Vg15P2Vwu4Fx/MGU7Z296TdqrIKODMiyDh9iEsDU4lcYj5BOzzHnh1NzLBBoCY7fRewmLOTSbQZElH/2nUbgjOy6nu+vM7h+MbIiMvSCB7Ol/V4HDDw1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTh0F4L82z2xdL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 13:33:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 9 Mar
 2026 10:33:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 9 Mar 2026 10:33:32 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 9 Mar 2026 10:33:24 +0800
Subject: [PATCH v2] hwmon: (aspeed-g6-pwm-tach): remove redundant driver
 remove callback
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
Message-ID: <20260309-pwm_fixes-v2-1-ca9768e70470@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAHMxrmkC/22MQQ7CIBQFr9L8tRiKFbAr72Eag/ARFi0EGtQ03
 F3s2uW8N5kNMiaPGcZug4TFZx+WBuzQgXZqeSLxpjEwyjg9UU7ia75b/8ZMxEUyZc6DtFRA82P
 C/Wj6bWrsfF5D+uzp0v/Wf5XSk56gRIPcPpQdxFXliGhW1O6owwxTrfUL8+YoPqcAAAA=
X-Change-ID: 20260306-pwm_fixes-7982ad548f07
To: Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-hwmon@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773023612; l=1632;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=ywRswqAB8D2YY+rXs//gmPTNZ8Sm18BNmrehwVM8z98=;
 b=AjSLGbGkPUi0r9yURsISZag5dOKqICck0v+Pkigi8eYhfINb7b4EQUNTQcuYvJHDMcHMJf0zU
 oIRm2AqrarzBw0452ZnJee0amYrENPrG33y23d/XHSVsFYsUIHvCPSh
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Drops the remove callback as it only asserts reset and the probe already
registers a devres action (devm_add_action_or_reset()) to call
aspeed_pwm_tach_reset_assert().

Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v2:
- Drops the remove callback.
- Link to v1: https://lore.kernel.org/r/20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 44e1ecba205d..4f6e6d440dd4 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -517,13 +517,6 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void aspeed_pwm_tach_remove(struct platform_device *pdev)
-{
-	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
-
-	reset_control_assert(priv->reset);
-}
-
 static const struct of_device_id aspeed_pwm_tach_match[] = {
 	{
 		.compatible = "aspeed,ast2600-pwm-tach",
@@ -537,7 +530,6 @@ MODULE_DEVICE_TABLE(of, aspeed_pwm_tach_match);
 
 static struct platform_driver aspeed_pwm_tach_driver = {
 	.probe = aspeed_pwm_tach_probe,
-	.remove = aspeed_pwm_tach_remove,
 	.driver	= {
 		.name = "aspeed-g6-pwm-tach",
 		.of_match_table = aspeed_pwm_tach_match,

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260306-pwm_fixes-7982ad548f07

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


