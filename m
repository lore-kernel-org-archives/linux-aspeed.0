Return-Path: <linux-aspeed+bounces-3605-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4298F01804
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Mar 2026 08:07:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRzXz6bgDz3c9y;
	Fri, 06 Mar 2026 19:07:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772784467;
	cv=none; b=OKN9h8YpDsyA9WWJ2sl3gfwI8cSrLKxYuz68BWx+Trk5kb48/NyHp4IgslLoa6ceFbIXW21gwq/siB90UlADhXh73zSgAAcPSxoPINmjrnS/FWxSywF2e6df8qP0KWTzoAZt5Fb/dQ56uwb2hYGZeSorP9Kqb+h2s41jp3U+KuWI6EJKBMJhmS96hFrUHRCQjwI6UtzFvBSPlqDFdAC50+o4FThICQYPjMKRfXzwGrz7qGy7xEMFTJaFD0mOC8bo24VSYcV9ouSa9TpCoazZjtrwrxJqkAoVmEjkNQwTZ2io28GjKl41OWT6CmQkZjaiLv3mFFzk7Bm8L6rwNxXa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772784467; c=relaxed/relaxed;
	bh=q57wOGgcZdGO8Qi6ke0EVo4ZqKPCH7+05dehr5k2jno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=flndxjTt3j5D8H5Fju4d6H7/1yF4KMdQslVLJIzQkShG6D9E/eQFvjkHyeSiZNRUz/sMkxizPEwysWCIRL6t7gczb65yfCtAWUYK4Rzwm0xqnbqWgqFNgBF6rSdV8OsvfcRIlu+Edhx6Uop1it+y92lR/n2qhptBVm9r+yzc8D3PjnGwpEKvood4exs8I8/JbUN9j2ROYYiuD/oVrhRLf8B7SiglfM5SbZC8HUHMz+deiedBoI62fR6y4YVWNj4IC57wK9L7EilHtUd+7AAjf7Zf6yQAw1aod+f/sUwU1Ec3AW1g1lb0GqCute+7CZ13BxZQZL9eqw0MnkKGcVohww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRzXz0BkPz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 19:07:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Mar
 2026 16:07:24 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Mar 2026 16:07:24 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 6 Mar 2026 16:07:27 +0800
Subject: [PATCH v2 5/5] dt-bindings: interrupt-controller: aspeed: Remove
 AST2700-A0 support
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
Message-ID: <20260306-irqchip-v2-5-f8512c09be63@aspeedtech.com>
References: <20260306-irqchip-v2-0-f8512c09be63@aspeedtech.com>
In-Reply-To: <20260306-irqchip-v2-0-f8512c09be63@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772784444; l=4783;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=3E1xw0HsueF+u/KGpP5CYluFLpq97aaG2OP77KelhBs=;
 b=kn3OWDXDQmtIRzIJ+vraA5kn3sCgavptGJTCroJCF5tKMdeBxGWqFh6O/g3qUTIV5PITffJCm
 x6t6XR7doW0DCAxoEbGTDatBhB49uxvPlTHJYMShILaxIWY7BloaU+0
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The existing AST2700 interrupt controller binding
("aspeed,ast2700-intc-ic") was written against the A0 pre-production
design.

In A0, the interrupt hierarchy effectively converged at the Primary
Service Processor (PSP): INTC1 instances fed into INTC0, and INTC0 was
wired to the PSP GIC. The binding therefore described a fixed, PSP
aggregation model.

From A1 onwards (retained in the A2 production silicon), the interrupt
fabric was re-architected: interrupt routing is programmable and
interrupt outputs can be directed to multiple upstream controllers
(PSP GIC, Secondary Service Processor (SSP) NVIC, Tertiary Service
Processor (TSP) NVIC, and Boot MCU interrupt controller). This design
requires route resolution and a controller hierarchy model which the
A0 binding cannot represent.

Remove the binding for the pre-production A0 design in favour of the
binding for the A2 production design. There is no significant user
impact from the removal as there are no existing devicetrees in any
of Linux, u-boot or Zephyr that make use of the A0 binding.

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


