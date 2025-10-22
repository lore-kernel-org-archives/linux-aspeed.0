Return-Path: <linux-aspeed+bounces-2553-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600BACCD1AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 06:55:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs0Kn5dCWz2yFW;
	Wed, 22 Oct 2025 17:55:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761116125;
	cv=none; b=gqqO9bxuaZUS6K4oMZOJ9K/2PqyjB+RsZPaZKFMgSo0H5yg+zzUxoCLNxWXFUETDxExmAd30HxkrjheQhkkBSkvIDxcd1vS74olHOt+puH5WhStXv6DPqeBMgvgrYBM7ikoPqL0IOsQDaqp6hs4ilN1T+Uhkqy0Ucmc//Ry08R7gARIl5Os9FmwD2Lp6RmiKPtzzx3pL+VDE85Ah3XLfRKGjRHC8H5v1aWBcYwCC9Rv56gWuKGEwmXNZ10ern6g1bgmGPCYER5ds/P2pEze366lci9f0IT1KvocQak7l0qDR92DjtsNqdZ2u197H5KcMR0dLpm7TlKFNX4edO0R2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761116125; c=relaxed/relaxed;
	bh=okB6pByIyI/e7nRJH3quN/+Tf6BalqrmJcLACRktqs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VTSHaaUOqYrNt76J4jlnJH3/dMqHkkTccqt0PJ+Oe79GCDKcmy3qx8IiNie9xmKmPsNfnX+3pfpokxKvV8KgDXdKyeg06ilC2FAGgdRAmJAI3aer3eVyodZrmaQck5fqiVa410ZxEhOp7nN+YRm2hw+5xFApkj3bZXMBB9IVbG41b7A7zWRbO4R+wIdbzsq6uXlb0q9cXVOyuZ27nrzG21uiLbcW3aYW1dks3rqp0FGkDJyDdt3FUz7j1s9buOCeT1oBni7caNSCAgfkijQynQs5xI/UxQqCzfxwKSQgToVIo9BdOnB1tr1ALF1pwiaAvF1ph7rR6oyjbeiKR3MoNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs0Km71Jkz2yFT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 17:55:24 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 14:55:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 14:55:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 0/3] AST2700 interrupt controller hierarchy support
Date: Wed, 22 Oct 2025 14:55:04 +0800
Message-ID: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
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

This series introduces YAML bindings and driver support for the
ASPEED AST2700 interrupt controller hierarchy. The AST2700 SoC
contains two top-level interrupt controller blocks, INTC0 and
INTC1, each responsible for routing different interrupt groups
to various CPU targets.

v5:
- Adds two new YAML bindings:
 - aspeed,ast2700-intc0.yaml
 - aspeed,ast2700-intc1.yaml
- irq-aspeed-intc.c
 - add aspeed,ast2700-intc0-ic, aspeed,ast2700-intc0-ic compatible.

v4:
- aspeed,ast2700-intc.yaml
 - Clarify the relationship between INTC0/INTC1 parent nodes, the
   aspeed,ast2700-intc-ic child nodes, and the GIC.
 - Add a block diagram and DT examples showing the cascaded wiring
   (GIC <- INTC0 <- INTC1 children).
 - Mirrors the datasheet-described topology and register map, including
   the separation of INTC0/INTC1 regions.
 - Lets DT unambiguously express first-level (GIC parent) and cascaded
   second-level (INTC0 parent) interrupt controllers via examples that
   use `interrupts` for INTC0 children and `interrupts-extended` for
   INTC1 children routed into INTC0.

- irq-ast2700-intc.c
 - Drop all string decoding and human readable tables.
   Debugfs now dumps raw routing/protection registers only.
 - Split into a separate source file and made it modular
 - If the compatible not match ast2700-intc0/1, bail out return -ENODEV.

v3:
- aspeed,ast2700-intc.yaml
  - Clarify the relationship between INTC0/INTC1 parent nodes, the
    aspeed,ast2700-intc-ic child nodes, and the GIC.
  - Add a block diagram and DT examples showing the cascaded wiring
    (GIC <- INTC0 <- INTC1 children).
  - Mirrors the datasheet-described topology and register map, including
    the separation of INTC0/INTC1 regions and their routing/protection
    registers.
  - Lets DT unambiguously express first-level (GIC parent) and cascaded
    second-level (INTC0 parent) interrupt controllers via examples that
    use `interrupts` for INTC0 children and `interrupts-extended` for
    INTC1 children routed into INTC0.
  
- irq-aspeed-intc.c
  - separate c file from irq-aspeed-intc.c
  - make m

v2:
- fix dt bindingcheck

Ryan Chen (3):
  dt-bindings: interrupt-controller: aspeed,ast2700: Add support for
    INTC hierarchy
  Irqchip/ast2700-intc: add debugfs support for routing/protection
    display
  irqchip: aspeed: add compatible strings for ast2700-intc0-ic and
    ast2700-intc1-ic

 .../aspeed,ast2700-intc0.yaml                 |  97 ++++++++++
 .../aspeed,ast2700-intc1.yaml                 |  94 ++++++++++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             |   2 +
 drivers/irqchip/irq-ast2700-intc.c            | 174 ++++++++++++++++++
 6 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
 create mode 100644 drivers/irqchip/irq-ast2700-intc.c

-- 
2.34.1


