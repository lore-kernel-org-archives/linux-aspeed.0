Return-Path: <linux-aspeed+bounces-1432-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E9FC71150
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:11:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJSCz5P13z30MY;
	Fri, 13 Jun 2025 15:11:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749785422;
	cv=none; b=lTVb00Av8hHaMFa6D9JljCTw4VgFlsaki62S/6NL3+FltA4dt++ZX48dgOhzTasngluhzjPfk7ouR/mk9QuYXVwABM0kaQqFxbvaaSvyzKp3HAlMyKC5c7gPqwjRzcY7W6uOXVEbIf09NhWCK45b16inz5e/7lZKjvALBxOhWst9lKGXwtAlUeI48mm4RVaM4dp0n/bxQDZtPna+NulSeuy84IKjeuNutuChUPZGKTaF5qAr5ViimSXTexDJQb3rlwOdJTy/cjq0j+P7fby90dbSuT6odyLXV+/TsoQPTeAIAi1u1n5ZrAhGPkaqjssiFcn72fHR0v+WTUvjqBLkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749785422; c=relaxed/relaxed;
	bh=QOTEEcWVIiz6O+GToF2cpyo+TZ3hUNgZ0JY3xul8rTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mnF55ceXV4bfBmJdznCy3Sa4dZV/U86hxAePA4pptphT0zGooAN4VFTVDxp+wBZIm9cyv4JuivZ60l/w2MdXNRqxHCMx85ElAaIMVCnWaQbn0qpsXm3AegIp7kKGzcJagnKUd25QNuPm50gASe9WVj9uSHAdw+E07R7uTfrruuxuhSS5eIar/D0rvjvTwYumD5Bom99dio/I8NLYuBln3YwIlutgBOci8vQn3125nUsRO9xYLrazhHJd1ojPLeM/b2C92f6iEt94bb33z2Wgky4CJ+hyfn4BaYNBscs5fg+polbb7KUrkmsonU4ScZedh4tYP6FB2aZTvHzqVDIAPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJPzd21pTz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 13:30:18 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <elbadrym@google.com>, <romlem@google.com>, <anhphan@google.com>,
	<wak@google.com>, <yuxiaozhang@google.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/7] Add ASPEED PCIe Root Complex support
Date: Fri, 13 Jun 2025 11:29:54 +0800
Message-ID: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
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

This patch series adds support for the ASPEED PCIe Root Complex,
including device tree bindings, pinctrl support, and the PCIe host controller
driver. The patches introduce the necessary device tree nodes, pinmux groups,
and driver implementation to enable PCIe functionality on ASPEED platforms.

Summary of changes:
- Add device tree binding documents for ASPEED PCIe PHY, PCIe Config, and PCIe RC
- Update MAINTAINERS for new bindings and driver
- Add PCIe RC node and PERST control pin to aspeed-g6 device tree
- Add PCIe RC PERST pin group to aspeed-g6 pinctrl
- Implement ASPEED PCIe Root Complex host controller driver

This series has been tested on AST2600/AST2700 platforms and enables PCIe device
enumeration and operation.

Feedback and review are welcome.

Jacky Chou (7):
  dt-bindings: phy: Add document for ASPEED PCIe PHY
  dt-bindings: pci: Add document for ASPEED PCIe Config
  dt-bindings: pci: Add document for ASPEED PCIe RC
  ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST ctrl pin
  ARM: dts: aspeed-g6: Add PCIe RC node
  pinctrl: aspeed-g6: Add PCIe RC PERST pin group
  pci: aspeed: Add ASPEED PCIe host controller driver

 .../bindings/pci/aspeed-pcie-cfg.yaml         |   41 +
 .../devicetree/bindings/pci/aspeed-pcie.yaml  |  159 +++
 .../bindings/phy/aspeed-pcie-phy.yaml         |   38 +
 MAINTAINERS                                   |   10 +
 .../boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |    5 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   53 +
 drivers/pci/controller/Kconfig                |   13 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-aspeed.c          | 1039 +++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    |   12 +-
 10 files changed, 1370 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/pcie-aspeed.c

-- 
2.43.0


