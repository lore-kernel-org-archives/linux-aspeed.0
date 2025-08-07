Return-Path: <linux-aspeed+bounces-1928-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18073C87FCB
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Aug 2025 00:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by7t33wLxz3bh6;
	Thu,  7 Aug 2025 10:52:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754527947;
	cv=none; b=gbyeP3Zmt2ZbrwqTBk8rITDSG98YD9u9Dj8i7Ha7C0ZSE8xGuF0WmmUCQCI+y/wc3prToU0/RFkGeNx5D+aDDbWptzgpBA+3t7hJA2gjmaXoh/tWVG3DKm5W/O8aE3U4KNcizGTyWQyOFqiGjdsEFCYP64ElUngs4Ae2QYvoYCyqdF5+QmLx/YpsiSJieL8FrIHodh05KqmAmBDJzyp6oLREcyAj5K5urKZAokPLrDlH2YF31J0e7sWE8YGSBOWXSoAojGabmgUh8FVpluXq3u2WdgsBl0brEFAE9f6dZAF5SXkj7oFkebRYIEOZMfvrrZ618eCOvw0wimCw12SDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754527947; c=relaxed/relaxed;
	bh=Ks5Ss7YFpXjhTGqITcgROMJeqC0PUPoFAPcO/JIUk6c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvo79BuVBasoHcG1joezf6WUyW/8l4Af72Y9R0B8/iDGpUqcGjklW0d67u0TLK4uCZrbYRKeIqF2FP0X1bGqei1L+OOzkZ/8Q9eNujItooBEgYC+mfzHt1mgfMolvC4Una631RD/CcwAkfOZ92mPkC0ycOCXRuK4bHHFej9V/KIXZ/UmHU+Q1kqTazJdanrGHWozLwNgJRSdrlFFKbn4rJiq8vz0R9J05EblyrhOfWvjGRQFOsuu8UXtmqUepod402ammFPES1JQTr2PmJAJYByqNnx+2mgnYurjFmrNIigqn94Yna9lhCj7zyQe6j6M9rV0uJAYNq3+JlBL7MvOsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4by7t25djkz3bgw
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 10:52:26 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 7 Aug
 2025 08:52:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 7 Aug 2025 08:52:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] soc: aspeed: socinfo: Add AST27xx silicon IDs
Date: Thu, 7 Aug 2025 08:52:08 +0800
Message-ID: <20250807005208.3517283-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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

Extend the ASPEED SoC info driver to support AST27XX silicon IDs.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---

v2:
 Update subject title from driver/soc/aspeed -> soc: aspeed: socinfo:

---
 drivers/soc/aspeed/aspeed-socinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 3f759121dc00..67e9ac3d08ec 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -27,6 +27,10 @@ static struct {
 	{ "AST2620", 0x05010203 },
 	{ "AST2605", 0x05030103 },
 	{ "AST2625", 0x05030403 },
+	/* AST2700 */
+	{ "AST2750", 0x06000003 },
+	{ "AST2700", 0x06000103 },
+	{ "AST2720", 0x06000203 },
 };
 
 static const char *siliconid_to_name(u32 siliconid)
-- 
2.34.1


