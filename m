Return-Path: <linux-aspeed+bounces-314-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F18EE7718F
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Jan 2025 07:01:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YNLNh4Mppz2ywC;
	Wed,  1 Jan 2025 18:01:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735714900;
	cv=none; b=clsp48MYnXKLlV+KYasNC+Wm4vcLKdZjMtbO0DrkL694rTJK+8mv4nI0pP3X/V1HQnuFc7hR9o+yJsTiKajKyt5gGeV4gMTubeO7o6AdUC+Egb0q6AA/XKdzOjg8NOfglmd1+GRmNqDMldRTvdcZrjaw6F/YTTMbpyE1c/0DQXQtwT7BkITwpJwF1fr4bO4ClDtALj9/xMcJwmKhU+qs3SWGKLD76VNfj9TuXE4Sl5yHIOQ/lJ5dZLhMn+tEKXClRjGhimTtSHb4CxOalsl/c9WESeMJKaOjZX4hWaEcj0ENn0KHg0WtHE5iv1UK0QDCMdhh5duF5HP7cDUchOND4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735714900; c=relaxed/relaxed;
	bh=t5KXlYIdplDlznAf/h1480kdbKFnWzMBkD6KXaxNsQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8S1JWa7sgA7EoRstt1H4cVitW+1AuIvlNsd8tw7cC2NfF+0kWfazt75k93MBCdwwYJNqo7mVevj22bfhqtvzum+zkg7Qnim/iiYKM5We8zIZ14I66POqHMlHwYQQ3Ll79HkYgEz7nKrC/vIaBWXrrkvED6jXqpgThof1o+DFoOWTqH/ke/FxBHXBPVes5b4tzUxFPl6zIicQWDs/Hy6117n5M/neh89A/in6HlpKyIVjQt/2MFhS/jPJtr7hoYeP9vrFQKQOViTUrdJUm74CEbY+PLf+t5k+tOo+axwXPlbFlA7YqpRD+YD3NEXNncusb3ReMttLQMHLkKcrlUoaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YNLNg6Vqjz2yvl
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Jan 2025 18:01:39 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Jan
 2025 15:01:16 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 1 Jan 2025 15:01:16 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <andrew@codeconstruct.com.au>, <linux@roeck-us.net>,
	<wim@linux-watchdog.org>, <joel@jms.id.au>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<BMC-SW@aspeedtech.com>, <chnguyen@amperecomputing.com>,
	<aaron_lee@aspeedtech.com>
Subject: [PATCH v5 1/1] watchdog: aspeed: Update bootstatus handling
Date: Wed, 1 Jan 2025 15:01:16 +0800
Message-ID: <20250101070116.2287171-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101070116.2287171-1-chin-ting_kuo@aspeedtech.com>
References: <20250101070116.2287171-1-chin-ting_kuo@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The boot status in the watchdog device struct is updated during
controller probe stage. Application layer can get the boot status
through the command, cat /sys/class/watchdog/watchdogX/bootstatus.
The bootstatus can be,
WDIOF_CARDRESET => the system is reset by WDT SoC reset.
Others          => other reset events, e.g., power on reset.

On ASPEED platform, the boot status is recorded in the SCU registers.
- AST2400: Only a bit represents for any WDT reset.
- AST2500/AST2600: The reset triggered by different WDT controllers
                   can be distinguished by different SCU bits.

Besides, on AST2400 and AST2500, since alternating boot event is
triggered by WDT SoC reset, it is classified as WDIOF_CARDRESET.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 85 ++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..1fae70b2fa6b 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,21 +11,30 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+struct aspeed_wdt_scu {
+	const char *compatible;
+	u32 reset_status_reg;
+	u32 wdt_reset_mask;
+	u32 wdt_reset_mask_shift;
+};
 
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	struct aspeed_wdt_scu scu;
 };
 
 struct aspeed_wdt {
@@ -39,18 +48,36 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.scu = {
+		.compatible = "aspeed,ast2400-scu",
+		.reset_status_reg = 0x3c,
+		.wdt_reset_mask = 0x1,
+		.wdt_reset_mask_shift = 1,
+	},
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.scu = {
+		.compatible = "aspeed,ast2500-scu",
+		.reset_status_reg = 0x3c,
+		.wdt_reset_mask = 0x1,
+		.wdt_reset_mask_shift = 2,
+	},
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2600-scu",
+		.reset_status_reg = 0x74,
+		.wdt_reset_mask = 0xf,
+		.wdt_reset_mask_shift = 16,
+	},
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -213,6 +240,60 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
+					 struct aspeed_wdt *wdt)
+{
+	struct resource *res;
+	struct aspeed_wdt_scu scu = wdt->cfg->scu;
+	struct regmap *scu_base;
+	u32 reset_mask_width;
+	u32 reset_mask_shift;
+	u32 reg_size;
+	u32 idx = 0;
+	u32 status;
+	int ret;
+
+	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res) {
+			reg_size = res->end - res->start;
+			if (reg_size)
+				idx = ((intptr_t)wdt->base & 0x00000fff) / reg_size;
+		}
+	}
+
+	wdt->wdd.bootstatus = WDIOS_UNKNOWN;
+	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
+	if (IS_ERR(scu_base))
+		return;
+
+	ret = regmap_read(scu_base, scu.reset_status_reg, &status);
+	if (ret)
+		return;
+
+	reset_mask_width = hweight32(scu.wdt_reset_mask);
+	reset_mask_shift = scu.wdt_reset_mask_shift +
+			   reset_mask_width * idx;
+
+	if (status & (scu.wdt_reset_mask << reset_mask_shift))
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	else
+		wdt->wdd.bootstatus = 0;
+
+	/* clear wdt reset event flag */
+	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-wdt")) {
+		ret = regmap_read(scu_base, scu.reset_status_reg, &status);
+		if (!ret) {
+			status &= ~(scu.wdt_reset_mask << reset_mask_shift);
+			regmap_write(scu_base, scu.reset_status_reg, status);
+		}
+	} else {
+		regmap_write(scu_base, scu.reset_status_reg,
+			     scu.wdt_reset_mask << reset_mask_shift);
+	}
+}
+
 /* access_cs0 shows if cs0 is accessible, hence the reverted bit */
 static ssize_t access_cs0_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -458,10 +539,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	aspeed_wdt_update_bootstatus(pdev, wdt);
+
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
 	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
-
 		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
 		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
 			wdt->wdd.groups = bswitch_groups;
-- 
2.34.1


