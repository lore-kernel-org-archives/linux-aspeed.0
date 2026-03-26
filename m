Return-Path: <linux-aspeed+bounces-3779-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F9109E54B
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:20:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDCc2vTfz2xlf;
	Thu, 26 Mar 2026 17:20:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506012;
	cv=none; b=ZcxXUywdMWkrvsPZvOFcODeY+o8wIweZHL5RWvq8AmUx0yJOTw6CQZgTim8IEWKUu2/7SkRbOvk+lKYZ5jydU6VUT6yvYTkje7JW4cVc5MSOqH49AKoFBUNCwsdOxGcUEdbcERbTPsUwy7MshqelsYGB2h+8UXpveT4mc8lCXeH5Sc5F4UqX3l0hyhGAcNiNgenzSnB7jIchfpuyc2NrMPZuZ1Um+rcgK9CLGPCKGbcysZPmxahXXvL7G0feyqkHv9a6NyI79QOE+iMYCaZt//rIJhQDcmVB8JtMZaLVFQcGifaDCS0wmCIN6ciRNMFMenIyJ6EZf97VUpeJ2O6m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506012; c=relaxed/relaxed;
	bh=Tyhc9gk+yvouecGUG0R1DdvFVEN8LvxUi2VdPr8MWGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D7pjGs7R+fVOP2lP+oHdnTrOs7DVCU0csgXHB7aMoh2bvtK88mG6PtfMFJcjDr63AQhjyaNWpO+7CIosU1raDEfr16pTImmrO5Zxu8IOBI3Ti+8o4PoOqGvo7WAy/OkO7G/Y8liBe838D3vuSyWT8Al5g7odyRcZetJosCreYFSF4zv5zBRQZLsEYw9QAzMv+BsZCUFbBxQHSjm8Q3sNMqIx2rlmH80ZvEdalLsO+5v2v8m18xNO6bMRQ1xsKFa5MpKaWCGztwAxAS80h+IHSp9Jzr6r8wkSCtYnjx+u9JmaAiJBG+/CjQ8g+tzqASBBjli3KE+zwPTNn1nYxKkomA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDCb0hXwz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:20:11 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Mar
 2026 14:19:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Mar 2026 14:19:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 26 Mar 2026 14:19:50 +0800
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: Describe
 AST2700-A2 hardware instead of A0
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
Message-ID: <20260326-irqchip-v3-1-366739f57acf@aspeedtech.com>
References: <20260326-irqchip-v3-0-366739f57acf@aspeedtech.com>
In-Reply-To: <20260326-irqchip-v3-0-366739f57acf@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774505990; l=13458;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=kQvAzVUVrDuNhd8V/zx0ZUqXw5mMTgMh6/foOcGUKZk=;
 b=Rl/L1cR1QBKRd7ZVM2ssXFWFJai1Vjhd1nIAod7FjuNdRvH6XNdtxcIFWMITHzB0xUD9w0C62
 7gpkgkMsY7MC0bhfUhASE6cKfQXyEH+KvW6CjXkcqvw5WbTQVgzP92V
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Introduce a new binding describing the AST2700 interrupt controller
architecture implemented in the A2 production silicon.

The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
prior to mass production. The interrupt architecture was substantially
reworked after the A0 revision for A1, and the A1 design is retained
unchanged in the A2 production silicon.

The existing AST2700 interrupt controller binding
("aspeed,ast2700-intc-ic")was written against the pre-production A0
design. That binding does not accurately describe the interrupt
hierarchy and routing model present in A1/A2, where interrupts can be
routed to multiple processor-local interrupt controllers (Primary
Service Processor (PSP) GIC, Secondary Service Processor (SSP)/Tertiary
Service Processor (TSP) NVICs, and BootMCU APLIC) depending on the
execution context.

Remove the binding for the pre-production A0 design in favour of the
binding for the A2 production design. There is no significant user
impact from the removal as there are no existing devicetrees in any
of Linux, u-boot or Zephyr that make use of the A0 binding.

Hardware connectivity between interrupt controllers is expressed using
the aspeed,interrupt-ranges property.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v3:
- squash patch 5/5.
- modify wrap lines at 80 char.
- modify maintainers name and email.
- modify typo Sevice-> Service
Changes in v2:
- Describe AST2700 A0/A1/A2 design evolution.
- Drop the redundant '-ic' suffix from compatible strings.
- Expand commit message to match the series cover letter context.
- fix ascii diagram
- remove intc0 label
- remove spaces before >
- drop intc1 example
---
 .../interrupt-controller/aspeed,ast2700-intc.yaml  |  90 ----------
 .../aspeed,ast2700-interrupt.yaml                  | 188 +++++++++++++++++++++
 2 files changed, 188 insertions(+), 90 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
new file mode 100644
index 000000000000..a62f0fd2435b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
@@ -0,0 +1,188 @@
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
+    - INTC1: Secondary controller whose interrupt outputs feed into INTC0
+
+  The SoC contains four processors to which interrupts can be routed:
+
+    - PSP: Primary Service Processor (Cortex-A35)
+    - SSP: Secondary Service Processor (Cortex-M4)
+    - TSP: Tertiary Service Processor (Cortex-M4)
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
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
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


