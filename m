Return-Path: <linux-aspeed+bounces-4176-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6619DCD6E4A
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 05:50:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVcHZ6ttnz2yth;
	Wed, 03 Jun 2026 15:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780465834;
	cv=none; b=U9J62ybh4PU8cloB4k8J67YexMLHSw8k27GyKm/chzauxH0e1GvT4nFJ2NhxO/B4OlMCMwP+RDA11ET6S2fYIH4jL6zrDr6l7AJOZkbjLDVlXKUFFUfc2FFq8qdt+K1lA0DzdtCQPtkhYPRxrkdmGy5St25dyWoY7kMKfxjGMYrxWIcxGRbwplrUxmQKiI5D+UQ7dNcPodrx1U0C2NgFnW3aQHlvhUCFm5xHPJwSBUDoAolOIbGu6cSmjiL2cTjACWidbK/uTMill5bsxeJ1wNLhKEo+AIc8au3g4kL2PeqFaYF87QpBEPI4zkKZBs/Sr+48wDRjHSpsTlxY6udHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780465834; c=relaxed/relaxed;
	bh=wf3GXQMq/sbUvVQvMpZuJdRO//yxgSA4sFLPJEPAeWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a+2JooY/5axG/icHENu0o1uZc2qd///mccC5Zo2tNXhr4O+rX3V5hc2yiQ5eibbUWW9dKOVH8vjRnjiT9X0Wlwe3JLYpnULeolX16hIphsSHSzc7czX1Ob9XJZHeTBDOryIFZcc3RjDW25W1dggf/8JDIICicNUfz28z2NgKSgTTDdHq+EpjjApSor960S/YhKZNtePJXeqk3J9EyjbKTVuL7o7Ss6O/ez+oHSafy5hXb29FiP3EMJnPAnma9YHxOOax+5WV20/cohjBJJzYMg/988tPH8hLR4VCdTTE4DVUkFAQaiu3Ox2ITgYzuzzJPW7wNEBTNev0/8CaQCP+ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVcHY5l84z2ybQ;
	Wed, 03 Jun 2026 15:50:33 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 3 Jun
 2026 13:50:14 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 3 Jun 2026 13:50:14 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 3 Jun 2026 13:50:13 +0800
Subject: [PATCH v31 1/5] dt-bindings: i2c: Split AST2600 binding into a new
 YAML
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
Message-ID: <20260603-upstream_i2c-v31-1-ba7a02714f22@aspeedtech.com>
References: <20260603-upstream_i2c-v31-0-ba7a02714f22@aspeedtech.com>
In-Reply-To: <20260603-upstream_i2c-v31-0-ba7a02714f22@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780465814; l=4676;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=YPKMcrNDJaJX+8ptTV6qqSy9Lxm7XtwOftPiAB5gsvk=;
 b=wa4XHPTuEaYeA3jwIGbJnp4YGL7gVWelgUi0BTLpfPmipntbPb5gFzWzMfTQKQ+A/PN0sC2/O
 95hD/cPJ+nYAopHvOlfsnN7d7xogQn6yKFPvNcnj8UIRwyWCXZgLaro
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2600 I2C controller introduces a completely new register layout
with separate controller and target register blocks, unlike the mixed
register layout used by AST2400/AST2500.

Move AST2600 I2C binding from aspeed,i2c.yaml to a dedicated
aspeed,ast2600-i2c.yaml schema.

Besides the split, this also adjusts for AST2600-specific requirements.
- describe two reg regions (controller register block + buffer block);
  the second region is optional (minItems: 1) so existing AST2600 DTs
  that only declare the controller register block continue to validate
- use clock-frequency for bus speed description
- interrupts are required on AST2600
- use correct DTS coding style in example

No compatible strings are changed.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v31:
- Commit message body: clarify that the second reg region is optional
  (minItems: 1) rather than required, matching the schema and the v30
  backward-compatibility fix (Sashiko AI review).

Changes in v30:
- Add minItems: 1 to reg so existing AST2600 DTs with a single reg
  region continue to validate (Sashiko AI review)
- Retain bus-frequency as a deprecated property to avoid breaking
  existing AST2600 DTs under unevaluatedProperties: false
  (Sashiko AI review)
Changes in v26:
- commit message: include details of changes from original binding
- fix example property ordering to follow DTS coding style
- use consistent "AST2600" naming
---
 .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 73 ++++++++++++++++++++++
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |  3 +-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
new file mode 100644
index 000000000000..abc614315dff
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,ast2600-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED I2C on the AST2600 SoCs
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-i2c-bus
+
+  reg:
+    minItems: 1
+    items:
+      - description: controller registers
+      - description: controller buffer space
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description: Desired operating frequency of the I2C bus in Hz.
+    minimum: 500
+    maximum: 4000000
+    default: 100000
+
+  bus-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Legacy name for clock-frequency. Existing AST2600 device trees
+      used this before the binding was split out. New device trees
+      should use the standard clock-frequency property instead.
+    minimum: 500
+    maximum: 4000000
+
+  resets:
+    maxItems: 1
+
+required:
+  - reg
+  - compatible
+  - clocks
+  - resets
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c@80 {
+        compatible = "aspeed,ast2600-i2c-bus";
+        reg = <0x80 0x80>, <0xc00 0x20>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon ASPEED_CLK_APB>;
+        resets = <&syscon ASPEED_RESET_I2C>;
+        clock-frequency = <100000>;
+        interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index 5b9bd2feda3b..d4e4f412feba 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ASPEED I2C on the AST24XX, AST25XX, and AST26XX SoCs
+title: ASPEED I2C on the AST24XX, AST25XX SoCs
 
 maintainers:
   - Rayn Chen <rayn_chen@aspeedtech.com>
@@ -17,7 +17,6 @@ properties:
     enum:
       - aspeed,ast2400-i2c-bus
       - aspeed,ast2500-i2c-bus
-      - aspeed,ast2600-i2c-bus
 
   reg:
     minItems: 1

-- 
2.34.1


