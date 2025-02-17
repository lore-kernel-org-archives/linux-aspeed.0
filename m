Return-Path: <linux-aspeed+bounces-754-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824EBC021A9
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 11:48:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxLXR1cyrz30Nl;
	Mon, 17 Feb 2025 22:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739792935;
	cv=none; b=AMwhGFvYcCqFxHlL5oP8mbuSoPFpkjW5NkU76ttfUOluZ5BqYjBrDWR2WbOuq8V+RfpT0pn44R9jfOSAlV1PV0FXJocfCIyiVnsoGS3EWF+K9aoFFHrLVik4+X5u/KARk34ceQoXAPS7sSJCvw0B9r2antwmmVeLhS9MTozFxk6Emw/nhjB5r45eOuoS04Ry9nK6PLcFaVUjywtMkZKf+4IWhIUalwWRy9rmne75vMkI1QOAAix1IgdPfmjXMZmhCKlUJDR1nVWx/S08JI6LaaVjPzk8kGxlJ0/aVY1dcE4c/WLOAA6gIcLc9nemOpuF8bf9xfttXOxOrYT2lQrlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739792935; c=relaxed/relaxed;
	bh=c24ZfnpXfvzqiy+e9d45Tbyw532eKgHdJFd17rEpGcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEbbqpf2vHCUVqfFZm+2Uy7IjkfyTuBwyDVIHeQ7rZFkMHtZmVfpl9re7YoSZVrhRUcegxAzHCS5QgtsskHMXibwOhp9DiDivt5PaUHoZsc9fzS7avWRzg1zqX8rewP7q7wTW2VDb723CNSuCdVQDfi9y2yTmV9FYoQDvpxLGZK6owZIfIXXtjCtkiwQB4bnpRl7Mha7kiHIHpAqpC7FVRjIaTq034rIOweIfGsN4PvJWGjCRQGeb1WRnzmEBtK4zuDnZuIK1mJCmYiokzcsJXmYjfdsPy8sa3eun9WT56yKsxgHtVj4HCyBPrpLMuKuTYtIHhfVv/QDMvPd1JDMbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxLXQ4z0Wz3093
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 22:48:54 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Feb
 2025 19:48:33 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Feb 2025 19:48:33 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<chiawei_wang@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v1 1/3] dt-binding: aspeed: Add LPC PCC controller
Date: Mon, 17 Feb 2025 19:48:29 +0800
Message-ID: <20250217114831.3225970-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
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

Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index 5dfe77aca167..367847bd7e75 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -149,6 +149,35 @@ patternProperties:
       - interrupts
       - snoop-ports
 
+  "^lpc-pcc@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      The LPC pcc interface allows the BMC to listen on and record the data
+      bytes written by the Host to the targeted LPC I/O pots.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2600-lpc-pcc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      pcc-ports:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: The LPC I/O ports to pcc
+
+    required:
+      - compatible
+      - interrupts
+      - pcc-ports
+
   "^uart-routing@[0-9a-f]+$":
     $ref: /schemas/soc/aspeed/uart-routing.yaml#
     description: The UART routing control under LPC register space
@@ -176,6 +205,13 @@ examples:
         #size-cells = <1>;
         ranges = <0x0 0x1e789000 0x1000>;
 
+        lpc_pcc: lpc-pcc@0 {
+            compatible = "aspeed,ast2600-lpc-pcc";
+            reg = <0x0 0x140>;
+            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+            pcc-ports = <0x80>;
+        };
+
         lpc_ctrl: lpc-ctrl@80 {
             compatible = "aspeed,ast2600-lpc-ctrl";
             reg = <0x80 0x80>;
-- 
2.34.1


