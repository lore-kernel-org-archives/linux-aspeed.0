Return-Path: <linux-aspeed+bounces-3601-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11691F01807
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Mar 2026 08:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRzXv1btzz3c5f;
	Fri, 06 Mar 2026 19:07:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772784463;
	cv=none; b=bz6k+J4EMoai/ZX35cDA8sOVDamNB0/nFJrwgSm966CkN08ujyJ9iwXX/u1Uyg8YDlGvtMd376gRMvndHgEM1tzBg2mq+FxbUiw2dTSB/8xveR4zhCIoiA4b+IYUMo4g5FqhgRERRbkpQDqGunH6XDg4FKZX9TjcBxwd6FNV6gGcXiVDvYO0ZMsM/wv5JZNsPAlBRJgSLclmQ+oI7bBpbXG+OphzS1lWjTVPWN568vjD9oEiVfaypbBbt++1hF8t2RD9T1TFbZZElTli3G1u3itwBMlMM0RTFWTj6dOzTCO/6l7CpsMfYC5gcp2XzaX/tWJ3sNZRhkJyW0pj4ZExgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772784463; c=relaxed/relaxed;
	bh=SM8zr2NY6Y4BXB4UjHFV2fshMd6voXcDv/Y5wyAVnuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RfK1M8tnzlA4PPK57coPaQNyofkLCs58jhOLOttFxij/WDfTHPZPUGL5zAgDwjrp3YvCADWoX3/gAZMwDqHQa4tlZ8U0UC+JArQkI/zovF2CAfiY5JvLLAZRoeDN9GPwMmomYo0MImLSm6NQIDFnXyCKQhZZ1Okz6EMe/2N15dkV4ACrYC6L77njxr4RUara0PolpHiki46NV1M7mxfmGlShhu1ye9wKI42CclO3djR88aG787Tm6jPQr/0yUstvR09EjUjpjIu5SnGSEY/VEoeSvxQIPUg6s/AnKDY1EKutk31AhGKe9R5vJpf0fwD+u3wK0GmCnxWdCgGxp0MffQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRzXt1y0Nz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 19:07:42 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Mar
 2026 16:07:24 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Mar 2026 16:07:24 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 6 Mar 2026 16:07:23 +0800
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: aspeed: Add
 AST2700-A2 support
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
Message-ID: <20260306-irqchip-v2-1-f8512c09be63@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772784443; l=9398;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=rA0xsKEWLoSL7d6YL/W1K60UqPk7UAphRD9sgfecE0E=;
 b=/qb6MI+j8NIkYFb/d31oTYZ4V2/gZ64YXf6Z9Zfs4Kbzka9bHU/ZiHcHzMmh3QKgfkZWivx7s
 4UtFkEayK0hBsWKGyj4YgBxj5OGSiMw5G1J1a0KhUxU5sSErNDU2nxL
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Introduce a new binding describing the AST2700 interrupt controller
architecture implemented in the A2 production silicon.

The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
prior to mass production. The interrupt architecture was substantially
reworked after the A0 revision for A1, and the A1 design is retained
unchanged in the A2 production silicon.

The existing AST2700 interrupt controller binding was written against
the pre-production A0 design. That binding does not accurately describe
the interrupt hierarchy and routing model present in A1/A2, where
interrupts can be routed to multiple processor-local interrupt
controllers (Primary Service Processor (PSP) GIC, Secondary Service
Processor (SSP)/Tertiary Service Processor (TSP) NVICs, and BootMCU
APLIC) depending on the execution context.

Hardware connectivity between interrupt controllers is expressed using
the aspeed,interrupt-ranges property.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v2:
- Describe AST2700 A0/A1/A2 design evolution.
- Drop the redundant '-ic' suffix from compatible strings.
- Expand commit message to match the series cover letter context.
- fix ascii diagram
- remove intc0 label
- remove spaces before >
- drop intc1 example
---
 .../aspeed,ast2700-interrupt.yaml                  | 189 +++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
