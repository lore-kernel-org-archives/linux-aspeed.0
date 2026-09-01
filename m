Return-Path: <linux-aspeed+bounces-4894-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD6AC624D2
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hg040Kz2xmh;
	Tue, 01 Sep 2026 21:36:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262562;
	cv=none; b=RQtst/oM780iw+/0UUHNA/n5JGPReyFX/7671Bay12MF74b9flA4R6Q3rnRpwIbMgwN5l2EL6nlwYHMNlrfFPxJc4bRmeYjXqDsCg+703ZieqES/NiTxtm14RtRGp5WCYFumtRMpLkfbUsdDUCS7xdvFpD1C/lLTjxygg3MQyti6++zPXnpsAzeWcZjNjpQsTaTrUjF7pjCJCL2hVzGl0yo2zRY6uZHApo39cjoz7sdjoF4wt+Qm+xFOvnqKSOeOhFu7w+ffTD2/Xx8Ok2PldhxqkiEhiY3oof47RSgYddxmSmkRWovWWoDpfKAYR7MjC/7xByvv9HbUx05hqHVtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262562; c=relaxed/relaxed;
	bh=JldW9rnjKPf9Ndo3hw5bd/n4o37HN08HKBEH3onbVpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NFCAn6ePduvh9Xz3IbQoTUUwRPitlMRzbwVT+soXGn+Mo5PFaQ4ysppzthEkwSNxMNft+rSnsHvDUm69d61wtK+dg5wuaFoHCu9Sbu99dYTfbix8UX+FrTEEs/sX1DzdyBScuBiaUGaETsZnpQhyPg2a+oWee/xkwiI1EJKqTQCdEqMEPmpV0OruE+Fx2AGBBmmg46uNsqz2YQW6pFPxH3zoacPJdvBW7yNe+6apH//+9Lj3cnTD/zjCQjw4UQ2TpEqesCcGOxCzIg0dJqY0vCDh+JI7cNmgHCunk7NmUxjoVgtWCpqlzcIk8ZE+hc0EleSbDEE7ZfdLgmZUzTNu5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hc59k3z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:36:00 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:38 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:38 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 1 Sep 2026 19:35:28 +0800
Subject: [PATCH 1/8] dt-bindings: i3c: Document the AST2700 I3C controller
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
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=6052;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=CmjtH7jTG5+YPiPuOpmBo34pkSZretrF0i3bIFIUIZs=;
 b=obfw+O0Z2sGTX5UNne+B4lR3b9FwoJjZ9Zlrl0aI1cWzON1B/wCWo+0EN2GTuX/RH0ZTh6vd2
 KgVDu5JN4lWC9bfdHmkYiflE6oNctNgHYy50RHU+eJ79u8mtHZmOv+W
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The AST2700 I3C controller implements the MIPI I3C HCI programming
model, extended with an ASPEED in-house control block and a PHY
programming window advertised through an HCI vendor extended
capability. Follow the existing aspeed,ast2600-i3c precedent of
describing SoC integrations of a common I3C IP in their own schema.

The controller takes a core clock for PHY timing and two reset-names
lines: its own reset and a DMA engine reset shared by all I3C
controllers on the SoC.

The PHY timings derived from the core clock and bus rate assume
nominal bus loading. Boards with long traces, weak pull-ups, or
capacitive loading need different ratios and setup periods, so
document properties to override the push-pull and open-drain SCL
periods, the SDA TX hold time, the tCAS/tCBP periods, and the SCL low
period used for a repeated START or STOP.

Boards without external I3C pull-up resistors can use the PHY's
built-in pull-ups instead. The achievable resistance depends on the
voltage domain of the pins (high-voltage vs low-voltage), which can be
determined from the pin group assigned to the bus. Reuse bias-pull-up
(pincfg-node.yaml) for the strength in Ohms; it is declared on this
node rather than a pin-config node since the pull-up switch is part of
the I3C PHY, not the broader SoC pin control IPs.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-fable-5

---
We considered formally expressing bias-pull-up's dependency on a
pinctrl state in the schema, but couldn't find a clean way to say
"depends on whichever pinctrl-N is active" without hard-coding
pinctrl-0 specifically, which would be wrong in general (a node's
active pin state doesn't have to sit at index 0). We've added
pinctrl-0 to the example to illustrate the typical usage instead,
without a formal schema-level dependency.
---
 .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
new file mode 100644
index 000000000000..19ecb5b15038
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
@@ -0,0 +1,133 @@
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
+      strength, in Ohms. High-voltage pins support 400, 470 or 600 Ohms,
+      and low-voltage pins support 177, 231, 261, 317, 400, 550 or 750
+      Ohms. When absent the internal pull-ups stay disabled and the bus
+      relies on external pull-ups.
+
+  aspeed,pp-scl-high-ns:
+    description:
+      Push-pull SCL high period. Overrides the value derived from the
+      i3c-scl-hz bus rate.
+
+  aspeed,pp-scl-low-ns:
+    description:
+      Push-pull SCL low period. Overrides the value derived from the
+      i3c-scl-hz bus rate.
+
+  aspeed,od-scl-high-ns:
+    default: 380
+    description:
+      Open-drain SCL high period.
+
+  aspeed,od-scl-low-ns:
+    default: 620
+    description:
+      Open-drain SCL low period.
+
+  aspeed,sda-tx-hold-ns:
+    default: 10
+    description:
+      SDA output hold time relative to the SCL edge.
+
+  aspeed,cas-ns:
+    minimum: 39
+    description:
+      Clock-after-start (tCAS) period driven after a START condition.
+      When absent it is derived from the SCL low period of the
+      applicable bus context, clamped to the protocol minimum.
+
+  aspeed,cbp-ns:
+    minimum: 20
+    description:
+      Clock-before-stop (tCBP) period driven before a STOP condition.
+      When absent it is derived from the SCL low period of the
+      applicable bus context, clamped to the protocol minimum.
+
+  aspeed,sr-p-scl-low-ns:
+    default: 40
+    description:
+      SCL low period used while preparing a repeated START or STOP
+      condition, kept separate from the push-pull SCL low period to
+      satisfy the MIPI I3C clock stalling requirements.
+
+dependencies:
+  aspeed,pp-scl-high-ns:
+    - aspeed,pp-scl-low-ns
+  aspeed,pp-scl-low-ns:
+    - aspeed,pp-scl-high-ns
+  aspeed,od-scl-high-ns:
+    - aspeed,od-scl-low-ns
+  aspeed,od-scl-low-ns:
+    - aspeed,od-scl-high-ns
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
+        bias-pull-up = <400>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i3c4_default>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };

-- 
2.34.1


