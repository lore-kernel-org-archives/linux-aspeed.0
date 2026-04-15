Return-Path: <linux-aspeed+bounces-3901-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6061FFA0C2C
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 05:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwTpW6fhbz2yvc;
	Wed, 15 Apr 2026 15:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776230067;
	cv=none; b=g0MUWBK5SKcW02a1YNuss7McZhc308Khm++8m0kNzSIaD0ZHG9fVNtxAGMtj3/MZPg+KhnXoWn8PqsxZjLXnKyTXKub0pqo+mflgYgzy6SZGVipkrkKYY62WI+5WOgtj/X6HjUQIS9IroxwjvrhrTvCKVycb+KCKj05epRwc01kVvKyb+WbwJLOScGgPOcmhSjzy6Akh1BRmsXJVHHp0wzjwE0U2l8NRhcU/JSp1sNPUKrxziqj7YR0+HauiEVGdfS/UKSFZgMt7rVW+K/hs4wIBiVPOER13kZ4YM4Q/YPgYE694LEB/c1nPlZAWwHuyzkRdATu6zPuDRkTY0/Uv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776230067; c=relaxed/relaxed;
	bh=STJAl7wXaNQ6k8TO/+hSgpxV0U1VI73STBDnby4HnXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oUue2wzozs/3iNWgTp+NCnYVhucqhEwJyToypd4ItCQy9Xgfw2Fz+zBQ3K80MzIFDdB7lJtJ0NH8r3jM148prf3JMMDFQtgwBPDYwvoV5+5/3sdEd3G3Si57PUr4EgDqTbMSh6xk4xAYVtaZpafYSJQJgN+/pIWo0hnpOj+3zaA5ZqjXM/67nPSYckLdevHODAdO0U7/Uzlkz1c1TjhyLBZdWFbhniHtzfUm/EBcbse1bzoTEbgFJm2EGlQCT9cUprllSqoKkyhnL7UeQY39YAh5OE7RSOUvhjfDPghuL1lXV0FSR5BRMa6y/cBJIjnF/VYwJq37WEKjUUny+nGJuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwTpW0dylz2ywS;
	Wed, 15 Apr 2026 15:14:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Apr
 2026 13:14:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Apr 2026 13:14:02 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 15 Apr 2026 13:14:03 +0800
Subject: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
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
Message-ID: <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>
References: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
In-Reply-To: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776230042; l=1666;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=NmCmiK6YACW7DFUncYOCMnn2CaKWPMjJD5hpa+pnJI0=;
 b=bGI32w39zOlRy9jRcS6+dr7tihXqYjV1b65Nm2t4a3D352zvDWCeKZLHgMau2Vl6ykGMNi3+Z
 wsuJSXIxDD5ABVIPCzx28RcBaBDZmjEF5eF/od4OGlvyXA78NmwBq+z
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the aspeed,global-regs phandle to reference the AST2600 global
registers syscon node, containing the SoC-common I2C register set.

These properties apply only to the AST2600 binding. Legacy DTs remain
unchanged.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v29:
- remove aspeed,enable-dma properties.

Changes in v28:
- update commit message correspond with aspeed,enable-dma.
- remove aspeed,transfer-mode and add aspeed,enable-dma property and
  description.
- Fix aspeed,enable-dma description to reflect hardware capability rather
  than software behavior

Changes in v27:
- change aspeed,transfer-mode to aspeed,enable-dma.
---
 Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index de2c359037da..0c769efb76a5 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -37,6 +37,12 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the i2c global syscon node, containing the
+      SoC-common i2c register set.
+
 required:
   - reg
   - compatible
@@ -59,4 +65,5 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
     };

-- 
2.34.1


