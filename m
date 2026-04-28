Return-Path: <linux-aspeed+bounces-3968-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E40BFF8868
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4bQH4bvRz2yv2;
	Tue, 28 Apr 2026 19:55:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777370103;
	cv=none; b=mnDmLppJeWUfUKypGf9/7GjeBD0yaRYMj5bOIlwBy9Pmm0PMfO5eh/YScpaJX47sxxfRxtPCDfLDfRBLyjNLNzSPYxhqV17k8WPNswdF9m801zN3xSHoCrM6zneyYySbXLqYMARAH11qRu9CCb7Yq07bmTkUeC0VdrOC8KwxG2LXwXFxTvFp4NAESaUHNd0F6EWRv40dh3yndcxYzBq8TgSih+eVA6tt+agbl2i5TlKljGB/U1mlkdM6fpIOHjg1WGIJu+Q4NXaa1mhclOJDz+iPneU8g8Mwppy5yRfkMSG+dxPq53fAClHp2c7CeJP+bFfZDeyzlqnCi5VN4WbK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777370103; c=relaxed/relaxed;
	bh=EhgW1JlYF9B1Go+gSCZ+kMZnTDafbz710Shygv/ybog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EmEC7KYVNPsPBcU0ur3y9IZCvRMam2FjYWkEY4xh4fdLwgYRdmzw8BxUT9z3P2A38DaQ/fF33rX6GC2MhEYPQB8Sn2ldYpQpqkC8oi6uLYoCfolRX6u+PELQJMj5d7krvq8aRWY6pY+rvdBj2xtQsm8z++9dphG4AB6+iIssmgaTjAbJe6ms3EX6vjIBtuY1MrWbnZeqpJk2rV0mwbbDfyj5QkU4ZvXMfM868tnCAAY0PrUvrk4DJjZpgRotWeeiJyCRLjEtRytG/1PgMMwXWuyKeu3AR8sLJQ7YCIvWNVVM5FPB8DwyKsFumizpU2u1KD3wF+pxOtDs2b3X0ybqmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4bQG6JBmz2ytj;
	Tue, 28 Apr 2026 19:55:02 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Apr
 2026 17:54:42 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Apr 2026 17:54:42 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 28 Apr 2026 17:49:46 +0800
Subject: [PATCH v8 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
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
Message-ID: <20260428-upstream_pinctrl-v8-2-eb8ef9ab0498@aspeedtech.com>
References: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
In-Reply-To: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Linus Walleij" <linusw@kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	"Bartosz Golaszewski" <brgl@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, <linux-clk@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777370081; l=5291;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=mrdhNPya3jJ61yZHR8p2pd3TxVaF8xWbxCDhBpD9L1w=;
 b=qnsT6QW0wFMWJxBnDEcDkCSRh2R9he1t+g4varVLV/zfZVtvlEYCofpsTBarULV55gZbC5j93
 Bfe6McMuKHnDdG1ZH+u+bWwIWcPTWLrSjdOvVFNfmJxbsgRSflJRmHw
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

AST2700 consists of two interconnected SoC instances, each with its own
System Control Unit (SCU). The SCU0 provides pin control, interrupt
controllers, clocks, resets, and address-space mappings for the
Secondary and Tertiary Service Processors (SSP and TSP).

Describe the SSP/TSP address mappings using the standard
memory-region and memory-region-names properties.

Disallow legacy child nodes that are not present on AST2700, including
p2a-control and smp-memram. The latter is unnecessary as software can
access the scratch registers via the SCU syscon.

Also allow the AST2700 SoC0 pin controller to be described as a child
node of the SCU0, and add an example illustrating the SCU0 layout,
including reserved-memory, interrupt controllers, and pinctrl.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index a87f31fce019..0d5e168b0309 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -46,6 +46,18 @@ properties:
   '#reset-cells':
     const: 1
 
+  memory-region:
+    items:
+      - description: Region mapped through the first SSP address window.
+      - description: Region mapped through the second SSP address window.
+      - description: Region mapped through the TSP address window.
+
+  memory-region-names:
+    items:
+      - const: ssp-0
+      - const: ssp-1
+      - const: tsp
+
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
     description: >
@@ -87,6 +99,7 @@ patternProperties:
             - aspeed,ast2400-pinctrl
             - aspeed,ast2500-pinctrl
             - aspeed,ast2600-pinctrl
+            - aspeed,ast2700-soc0-pinctrl
 
     required:
       - compatible
@@ -156,6 +169,30 @@ required:
   - '#clock-cells'
   - '#reset-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2700-scu0
+              - aspeed,ast2700-scu1
+    then:
+      patternProperties:
+        '^p2a-control@[0-9a-f]+$': false
+        '^smp-memram@[0-9a-f]+$': false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: aspeed,ast2700-scu0
+    then:
+      properties:
+        memory-region: false
+        memory-region-names: false
+
 additionalProperties: false
 
 examples:
@@ -180,4 +217,81 @@ examples:
             reg = <0x7c 0x4>, <0x150 0x8>;
         };
     };
+
+  - |
+    / {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        reserved-memory {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            ssp_region_0: memory@400000000 {
+                reg = <0x4 0x00000000 0x0 0x01000000>;
+                no-map;
+            };
+
+            ssp_region_1: memory@401000000 {
+                reg = <0x4 0x01000000 0x0 0x01000000>;
+                no-map;
+            };
+
+            tsp_region: memory@402000000 {
+                reg = <0x4 0x02000000 0x0 0x01000000>;
+                no-map;
+            };
+        };
+
+        bus {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            syscon@12c02000 {
+                compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+                reg = <0 0x12c02000 0 0x1000>;
+                ranges = <0x0 0x0 0x12c02000 0x1000>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+                #clock-cells = <1>;
+                #reset-cells = <1>;
+
+                memory-region = <&ssp_region_0>, <&ssp_region_1>,
+                                <&tsp_region>;
+                memory-region-names = "ssp-0", "ssp-1", "tsp";
+
+                silicon-id@0 {
+                    compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+                    reg = <0x0 0x4>;
+                };
+
+                interrupt-controller@1b0 {
+                    compatible = "aspeed,ast2700-scu-ic0";
+                    reg = <0x1b0 0x4>;
+                    #interrupt-cells = <1>;
+                    interrupts-extended = <&intc0 97>;
+                    interrupt-controller;
+                };
+
+                interrupt-controller@1e0 {
+                    compatible = "aspeed,ast2700-scu-ic1";
+                    reg = <0x1e0 0x4>;
+                    #interrupt-cells = <1>;
+                    interrupts-extended = <&intc0 98>;
+                    interrupt-controller;
+                };
+
+                pinctrl@400 {
+                    compatible = "aspeed,ast2700-soc0-pinctrl";
+                    reg = <0x400 0x318>;
+                    emmc-state {
+                        function = "EMMC";
+                        groups = "EMMCG1";
+                    };
+                };
+            };
+        };
+    };
+
 ...

-- 
2.34.1


