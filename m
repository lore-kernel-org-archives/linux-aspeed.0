Return-Path: <linux-aspeed+bounces-3339-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5181D3CCAB
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 03:35:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds7tG12CGz2yFm;
	Thu, 15 Jan 2026 14:35:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768448150;
	cv=none; b=LOhC7lBG6BX5OHRZwf8PGxpTusHrdwWzd9tSE8IB8eSFwdhfBYfZt8Cmg4GsbcdF1WbkCnHqeNBozszmDjHd9hw++g23j0LDgkeQVR77RQ0oaULiW6FZn1P8Vh5ji/TdfJ9L49QTaRl9b+44gE0KWeY7wIhQM1ukx8cSnUB/bS5URoY4GjuPjbMWf3fQ69vCJ4R9Ev9deKJgOTo3XBXgpheNeZV/f9+XHWBbPL0MnKPVvCDs+j0DNAmFCR5kXFgQxwFaTLBrgcfn4b/9+Vvwm4uN2vDZCCwMLHgEfY5tdXgqajr/H/J+vSt3PhJML4PfeaYbBLGPz9E44mj7WRXHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768448150; c=relaxed/relaxed;
	bh=6An+59kZrrX/6VO4uDw/aRmHE7vH01Ooy0Q4JMyt7Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OkdU1FE3RsRVDbtH6eRb8969r69AZUB4VvP1s2CQjV15IL1n9MWU6KS6vt0pMYY8EByfYIlJl7rH1Dc6uCEGLMOF8n8lK8i5CirEcSnZik91Sr/nX8I8MDSS1/l8Au7hWqTUVp4dyp1sFpQXvvhQ4gpNCi0RqOVPZx/jeh77w8LuIo1YqYb1H7D/b5I8ftGgAOErIsl4n9fAvfKo/nvBuW7/MSfrEBTrSBMFG6D1AbTEREngkL5cbacNuIqhl5hz0MeaL8sK7Re2JgcAlcQ3yMOPUwkg5DEggP8oli2Bm/4ufpbDF0NNlxEz9mES27llw0Fndif3vAZUbb8DVRmLgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds7tF4VkZz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 14:35:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Jan
 2026 11:35:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Jan 2026 11:35:29 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 15 Jan 2026 11:35:31 +0800
Subject: [PATCH v9 3/3] MAINTAINERS: Add ASPEED PCIe PHY driver
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
Message-ID: <20260115-upstream_pcie_rc-v9-3-d6c82a1556a7@aspeedtech.com>
References: <20260115-upstream_pcie_rc-v9-0-d6c82a1556a7@aspeedtech.com>
In-Reply-To: <20260115-upstream_pcie_rc-v9-0-d6c82a1556a7@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768448129; l=878;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ukzk8V/+iAWF9vSX9HcoXRh6kD8Xte6R6G0Qmwo0orU=;
 b=Gd49zuaoYFSMlRUbrx/0CcYL0v85DMGnAT15UunB5qirAWWKqhtQBGZ0mNuX9C1azisZvb01Y
 Dmr5JiU/CshCdJ35bT2bREho6WwUWC6sG1gkYxiiAXHjTtHPelXSBg/
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add maintainer entry for ASPEED PCIe PHY driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf755238c429..a1979c574759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3844,6 +3844,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
+ASPEED PCIE PHY DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-phy@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
+F:	drivers/phy/aspeed/pcie-phy-aspeed.c
+
 ASPEED PECI CONTROLLER
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)

-- 
2.34.1


