Return-Path: <linux-aspeed+bounces-64-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53560E6B251
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Nov 2024 12:12:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xg09P6zS2z2yG9;
	Fri,  1 Nov 2024 23:12:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730463145;
	cv=none; b=m8FJpiLTyPtxttf34CCsesx/BNWNGpDZKVKc+v6Y3mfH1/B+jjh0cAxndPcWM9kieMQj7QP5RXAH6Vagz7HcaAc52Zv8upJ2EzmUtbuY8RWSryYfJK+2ZWmNpzAyXM59zbK1hTMqChGWbYtp9r8JLIfS770GwItcQY2/sEWGgaMqCEd8dnLNtoH7orjKAOv94SvCbwmj6181vUJmudpnV/fv8P7cNAcJOWicQRTfBXnA+h1QmvMVuuWUBgM7Qvkm7DMronqfIbvKtB2eARPrQkLxoXyIjVfqC7lX+9WhlP2kKh9J7tntUbHh3dHyvUFqN4knz/EmSi5A5wbH2GVwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730463145; c=relaxed/relaxed;
	bh=6eWAzGj+1b2Io4GwH59IJ5RketErYES6BDOa5GQWG6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIlDvu8OqBtXXEjIsVP6vhXJfJyzfCdYt86Fy0e6PzJcIAQbDE2sMInR2gdmF4d2Ytdqs8GrmKgV2YzYJSpwrKghdneR1W/iUSsE+6Cq+GRVS2DaQSaYZTt/vi2z+d2AdSF3qLR6QNbu3eOYPdX3mXeiG2oxNLDgUA3iUMMrWMQ3rQ5Qwoloh3mISKMxCJHmld0auy1SHb4iBRDMB5eDCXqaavzhhJbcO6hKUDqQtkO3Y3StOCSEaYXbg95Hv2IEqNfzr+Owx1IIibrzFJaHyxq/5iVBlRMKz0u/PNKIjYuc5N2g+dyekoqSew7fLCoc1cMUAgSW2RtvQEg+Vqt4Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xg09N4s20z2xH9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Nov 2024 23:12:24 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Nov
 2024 20:12:02 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 1 Nov 2024 20:12:02 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v4 2/3] watchdog: aspeed: Change aspeed_wdt_config struct name to aspeed_wdt_data
Date: Fri, 1 Nov 2024 20:12:00 +0800
Message-ID: <20241101121201.2464091-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
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

aspeed_wdt_config struct is used to store some HW configuration
information. Changing its naming to a more generic one,
aspeed_wdt_data, in order to contain more platform specific
inforamtion or SW callback functions.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 4ad6335ff25b..63b5ff9e2751 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -31,7 +31,7 @@ struct aspeed_wdt_scu {
 	u32 wdt_reset_mask_shift;
 };
 
-struct aspeed_wdt_config {
+struct aspeed_wdt_data {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
@@ -42,10 +42,10 @@ struct aspeed_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*base;
 	u32			ctrl;
-	const struct aspeed_wdt_config *cfg;
+	const struct aspeed_wdt_data *data;
 };
 
-static const struct aspeed_wdt_config ast2400_config = {
+static const struct aspeed_wdt_data ast2400_data = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
@@ -58,7 +58,7 @@ static const struct aspeed_wdt_config ast2400_config = {
 	},
 };
 
-static const struct aspeed_wdt_config ast2500_config = {
+static const struct aspeed_wdt_data ast2500_data = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
@@ -71,7 +71,7 @@ static const struct aspeed_wdt_config ast2500_config = {
 	},
 };
 
-static const struct aspeed_wdt_config ast2600_config = {
+static const struct aspeed_wdt_data ast2600_data = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
@@ -85,9 +85,9 @@ static const struct aspeed_wdt_config ast2600_config = {
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
-	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
-	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
-	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
+	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_data },
+	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_data },
+	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
@@ -216,8 +216,8 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
 {
 	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
 	u32 actual = pretimeout * WDT_RATE_1MHZ;
-	u32 s = wdt->cfg->irq_shift;
-	u32 m = wdt->cfg->irq_mask;
+	u32 s = wdt->data->irq_shift;
+	u32 m = wdt->data->irq_mask;
 
 	wdd->pretimeout = pretimeout;
 	wdt->ctrl &= ~m;
@@ -248,7 +248,7 @@ static int aspeed_wdt_update_bootstatus(struct platform_device *pdev,
 					struct aspeed_wdt *wdt)
 {
 	struct resource *res;
-	struct aspeed_wdt_scu scu = wdt->cfg->scu;
+	struct aspeed_wdt_scu scu = wdt->data->scu;
 	struct regmap *scu_base;
 	u32 reset_mask_width;
 	u32 reset_mask_shift;
@@ -401,7 +401,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	ofdid = of_match_node(aspeed_wdt_of_table, np);
 	if (!ofdid)
 		return -EINVAL;
-	wdt->cfg = ofdid->data;
+	wdt->data = ofdid->data;
 
 	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
@@ -409,7 +409,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdd.info = &aspeed_wdt_info;
 
-	if (wdt->cfg->irq_mask) {
+	if (wdt->data->irq_mask) {
 		int irq = platform_get_irq_optional(pdev, 0);
 
 		if (irq > 0) {
@@ -485,7 +485,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 
-		reg &= wdt->cfg->ext_pulse_width_mask;
+		reg &= wdt->data->ext_pulse_width_mask;
 		if (of_property_read_bool(np, "aspeed,ext-active-high"))
 			reg |= WDT_ACTIVE_HIGH_MAGIC;
 		else
@@ -493,7 +493,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 
-		reg &= wdt->cfg->ext_pulse_width_mask;
+		reg &= wdt->data->ext_pulse_width_mask;
 		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
 			reg |= WDT_PUSH_PULL_MAGIC;
 		else
@@ -510,7 +510,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
-		u32 max_duration = wdt->cfg->ext_pulse_width_mask + 1;
+		u32 max_duration = wdt->data->ext_pulse_width_mask + 1;
 
 		if (duration == 0 || duration > max_duration) {
 			dev_err(dev, "Invalid pulse duration: %uus\n",
-- 
2.34.1


