Return-Path: <linux-aspeed+bounces-2692-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2517CCF9EE
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 18:54:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxbyp2ZX2z2yG3;
	Thu, 30 Oct 2025 05:54:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761764098;
	cv=none; b=ggNlyc6AdOk1y7BxlhXXdwMWpFQ36BXVUIfzi0VBdV1ifKfZg4xjaOX6UuU8PJxWNz/GLlfcfrSw9BhKPdIRGTCreRwbdM/oefct9YVI56WsbnZ2zxlc6PDHlhx6MzLdLhPGnPxEmGRuutCbVhPs7pgtrwWtj6MZIMYY4zi4yApyx14jRkFqoijXYGWd1ZGLVT2gMwYmLtVxzFm1X/aggFeZnCMJdN5RGKU0boDHseZTgK/eL/g9ppNHcjd8chR+OsIs2265CLueCaktDww3tYv+4erPK+QO96JpYmOKIQVCDW16SaA5zB98LIJdz8GU+xova7q/uzfHlypohFjKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761764098; c=relaxed/relaxed;
	bh=YsBOpAAqa1N3JbCYBbVWgB5n+zm6R9AZZTXVVHL0rwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTFm7Kbuio/ZeMmAiZ63D5Ftr82rRoxIcAHETqJ5D22rorcB+Y6RvmxjPETDUbMgvFbyhmJDzhqksY/LeP4X4V6cP5D0wy3TK+okFqyQII5kp3Sxf6pfgD9/rRK4D1ZKw760WJIb7UUe+8Qpq9btCpgTEFP8Zjwkmy7zFv1yvJzO2LMSRaXUUnQB+JoEgudHjVcVAGQ0fxDzf8RC7e09htodi2MIlApPLpLsjfprzeOuMurlojaQVVgYms99MklfXYgyjDpRf2hBOsgXimnNa+WDMK5VXpecZi0cW8GybG4XK3srUQnyCY7nuVGdtNB/cD64cQx2mLxKKsEYV7me7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sVS4zzVo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sVS4zzVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxbyn1snKz2xsq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 05:54:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E3B241AAF;
	Wed, 29 Oct 2025 18:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7164C4CEF8;
	Wed, 29 Oct 2025 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764095;
	bh=Ux2ENO/i6V+guiQo5qhqzoW+zBs4ctUVICsR7hoAkmM=;
	h=From:To:Cc:Subject:Date:From;
	b=sVS4zzVoWEbn3QNcolgohy69sS19mV2rlckr+Nb1zlcn94jHeFxnwQuWxg2DHk6BR
	 igkJp82NMhShSfHOAPUq24eD+mGpH0QvxJv5r2lWjm9GKBe3az64cj9fhB0eZGaidy
	 GtcLGhr4poM+za/wWzkLrP2at6lO0Bhu58WHOlV5yNHL7cswjeNgNX3vOkTdBy11BH
	 Ax2+WrZY59Ww4m0riErBCGxbdr7U53xiZeruL+TohdZjmleelKKid3663ihTaWc/NG
	 rHGxe2y6yJMfGcbI6AGlNEtck/TQC+G2RhMfqKzDX1qVj1LKBNW/oR+U+dQTVXGUbX
	 aBEXlLI3AR2jQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to DT schema
Date: Wed, 29 Oct 2025 13:54:47 -0500
Message-ID: <20251029185448.2121857-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit

Convert the ASpeed fan controller binding to DT schema format.

The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
rather 1.

Some users define more that 8 fan nodes where 2 fans share a PWM. The
driver seems to let the 2nd fan just overwrite the 1st one. That also
creates some addressing errors in the DT (duplicate addresses and wrong
unit-addresses).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../hwmon/aspeed,ast2400-pwm-tacho.yaml       | 105 ++++++++++++++++++
 .../bindings/hwmon/aspeed-pwm-tacho.txt       |  73 ------------
 2 files changed, 105 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
new file mode 100644
index 000000000000..018249f97a5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
@@ -0,0 +1,105 @@
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
+  The ASPEED PWM controller can support upto 8 PWM outputs. The ASPEED Fan Tacho
+  controller can support upto 16 Fan tachometer inputs.
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
+    const: 1
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
+        #cooling-cells = <1>;
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
-- 
2.51.0


