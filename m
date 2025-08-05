Return-Path: <linux-aspeed+bounces-1902-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCA4C87FD1
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Aug 2025 06:40:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx3hJ3h4cz3bh6;
	Tue,  5 Aug 2025 16:40:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754376016;
	cv=none; b=mlYxoTwhhQlpsccWbjJLZPZDfPHpBG0N20COMl/0W8x4up8ik3BPDKGSJ89carltCGan/EyD/oik8vORikVdzvmsazZXERdSUTh3urITTtyyDOHr6twmkF7F9pPmzOGwqgP6XqsTuGd3VqlnRWHiIC5blKZ1JbmIBypt0hl/PitABkapWDxGt53QoiKx/pnfh/egQR130VjMyBWkZghF20RniC8nL5u4YNd641aMzXnWULewg6RW3ulAku3kFCDVcHMRVGP9mPgcvJlS+0dfgrSdqw9YPwN5insV8oZ+LEpCm5FhM8fPuoexhPsGV7RX7ZbpNrXut2niGmQYs97r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754376016; c=relaxed/relaxed;
	bh=qVdrjXMtECdtrZs+HUTY2ckkXITMOXZNOzfnH04igFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ii3fz0XSYVEHDLw+bTf5MCZaBCDkA94cp1oPFQcn174sscZkJfmGQfXuQMmFsUBCS8itDuhWaE+Tyw1KvLb3hp1LqtcHi8v1kF0WkUnlscnxO6E6aaq69OdE24bZkic3tF3V+poQJ15pElQMQfzK2B4l9mz3pYqle7mUzMp6Ku5xoJ6zfGc6w5XlyW5NUYMToLsRcSMUJQy8T21HfvMnIy22CmjWI0pSD0qtyUPWrQfvWXeWwsadUqE/fdZeDwuh+D9K+oK1VPCQTPO51XlNCf/4FFfrBbNNHsbj/oGh4GuPS/vkO7EhLgFQI7P2u0ledMSx470TZlZvYmhKJ+hsUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx3hH0Q3sz2yLJ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Aug 2025 16:40:14 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 5 Aug
 2025 14:39:57 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 5 Aug 2025 14:39:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/soc/aspeed: Add AST27XX SoC ID support
Date: Tue, 5 Aug 2025 14:39:57 +0800
Message-ID: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
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


