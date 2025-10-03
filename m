Return-Path: <linux-aspeed+bounces-2390-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F7FCCD184
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 01:59:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdBfZ3ZJsz3cyM;
	Fri,  3 Oct 2025 11:59:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759456742;
	cv=none; b=BdIAYKB3FUW2XGo+Ib3TPLjrDh6PnxKIuz7YgEiCGHpJ6YbxiOc01l+EQLV+T2/k6EocxA8iI6+4uSMW2q5sUWBwNTx0AeaVacNCKTgLKGbHc9mUXFhi4Z9uo6KBlMUROy3d1SqP1NnP0goHw8z8CdAUGMLkxKbVBf5LODog0hUur53Wfq0unkH5OmprGp5NGw2JCA9T8RD6QqnJrVbpc+zja2GDFKLw9GMcgk9ArjeUQBxmScumtXDbT2qegFSa/hw8Bpmz1TSlV4nciM0cdY4DcAp5VOy1ZA08xuDwUMHNSoHBupElTTSoiAGPjWFmYWz46mq6bNtJcNPm9XQYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759456742; c=relaxed/relaxed;
	bh=Lp5KjYsVOUh23OaImHUWhpl9YGiPDIKLH5wGc2MnqkQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2ziXm8vNeg3lmGPgyjcqo9//QmMkcObMjjR8pkpljId7RNA+59ZhoBiU6POf8pmEnnYot9utZE+bUTJBPnLbq09E1WA8BMDxtQ0xqpszfRE2RU+WUzoMcKHEGflMxTRun7yfcgA+/NrloOEO1crECzbWxS0J2O85lHyNAimf5GxRn2J4MZyC2aGu8yqNIr5Hcp4s4Qbq33gg+wq0Ir3yzwUBq8Wk8veY8i52fXncgdr/8LkaUHNVxrliIHYgd6YgK2jAWppcdVaB4qXwtOZWdeSgewWb9gz1CWQcD6+DZhhHd7tR7ZOPyuZImuKhg/RKIn3H6OeAvyesG4go5ppNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdBfY73SYz3cnv
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 11:59:01 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 3 Oct
 2025 09:58:45 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 3 Oct 2025 09:58:45 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] clk: aspeed: Add reset for HACE/VIDEO
Date: Fri, 3 Oct 2025 09:58:45 +0800
Message-ID: <20251003015845.2715538-3-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
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

Add mappings of reset per hw's definition.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/clk/clk-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index ff84191d0fe8..74c8c1377b70 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -278,6 +278,8 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
+	[ASPEED_RESET_HACE]	=  4,
+	[ASPEED_RESET_VIDEO]	=  6,
 
 	/*
 	 * SCUD4 resets start at an offset to separate them from
-- 
2.25.1


