Return-Path: <linux-aspeed+bounces-3203-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E0EE7491A
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Dec 2025 05:37:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbgd20gN0z2yFk;
	Wed, 24 Dec 2025 16:37:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766554662;
	cv=none; b=TSZ+aatuMY3ZWFsRJAygJb/KBj27DwvmQmeOsqkMst5hYbn75eC2Srvl5eLGQaX8dW0T3XYxO5tM5eHjI17mlNZiyPtiEhi9nYhGSrICoEl/Qb+X2sXXyP4d9++8dSmU6fgaNiSV2eY8ETqYzRcWgYMAAE5zSUJTN5lpmxP84V3cQ1G+ZY725KRjidcC8PQlxrPHvtun39vQz/C0Blawzb2DdePQGybZ04VU8dDo7MX499oRr+Qyj4plBp3unfYhSR2891K/TEV4kjrtYktQUDbYVq56lX5lwO1d88H++wWNACUq9C7qaBoM/6HczWf2OERB2H4o0HNIIHv7CN8hrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766554662; c=relaxed/relaxed;
	bh=2cqpSBWZTm3ItKpqET0vvUJxJ4ZTJqkwttG2v5AY8IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M5FUCRIIwXG+QcHgje7SLDBNO9CK60vcEUKNMGmSaGcFWpPu8y//AE6M+tJV6BVVIuqZ2/fnew9aGvh+ipc1umUhGOOPuqHTuF5kMBG8gGPqqfp5xURf1XqbxzQ8yBrojRuNGx/Yz/UGe6Xr2ffTZ9tTR5FwQNoRGFFEcLlBD7omNU5Ur5ILbNCLpToGX0QXQAXoJHR617FWP0FKCFmp3TxKW5v3r9pvlBsBENd2xa0KXWlqCuPsXLtqKTlCbsPWBThTQCWqZTgY4eswX99LpGvZ++p1SjsjAYTZjYcxVpbxtBQbn0BH94jP/F/oo4PlBrICDIors0owBXnhSAHOZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbgd147Wdz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 16:37:41 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Dec
 2025 13:37:23 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Dec 2025 13:37:23 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 24 Dec 2025 13:37:23 +0800
Subject: [PATCH v16 2/3] MAINTAINERS: Add entry for ASPEED clock drivers.
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
Message-ID: <20251224-upstream_clk-v16-2-8c1318f56c3c@aspeedtech.com>
References: <20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com>
In-Reply-To: <20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com>
To: Brian Masney <bmasney@redhat.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766554643; l=829;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=GAvow/VegJcR+SznQ1U89Bb19y2myE8OgX+jpQtvYRM=;
 b=0DgzmB1KgK1DHqUvIXQ+w1pgqYdQkPpiyiGNpTYJXmQBzfbrQ1S43sjL/D4pBPjFjW/16Nqes
 UiwN46W0Fd+AT3WHmRBKTz68a4DoaUzUtQMvUsxIYuFGP/6ZZXeNcRt
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add support entry for ASPEED clock drivers.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..201ff5d5c31c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3836,6 +3836,15 @@ L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/ax88796b_rust.rs
 
+ARM/ASPEED CLOCK SUPPORT
+M:	Ryan Chen <ryan_chen@aspeedtech.com>
+R:	Joel Stanley <joel@jms.id.au>
+L:	linux-clk@vger.kernel.org
+L:	linux-aspeed@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+F:	drivers/clk/aspeed/
+
 ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)

-- 
2.34.1


