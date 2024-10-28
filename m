Return-Path: <linux-aspeed+bounces-39-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C871AD13593
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 02:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcHrf2hbpz2xrv;
	Mon, 28 Oct 2024 13:48:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730083714;
	cv=none; b=XXN5ltGo61bPUiq2FUVsVxyRP3vR5UrImsQ1O5eCtiOrJFxUSdbA0ES+w1c46rmR9Sm3KbBgsCTzjPeL5/JPwSqgxwK9PVGNXD1+t+vIW/pCOCPTAuDogc6l37Lz28xe9g0rGpwUiHE8m/EIBUQgWLa1lOzDcqdTDarAdFt0xRyYafHCO9G9Hd0Fy0vI+g4rur56IrgRSjAyao24Ey/3kXPCj8ed0j1n0htrNvhIFj0eVbksVy9Gn4nNnX0WO/mAxK8D9GH/Ux03uNaPYeYybOs9YjWaeBWMffHaT/b7X8zKpUMDTUCNSejf0g74BqN4Fs5JNePY0KTDQl0jAkyaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730083714; c=relaxed/relaxed;
	bh=c9HWC4m6rb9ndyC5ErvdPuT44pArhrfWsxKcc2QWQDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WML83piGbinfkT3KbGrKTa6urOjcRqR7yySE/rS1biMRr5x4gLKfcibviKrEPuBZWs7X6+npf1p2YBv4k6bPXKAt3sZ4GN90dHJqpOEHHhKJwuhVr1dH+xyZEFKFtH3oB2YNsjqHlLQCT6stHRRJXnXmoksBLktwsb8uw4QMyWIzSrKT3Eukk7+jvDjKEsIHRW+55XojFHId+fxw/K/0F7lb+A9xc/Z83hJD8R12BJJez4PQbUsnpXtRqyfaetkiB9JNV/A2PcXx6t4atwPUe+K/nKjt2flUNzEcowxYPbWUzGavX/1N8ppZPi4qaGChVqS32XT+p1ySf6/RNda5pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcHrd57bgz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 13:48:33 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 28 Oct
 2024 10:48:13 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 28 Oct 2024 10:48:13 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v2 2/3] watchdog: aspeed: Update bootstatus handling
Date: Mon, 28 Oct 2024 10:48:12 +0800
Message-ID: <20241028024813.2416962-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
References: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
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

Update the bootstatus according to the latest design guide
from the OpenBMC shown as below.
https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-update.md#proposed-design

In short,
- WDIOF_EXTERN1   => system is reset by Software
- WDIOF_CARDRESET => system is reset by WDT
- Others          => other reset events, e.g., power on reset.

On AST2400 platform, only a bit, SCU3C[1], represents that the
system is reset by WDT1 or WDT2.

On AST2500 platform, SCU3C[4:2] are WDT reset flags.
  SCU3C[4]: system is reset by WDT3.
  SCU3C[3]: system is reset by WDT2.
  SCU3C[2]: system is reset by WDT1.

On AST2600 platform, SCU074[31:16] are WDT reset flags.
  SCU074[31:28]: system is reset by WDT4
    SCU074[31]: system is reset by WDT4 software reset.
  SCU074[27:24]: system is reset by WDT3
    SCU074[27]: system is reset by WDT3 software reset.
  SCU074[23:20]: system is reset by WDT2
    SCU074[23]: system is reset by WDT2 software reset.
  SCU074[19:16]: system is reset by WDT1
    SCU074[19]: system is reset by WDT1 software reset.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 109 +++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..a0c03a949173 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,10 +11,12 @@
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
@@ -22,15 +24,41 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+
+/* AST SCU Register for System Reset Event Log Register Set
+ * ast2600 is scu074 ast2400/2500 is scu03c
+ */
+#define AST2400_SCU_SYS_RESET_STATUS	0x3c
+#define   AST2400_SCU_SYS_RESET_WDT_MASK	0x1
+#define   AST2400_SCU_SYS_RESET_WDT_MASK_SHIFT	1
+
+#define   AST2500_SCU_SYS_RESET_WDT_MASK	0x1
+#define   AST2500_SCU_SYS_RESET_WDT_MASK_SHIFT	2
+
+#define AST2600_SCU_SYS_RESET_STATUS	0x74
+#define   AST2600_SCU_SYS_RESET_WDT_MASK	0xf
+#define   AST2600_SCU_SYS_RESET_WDT_SW_MASK	0x8
+#define   AST2600_SCU_SYS_RESET_WDT_MASK_SHIFT	16
+
+struct aspeed_wdt_scu {
+	const char *compatible;
+	u32 reset_status_reg;
+	u32 wdt_reset_mask;
+	u32 wdt_sw_reset_mask;
+	u32 wdt_reset_mask_shift;
+};
+
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	struct aspeed_wdt_scu scu;
 };
 
 struct aspeed_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*base;
