Return-Path: <linux-aspeed+bounces-3466-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6BAE83040
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 03:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4ptQ5536z30Lv;
	Tue, 03 Feb 2026 14:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770089486;
	cv=none; b=YVBYzkZ/2Fq3TTqkpP2YNfKfnhs3TNj+h4DkhpMQ7wuSTZkthZd0FxgQufv8HxmwFT2DE14vCiXfbo2sBoSMZGYW/6e1613lO9nFaShazPIwPPaUP/Ls0PJxvYCvCDPJGshl2U9WzDVn3QkVNgLoymzYnd7tJPWU0CM/hD/pryAx0I8Z//3SVl3BAVq43ze0nW1ARksp6T1M9HtxQF3ZB45hTKs2jEcNTYC9jp66WL/x236CCBQ/qnq/Ym31H7IkaV/IuDyg+hSwDFBODcfX5xy9fFmEA0D7RmRlJW7KyQTPeQMw4YNHwc3yFmHwjxWReX1qjknGNHXLbzes5wK5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770089486; c=relaxed/relaxed;
	bh=6An+59kZrrX/6VO4uDw/aRmHE7vH01Ooy0Q4JMyt7Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=il/tnLuPN3DRlW0RTH+uiZiKtzYrabMf2cmn9TYU4pyfpdYH156VBOc8PY4wZi4wWmFgTXY1zodVQmx2IOxZu4h/hApEKTanPd9QerM3Nhbag6TOojlNJlyffT+H25lqecYPKnNMvdbA9ZvWJa5nF5ug0LAVzM/zDmj1726CdGW7+SMTkaoLeZjFPZdW2fsJkmEuadR5bzfb6ibiPddEJLUMDwuZsBbBX6983YL3qc7d78GZJKXlWtB9k3YnWmvZK9LgCA5rqLsugqaApgxLz/hRGOBYa0r9SI/dZWt3rzThSIsX7Wq0hQkslhWWToTe1w7Pwa8p0JEzPQ2sGc9e2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4ptQ1JnFz30FD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 14:31:26 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 11:31:04 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 11:31:04 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 3 Feb 2026 11:30:55 +0800
Subject: [PATCH RESEND v9 3/3] MAINTAINERS: Add ASPEED PCIe PHY driver
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
Message-ID: <20260203-upstream_pcie_rc-v9-3-899ee4efe94e@aspeedtech.com>
References: <20260203-upstream_pcie_rc-v9-0-899ee4efe94e@aspeedtech.com>
In-Reply-To: <20260203-upstream_pcie_rc-v9-0-899ee4efe94e@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770089464; l=878;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ukzk8V/+iAWF9vSX9HcoXRh6kD8Xte6R6G0Qmwo0orU=;
 b=G2CD879Xzlho3fMNFvzxuYw6vpDxxmu3kPHQoC7R0irjiN9C+xubhQ2NNQzDYi9eIaTbUhPsM
 p5ePUDdcGGVBFgY6mVCrSMZwJj6g2ntionuiImAp7GQIW0U1B6+BXtw
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


