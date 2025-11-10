Return-Path: <linux-aspeed+bounces-2850-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC4CCFA13
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 11:10:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4n550Wfzz2xqM;
	Mon, 10 Nov 2025 22:10:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762773017;
	cv=none; b=dlw6VMuVWDodKIvDutSxl0XNoxw6I4t6gjC91lhPOuMznAdzPQg6P6FDTf7K0sMfek0fefY/mmgpOWKbmjSINd+K3KyZCjpOgtyYhZRL3ajTgFsATCq2PH/cvRBFx13FA2wxho9JL1Zb99sohi6ctHNu3NmCAjBJaA8wlermOVi3Ab4dRCl78L2jpjJA78l8XTX9sAMYAg1GZkI+yknMcKF3V8IS83M5oMEwM5CyY34x7U0q/War5taC7VjTIFiIkr8zFHNMcR1B4xVIXAScZjACBeQrJUZmlaEBitmoc1XJp5TBDKY0UGZ1TcXCKOVaJEYYkO+lQMxdiU0LFrRBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762773017; c=relaxed/relaxed;
	bh=ZgTYM7TUnJxppVv/poJEWBus2ihz08ACoFaLOlNWMI8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Pf0TmmznN9Drs1NmQAJwhIWJ780+85QtJgtiyK+0dWcaP9AseI/fS/RlYMkYqoNLoQJHH1KhOKh+yfho9TwojnUfg8cnZi3BAKNekfvpQwBZEM7ZffWz+6y+uS8mu/uk3zHgTQuaMKQJl24DUDkoISwqmnHVh5lmcmUV+62EN1NGYsP0rr4oRvsGRwcGaZAkKnsqL3sv6/8yDObjtrqjgSdsRknPjt9BHd3j4OsxX/zMPRKu54iHzddjSOr27rJ6I6mTkKS5H5OMqFhh2oiPy+XY+sFkmyxSEbZpaOKUiq5KMWh+K6FQQDZm0A5r94eAN7saXSjs7CIYt1k+o1Z7kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4n5327TCz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 22:10:14 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 10 Nov 2025 19:09:24 +0800
Message-ID: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAOTHEWkC/32Q0WrDMAxFf6X4eQ6y1NjpnvYfowTXURpvbdLZb
 mgo+fcaF7aHjT2Jy+UcId1F5OA5itfNXQSeffTTmMP2ZSPcYMcjS9/lLBCwVkBKhuPZ+7bjk11
 a1ADSAhwAt40zrEXGLoF7fyvKdzFykiPfktjnZvAxTWEpu2YqfdFm72/tTBIko+1R17o3nXmz8
 cLcJXZD5aZzMc74bYFGEWgiUBVR09RKKvlh3efSumG6/gmrH5iUyWOHWKka9Y7M//T6vDPw1zV
 /LD2P3a/rA4EO8HpPAQAA
X-Change-ID: 20251031-rgmii_delay_2600-a00b0248c7e6
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=3865;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=mSZ7gmoan1EeU4GVjsq0MXdF6q2IRPBWHzVnBREFK+s=;
 b=JVJatIp03PtH1be/zgyXFjCLbEZ6UugDbJ2mlEjc9L64B6RVVc4X2jTenUy6r0JzK1NSYWVcJ
 IOdDKo1zV8jDzZ5RwMbbHMmwydpv/KiWg9M0TEjzQ70L0Y1AMMjfoWl
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This patch series adds support for configuring RGMII internal delays for the
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay
properties for each MAC type. Corresponding changes are made to the device tree
source files and the FTGMAC100 driver to support the new delay configuration.

Summary of changes:
- dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and
  MAC2/3.
- ARM: dts: aspeed-g6: Add aspeed,rgmii-delay-ps and aspeed,scu
  properties.
- ARM: dts: aspeed-ast2600-evb: Add rx/tx-internal-delay-ps properties and 
  update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Po-Yu Chuang <ratbert@faraday-tech.com>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: taoren@meta.com

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v4:
- Remove the compatible "aspeed,ast2600-mac01" and
  "aspeed,ast2600-mac23"
- Add new property to specify the RGMII delay step for each MACs
- Add default value of rx/tx-internal-delay-ps
- For legacy dts, a warning message reminds users to update phy-mode
- If lack rx/tx-internal-delay-ps, driver will use default value to
  configure the RGMII delay
- Link to v3: https://lore.kernel.org/r/20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com

Changes in v3:
- Add new item on compatible property for new compatible strings
- Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
- Add new compatible and scu handle to MAC node in
  aspeed-ast2600-evb.dts
- Change all phy-mode of MACs to "rgmii-id"
- Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
  rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
- Link to v2: https://lore.kernel.org/r/20250813063301.338851-1-jacky_chou@aspeedtech.com

Changes in v2:
- added new compatible strings for MAC0/1 and MAC2/3
- updated device tree bindings to restrict phy-mode and delay properties
- refactored driver code to handle rgmii delay configuration
- Link to v1: https://lore.kernel.org/r/20250317025922.1526937-1-jacky_chou@aspeedtech.com

---
Jacky Chou (4):
      dt-bindings: net: ftgmac100: Add delay properties for AST2600
      ARM: dts: aspeed-g6: Add scu and rgmii delay value per step for MAC
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC
      net: ftgmac100: Add RGMII delay support for AST2600

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  35 +++++
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  20 ++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   8 ++
 drivers/net/ethernet/faraday/ftgmac100.c           | 148 +++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h           |  20 +++
 5 files changed, 227 insertions(+), 4 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


