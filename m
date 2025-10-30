Return-Path: <linux-aspeed+bounces-2699-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87187CCF9F6
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 06:02:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxtmj0hXpz2yvv;
	Thu, 30 Oct 2025 17:02:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761804133;
	cv=none; b=AeTJICWV2i9RW3CwmUerAmyQZWj7AUP88/wHZS0RyLjZS8DmAiuJfLu0p6MSA7DczzOa12SS/gA6ajdPc/GN9vkAVk1RkOMNSJYBi89a8GSjFk2Rmdc0sP9L7UOTU5eyQeRFFO4aS4KnLwcVhEpq+0L6y7/AGBorBmmguIWLJNehuVYiWuy5PfpkUKXWFhkxRZfJa9tAU6PrQ3R6aeyhZgtJHIhiF74vKONc9ILLgWOPTPpZnIAzRJM6rYCOnJwP0fDVIw6YTvbc20v7vS9H6JrElNNOtvJfXYemyr3buxI1EGATwuWk1w3Hw6hueV1hTV/yg6lvw+thtTQqCX991g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761804133; c=relaxed/relaxed;
	bh=zoQNOp3cXeHgwjbw6Sp+aks973CQJHS2QAkO4BmOwO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBOJQMmyCdnI1gxodNvPUWWa81ncDZgf8gXwkE/L/IHjGuCreUEvPQxvNJ8edb6p2IKa1pL4jvxRIXo+jz4Pk7hv7Vt7vFeCEiF3DnmAtFEmm/ZfWT0+R06B4p18peUv2wcRwn2BfdDiqttN7x7p12G48XzOq0szavRSgJqZ/EHzRYGaZyyU2Q5VszKMTxa3/eKrb4qM85zszCkZ7bUOuUioR3ZZ/nfhuNZyH6Z2Krt1nxLNIoJwSiOMUDZ7hRAULgR/kPLj9K3p/IDwhbV97vhe9PzVKyeRpvhIgDEEWn7m+QHqpplpuHV6itHim7qg/rUTj5H7FtrVyvYsbp5z7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxtmh2Nb0z2xsq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 17:02:11 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 30 Oct
 2025 14:01:55 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 30 Oct 2025 14:01:55 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v6 0/1] Update correct AST2700 interrupt controller binding
Date: Thu, 30 Oct 2025 14:01:54 +0800
Message-ID: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
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

Update the AST2700 interrupt controller binding to match the actual
hardware and the irq-aspeed-intc driver behavior.

v6:
- aspeed,ast2700-intc.yaml
 update interrupt-cells, interrupts.

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

Ryan Chen (1):
  dt-bindings: interrupt-controller: aspeed,ast2700: correct
    #interrupt-cells and interrupts count

 .../interrupt-controller/aspeed,ast2700-intc.yaml   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1


