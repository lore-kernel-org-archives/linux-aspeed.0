Return-Path: <linux-aspeed+bounces-3482-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C36E9126E
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 06:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f66G25kHRz30FD;
	Thu, 05 Feb 2026 17:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770271674;
	cv=none; b=DjtQ0yYNgx6Zvf+6v/adZkSJuz5SYY+Z4XuUXlhLwNvlilkjqsmthS85fAlyGFRAntWSYA7v2TYJuqfbwvM+FWpQBA2BrPT3Ah7LOwMZOAwbBhDWFNdxTJythUQOUQQ7grTDpuPdclbMw9WfzPTvzzu7zOU+X4sdxADbS+Q45tR3Qh4+VsKQ152JLTmiyXfZkOZx3/ysZ1I9riod7BTamATQV5xDkHodv9XZWOwkZBiCGIDZfbgO4yt9MRolWlnJ5naB53b+By8B01j5qguOQ4JTEQ9AjnW6ETprnTsolPUsBMXX1uJIJ5rJV1fSVXTqYBXW4BpYS7SWeimO1T7MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770271674; c=relaxed/relaxed;
	bh=0OW+i9rzpbljgSJ4wy1JZuTrK0oFgB7X+hdhCdWfUIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mqmdJl+PAmfySFYMsvG+R409aTsWMjkm7fx6t++AikPbZFWpwTbY3Kr8YXllpotYJwEPR8uRnpTkLRE2PIo7VX+vTVZzogReWA2bc5NjEM3Q3VlJnA26Uez+pAbfmg/UPQyc60ZF7tx4JeijjSwwsWHLTuSE2aHfAnzn9mYHm240EHwy6GFAVzdw2N0f7U7kDJnd83epRuMQ1ULfyr7Ylxth631OGIszzcROLjfdtph/2HlbEWNzATsYEqe27ejrzylgq71kLi2M9pbwTYHKGQLe/ndS+5o3Q8tlhUNxM66iP8+KK3DP6pBTqzEAspMidCeFpicC2DP1HCq8gogAWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f66G210syz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 17:07:54 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 5 Feb
 2026 14:07:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Feb 2026 14:07:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 5 Feb 2026 14:07:22 +0800
Subject: [PATCH 4/4] dt-bindings: interrupt-controller: aspeed: Remove
 legacy AST2700 interrupt binding
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
Message-ID: <20260205-irqchip-v1-4-b0310e06c087@aspeedtech.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
In-Reply-To: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271649; l=4143;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=94kybmSK3L5D9FwcDBryTTemjApRuHICkM61YUdO5vs=;
 b=W0brkznpcQsf8wSaCgi65FA86/dT8/rbmt2Kul/YxEM7azEc3tuqfRQbbcJukMHzbV6QsMC9e
 SkcxUdArKffAJKnTsjEsFA3BtWotZjQjgtH2mmdDNTtaW7iPEV8rUzN
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Remove the legacy AST2700 interrupt controller Devicetree binding.

The legacy binding was limited to a PSP-centric view of the interrupt
architecture and cannot describe interrupt routing and protection for
the full AST2700 system.

It is superseded by the new ASPEED AST2700 INTC0/INTC1 binding, which
describes the interrupt controllers at the block-function level.

There are no known upstream users of the removed binding.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../interrupt-controller/aspeed,ast2700-intc.yaml  | 90 ----------------------
 1 file changed, 90 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
deleted file mode 100644
index 258d21fe6e35..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ /dev/null
@@ -1,90 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Aspeed AST2700 Interrupt Controller
-
-description:
-  This interrupt controller hardware is second level interrupt controller that
-  is hooked to a parent interrupt controller. It's useful to combine multiple
-  interrupt sources into 1 interrupt to parent interrupt controller.
-
-maintainers:
-  - Kevin Chen <kevin_chen@aspeedtech.com>
-
-properties:
-  compatible:
-    enum:
-      - aspeed,ast2700-intc-ic
-
-  reg:
-    maxItems: 1
-
-  interrupt-controller: true
-
-  '#interrupt-cells':
-    const: 1
-    description:
-      The first cell is the IRQ number, the second cell is the trigger
-      type as defined in interrupt.txt in this directory.
-
-  interrupts:
-    minItems: 1
-    maxItems: 10
-    description: |
-      Depend to which INTC0 or INTC1 used.
-      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
-      status registers for use.
-      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
-      INTC1 is used to assert INTC0 if interrupt of modules asserted.
-      +-----+   +-------+     +---------+---module0
-      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
-      |     |   |       |  |  |         |---...
-      +-----+   +-------+  |  +---------+---module31
-                           |
-                           |   +---------+---module0
-                           +---| INTC1_1 |---module2
-                           |   |         |---...
-                           |   +---------+---module31
-                          ...
-                           |   +---------+---module0
-                           +---| INTC1_5 |---module2
-                               |         |---...
-                               +---------+---module31
-
-required:
-  - compatible
-  - reg
-  - interrupt-controller
-  - '#interrupt-cells'
-  - interrupts
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    bus {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        interrupt-controller@12101b00 {
-            compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <1>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
-        };
-    };

-- 
2.34.1


