Return-Path: <linux-aspeed+bounces-2416-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F6CCD190
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjfPx2H7Lz2yqR;
	Fri, 10 Oct 2025 19:03:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760083413;
	cv=none; b=TmjITC+BJ6YJIa3aL+WScTODp8J/4VYKm8EWi6fqpecUjMG7Eg5/EcAsRWnvcWl1YhWQAu3ZYm8qwu7FESjgcd3yr6ZMh+lNpppeyk+NAEGE7GRVMqn3LJ042yA8gYeEjJWcyeeW6ylkiubw3Gu1cHDJB/qMAB8udWjf/ErGgh/KV9tWAX4crDCoqsdCJdnXftbIj674Oc5KnIMGqmyam6c27lyH4mwRzquUZZEGQB9yyVyRjJZswbDbtiz62L0VMB7x85L9NRacn+3RBrdtiO3Ei6VM+ITlHu5sHFjc3nLw07R0p7J4ZJFIByCrw/T9NfLPsaIn11fBrru2yhe86A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760083413; c=relaxed/relaxed;
	bh=zxfMRrE8il0yOnAObNAwbxVxFL1j9FZ+kXpHdeGoTLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUUG6kRDEA8nSg6YefN+IwKnM5Hf02iOruyPb2lHq4rTUDzWRWA3Tf98RmFqjRyH2cPlWhUzkgi0i2YHnWpU3TqcCc7fHG4nQXmnUcAE33Ca56whtjML903/0bZ/mllyYKtLu7CbUcQph0F05r3NTZo4GZp1EU9+i0a39+juidd8HneWe8Q1HTsmVmXlKWBmJhTHP1Qg//GicPY/8bVj5txTzEhk4ssieQa1bfBt+pRrzcZJYRQMX/DlynXYLeYmE/0Zc9ydZkHsnIMREtUYa8Pqkv4XVZOfHmMvIMI5R1UMx0aloPoMyz+l1Zm74+BJJNLq8RS17/OCBphfRl8v4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjfPw5G2bz2xK1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 19:03:32 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 10 Oct
 2025 16:03:16 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 10 Oct 2025 16:03:16 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH v2 3/3] watchdog: aspeed: Add support for AST2700 platform
Date: Fri, 10 Oct 2025 16:03:15 +0800
Message-ID: <20251010080315.816628-4-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
References: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add AST2700 platform support to the ASPEED watchdog driver. This includes
a new per-platform configuration with SCU reset status register at
SCU1_070 and support for 5 reset mask registers.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index d23e565f30a8..c9e79851504c 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -83,10 +83,24 @@ static const struct aspeed_wdt_config ast2600_config = {
 	.num_reset_masks = 2,
 };
 
+static const struct aspeed_wdt_config ast2700_config = {
+	.ext_pulse_width_mask = 0xfffff,
+	.irq_shift = 0,
+	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2700-scu0",
+		.reset_status_reg = 0x70,
+		.wdt_reset_mask = 0xf,
+		.wdt_reset_mask_shift = 0,
+	},
+	.num_reset_masks = 5,
+};
+
 static const struct of_device_id aspeed_wdt_of_table[] = {
 	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
 	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
+	{ .compatible = "aspeed,ast2700-wdt", .data = &ast2700_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
@@ -483,7 +497,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	if (!of_device_is_compatible(np, "aspeed,ast2400-wdt")) {
-		u32 reset_mask[2];
+		u32 reset_mask[5];
 		size_t nrstmask = wdt->cfg->num_reset_masks;
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 		int i;
-- 
2.34.1