+	int			idx;
 	u32			ctrl;
 	const struct aspeed_wdt_config *cfg;
 };
@@ -39,18 +67,39 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.scu = {
+		.compatible = "aspeed,ast2400-scu",
+		.reset_status_reg = AST2400_SCU_SYS_RESET_STATUS,
+		.wdt_reset_mask = AST2400_SCU_SYS_RESET_WDT_MASK,
+		.wdt_sw_reset_mask = 0,
+		.wdt_reset_mask_shift = AST2400_SCU_SYS_RESET_WDT_MASK_SHIFT,
+	},
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.scu = {
+		.compatible = "aspeed,ast2500-scu",
+		.reset_status_reg = AST2400_SCU_SYS_RESET_STATUS,
+		.wdt_reset_mask = AST2500_SCU_SYS_RESET_WDT_MASK,
+		.wdt_sw_reset_mask = 0,
+		.wdt_reset_mask_shift = AST2500_SCU_SYS_RESET_WDT_MASK_SHIFT,
+	},
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2600-scu",
+		.reset_status_reg = AST2600_SCU_SYS_RESET_STATUS,
+		.wdt_reset_mask = AST2600_SCU_SYS_RESET_WDT_MASK,
+		.wdt_sw_reset_mask = AST2600_SCU_SYS_RESET_WDT_SW_MASK,
+		.wdt_reset_mask_shift = AST2600_SCU_SYS_RESET_WDT_MASK_SHIFT,
+	},
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -213,6 +262,52 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int aspeed_wdt_get_bootstatus(struct device *dev,
+				     struct aspeed_wdt *wdt)
+{
+	struct device_node *np = dev->of_node;
+	struct aspeed_wdt_scu scu = wdt->cfg->scu;
+	struct regmap *scu_base;
+	u32 reset_mask_width;
+	u32 reset_mask_shift;
+	u32 status;
+	int ret;
+
+	wdt->idx = of_alias_get_id(np, "watchdog");
+	if (wdt->idx < 0)
+		wdt->idx = 0;
+
+	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
+	ret = regmap_read(scu_base, scu.reset_status_reg, &status);
+	if (ret)
+		return ret;
+
+	/* On AST2400, only a bit used to represent WDT reset */
+	if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
+		wdt->idx = 0;
+
+	reset_mask_width = hweight32(scu.wdt_reset_mask);
+	reset_mask_shift = scu.wdt_reset_mask_shift +
+			   reset_mask_width * wdt->idx;
+
+	if (status & (scu.wdt_sw_reset_mask << reset_mask_shift))
+		wdt->wdd.bootstatus = WDIOF_EXTERN1;
+	else if (status & (scu.wdt_reset_mask << reset_mask_shift))
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	else
+		wdt->wdd.bootstatus = 0;
+
+	ret = regmap_write(scu_base, scu.reset_status_reg,
+			   scu.wdt_reset_mask << reset_mask_shift);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* access_cs0 shows if cs0 is accessible, hence the reverted bit */
 static ssize_t access_cs0_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -312,7 +407,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	struct device_node *np;
 	const char *reset_type;
 	u32 duration;
-	u32 status;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -458,14 +552,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	ret = aspeed_wdt_get_bootstatus(dev, wdt);
+	if (ret)
+		return ret;
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
-	}
+	if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
+		wdt->wdd.groups = bswitch_groups;
 
 	dev_set_drvdata(dev, wdt);
 
-- 
2.34.1


