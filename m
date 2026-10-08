Return-Path: <linux-aspeed+bounces-5156-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB81DCA6012
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Oct 2026 11:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0nnJ19yNz2yWy;
	Thu, 08 Oct 2026 22:28:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791458932;
	cv=none; b=P94bCTCssLz+eDwGMiM95xqgvj4ATHMr74Hhv59TLIWEUs4IQgeTvhK6RxVbgu6JFIZ6/Kwe1JszqMYL42FsACX98w/MbYqJ63OQqrF9+kfoeYxYc7G+qYxQOYztC5ZsoYJ+tRhHjM30s/a31AfVV+KvDRt8QFpITid84YN8GIJ1McFPWyLBWcAeer5e2WUDkRyqlA7SLuxtBH2IUb4qX5oHo4YX0e+aFjD0Sz1ftoJAC1BjtxJqjs1zWpoEmLhAXYwN7f5R7mFu5JszdaWsQ4ztX0Fqa+9sKMYYgMOmmfESk2lvzTYqw7hOiPRk8+Hck10LtcLPMq+bcNTkdlY4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791458932; c=relaxed/relaxed;
	bh=i4oGaJQV3XJqsm/hWoRJNMCRGKUS59OxQJLz4fnNv00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jgg84DO5HHsOjxD1S1S7e1BkghEZHD7NlmEKgEqJj5orsGGm2dsRbQYkrm6xWlbr6BW04Q3Jf+nJOii20ftfjKd6wRdqHoeFdovtzCFCUQHXJ1CR/JW//o3gC88Nr0o7ZUywuqw7ZFV6q14eUq24JJW7buswzbHWncnlNTsNXQFyAo0nigge3yydL+nImmhmYGifyLCojangWQ+1il4uqI6xXq8/80HC/Z84SzYmZXoVEWHJ1YjJkJmtEYVwVX0ZmZSule54AbCrSnIToZ1xPMshlc6RhKqfYoJjPASEpJOHikbLouLmm1RqkGOIEV2HycD1xTpJjENjLcEiy4I1vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0nnH2nDhz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Oct 2026 22:28:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 8 Oct
 2026 19:28:28 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Oct 2026 19:28:28 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 8 Oct 2026 19:28:21 +0800
Subject: [PATCH 3/3] MAINTAINERS: Add ASPEED PCIe PHY driver
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
Message-ID: <20261008-aspeed_pcie_phy-v1-3-96764937aef0@aspeedtech.com>
References: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
In-Reply-To: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Manivannan Sadhasivam
	<mani@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791458908; l=878;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=YHD/I/0JKp9KeOT+Xzp15SjhKbuwAUqqCo+GFOfkoDI=;
 b=GCJ1DAkF3dtg0StyLJYn2Lu/VzaT7HCKTM8mzTXwp5k942BVdvTflXXUroYQt0WOwGHTKAlqK
 o1YRyouBCddBUUGxJUaunwhpIpwZQiAcFqefBaNbn79+q1OYswjPzb8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add maintainer entry for ASPEED PCIe PHY driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0570815ee980..33a0336110a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4044,6 +4044,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
+ASPEED PCIE PHY DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-phy@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
+F:	drivers/phy/aspeed/phy-aspeed-pcie.c
+
 ASPEED PECI CONTROLLER
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)

-- 
2.34.1


