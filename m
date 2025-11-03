Return-Path: <linux-aspeed+bounces-2710-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6C4CCF9FE
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 07:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0NlV0W20z30T8;
	Mon,  3 Nov 2025 18:39:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762155590;
	cv=none; b=Wdu78QX6ufwDrJTIDBnyc3xOTkjU2D6cduarPK3aHtERp/qn6Ew+jTksvAZSht/0eDY+b+YiWOm8zKdgfI54BtzlqQoaxPFYy1zqNGY8XDDvaJG51kZL153lT9RnRYaNEcdI6POkhtxbw3XGwUk30pJzy+PIvL782vvwD5uVQAsbh05W9URbst8nhJnPXbkN37sTe1JdQh5uRbmwkbcdPogGWouB6ORyDlWj8iN5c3MmpZd6F4AB3Rqt/X4AjWlvcZP30tWb3n/5dJbsVLW9xsJFzGLyUAsvpSIOKxE2ZE6CKVGXDvzu+wCBtMkRUydalW2rjI7Srf1w6BJQoDub2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762155590; c=relaxed/relaxed;
	bh=HyBWjGCdQ56N5mUJS4FqY/Xhl2MrYCXAoeOEUBzSX2E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QL2HuadY+rW3BUFUE+oXy6YeVyA/QD/pSHvaO6knbEXqqm/tUnlcuczRXqBTucE28FXJU6azgUSZm2w4UN9he+fas9wRcfmWDOmZ4O06GqZKLxnCeQtnQGiRDcqpgA5eoeFYq5NIQy7EdkFS6HIFmWfU42vkv7WsJZzRnXhfNpZEo22kpbIGb0weQV3Yzpm0/tavHE5jkuk96qvIrIBCZ46X3jRZ6LwY4kZ6eBnR6c/NvLtsizrlWmjWFoaQCQkmexp2ot79u8yOktpY9EaxpsR88lIn9oAB0L4pI14MS0P7VBeEM8bD+HND8z6u3qpqrYW8ve40NVtO8gj/4F+GOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0NlT150pz30RN
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 18:39:48 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 3 Nov 2025 15:39:15 +0800
Message-ID: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIACNcCGkC/x3MQQrCMBBG4auEWRuYpLWKV5FS0vQ3DmiUpEik5
 O4NXX6L9zbKSIJMN7VRwk+yfGJDd1Lkny4GaFmaybI9G+6MTuEtMi14uf9kB2btmGe2/dVfMFD
 LvgkPKcfyThGrjigrjbXupxSX7mwAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=2614;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PqRciZ9pt8w7E8BTpp5PCJ9LMcXBFSAE7sxgLoWY5qw=;
 b=ZsJ8ICqzAmlkil/2X2ZC7pjgchQy9vsSXnfRLxbn93VAb2AZ7aFqIKPI55aDCy+mKjYG59Tvr
 xGzWRAravsVAlfBgdPT3x9YoiA7roBDKdmhSD7nvuhS1ZpkX9EDnUso
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
  MAC2/3, restrict delay properties, and require SCU phandle.
- ARM: dts: aspeed-g6: Add ethernet aliases to indentify the index of
  MAC.
- ARM: dts: aspeed-ast2600-evb: Add new compatibles, scu handle and
  rx/tx-internal-delay-ps properties and update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

---
v3:
 - Add new item on compatible property for new compatible strings
 - Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
 - Add new compatible and scu handle to MAC node in
   aspeed-ast2600-evb.dts
 - Change all phy-mode of MACs to "rgmii-id"
 - Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
   rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
v2:
 - added new compatible strings for MAC0/1 and MAC2/3
 - updated device tree bindings to restrict phy-mode and delay properties
 - refactored driver code to handle rgmii delay configuration
---

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

---
Jacky Chou (4):
      dt-bindings: net: ftgmac100: Add delay properties for AST2600
      ARM: dts: aspeed-g6: Add ethernet alise
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC
      net: ftgmac100: Add RGMII delay support for AST2600

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  50 ++++++++++
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  28 +++++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   4 +
 drivers/net/ethernet/faraday/ftgmac100.c           | 110 +++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h           |  15 +++
 5 files changed, 203 insertions(+), 4 deletions(-)
---
base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


