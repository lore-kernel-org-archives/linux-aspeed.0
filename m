Return-Path: <linux-aspeed+bounces-206-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B8E77180
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 16:00:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8HH444Vmz30W0;
	Fri, 13 Dec 2024 03:00:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734019200;
	cv=none; b=WcAZqaKnchkEZqwR1y5+O8NUQYaV84PVaUuR/vm70ceonHAH7/OrfPm87D8uAr4HfdB9lKjwRwEhJfCP6HqrMt6YLyu8PKjV4totugjAYAv8viEgDc8EWfMq4vrb/rp/pkskCwkxM8+65LUzW6HtnaZPf270Gs2SPJIOl6FGVdPU67YHeumKxsnuQ4NZ+tePycPk5zoX3/yWwf3S19sSzAtvqwDhHDc8/o+3inrQSW3GuhIpbxcsA8VXJcZ6yeRjTRawkFlsirVfJMRXxd4aB9Nh+advZobOd+wXxx7smHuoIcKqCDglNS7EXGUv2fkEmisslySHCWVP1pHNjdyiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734019200; c=relaxed/relaxed;
	bh=03bRo/yex2pHmpYEtRlqRJRwqxt6KMLPLLG0WvNWhYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FavEH0ByqwfRK1rsbLnbqjUGWlLZ8lozNIS2iwX+dwQQJKO2l9sbGvvD6Ar6tgE/X0sZNH6vo3IjGzIahSPeY1RG0fl8bG+NLReSVinLT6rv5wkWGomQ8xxb5O5SraqKkzvxkNj/2F5PGRIz8cdD8+3RqVOr1Zj8b0KPZs1vzXn9Li+VR2wSCfYdUqYR3TymBBO2flahec9uBnAWdMLiSPrtANmfGeRGRIE2Ws1XXixB/k+cnqchLecbFSktcC7Wj12g9OjXSO7rI4K5VUJTB4nDwYDbbiPL4kSpHAZrf22C0en2dluUMBBdZpcPJdh04Yp+x92NDhS1TFEaDf8T+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8HH33g8Vz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 02:59:59 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine size/interrupt-cell usage.
Date: Thu, 12 Dec 2024 23:52:31 +0800
Message-ID: <20241212155237.848336-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

1. Because size-cells is no need to use 2, modify to 1 for use.
2. Add minItems to 1 for interrupts for intc1.
3. Add 1 interrupt of intc1 example into yaml file.
4. Add intc1 sub-module of uart12 as example using the intc0 and intc1.
---
 .../aspeed,ast2700-intc.yaml                  | 60 +++++++++++++++----
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..eadfbc45326b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -31,6 +31,7 @@ properties:
       type as defined in interrupt.txt in this directory.
 
   interrupts:
+    minItems: 1
     maxItems: 6
     description: |
       Depend to which INTC0 or INTC1 used.
@@ -68,19 +69,52 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
+      #address-cells = <2>;
+      #size-cells = <1>;
+
+      intc0: interrupt-controller@12100000 {
+        compatible = "simple-mfd";
+        reg = <0 0x12100000 0x4000>;
+        ranges = <0x0 0x0 0x0 0x12100000 0x4000>;
         #address-cells = <2>;
-        #size-cells = <2>;
-
-        interrupt-controller@12101b00 {
-            compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <2>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        #size-cells = <1>;
+
+        intc0_11: interrupt-controller@1b00 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0 0x12101b00 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
         };
+      };
+
+      intc1: interrupt-controller@14c18000 {
+        compatible = "simple-mfd";
+        reg = <0 0x14c18000 0x400>;
+        ranges = <0x0 0x0 0x0 0x14c18000 0x400>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        intc1_4: interrupt-controller@140 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0x0 0x140 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts-extended = <&intc0_11 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+        };
+      };
+
+      uart12: serial@14c33b00 {
+        compatible = "ns16550a";
+        reg = <0x0 0x14c33b00 0x100>;
+        interrupts-extended = <&intc1_4 18 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+        reg-shift = <2>;
+        reg-io-width = <4>;
+        no-loopback-test;
+      };
     };
-- 
2.34.1


