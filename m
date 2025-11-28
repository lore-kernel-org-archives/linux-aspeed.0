Return-Path: <linux-aspeed+bounces-3015-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECC8D116F6
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Nov 2025 00:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHYzZ2c3Fz2yvD;
	Fri, 28 Nov 2025 11:27:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764289674;
	cv=none; b=Ds1WC4kLwx1r11/g2UG+ykRW5xoP+bNSLYtyq8su39i+iVq+xQ/84U4yUq1THfALrlW/QJbr58boCF+s/ErX52vECQP/N/x8uLMR+O6KRZChBWYLGeXQ7brxNa/AV9ZZDMkrQhGUO1MCGEJKqP177nYvEStw6M2czChFwTTUZn7AXsNF71DlQQUDfEpd2XvGQUPRqbV/EoEcugYa5OtUf38lW5sQr60D9kxp9nF/OBdHvXvk8+4eyFrmfowaPWeNvmWDrApOWzUCh6yAlB/dc6eq+8/JFlaJJEXgNyNQnIaA2bt6MwOoC5ORjJ+kbxgmDn8e02gnIh86DqVi60VUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764289674; c=relaxed/relaxed;
	bh=RKcCwwCRe4Td+QbPJzIZf+orW5JDnnyWAr8yiknjLA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ap2GuXVMUyQV2GhDSa2UnevN5cxkUi37XSO9E5P1jVJIJKYEVQhOkzXtwLiRnoBienyea1uT4qNh2WbR76UCurKnm/f4zySM1GsYVsBo+jjVBtLKeNcR4rfacaPdrJOBNSTBr3NGOaaJ60OYwybIb2b/GF3nhnF7w3BB3JXD6rxvPGh0qb0kBzIbb3oo4+NK+EPG00l2pJaLS9DuklqABWyKlKj8XAODHueH35w1NQKxC8OM6HDy1h1mfzgHXwiwuvN1+jzMr/yd9OBkK3t2Ftgynx+NzHEP4k6OyjjXX6wTXksBFPrFKbZcA1usTvGOZoM33pIgeFxDRXxmKFSt/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHYzY5gK1z2yFT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Nov 2025 11:27:53 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 28 Nov
 2025 08:27:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 28 Nov 2025 08:27:34 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 28 Nov 2025 08:27:30 +0800
Subject: [PATCH v2 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
 support
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
Message-ID: <20251128-upstream_vhub-v2-1-1fa66a5833c2@aspeedtech.com>
References: <20251128-upstream_vhub-v2-0-1fa66a5833c2@aspeedtech.com>
In-Reply-To: <20251128-upstream_vhub-v2-0-1fa66a5833c2@aspeedtech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764289654; l=1845;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=rHhaKj8gv7+Qbhqwp9C1BhoCdFoga26doEIHEcEHt24=;
 b=jH+dOWj6JNSZPqM2w11PcC1CvWoBV1OvZI8jZk8o66+YsIEjsINZM5OEsEv+x97WocFe8fItI
 ewxRui6nq2LD8hbA8zd6aZRwaQQk7odUEh/8YNQhZyTzd/+Z+7dNiCh
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the "aspeed,ast2700-usb-vhub" compatible. The ast2700 vhub
controller requires an reset, so make the "resets" property
mandatory for this compatible to reflect the hardware requirement.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
index 7f22f9c031b2..b8bac2cce949 100644
--- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -17,8 +17,8 @@ description: |+
 
   Supported number of devices and endpoints vary depending on hardware
   revisions. AST2400 and AST2500 Virtual Hub supports 5 downstream devices
-  and 15 generic endpoints, while AST2600 Virtual Hub supports 7 downstream
-  devices and 21 generic endpoints.
+  and 15 generic endpoints, while AST2600 and AST2700 Virtual Hub supports
+  7 downstream devices and 21 generic endpoints.
 
 properties:
   compatible:
@@ -26,6 +26,7 @@ properties:
       - aspeed,ast2400-usb-vhub
       - aspeed,ast2500-usb-vhub
       - aspeed,ast2600-usb-vhub
+      - aspeed,ast2700-usb-vhub
 
   reg:
     maxItems: 1
@@ -33,6 +34,9 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
@@ -107,6 +111,20 @@ required:
   - aspeed,vhub-downstream-ports
   - aspeed,vhub-generic-endpoints
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-usb-vhub
+
+then:
+  required:
+    - resets
+
+else:
+  properties:
+    resets: false
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


