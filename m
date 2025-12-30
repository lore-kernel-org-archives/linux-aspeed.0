Return-Path: <linux-aspeed+bounces-3237-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1666FE94116
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Dec 2025 05:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgMp36d44z2yFQ;
	Tue, 30 Dec 2025 16:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767074299;
	cv=none; b=Z3HAKvf9Cc8ITFpVnwYORlH8HcN6y9M3lxoA8aLHTcvXYEsVKOp3TFa/CiCUlkMrvGm+Qt17bX5om6JnfUoG2McAG/3atADsjPb84SQewMIOE56tib6kshgSKrsqfvdBcOeGTd3MYS9g+SYvpSI16ndQYMxOXEMxnLXTVd3ASRBDT4PLjfqFCPNHqGqvR7in3vGwVVqOTQKHoZTV4ZgW0i/Fot5Dc7MKqKfJJIMLAAnYCloYP3BAbh5tOjCXMQNt2StC6RZooTiSYP26fYmhSKiJOrzXccPHvT8n7yDed6J80f6qhjV5MVpyaHsdgLndTjqQFW3khwnoM6xL+MXP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767074299; c=relaxed/relaxed;
	bh=CIXcoG1w+dDwMJsXtzP6csYjJEVilGcdonr6G/4Byp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g/Y/Y+0PdS/YEPeMKlEWaUkgYykFDrpQ1fbYnOhadkO3HW76smJH27TkA4msANcckte6xtGRBpsIPU1FzwsVWTdPWbiMIQlI6gGuM8oWWs3blaq70yGBT+2spID/TG0eVD95veTXBqZzSd3Bc/oPW07Dyhy9WTFuB+bTLgSqsOpr3SWVzzAJr5k78vSJMM1WvZdgVfhV2kDCBOl4ZWWgj36k4fvH9OcSTjtWnivyb+hdH+8n1kwEq2P+97DUXmch+CT/YSXG+cFhXUXZEktA5dYbNJeyHvG6ooYmKF3/mgaKW8o7UHXf0MFUt7yHtvJOmSMpSeT4HjhzEtGq7BhC1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgMp331hhz2xgX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Dec 2025 16:58:19 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 30 Dec
 2025 13:57:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 30 Dec 2025 13:57:59 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 30 Dec 2025 13:58:01 +0800
Subject: [PATCH v8 4/4] MAINTAINERS: Add ASPEED PCIe PHY driver
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
Message-ID: <20251230-upstream_pcie_rc-v8-4-03598cdd80cd@aspeedtech.com>
References: <20251230-upstream_pcie_rc-v8-0-03598cdd80cd@aspeedtech.com>
In-Reply-To: <20251230-upstream_pcie_rc-v8-0-03598cdd80cd@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767074279; l=878;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=7BsJ9XPv5rGKvSJQ3KjVN6WF7d6K48ePDihYrmnFgLA=;
 b=zPygAO6pzHv1s2zc0IMazDFA4SlSDHTnUhapiyVpEktNPNa3UuJUPEpY1BhpwaVuxycM2bQMA
 Ro7Eo1n0hwXAXNSO2swWrfxQTYPhZYu5o4uD+k6/1a0oN78LrEJ5qd8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add maintainer entry for ASPEED PCIe PHY driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..bcb94fe3faa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3843,6 +3843,14 @@ S:	Maintained
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


