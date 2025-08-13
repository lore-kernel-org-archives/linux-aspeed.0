Return-Path: <linux-aspeed+bounces-1949-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99173CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBG39tdz30Vn;
	Thu, 14 Aug 2025 09:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755066798;
	cv=none; b=Gp26mYVAVH3iw0nL2HqKgI9zWpJgjcmM9dJjTG2tHVuecoqlgai3HbwOwbt2AIfpp706G91S0FzF9977sqLuBLISUIesOlsyj0yR2OtZ2WIid5L5MYqrL+y2VJOtLlsFqw7TL1nlRNgw2R/8cmWFMqPp5Pb+3fdc82MDFxWat6vSV4MEWWY1z3ByyB4Ezykxw0SCuHTvkBEKv3F3ifkTTs62adl2vk76J/QfXMLIZ51P8O+xcm1qzSb+hISCpdyOYw1TLElz0BPPQNKT5LVuULHCYrBR7L7dJAKUT1HwkYLR3L/SoWOVfQkV/lfvZvfcwGslYcKnH9BeR3k629l1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755066798; c=relaxed/relaxed;
	bh=wsbRxHD9xo+7R0EcGZLaztCae868kFf5aK+E5Gk9/qY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnaLuKxoXTutes6and7Egd063Xint5TD/e95LEymuBHE7bVm5EIiSc53jEa/7dGT6z2iRFJnTsf3+Q1RJBIHAcJo38idfTUrtC71eDZM4xmk0XHsG76QPoaBtqG0xOR1sUQc08OsTC/5mGlrSR+H/3DXQWoCy8rQzgenHLJGqogOqe80G4aOsXixYoQ4v4tv73FpsZgpo7j9zqn3AYmXuV5LtAyrNaM9aNsiLJ2mUdiudvczJpMIC9HVs9v9UQUY4oLJb28t4UztG/Tt23Q0Ig8GVwjG1t+ilFwa0JGYDZrEKiP528aa+OuHKf2rvDpTkTDRm5SSka7kUMLLKV+4OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1z8Y55Bbz30Vs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 16:33:17 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Wed, 13 Aug 2025 14:32:57 +0800
Message-ID: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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

This patch series adds support for configuring RGMII internal delays for the 
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to 
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration 
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay 
properties for each MAC type. Corresponding changes are made to the device tree 
source files and the FTGMAC100 driver to support the new delay configuration.

Summary of changes:
- dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and 
  MAC2/3, restrict phy-mode and delay properties, and require SCU phandle.
- ARM: dts: aspeed-g6: Add ethernet aliases, update MAC compatibles, and add 
  SCU phandle for delay configuration.
- ARM: dts: aspeed-ast2600-evb: Add rx/tx-internal-delay-ps properties and 
  update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600 
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms, 
improving interoperability with various PHYs.

Jacky Chou (4):
  dt-bindings: net: ftgmac100: Restrict phy-mode and delay properties
    for AST2600
  ARM: dts: aspeed-g6: Add ethernet alise and update MAC compatible
  ARM: dts: aspeed: ast2600evb: Add delay setting for MAC
  net: ftgmac100: Add RGMII delay configuration for AST2600

 .../bindings/net/faraday,ftgmac100.yaml       | 50 ++++++++++-
 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    | 16 +++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 24 +++++-
 drivers/net/ethernet/faraday/ftgmac100.c      | 86 +++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h      | 12 +++
 5 files changed, 179 insertions(+), 9 deletions(-)

---
v2:
 - added new compatible strings for MAC0/1 and MAC2/3
 - updated device tree bindings to restrict phy-mode and delay properties
 - refactored driver code to handle rgmii delay configuration
---

-- 
2.43.0


