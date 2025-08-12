Return-Path: <linux-aspeed+bounces-1942-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19538C87FCB
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 Aug 2025 10:08:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c1Rzj2xSdz3dSW;
	Tue, 12 Aug 2025 20:08:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754993329;
	cv=none; b=CsUQo1NLs3kDrMuiidNDbWZbcoSwOazPXuTVCqeWk1ZhwL2vg7yFKLp9bYLFqbNAJN2tgDewnN6NQj8DlFlhUQd1GnXMNFqs2horlIGzDJJNlu+cPHEJtDJg6T9GPDTlf2AEqnfg9qtgTg4df6vFPT9iPD75IchSABP9+0eZrnbtF6s1EhBzbjGliv3iBo0HfW8TiDIlxTDduqabqdC3e3RwWUQ8cyUwkBzD3qz+qm1PvI+fW8P2Hbly/PnYqtPNsrhIgszjhZK5ZXNKOqQx2ifbCJCkQ3ox0PH0wGD0KsK+jXMhTY4jiblkOn0sQTtJlZtyo9OUrPYw5Frz7sEO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754993329; c=relaxed/relaxed;
	bh=WFkx4U9cuFXk03WjKVwN46GWivXczH1K5V0/kz3Ucco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFMUxfGjSCwnvS+Lpz0SF9nKrx+6ZqDyVT8dUINCfi6DXTfr7fFOar4iegS04NRNx3uPJZDtXY1Ja6p8rB7HaOC8HdIhSwwXk/pCgwzcNoRcv3alTtqyzqWAD9H+UvDH0VoNkVXPdRlN3JnORtYguADCM5cnvoOwfVPwj8YvdpxwAsiQqr0pPRm+gOknuSRlpJa9OoOA668kQjSfJEtmXKbzVmBT2G8KdoSUihhaRLXl2dQ2gEjS6z5relk/cG9BZBoEPdnp5ebenhhFthn7rMc2ABZ6JvV9X9eNlrMgNz/0zTiQzG+4fH9iPi6QGJpMMQsQHUZcMdgB9okX0GhzrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1Rzh3k0Nz3dLS
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 Aug 2025 20:08:47 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 18:08:30 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 18:08:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v4 0/2] irqchip/ast2700-intc: Add AST2700 INTC debugfs support and yaml update
Date: Tue, 12 Aug 2025 18:08:28 +0800
Message-ID: <20250812100830.145578-1-ryan_chen@aspeedtech.com>
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

This patch series adds device tree bindings and driver support for the
AST2700 SoC!|s two interrupt controllers (INTC0 and INTC1), along with
debugfs entries for runtime inspection of routing and register protection
status, and bindings example refine.

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

Ryan Chen (2):
  dt-bindings: interrupt-controller: aspeed: Add parent compatibles and
    refine documentation
  Irqchip/ast2700-intc: add debugfs support and AST2700 INTC0/INTC1
    routing/protection display

 .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++-----
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-ast2700-intc.c            | 174 ++++++++++++++++++
 4 files changed, 296 insertions(+), 43 deletions(-)
 create mode 100644 drivers/irqchip/irq-ast2700-intc.c

-- 
2.34.1


