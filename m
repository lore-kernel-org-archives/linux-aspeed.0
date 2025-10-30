Return-Path: <linux-aspeed+bounces-2700-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D6ACCF9EA
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 06:02:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxtmj4yNYz30V1;
	Thu, 30 Oct 2025 17:02:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761804133;
	cv=none; b=jFT13bssEKspLLS8xx89Pw71/xkO38ni3bGa01rVDKFwxE3K6HRxYqP4eaLeQaRdV9GdNsKFW8TOOI8Yx7T4Hbw2BPRM2ILZRxG+0wW4J7fhX6YKhyw/rF8dqx5A13oOiFFVY3sFqqQ4a8OZt/T/XawLsZBCTnSgJrBwqI9zzTL8tw5XT97tqw7PS4PkH23F+IKjA8m8VmWiKR2zrJqt7PKCxac8En4HRRWtRL5PYwdtussL5xtnEsAuSaui3qdT+ZCqDzQxel4DlF5rX78YUF5k72QZmnzozhoBGdDbh8SP/1Y5FGr9aDSUaX1eA6CMzkAN5GQuRP4U/DaPgHv0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761804133; c=relaxed/relaxed;
	bh=alhH5QaYTWa/mI8EEvA4Rm0NZmF52xRpzaz5Q8pj900=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZnun8J0Kz4hj1Pu9muwdE5uUcZjgkm8muq3ErWYTSj1h1aRhECkZVRqmOWodAUrMVeGPExga3COElbMcRQEH0vRQhj/kVgUCchhkiYkkFRvKRDOSwNJG43s3DBc7yOCY8Ywq8DNDOiMgCo2jXGXBnyfO4LHBIsdC7C41zSakKHRJKp5Vh80vxhFPjepRXl/ReW4yAG/IDQNgouy30N2FW8o7ce88m2JKeDZ+iEV5yoNTzJwVZvNWIADOUwF6L6H+tDlTkFFA/G9sxuXeAXegNPfJLRbKx6MWjiz3IoT1ua/dUGj0xwjGUelQAm9zaHrs7vkxw+AxD9coXQwqm0R0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxtmj1NgWz2xsq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 17:02:13 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 30 Oct
 2025 14:01:55 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 30 Oct 2025 14:01:55 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v6 1/1] dt-bindings: interrupt-controller: aspeed,ast2700: correct #interrupt-cells and interrupts count
Date: Thu, 30 Oct 2025 14:01:55 +0800
Message-ID: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
References: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain

Update the AST2700 interrupt controller binding to match the actual
hardware and the irq-aspeed-intc driver behavior.

- Interrupts:
  First-level INTC banks request multiple interrupt lines to the root
  GIC, with a maximum of 10 per bank. Second-level INTC banks request
  only one interrupt line to their parent INTC-IC. Therefore, set the
  interrupts property to allow a minimum of 1 and a maximum of 10
  entries.

- #interrupt-cells:
  Set '#interrupt-cells' to <1> since the irq-aspeed-intc.c driver does
  not support specifying a trigger type; only the interrupt index is used.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../interrupt-controller/aspeed,ast2700-intc.yaml   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..999df5b905c5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -25,13 +25,14 @@ properties:
   interrupt-controller: true
 
   '#interrupt-cells':
-    const: 2
+    const: 1
     description:
       The first cell is the IRQ number, the second cell is the trigger
       type as defined in interrupt.txt in this directory.
 
   interrupts:
-    maxItems: 6
+    minItems: 1
+    maxItems: 10
     description: |
       Depend to which INTC0 or INTC1 used.
       INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
@@ -74,13 +75,17 @@ examples:
         interrupt-controller@12101b00 {
             compatible = "aspeed,ast2700-intc-ic";
             reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <2>;
+            #interrupt-cells = <1>;
             interrupt-controller;
             interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
-- 
2.34.1


