Return-Path: <linux-aspeed+bounces-3923-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD1EF8809B
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 07:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fx8nM2cvHz2ynC;
	Thu, 16 Apr 2026 17:30:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776324647;
	cv=none; b=Qy4KVmrk+z4laWCsulwfZCzJK/P/CicO+pLY0Zg0LTyjazSlU52YNg5fwbtf6DkiIJu/bqLK8m+GSxj2avnZSiwS5RqFxNC4NXPLFhcshe9hQ+SAUy51go/suoR0xgvdjLAsLN9fquyMtMTECSnxFNiVhGvK2Z+Yw8R83HPYgndCmfP0lhkeikoHvQt4TSpyG81w5JkI+ImpHw2Y/P4U8GCd6zwkB/C5WhO0oE0bj7zyxY3epm6PWkbF/FdoJQwG2Te8PbxnBp3NZ5daeQaG5KUiXWkjxtQoD32UpY/Hmk7QmJrL5jW5zayJMocX7V78iiRvb5dQMSox/RgCQLJYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776324647; c=relaxed/relaxed;
	bh=ydQUlSGVDJ3UKH7xRkB0Ji0sOcI35bFu0wtDJfeG9Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Un6crV/IJwiqVJ8JrHDuwvnPKHtbtFZG6F/sX0cMS8bpMfXy+1CpEpFsKbO4llMHCaO+LKbGMAV++Nop6xAZlxZL7tkCnPL9cuofldFOn9/n7aKGMqOIZRbBuYaUTAXkVW4NMqcHrJOxXKgqN645Gkbm0Q11XOphOieQ1tog5gWEnAtmRIeLVEJVJqgbE3XR+mwSv0cZVrq77Xm4VMYWity6xTh/f7vpto975fveg+Q7C/v0xKe9ZWJWRf6lN1AedMTTGwGqNce2juMAyxGwHwg6R5b0FVV9teiD7VYx6IOKfSIFl5PzRpX1qGg/qrJc4HCO1FuFdbMdUjir+kCg7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fx8nL2jzzz2yvc;
	Thu, 16 Apr 2026 17:30:46 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 16 Apr
 2026 15:30:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 16 Apr 2026 15:30:26 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 16 Apr 2026 15:29:44 +0800
Subject: [PATCH v7 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
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
Message-ID: <20260416-upstream_pinctrl-v7-2-d72762253163@aspeedtech.com>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
In-Reply-To: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776324626; l=5303;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=6KEs7OlG92CfANOz1QGj/Gij2ue1APO5MhB7ziqj0qE=;
 b=eVTJqoHgnSga/L7y7lL1Lb+LsMSXnZ0ZjTZl+dWguTNAcFmZS6/Drh7UXo3EsmQFe+geZhWhq
 8A0U1s00IJLBjJLRnQgCb7tfHgey1F5aF8IR0um1LMbnuvE9Ir4QRUp
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
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index a87f31fce019..215ff59b38ea 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -46,6 +46,17 @@ properties:
   '#reset-cells':
     const: 1
 
+  memory-region:
+    items:
+      - description: Region mapped through the first SSP address window.
+      - description: Region mapped through the second SSP address window.
+      - description: Region mapped through the TSP address window.
+  memory-region-names:
+    items:
+      - const: ssp-0
+      - const: ssp-1
+      - const: tsp
+
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
     description: >
@@ -87,6 +98,7 @@ patternProperties:
             - aspeed,ast2400-pinctrl
             - aspeed,ast2500-pinctrl
             - aspeed,ast2600-pinctrl
+            - aspeed,ast2700-soc0-pinctrl
 
     required:
       - compatible
@@ -156,6 +168,30 @@ required:
   - '#clock-cells'
   - '#reset-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: aspeed,ast2700-scu0
+              - const: aspeed,ast2700-scu1
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
@@ -180,4 +216,81 @@ examples:
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


