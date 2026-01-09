Return-Path: <linux-aspeed+bounces-3269-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458FD232E3
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Jan 2026 06:10:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnWbs5SVlz2xQ1;
	Fri, 09 Jan 2026 17:10:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767939049;
	cv=none; b=bizrpE6xB++HlmLk/TPAGDr5aB4oFQwOEPASf+RNRaHfjJ1eBzju5nTotGDo9Wcl4KpmAzH5a+T4Q6GPDgNhOGQWjys6OnO7W/W5kDBGiowFYFZQLec3WzGkcjdmHcp72XM7ZZ6amFq/6/kpZSon1qPl8jMjteP8GKxcas6qijECLWFjyIfqtDhTGpox5Cj/jTiSQFK1Ul3oMzDUE1h+LBktTGkTlBjXGzGms7OeORKGopOPKTW7a0ozaNZiPWJYwyQ0fNArU4cubedTocnO1lnTL8U+TroIXJyFKs0N9fWIatdSgv2t+qPEfVjzy+LwC+5uZ761/cX9Q1wPJetJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767939049; c=relaxed/relaxed;
	bh=vRFQQUj7n/i2ZiWtqXly1x4ZWNMsf/8vSdo3mxivNNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=USpKxCJ4GDI+ENtrSHx/rkjrGgSQf4iYlou6HaOsHFoNxF/3rr7DmRbU1BCPxua1GF2rlxtJLelnqb4gT20r3j3aBzxsTSSluSH/EAVpaOzZPoogyOtj7ZoIUqp/NHp00b0+BEVvqFICI0FP5Zk/sEXs9jEmWsZgeUyjoPp+lpUOs1Bffc1Z7ZdahPnBUcI7Y4QvWKw7ZAx27w2bNAbPFrp6frD48DFOt2wfkzwVDYU/886anAuByw+9sjOdlaEF0XwGVT9Z8GEVV5grfv7EdVzTE4mwptSFuQjz5vjbyHSC7WWIz/87USbb64ctOEP7iGMgIS48CGd2xR6FUzRMZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fBNOnwS6; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fBNOnwS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnWbr4XrZz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Jan 2026 17:10:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767939047;
	bh=vRFQQUj7n/i2ZiWtqXly1x4ZWNMsf/8vSdo3mxivNNk=;
	h=From:Date:Subject:To:Cc;
	b=fBNOnwS6DvYHhp8uGDM5eJ3t7NS2jPjupsbF96O4/++BbjOYqovpIOqhHrTLJxRwL
	 7q0Dnu0XYjGttwIA4f50USyYylBe8SgAnBglGAtDSpFz7VIjcRKhmOuyCO22Kh74Pg
	 qHFDjQa1LsmwjMV7eDduiiW7Wj0LRWMANSkck5pmik/1dXlaqhz08VTVJuulF1/YSJ
	 ITy1VDbE4r97CCOvfcvKQKHlSIgr+z+h1Y154GUqqoFqj5Hlzhl0pcLj1VW0o6xx9S
	 X5O9BjHf8IKe18UwvNkU0s1QPlUP6JnzTnE9vELDlJMt6GmrR2Uyo7l54Q5rV4KnPR
	 dAJtRY4Ez/7GA==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8A9037E142;
	Fri,  9 Jan 2026 14:10:45 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 09 Jan 2026 16:40:28 +1030
Subject: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to DT
 schema
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
Message-Id: <20260109-dev-dt-warnings-hwmon-v1-1-f2a84cdb0e1b@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIANObYGkC/x3MQQqAIBBA0avErBtQo6KuEi0kx5pFU2hkIN09a
 fkW/2eIFJgijFWGQDdHPqRA1xUsm5WVkF0xGGU6pdWAjm50FyYbhGWNuKX9EPSqteRM0y69htK
 egTw//3ea3/cDy3wDc2cAAAA=
X-Change-ID: 20260109-dev-dt-warnings-hwmon-f05aed235c71
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.3

From: "Rob Herring (Arm)" <robh@kernel.org>

Convert the ASpeed fan controller binding to DT schema format.

The '#size-cells' value is 0 rather 1.

Some users define more that 8 fan nodes where 2 fans share a PWM. The
driver seems to let the 2nd fan just overwrite the 1st one. That also
creates some addressing errors in the DT (duplicate addresses and wrong
unit-addresses).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Hello,

This change has been on a bit of a journey[1][2] and was eventually
integrated into my RFC series tidying up the AST2600 EVB at [3]. Rob
did some further digging at [4] and I've now addressed his finding
there.

Much of the series at [3] was merged so I'm splitting out what remains
and peeling off the RFC label after making necessary fixes.

Guenter - I've included your A-b tag from [3], but as I'm sending this
to be applied through the hwmon tree, do with that as you please.

Changes since the series at [3]:
- Update #cooling-cells to 2 based on Rob's observation at [4]

