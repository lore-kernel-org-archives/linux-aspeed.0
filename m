Return-Path: <linux-aspeed+bounces-1348-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC8C677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 03:06:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bH9Xj3q3Qz30HB;
	Wed, 11 Jun 2025 13:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749518669;
	cv=none; b=Z8Yv3vyIXFOtTMhEczOEI9Nt8hJJl1seMZSzlJQDYWG1XcdwbFBBqFHcg65YXi+wPzFQRUwjpf8SoMEvBPROXjHOptZaB7YkCJzW/SvnN0kzcw/1SgPNjx0AFGmp1rEtR6LcmuE0URZIo2vGt3+VB+sAohVt1Eceb9jca7ITA/yRyHilMoPMnL4WS1tUVfuFYiA+OXPnU9AeidwDcJaa1q6RXc1DHVECrA7R1HM6YinD8NlWDy3407Ol5mhyOBa6xe7HVFes0I9TA5+YNzVnPAKBea8DMuAdRUJhiSVkAfxucWX3UFa2MsC/a2K9wkBL72k13ntSrdP8Hj0kY89FMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749518669; c=relaxed/relaxed;
	bh=NzS5/ITPJn/xFgNJD/PmNPqfpKluXFZGJG0Jw9l2akc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+oioRVCfSGE6wdC3LsY+W/l8V0tz87UkAVZBNQBtV+7Xh4mkug3Ln0+6frf0opm7nJrcikRa7ccwY31nS5WNYg/xDAcyi01+uHJ/k9UNTBLHFoG9uor0YiYJSsG/oSeCLkCXkMaztDmbhjQaN0NkFOhaMJh22fVOoQ23rLRggZUrw4pFEy8vWACd/yF1lutz0eGG+7oDQI1lJKP86tEeOfKN+0phWrQYpa/IEytymwDyayr16cQes/O5R+KzLN8shaQnUv9Y1AD/R6zZpcJgfZxkvqMKt6XxvWm+o1kiCa+2bWK+IXMo5moxI3WMkOiEpfRoVcciiaQ0SJDLNewFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGWKk7214z2xJ1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 11:24:25 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 09:24:06 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 09:24:06 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net-next v2 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Date: Tue, 10 Jun 2025 09:24:02 +0800
Message-ID: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
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

This patch series adds support for an optional reset line to the
ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
the internal MAC reset is not sufficient to reset the RMII interface.
By providing a SoC-level reset via the device tree "resets" property,
the driver can properly reset both the MAC and RMII logic, ensuring
correct operation in RMII mode.

The series includes:
- Device tree binding update to document the new "resets" property.
- Addition of MAC1 and MAC2 reset definitions for AST2600.
- Device tree changes for AST2600 to use the new reset properties.
- Driver changes to assert/deassert the reset line as needed.

This improves reliability and initialization of the MAC in RMII mode
on Aspeed platforms.

Jacky Chou (4):
  dt-bindings: net: ftgmac100: Add resets property
  dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
  ARM: dts: aspeed-g6: Add resets property for MAC controllers
  net: ftgmac100: Add optional reset control for RMII mode on Aspeed
    SoCs

 .../bindings/net/faraday,ftgmac100.yaml       | 19 ++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/net/ethernet/faraday/ftgmac100.c      | 26 +++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h     |  2 ++
 4 files changed, 51 insertions(+)

---
v2:
  - Added restriction on resets property in faraday,ftgmac100.yaml.
---

-- 
2.34.1


