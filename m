Return-Path: <linux-aspeed+bounces-4420-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B4FC43458
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvW9F19wgz3brc;
	Tue, 07 Jul 2026 16:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783404753;
	cv=none; b=Ms9aoaUq+bz0jpVsx0COQWEACowoG7Fp35vZbvzBG2Z0m+W1jxh0AhUZtn1V2mqmwnNnVwL8gM2Gzen9PNQfPRO5GEtN7whWJ3kTSsbOoDSP9eG2Svk6aFF2gI5qUNBhIKUkp6ONIr+TqHj8+vuNHB2wLGBQnpGsw5YMr+pyWGyWJeU/Wq3ErqWrmhLNczRs2bQrqmvAnynx2JDhDeWGPrjJtEj2SpwnJydn027Smt+0WwnbBeZ/GKgtyyoQnPo3yq/WZ+4GFKcGKofgK1sdQ3O1aWUeak4tSS8ZGBtBQXtg4a1eI6sPof5tHjmT1tsEyK5bcspc4ePAhrA89SqbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783404753; c=relaxed/relaxed;
	bh=8lABHXo8BBOM5aWqkiTc7zgArVT0tZs9MCClqWqEhTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=iqbzYlBsIWR9wYBaK9IpipW5/rK4pl3y8DPczr1oOKkOzrx6xHsRapQqn7HMCK9uatV4+Qv51+RtoTE8sUpB4QE/bYR25QeMPJ+sZumUGJVN8RucrZc8Fy5Os3aZjMPj0UlzHHBQDLQF9HU3R/AsjF6G/2JgVQIUHsYpo/VmTMZ3xQ0xpDJLULkh8ouTNlZBCDOU9w+0JxAgBhKIu1VPm68i6y7alaG8XvEMCqeFxJb7htDVUrJjBdoXGweMF9/Db/irxz4tX+Nt1KE4KHwdl3QLFsWZpnF9881n17C5kGZGWrH+gEUTdyQpW8Doqp+Yyxx13v5SR0a3OJP3W3ghVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvW9D01m2z2yfS;
	Tue, 07 Jul 2026 16:12:31 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 7 Jul
 2026 14:12:09 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 7 Jul 2026 14:12:09 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 7 Jul 2026 14:12:04 +0800
Subject: [PATCH] dt-bindings: usb: Add Aspeed AST2700 DWC3 controller
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
Message-ID: <20260707-xhci-v1-1-b202b9b3274e@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIALOYTGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMT3YqM5ExdQwvTtLQUy9Q0i6QUJaDSgqLUtMwKsDHRsbW1AJAmetl
 WAAAA
X-Change-ID: 20260624-xhci-185ffd9ef8bd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404729; l=3778;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=zctmRnr5zZwaI8WX/0DJyaFrcv2r1wAp7MFjzRmind8=;
 b=jyOU98vFE6v//IJl6fyetJll2J78DvchSa8IdXqv6tkADH9D65LrOq5YFfy5oPid1xwTHR8hs
 U54y6Dkvi0qA1mObAuKzUYMZE2ttMMPyjkQ50h8NrFGh274Yy/GdWYf
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The Aspeed AST2700 SoC integrates the Synopsys DesignWare USB3 core with
no vendor glue logic: it is functionally compatible with snps,dwc3, uses
the standard DWC3 clocks, and the only SoC-specific part is a USB3 PHY
that is handled by a separate driver.

Add a dedicated binding document rather than adding the compatible and a
conditional to snps,dwc3.yaml. This follows the established per-vendor DWC3
convention (apple,dwc3.yaml, socionext,uniphier-dwc3.yaml, ...) and keeps
the AST2700-specific constraints - notably the mandatory USB3 PHY - out of
the generic schema.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
The common DWC3 node properties are inherited from snps,dwc3.yaml via the
allOf $ref, so this schema only defines the additional AST2700-specific
constraints (the compatible, a single interrupt and the USB3 PHY) and does
not redefine the properties covered there. snps,dwc3.yaml is used rather
than snps,dwc3-common.yaml because the controller uses the standard DWC3
bus_early/ref/suspend clocks defined there.

Because reg, clocks and clock-names are only defined indirectly through
the $ref, they still appear in the required list, the same approach as
apple,dwc3.yaml.
---
 .../devicetree/bindings/usb/aspeed,dwc3.yaml       | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/aspeed,dwc3.yaml b/Documentation/devicetree/bindings/usb/aspeed,dwc3.yaml
new file mode 100644
index 000000000000..976f80b87e24
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/aspeed,dwc3.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/aspeed,dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description:
+  The common content of the node is defined in snps,dwc3.yaml.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-xhci
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: aspeed,ast2700-xhci
+      - const: snps,dwc3
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb3-phy
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - phys
+  - phy-names
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed,ast2700-scu.h>
+    #include <dt-bindings/reset/aspeed,ast2700-scu.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@12030000 {
+            compatible = "aspeed,ast2700-xhci", "snps,dwc3";
+            reg = <0x0 0x12030000 0x0 0x10000>;
+            interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>,
+                     <&syscon0 SCU0_CLK_U2PHY_REFCLK>,
+                     <&syscon0 SCU0_CLK_U2PHY_CLK12M>;
+            clock-names = "bus_early", "ref", "suspend";
+            resets = <&syscon0 SCU0_RESET_PORTA_XHCI>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_usb3axh_default &pinctrl_usb2axh_default>;
+            phys = <&uphy3a>;
+            phy-names = "usb3-phy";
+            dr_mode = "host";
+        };
+    };

---
base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
change-id: 20260624-xhci-185ffd9ef8bd

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