new file mode 100644
index 000000000000..13398ff8be12
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-interrupt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2700 Interrupt Controllers (INTC0/INTC1)
+
+description: |
+  The ASPEED AST2700 SoC integrates two interrupt controller designs:
+
+    - INTC0: Primary controller that routes interrupt sources to upstream,
+      processor-specific interrupt controllers
+
+    - INTC1: Secondary controller whose interrupt outputs feed into
+      INTC0
+
+  The SoC contains four processors to which interrupts can be routed:
+
+    - PSP: Primary Service Processor (Cortex-A35)
+    - SSP: Secondary Service Processor (Cortex-M4)
+    - TSP: Tertiary Sevice Processor (Cortex-M4)
+    - BMCU: Boot MCU (a RISC-V microcontroller)
+
+  The following diagram illustrates the overall architecture of the
+  ASPEED AST2700 interrupt controllers:
+
+                  +-----------+                +-----------+
+                  |   INTC0   |                | INTC1(0)  |
+                  +-----------+                +-----------+
+                  |   Router  | +-----------+  |   Router  |
+                  | out   int | +Peripheral +  | out   int |
+  +-----------+   |  0     0  <-+Controllers+  | INTM      | +-----------+
+  |PSP GIC  <-|---+  .     .  | +-----------+  |  .     .  <-+Peripheral +
+  +-----------+   |  .     .  |                |  .     .  | +Controllers+
+  +-----------+   |  .     .  |                |  .     .  | +-----------+
+  |SSP NVIC <-|---+  .     .  <----------------+  .     .  |
+  +-----------+   |  .     .  |                |  .     .  |
+  +-----------+   |  .     .  <--------        |  .     .  |
+  |TSP NVIC <-|---+  .     .  |       |    ----+  .     .  |
+  +-----------+   |  .     .  |       |    |   |  O     P  |
+                  |  .     .  |       |    |   +-----------+
+                  |  .     .  <----   |    --------------------
+                  |  .     .  |   |   |        +-----------+  |
+                  |  M     N  |   |   ---------+  INTC1(1) |  |
+                  +-----------+   |            +-----------+  |
+                                  |                  .        |
+                                  |            +-----------+  |
+                                  -------------+  INTC1(N) |  |
+                                               +-----------+  |
+  +--------------+                                            |
+  + BMCU APLIC <-+---------------------------------------------
+  +--------------+
+
+  INTC0 supports:
+    - 128 local peripheral interrupt inputs
+    - Fan-in from up to three INTC1 instances via banked interrupt lines (INTM)
+    - Local peripheral interrupt outputs
+    - Merged interrupt outputs
+    - Software interrupt outputs (SWINT)
+    - Configurable interrupt routes targeting the PSP, SSP, and TSP
+
+  INTC1 supports:
+    - 192 local peripheral interrupt inputs
+    - Banked interrupt outputs (INTM, 5 x 6 banks x 32 interrupts per bank)
+    - Configurable interrupt routes targeting the PSP, SSP, TSP, and BMCU
+
+  One INTC1 instance is always present, on the SoC's IO die. A further two
+  instances may be attached to the SoC's one INTC0 instance via LTPI (LVDS
+  Tunneling Protocol & Interface).
+
+  Interrupt numbering model
+  -------------------------
+  The binding uses a controller-local numbering model. Peripheral device
+  nodes use the INTCx local interrupt number (hwirq) in their 'interrupts' or
+  'interrupts-extended' properties.
+
+  For AST2700, INTC0 exposes the following (inclusive) input ranges:
+
+    - 000..479: Independent interrupts
+    - 480..489: INTM0-INTM9
+    - 490..499: INTM10-INTM19
+    - 500..509: INTM20-INTM29
+    - 510..519: INTM30-INTM39
+    - 520..529: INTM40-INTM49
+
+  INTC0's (inclusive) output ranges are as follows:
+
+    - 000..127: 1:1 local peripheral interrupt output to PSP
+    - 144..151: Software interrupts from the SSP output to PSP
+    - 152..159: Software interrupts from the TSP output to PSP
+    - 192..201: INTM0-INTM9 banked outputs to PSP
+    - 208..217: INTM30-INTM39 banked outputs to PSP
+    - 224..233: INTM40-INTM49 banked outputs to PSP
+    - 256..383: 1:1 local peripheral interrupt output to SSP
+    - 384..393: INTM10-INTM19 banked outputs to SSP
+    - 400..407: Software interrupts from the PSP output to SSP
+    - 408..415: Software interrupts from the TSP output to SSP
+    - 426..553: 1:1 local peripheral interrupt output to TSP
+    - 554..563: INTM20-INTM29 banked outputs to TSP
+    - 570..577: Software interrupts from the PSP output to TSP
+    - 578..585: Software interrupts from the SSP output to TSP
+
+  Inputs and outputs for INTC1 instances are context-dependent. However, for the
+  first instance of INTC1, the (inclusive) output ranges are:
+
+    - 00..05: INTM0-INTM5
+    - 10..15: INTM10-INTM15
+    - 20..25: INTM20-INTM25
+    - 30..35: INTM30-INTM35
+    - 40..45: INTM40-INTM45
+    - 50..50: BootMCU
+
+maintainers:
+  - ryan_chen@aspeedtech.com
+  - andrew@codeconstruct.com.au
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2700-intc0
+      - aspeed,ast2700-intc1
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+    description: Single cell encoding the INTC local interrupt number (hwirq).
+
+  aspeed,interrupt-ranges:
+    description: |
+      Describes how ranges of controller output pins are routed to a parent
+      interrupt controller.
+
+      Each range entry is encoded as:
+
+        <out count phandle parent-specifier...>
+
+      where:
+        - out:     First controller interrupt output index in the range.
+        - count:   Number of consecutive controller interrupt outputs and parent
+                   interrupt inputs in this range.
+        - phandle: Phandle to the parent interrupt controller node.
+        - parent-specifier: Interrupt specifier, as defined by the parent
+                            interrupt controller binding.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    items:
+      description: Range descriptors with a parent interrupt specifier.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - aspeed,interrupt-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@12100000 {
+        compatible = "aspeed,ast2700-intc0";
+        reg = <0x12100000 0x3b00>;
+        interrupt-parent = <&gic>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        aspeed,interrupt-ranges =
+          <0 128 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+          <144 8 &gic GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+          <152 8 &gic GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+          <192 10 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+          <208 10 &gic GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+          <224 10 &gic GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+          <256 128 &ssp_nvic 0 0>,
+          <384 10 &ssp_nvic 160 0>,
+          <400 8 &ssp_nvic 144 0>,
+          <408 8 &ssp_nvic 152 0>,
+          <426 128 &tsp_nvic 0 0>,
+          <554 10 &tsp_nvic 160 0>,
+          <570 8 &tsp_nvic 144 0>,
+          <578 8 &tsp_nvic 152 0>;
+    };

-- 
2.34.1