Cheers,

Andrew

Link: https://lore.kernel.org/all/20251029185448.2121857-1-robh@kernel.org/ [1]
Link: https://lore.kernel.org/all/20251205144929.GA76422-robh@kernel.org/ [2]
Link: https://lore.kernel.org/all/20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au/ [3]
Link: https://lore.kernel.org/all/CAL_JsqJUaKKsJ8BCNbVXe4vLVsQ2Av7VuWqf9DnUKHeLzLb8NQ@mail.gmail.com/ [4]
---
 .../bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml   | 106 +++++++++++++++++++++
 .../devicetree/bindings/hwmon/aspeed-pwm-tacho.txt |  73 --------------
 2 files changed, 106 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
new file mode 100644
index 000000000000..ca6e2d67ddbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2400/AST2500 PWM and Fan Tacho controller
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+description: >
+  The ASPEED PWM controller can support up to 8 PWM outputs. The ASPEED Fan
+  Tacho controller can support up to 16 Fan tachometer inputs.
+
+  There can be up to 8 fans supported. Each fan can have 1 PWM output and
+  1-2 Fan tach inputs.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-pwm-tacho
+      - aspeed,ast2500-pwm-tacho
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#cooling-cells':
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  '^fan@[0-7]$':
+    description: Fan subnode
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: PWM source port index (0 = PWM A, ..., 7 = PWM H)
+        maximum: 7
+
+      cooling-levels:
+        description: PWM duty cycle values for cooling states
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+        minItems: 1
+        maxItems: 16  # Should be enough
+
+      aspeed,fan-tach-ch:
+        description: Fan tachometer input channel
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+        minItems: 1
+        maxItems: 2
+        items:
+          maximum: 15
+
+    required:
+      - reg
+      - aspeed,fan-tach-ch
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    fan-controller@1e786000 {
+        compatible = "aspeed,ast2500-pwm-tacho";
+        reg = <0x1e786000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #cooling-cells = <2>;
+        clocks = <&syscon ASPEED_CLK_APB>;
+        resets = <&syscon ASPEED_RESET_PWM>;
+
+        fan@0 {
+            reg = <0x00>;
+            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+            aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+        };
+
+        fan@1 {
+            reg = <0x01>;
+            aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt b/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
deleted file mode 100644
index 8645cd3b867a..000000000000
--- a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-ASPEED AST2400/AST2500 PWM and Fan Tacho controller device driver
-
-The ASPEED PWM controller can support upto 8 PWM outputs. The ASPEED Fan Tacho
-controller can support upto 16 Fan tachometer inputs.
-
-There can be upto 8 fans supported. Each fan can have one PWM output and
-one/two Fan tach inputs.
-
-Required properties for pwm-tacho node:
-- #address-cells : should be 1.
-
-- #size-cells : should be 1.
-
-- #cooling-cells: should be 2.
-
-- reg : address and length of the register set for the device.
-
-- pinctrl-names : a pinctrl state named "default" must be defined.
-
-- pinctrl-0 : phandle referencing pin configuration of the PWM ports.
-
-- compatible : should be "aspeed,ast2400-pwm-tacho" for AST2400 and
-	       "aspeed,ast2500-pwm-tacho" for AST2500.
-
-- clocks : phandle to clock provider with the clock number in the second cell
-
-- resets : phandle to reset controller with the reset number in the second cell
-
-fan subnode format:
-===================
-Under fan subnode there can upto 8 child nodes, with each child node
-representing a fan. If there are 8 fans each fan can have one PWM port and
-one/two Fan tach inputs.
-For PWM port can be configured cooling-levels to create cooling device.
-Cooling device could be bound to a thermal zone for the thermal control.
-
-Required properties for each child node:
-- reg : should specify PWM source port.
-	integer value in the range 0 to 7 with 0 indicating PWM port A and
-	7 indicating PWM port H.
-
-- cooling-levels: PWM duty cycle values in a range from 0 to 255
-                  which correspond to thermal cooling states.
-
-- aspeed,fan-tach-ch : should specify the Fan tach input channel.
-                integer value in the range 0 through 15, with 0 indicating
-		Fan tach channel 0 and 15 indicating Fan tach channel 15.
-		At least one Fan tach input channel is required.
-
-Examples:
-
-pwm_tacho: pwmtachocontroller@1e786000 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	#cooling-cells = <2>;
-	reg = <0x1E786000 0x1000>;
-	compatible = "aspeed,ast2500-pwm-tacho";
-	clocks = <&syscon ASPEED_CLK_APB>;
-	resets = <&syscon ASPEED_RESET_PWM>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
-
-	fan@0 {
-		reg = <0x00>;
-		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
-	};
-
-	fan@1 {
-		reg = <0x01>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
-	};
-};

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260109-dev-dt-warnings-hwmon-f05aed235c71

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


