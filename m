Return-Path: <linux-aspeed+bounces-5008-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1FEC88E77
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 05:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl6tg2Y4Lz2ypW;
	Wed, 16 Sep 2026 15:31:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789536667;
	cv=none; b=FJUai9T9iU+IvtsFGjflJwCbJ1m8/ejSipRZ805q215xypi+uBL7FrgE5FczUSUnFgFVy2M8mtIpJGUfiGWjRRVk7E5DmbAMuD36rbGfKTfQroFC7+KZO17mqYJ8K37FZkudYI+067+AjiGoopPsUSSCowbShhdEshIVUapEHSYuAuiMJRabTSkgSgAmGW2wrRcO3f4K8gOxun62Af30osCUphsOF9Z63XfKShGEayJhKScjK/8/p4wXfG+V0ABiZbrOmd8Ta4T/UxipctObosDHiRevNLsyX+ZWe+tdrAzCkS8DTXRLD7CFsSDfihcSzmWQkzuO296rtYq7asvVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789536667; c=relaxed/relaxed;
	bh=NssIyO8xi736nbqnWrVtafofhvXBDDuqUcPa4+qQ9uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CQutpzqvHcEH/qM/bRnxNsi7bBJwtqJAofJd24O+Cjm59rg4d0eDrAGhqHdSDNlgQNlRa0sMGOT8QfAS3kGPxb6+IysQzzzb+ivTeLdejf3lVye/JSpRUiw5D15/2IP9q2C7OdO79bT95B5mSW313M7Fem/NjXenFIdGNSCb0/lMd3B0u8ovBG6XWvhsiV1GAdx68WM870J/VCDX1M4t4qkXZRnb3hkqCV35Cok7kdQwNVHCrCx+c0EtnTVlx3IwbTx8dfsY2nKROEPoCCRpbctcV/rK9deTLV51wtFEHldy4GCemb3guHU0/nMOcGy9stOhkaDTJ0JFNl+OfbwyIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl6tf4Rc9z2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 15:31:06 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 13:30:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 13:30:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 13:30:46 +0800
Subject: [PATCH v3 9/9] MAINTAINERS: Add a reviewer for the Aspeed EDAC
 driver
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
Message-ID: <20260916-edac-v3-9-23e9ed2fbdf9@aspeedtech.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
In-Reply-To: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789536639; l=629;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=w8T0hgmEG8Qfrn667ljaWu8sAzWzj8Ca/Lo8h8/IWDA=;
 b=ldCLmciBR1ODuMPQ0Ij0lrTVtU6qNgoqih4XP2N1MgHt2Z5RuqAs50ybQ1LoKs48sOV2BCf4c
 rYcw5j0WwE7D0tQx8p8goZeRFFmIv7IA4rX6nYccL7snKNwjjMAmZCI
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add myself as a reviewer to be copied on changes to the driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v3:
- New patch.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d413dac5c8b3..5bd0109f0f1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9284,6 +9284,7 @@ F:	drivers/edac/armada_xp_*
 
 EDAC-AST2500
 M:	Stefan Schaeckeler <sschaeck@cisco.com>
+R:	Ryan Chen <ryan_chen@aspeedtech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 F:	drivers/edac/aspeed_edac.c

-- 
2.34.1


