Return-Path: <linux-aspeed+bounces-1182-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A81C3ABAA
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 May 2025 14:46:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zrkqb2vB2z2yr2;
	Tue,  6 May 2025 00:46:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746456379;
	cv=none; b=asTO9kkQhpTb2Lslt5JTrTwzD+u1Xhs/EELC1jiMx7t+CCAjCKo1Gvr2Tg01/nLfqw7asWsgkB5XCJDEEeBc4oUgF3biZn2eXfkc+0+Tp8cKBl7zGvy6esSWSn9W9OVUF+PHN1GCGtcg7yfYuquocvyAlC8zR8/aei3Sq2/Y0ljPCIDK0sUquxgDC/AJJdnHHxoIDIPkptTM8H/Px48rOmQT8XZHdtTFwWmGjsEiJ0hqqcmiNx+gDJXpv1w4Ld4vCn7M2VDHV7BdKTyHhPG0rbj6TghkrmNauq6ZD06GRQWuw7C/GbdhgK9mBHi0VlxMDiSVhGqvsSeaITGLdbfdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746456379; c=relaxed/relaxed;
	bh=iTBTgsz+Ilutml5RH24YXByNyxuquONZJQpFMgadR/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbYhgrNsZpAX8WKTmz+29scz/+QQZ97BxZCDpJnlwCE+OUPnGZonGVQh/2OoxRzjW/Yi3uO5Sb7PrGT+Z5jkTFskfSZqDUY6USXaZ+nDke1eELPGGl6SOjr4+mIsjQYwdsxwSJuX2rov+JHGsTzBBbOsCTNItL9h0GwRSdWsKc8gm+4p5Mtb5sis5aJy/0m9QySKv61a65hQ42/BtR4xQNEzyVGxcT2/z2fr7Fc4n5Zt23OSl7JhWdpy5q/VP3z2G0O7+JZvFQknYNNCTEY/+TFfkn2GMSp/XDYW700fOjjxFOVxsYTh4cT6QX/vC9qtG2v9bTP/HRqswfvQ/jbPDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BkWSzRYI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BkWSzRYI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZrkqZ40d5z2xVq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  6 May 2025 00:46:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B8E66135E;
	Mon,  5 May 2025 14:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35837C4CEEF;
	Mon,  5 May 2025 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456376;
	bh=4bDA+VU4HKiAdPSG7pDQ7lpUmXsZe5SALIM6IjFpDmY=;
	h=From:To:Cc:Subject:Date:From;
	b=BkWSzRYIoY22w53CdjXaPfov8jjMYYJQ3D3fok+SjanF80LxfaYknu7A5Rx9Q2/Nk
	 FK+gSdYkE+3vbSUZlVf3fL5dYlfwjy8/3yrNgSNiPQS17geHLJtuiiUTUXMnM8JAi1
	 3Ew71fC6N7Dt4K+6Y3aN/HuwKu81iwUfQjabkWU5/UwJOw3//EP24jA52XJOCNwztq
	 l57OQvVoXXHmu1qmnTwdZ9EUACab6g28wKUCCjjes6f85zhK428gS6vaKe5s0tTrDC
	 M71U+bbIWDyqBMZiOw666hfCM834ZaIhy2PZRy8HGbMQ6hmGFielO/zIMMOx9Ka4Na
	 rhOBXLbs8M2LQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert aspeed,ast2xxx-scu-ic to DT schema
Date: Mon,  5 May 2025 09:46:11 -0500
Message-ID: <20250505144613.1287360-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
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

Convert the Aspeed SCU interrupt controller binding to schema format.
It's a straight-forward conversion of the typical interrupt controller.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../aspeed,ast2500-scu-ic.yaml                | 48 +++++++++++++++++++
 .../aspeed,ast2xxx-scu-ic.txt                 | 23 ---------
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |  9 +++-
 MAINTAINERS                                   |  2 +-
 4 files changed, 57 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
new file mode 100644
index 000000000000..d5287a2bf866
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Eddie James
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-ic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2500-scu-ic
+      - aspeed,ast2600-scu-ic0
+      - aspeed,ast2600-scu-ic1
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - interrupts
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@18 {
+        compatible = "aspeed,ast2500-scu-ic";
+        reg = <0x18 0x4>;
+        #interrupt-cells = <1>;
+        interrupts = <21>;
+        interrupt-controller;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
deleted file mode 100644
index 251ed44171db..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Aspeed AST25XX and AST26XX SCU Interrupt Controller
-
-Required Properties:
- - #interrupt-cells		: must be 1
- - compatible			: must be "aspeed,ast2500-scu-ic",
-				  "aspeed,ast2600-scu-ic0" or
-				  "aspeed,ast2600-scu-ic1"
- - interrupts			: interrupt from the parent controller
- - interrupt-controller		: indicates that the controller receives and
-				  fires new interrupts for child busses
-
-Example:
-
-    syscon@1e6e2000 {
-        ranges = <0 0x1e6e2000 0x1a8>;
-
-        scu_ic: interrupt-controller@18 {
-            #interrupt-cells = <1>;
-            compatible = "aspeed,ast2500-scu-ic";
-            interrupts = <21>;
-            interrupt-controller;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index c800d5e53b65..12986ebe7ec7 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -48,8 +48,15 @@ properties:
 
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
-    description: See Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
     type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          enum:
+            - aspeed,ast2500-scu-ic
+            - aspeed,ast2600-scu-ic0
+            - aspeed,ast2600-scu-ic1
 
   '^pinctrl(@[0-9a-f]+)?$':
     type: object
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e37f0c14496..a792c5495d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3577,7 +3577,7 @@ ASPEED SCU INTERRUPT CONTROLLER DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
 F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 
-- 
2.47.2


