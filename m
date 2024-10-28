Return-Path: <linux-aspeed+bounces-40-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AEDD13594
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 02:48:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcHrg18SCz2yGv;
	Mon, 28 Oct 2024 13:48:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730083715;
	cv=none; b=XjpVa/vlZxM7Be+O/Ph4RM8qK7W3IEBkinXD7EHdcvruDqqvf61EuW+tVisJ+F5mUhx3lDzWU3Z0qwHu3iYyN804nNHz/LDMXAZfrRKWglYDg1qS7sVtAhv+TZFwAaqz4+lCrnp0lukudCJXturzPCEvT4ivLt7Is6EIa0yZbuqFbl+CQBLYCxw6KPLfppJYMj6doWaxcCDsCGgYgyucsF71Z0MtfISGrXXuQHEGmYzGZpnXg7eOYXOotAc7jIy59dcxJoZvV4YnWxmC0yJI55dgBPTyq9TGLiRtG7cFWqQE17bukKfMi9S2tOS8V0dkC2c5Txg8LiuaGOOFx8gfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730083715; c=relaxed/relaxed;
	bh=tKrqBYDWpA2Rp4McGKPnb/6dNWLjIXWZ+IBgL2/lAbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYOTX2MWhcSiLdUj+qGFjE70h9eLz7bNKrhbTRhpfTePFXuDoP4ZuQkKdCpPZnEJQ55CVuGjXyfOg9RZm2Avh0rg8iSOBZqwS0fhrHMwZn+XkcxdapJQ4hKegqnI1TxmHdpXvAHt0OcNJd4pFdM1zabNlb/9Zg9kgxF0w9Sl1AEp1lc2CP+7vLErVDjL10vgDWqfxdRbIOpsiRoc9pPmv1WE8V3cGxkORFY609iqUyrR4ayWatnZTX84qNsoLeBXmRQJxD5TzDm9JwGjX4NOjPgKT4M0Vbrq1GBeWjp+Mk1mo/d8PQiZM/Q6qq8+UM8Tw6BPg/ROg1Y57TdWgFDKTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcHrf3c5kz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 13:48:34 +1100 (AEDT)
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
Subject: [PATCH v2 3/3] watchdog: aspeed: Add support for SW restart
Date: Mon, 28 Oct 2024 10:48:13 +0800
Message-ID: <20241028024813.2416962-4-chin-ting_kuo@aspeedtech.com>
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

Since AST2600, except for HW WDT counter timeout, HW WDT
reset can also be triggered by just cinfiguring some
HW registers by SW directly. We named it "SW restart".
Although it is "SW" restart, its mechanism is implemented
by HW.

Originally, system can only know it is reset by WDT
through a reset flag. However, since AST2600, SW can
trigger the reset event consciously and directly without
wait for WDT timeout. WDT counter is not enabled when
SW restart is adopted. After that, an independent reset
event flag will be set after systemis reset by SW.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index a0c03a949173..9ba9b7346d44 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -40,6 +40,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 #define   AST2600_SCU_SYS_RESET_WDT_SW_MASK	0x8
 #define   AST2600_SCU_SYS_RESET_WDT_MASK_SHIFT	16
 
+/* WDT behavior control flag */
+#define WDT_RESTART_SYSTEM_SW_SUPPORT	0x00000001
+
 struct aspeed_wdt_scu {
 	const char *compatible;
 	u32 reset_status_reg;
@@ -53,6 +56,7 @@ struct aspeed_wdt_config {
 	u32 irq_shift;
 	u32 irq_mask;
 	struct aspeed_wdt_scu scu;
+	u32 flags;
 };
 
 struct aspeed_wdt {
@@ -67,6 +71,7 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.flags = 0,
 	.scu = {
 		.compatible = "aspeed,ast2400-scu",
 		.reset_status_reg = AST2400_SCU_SYS_RESET_STATUS,
@@ -80,6 +85,7 @@ static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.flags = 0,
 	.scu = {
 		.compatible = "aspeed,ast2500-scu",
 		.reset_status_reg = AST2400_SCU_SYS_RESET_STATUS,
@@ -93,6 +99,7 @@ static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.flags = WDT_RESTART_SYSTEM_SW_SUPPORT,
 	.scu = {
 		.compatible = "aspeed,ast2600-scu",
 		.reset_status_reg = AST2600_SCU_SYS_RESET_STATUS,
@@ -130,6 +137,11 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
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
@@ -249,10 +261,31 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void aspeed_wdt_sw_reset(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	u32 ctrl = WDT_CTRL_RESET_MODE_SOC |
+		   WDT_CTRL_RESET_SYSTEM;
+
+	writel(ctrl, wdt->base + WDT_CTRL);
+	writel(WDT_SW_RESET_COUNT_CLEAR,
+	       wdt->base + WDT_SW_RESET_CTRL);
+	writel(WDT_SW_RESET_ENABLE, wdt->base + WDT_SW_RESET_CTRL);
+
+	/* system must be reset immediately */
+	mdelay(1000);
+}
+
 static int aspeed_wdt_restart(struct watchdog_device *wdd,
 			      unsigned long action, void *data)
 {
 	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	struct aspeed_wdt_config *cfg = wdt->cfg;
+
+	if (cfg->flags & WDT_RESTART_SYSTEM_SW_SUPPORT) {
+		aspeed_wdt_sw_reset(wdd);
+		return 0;
+	}
 
 	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
@@ -524,6 +557,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 			if (nrstmask > 1)
 				writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
 		}
+
+		if (wdt->cfg->flags & WDT_RESTART_SYSTEM_SW_SUPPORT) {
+			reg = readl(wdt->base + WDT_RESET_MASK1);
+			writel(reg, wdt->base + WDT_SW_RESET_MASK1);
+			reg = readl(wdt->base + WDT_RESET_MASK2);
+			writel(reg, wdt->base + WDT_SW_RESET_MASK2);
+		}
 	}
 
 	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
-- 
2.34.1


