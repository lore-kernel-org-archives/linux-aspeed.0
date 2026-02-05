Return-Path: <linux-aspeed+bounces-3478-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B7CE91269
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 06:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f66Fy0Bp4z2xrk;
	Thu, 05 Feb 2026 17:07:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770271669;
	cv=none; b=f4oq5UqtIYmMAE7uGzlFADTq+EV9nVY4Au2wp9oz9wluSEeaqeK+UVXyhAmyzvB34fd5JT7Fce2eEsASFTTQcrFrGPlbM0rCGkxpFlfEkFgKYVb1jBWChzQy639jpjazyRpI5/RccU7bOIBWasPTTcwFcuto3HddSFfq/FMD53MMAkhFMGmVsG2i8iCKUdeGs7of7vsUby2nZsRKBN6Z2TzNaRxlyhnwWSROSzn4QNNUgtqGW5vyTTCvGN9QbAZb0c3n3ttNeW/+5t7DSpY5DPmyffZ4rNkjAOqZYABQ3MqcmjIH8NeTuY+NxlRJrF6uHSid+TMNisDGc3kYWDx8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770271669; c=relaxed/relaxed;
	bh=3h6HJz8NNrYlReHNuQDohxNkBviqiY9Qh90W6eUVqks=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=H4ouXLqRqS5bitXFXL9gf1IIoeVqmblZ1LwKV0OUoiXTTPRb/HFwaiynWJjZCjsfdimCavzCBELSQxdVv4SRopBMp2niCrCc2FVP6XEBbYfT/0QE9cOoH9/nNz4SV2UgfPS6nt1X6jAyIolo+FtCJV55y4S2HABTxpHiE2Fv0UcTDeGAGXSIyCLsj5sjXPOLY6BGwGc81PfVghwsa3KlsAXsSljVrf51v6v/WZXJCcMaIr9SyD6oraRTHe927opxINLdOGUFgU5af88L6nzlgyWhH/Kn0RS9maag+waDqmLnNT5Bj8PXPTJpdC6dIUD2cPpKIvIveH518aDzhjR+3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f66Fw5fdVz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 17:07:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 5 Feb
 2026 14:07:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Feb 2026 14:07:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Date: Thu, 5 Feb 2026 14:07:18 +0800
Message-ID: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAJYzhGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNT3cyiwuSMzAJd89TE1DRjM3OTlFRLJaDqgqLUtMwKsEnRsbW1APC
 PjmBZAAAA
X-Change-ID: 20260205-irqchip-7eaef3674de9
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271649; l=3818;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=rDmI36wMlYPSwIc+H4llkof4eAuk8Sz030JtmtRFVJ4=;
 b=tMe7+qBoJqIpvk9QS5BEc1NujHzW57rW7AGNx4xk2x2iJRWTRjJwo/SzX3gvIayPcEgNNMcxW
 qlTUc2ct44eDAVTIOuK9PgPK5B6PQBOAp/sChagEtI/drVbY+ZeOq9l
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series replaces the existing AST2700 interrupt controller binding
and driver. The original implementation was focused on a narrow,
PSP-centric view and could not fully describe the complexity of the
AST2700 interrupt fabric:

* It was focused primarily on the perspective of the Primary Service
  Processor (PSP).
* It could not handle interrupt route configuration.
* It could not handle interrupt register protection.

By contrast, the new bindings and drivers describe the interrupt
controllers at the block-function level and provide a unified binding
design that can be used from the perspective of any of the four
integrated processors (the Primary, Secondary and Tertiary Service
Processors, and the Boot MCU):

* Can handle interrupt register protection.
* Can handle interrupt route configuration.
* Has a unified binding design that applies to the system perspective
  of any integrated processors ({P,S,T}SP, BootMCU).
* Provides enough information for any of the {P,S,T}SP or BootMCU to
  route interrupts intended for any of the other processors' interrupt
  controllers.

There are no known upstream users of the existing binding. This series
removes it along with the associated driver after introducing the new
binding and driver at the start of this series.

The AST2700 interrupt architecture is built around two controller
designs. INTC0 routes interrupt outputs to upstream interrupt
controllers (e.g. the ARM GIC used by the PSP, as well as interrupt
controllers associated with other cores such as the SSP and TSP).
INTC1 is a banked secondary controller whose interrupt outputs feed
into INTC0 via INTM lines. Connections between the two interrupt
controllers are described in the devicetree using the
aspeed,interrupt-ranges property.

The INTC0 driver creates a hierarchical irqdomain under the selected
upstream interrupt controller. The INTC1 driver implements the INTM-fed
banked controller and exposes a linear interrupt namespace to its
parent.

The design intent of the binding is that, by default, the interrupt for
a given peripheral is routed to the processor consuming that
peripheral. To support this, the devicetree provided to the operating
environment for each processor should set its own processor-local
interrupt controller (e.g. the GIC for the Cortex-A35 PSP) as the
interrupt-parent of INTC0.

Information derived from interrupt-parent at each interrupt controller
is incorporated into the route resolution algorithm implemented in the
INTC0 driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (4):
      dt-bindings: interrupt-controller: aspeed: Add ASPEED AST2700 INTC0/INTC1
      irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1 support
      irqchip/aspeed: Remove legacy AST2700 interrupt controller driver
      dt-bindings: interrupt-controller: aspeed: Remove legacy AST2700 interrupt binding

 .../interrupt-controller/aspeed,ast2700-intc.yaml  |  90 ---
 .../aspeed,ast2700-interrupt.yaml                  | 207 ++++++
 drivers/irqchip/Kconfig                            |  11 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-aspeed-intc.c                  | 139 ----
 drivers/irqchip/irq-ast2700-intc0-test.c           | 474 +++++++++++++
 drivers/irqchip/irq-ast2700-intc0.c                | 770 +++++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc1.c                | 345 +++++++++
 drivers/irqchip/irq-ast2700.c                      | 105 +++
 drivers/irqchip/irq-ast2700.h                      |  37 +
 10 files changed, 1950 insertions(+), 230 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260205-irqchip-7eaef3674de9

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


