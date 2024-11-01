Return-Path: <linux-aspeed+bounces-65-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B194E6B252
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Nov 2024 12:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xg09Q5frbz2yN8;
	Fri,  1 Nov 2024 23:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730463146;
	cv=none; b=W83ESqj7/U4HDd3N5hop61iDe50mqwM2aJwvvN3sHn0HitfmMShqan5ATBB1W5kuJ8Ho8HK9vD2XkkDQwXuX0PMXrCVUMREOpGodiBqxzGr1Y7SFkxpke1PunOxhnMpzQfiIiStBIbdSXm7ogCl3k1tF0gWvUMEEk+mFJmsYfaKjabbRfwTOuOTYUw9DRvJ4ysdWEi8w/rOaiiELVHHCjI7bhtSn23txjCKP0YZRc+xh41yzO1Q9c4CFS7jiNa3fcZ7Hp+8FwR+f0Ot+F2ecPkTQ8956GAiyM1HdTDsp+sLWP4YyfVqTd++YuAsCi1Iwkc0kLGiDhk4zzcPGEkKfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730463146; c=relaxed/relaxed;
	bh=Bumxjbac1qkRIvzFmwsc/skdkzA5dF+Lt2xM6bxv250=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVcKiB8D6bNF7UWP+UorYgqDcgk5GSz53nGavt8OPsc9E3fZohqVKQnxDLsLoxXDo7hkj48ZYuCWQu6m4vS1uKz2W22QvJGcYWIQzRyri3Z0h5FwI+GqAVAKCiyUQ9v8cd9DL+cSyChcQuqIDraIeJvENtC9CXsCwzBQZ7AJAWs9VS4OH6IN8uhVp1/TublPSjQNxhi1Wf8SgnHUNM4EYIB4XuhRKMYYFXgGRlUBEeU3xU/UnD11w4wK7qTVAyjiVnAv3AbWQ+JPKFdVYY0wPs9OgKBRoEjnATH55RV/aZklHy4Eo26Vkx6RMXYgI7vH7u+BQDDx92YKBsR4pfmFQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xg09Q0n6Rz2xH9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Nov 2024 23:12:26 +1100 (AEDT)
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
Subject: [PATCH v4 3/3] watchdog: aspeed: Update restart implementations
Date: Fri, 1 Nov 2024 20:12:01 +0800
Message-ID: <20241101121201.2464091-4-chin-ting_kuo@aspeedtech.com>
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

Restart callback function is created to distinguish the restart mechanisms
between AST2400/AST2500 and AST2600.

On AST2400 and AST2500 platforms, system can only be reset by enabling
WDT and waiting for WDT timeout. Since AST2600, SW can trigger the reset
event consciously and directly by just cinfiguring some HW registers
without waiting for WDT timeout. This mechanism is named "SW restart" and
is implemented by HW. The WDT counter is not enabled when SW restart
is adopted.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 59 +++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 63b5ff9e2751..28a16a0c442d 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -23,6 +23,14 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct aspeed_wdt {
+	struct watchdog_device	wdd;
+	void __iomem		*base;
+	u32			ctrl;
+	const struct aspeed_wdt_data *data;
+};
+
 struct aspeed_wdt_scu {
 	const char *compatible;
 	u32 reset_status_reg;
@@ -36,14 +44,11 @@ struct aspeed_wdt_data {
 	u32 irq_shift;
 	u32 irq_mask;
 	struct aspeed_wdt_scu scu;
+	int (*restart)(struct aspeed_wdt *wdt);
 };
 
-struct aspeed_wdt {
-	struct watchdog_device	wdd;
-	void __iomem		*base;
-	u32			ctrl;
-	const struct aspeed_wdt_data *data;
-};
+static int aspeed_ast2400_wdt_restart(struct aspeed_wdt *wdt);
+static int aspeed_ast2600_wdt_restart(struct aspeed_wdt *wdt);
 
 static const struct aspeed_wdt_data ast2400_data = {
 	.ext_pulse_width_mask = 0xff,
@@ -56,6 +61,7 @@ static const struct aspeed_wdt_data ast2400_data = {
 		.wdt_sw_reset_mask = 0,
 		.wdt_reset_mask_shift = 1,
 	},
+	.restart = aspeed_ast2400_wdt_restart,
 };
 
 static const struct aspeed_wdt_data ast2500_data = {
@@ -69,6 +75,7 @@ static const struct aspeed_wdt_data ast2500_data = {
 		.wdt_sw_reset_mask = 0,
 		.wdt_reset_mask_shift = 2,
 	},
+	.restart = aspeed_ast2400_wdt_restart,
 };
 
 static const struct aspeed_wdt_data ast2600_data = {
@@ -82,6 +89,7 @@ static const struct aspeed_wdt_data ast2600_data = {
 		.wdt_sw_reset_mask = 0x8,
 		.wdt_reset_mask_shift = 16,
 	},
+	.restart = aspeed_ast2600_wdt_restart,
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -112,6 +120,11 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
+#define WDT_SW_RESET_CTRL	0x24
+#define   WDT_SW_RESET_COUNT_CLEAR	0xDEADDEAD
+#define   WDT_SW_RESET_ENABLE	0xAEEDF123
+#define WDT_SW_RESET_MASK1	0x28
+#define WDT_SW_RESET_MASK2	0x2c
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -231,11 +244,8 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
 	return 0;
 }
 
-static int aspeed_wdt_restart(struct watchdog_device *wdd,
-			      unsigned long action, void *data)
+static int aspeed_ast2400_wdt_restart(struct aspeed_wdt *wdt)
 {
-	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
-
 	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
@@ -244,6 +254,35 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int aspeed_ast2600_wdt_restart(struct aspeed_wdt *wdt)
+{
+	u32 reg;
+	u32 ctrl = WDT_CTRL_RESET_MODE_SOC |
+		   WDT_CTRL_RESET_SYSTEM;
+
+	reg = readl(wdt->base + WDT_RESET_MASK1);
+	writel(reg, wdt->base + WDT_SW_RESET_MASK1);
+	reg = readl(wdt->base + WDT_RESET_MASK2);
+	writel(reg, wdt->base + WDT_SW_RESET_MASK2);
+
+	writel(ctrl, wdt->base + WDT_CTRL);
+	writel(WDT_SW_RESET_COUNT_CLEAR, wdt->base + WDT_SW_RESET_CTRL);
+	writel(WDT_SW_RESET_ENABLE, wdt->base + WDT_SW_RESET_CTRL);
+
+	/* system must be reset immediately */
+	mdelay(1000);
+
+	return 0;
+}
+
+static int aspeed_wdt_restart(struct watchdog_device *wdd,
+			      unsigned long action, void *data)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	return wdt->data->restart(wdt);
+}
+
 static int aspeed_wdt_update_bootstatus(struct platform_device *pdev,
 					struct aspeed_wdt *wdt)
 {
-- 
2.34.1


