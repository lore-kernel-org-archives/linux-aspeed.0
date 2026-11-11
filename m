Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766960A260B
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:16:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTFx5kQKz2y2h;
	Wed, 11 Nov 2026 14:16:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367013;
	cv=none; b=M22XPDtiOX40yZD/YxNRTld665A35DegYNyVRPNyrSVqZBPS6K4Uxbg+ueY0HuzehUbV6kulr/4phNGQ5vSzVTlE4/sZnF4Hrz8dA3RyMivZhmeJygMnEnqEzrLSzLqDUiVCNdfsW0K5v0eZfw4z8dgZZXC4guyyQuC6bzvshoLmi/xIciIvAh0Mu7mG2F2voY6xFBeIoTM4BccnGbofUwqrT6bKcdbeQSsa+ynJMLSVdX18pAi4+J7dQzKZ+/AmNPclTisdXhPifhn6V0x8HE40bj1ZRsF9Cn6aSfFeeTKvirmc0bHkYDSL2UmI+jGEtoWhUg4FF1MeverdJj1Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367013; c=relaxed/relaxed;
	bh=o9bTZqbR1XvBSmTu8qrSg1NGYiQ9aPrsGDJsuKNGJzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CBFIUJ+V6nUw2qT1jF7mDx57AVPDlsl5XqWFZGeeIuDy/pfpIjywNsfdO0oxl/UKfkXx8wQi/HO9wZzj9gkxfIWtqnj7SZyNYQUbXcFwodRAOo1zEBt9R22nbQV5SNG6tAVwgNTwo5RgSusfONx4W5tKeR/rOIMMOO/I72iprOeEq0U7EHD0hXhkYJ/qytzbykF1RYfvrCyo6oevzUmQLAMqefeyqqAiSiGdZY6hCuL1qmbcA3z0jmtS+NLBB5L77aaYJIKcUEpRFBnd5Jw81d8JSgOA+MzLKavdZDkuSKCPRFa1wGYZlptyCCHbGTc2l62nLOn1Z/X40KFqaQHe/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTFw6cFtz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:52 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:31 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:30 +0800
Subject: [PATCH v2 2/9] dt-bindings: i3c: Document the AST2700 I3C
 controller
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-2-4d8fff5c5196@aspeedtech.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
In-Reply-To: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>
CC: <tbevis@amazon.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=4018;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=C7LPU47uCZf5PPs+zL2heQyebkx3hyevu7kHTop8XYA=;
 b=C5w0tgnbjl+kPCYW/DP5xE3+7DqdIX0sv2WA1xt/Uef0X70Oj+iPFJLJ6MC91BmLvag49ScN3
 BwtoHa8o8nhCrF9EDbHA0drYLD0Ex2K4q3MOEIHmXhsjcyPFb1Gbrs3
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST2700 I3C controller implements the MIPI I3C HCI programming
model, extended with an ASPEED in-house control block and a PHY
programming window advertised through an HCI vendor extended
capability.

The controller takes a core clock for PHY timing and two resets,
named in reset-names as the controller's own reset and its DMA engine
reset.

Boards without external I3C pull-up resistors can use the PHY's
built-in pull-ups instead, selected with bias-pull-up; the achievable
strength set depends on which pin group backs the bus, since that
fixes the pin voltage domain. Reuse bias-pull-up (pincfg-node.yaml)
for the strength in Ohms; it is declared on this node rather than a
pin-config node since the pull-up switch is part of the I3C PHY, not
the broader SoC pin control IPs.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

---
We considered expressing bias-pull-up's dependency on a pinctrl state
in the schema, but couldn't find a clean way to say "depends on
whichever pinctrl-N is active" without hard-coding pinctrl-0
specifically, which would be wrong in general (a node's active pin
state doesn't have to sit at index 0). We've added pinctrl-0 to the
example to illustrate the typical usage instead, without a formal
schema-level dependency.
---
 .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
new file mode 100644
index 000000000000..873398cbbcf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/aspeed,ast2700-i3c-hci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2700 I3C controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description:
+  The AST2700 I3C controller implements the MIPI I3C HCI programming model,
+  extended with an ASPEED in-house control block and a PHY programming window
+  that are advertised through an HCI vendor extended capability.
+
+properties:
+  compatible:
+    const: aspeed,ast2700-i3c-hci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Core controller reset.
+      - description: DMA engine reset shared by all I3C controllers.
+
+  reset-names:
+    items:
+      - const: core
+      - const: dma
+
+  bias-pull-up:
+    $ref: /schemas/pinctrl/pincfg-node.yaml#/properties/bias-pull-up
+    enum: [177, 231, 261, 317, 400, 470, 550, 600, 750]
+    description:
+      Enable the PHY-internal pull-ups on SCL and SDA and select their
+      strength, in Ohms. High-voltage pins support 400, 470 or 600 Ohms, and
+      low-voltage pins support 177, 231, 261, 317, 400, 550 or 750 Ohms. When
+      absent the internal pull-ups stay disabled and the bus relies on
+      external pull-ups.
+
+  i3c-od-scl-high-period-ns:
+    default: 380
+
+  i3c-od-scl-low-period-ns:
+    default: 620
+
+  i3c-pp-sda-hold-ns:
+    default: 10
+
+  i3c-sr-p-scl-low-period-ns:
+    default: 40
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c@14c24000 {
+        compatible = "aspeed,ast2700-i3c-hci";
+        reg = <0x14c24000 0x1000>;
+        interrupts = <100>;
+        clocks = <&syscon 20>;
+        resets = <&syscon 37>, <&syscon 34>;
+        reset-names = "core", "dma";
+        bias-pull-up = <177>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i3c4_default>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };

-- 
2.34.1


