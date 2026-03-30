Return-Path: <linux-aspeed+bounces-3804-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF6EF3D5E8
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 08:22:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkkkQ64Pwz2ygf;
	Mon, 30 Mar 2026 19:22:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774858926;
	cv=none; b=D3CXAANJQ1/7+1DXwLdPiEJ8sj+wXnO1gjjgfd2YJcjK1WcJOGcIURb/6mDirNCKu/Eh7dyvB1oJqP4JAOhfuW/XNzgNIwbwhqNXaGSEL2/bHiXYKz11Rd8DJ7S2AKTZrJNDX6ueGi57d1LElSn41p0Yu//acd7gicfKefwKD5gzyPOcOjLxAx/2yNoeYlX2pyxc1KLKiURz5nH4WEfS3GKo8kMhF/eBiQUY9FDfKa7EB+Y2/XL38RxlsXkc/KaCu8IklEE9kVWSBK8huas11qMwYxiMll3idP2iuI3h8fkuS5DJUUOzqajHOnk8pA/3JhOdI19MOEkkiO28Ng4K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774858926; c=relaxed/relaxed;
	bh=Gb1OEmdc6nHnegssDa+XgzmRMUmtqiRcJwYrGyz0B+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TGG5M+DWMenaTZNIb77CFLIN5QTGGUO4J1Z5XAWk7IycNyh112KPg+BwjUUJ8fS+f0fy1DmeQCSdB3Ll7YfjNTVMkOByPhB9Hr3FkjD3Wq6frlWmqGQCvJMVxWWCcbgwBk74C15H7WJ6dWVa5R7z9aWfLZ+ZEd9l5oSaE7fFYfvOneBEuGw2wF6Ic0cksMKh6C4E9Cwo2babJDl6q+xhLm5EyLQk0kpMq5XeikM04VP50jjAlcCIfQqIRwOnbhmsb8ytcjIlzZxV+tdb7qzrZVAjngYI+PiflWK0s94cA5h8i32uqufsh3v+gqngCvNCHWTF3Dpd6W+3veGbNr0Ecw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkkkQ07K4z2yhP;
	Mon, 30 Mar 2026 19:22:06 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Mar
 2026 16:21:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 16:21:47 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 30 Mar 2026 16:21:47 +0800
Subject: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
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
Message-ID: <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
In-Reply-To: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774858906; l=1878;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=Z2AXlRcw8rroVI4rnpHgF+99FZI/yNPMg8RNUT8tbwc=;
 b=mRu3dj7XE8wlOn99k+9o1IjAAtiPtC4krH7vcIPJvKLUcC8Mo/TQob7qLzxbb10+44H3WcEbG
 O1gXVUoJBpIAqYXpj+1/h707e1Uzv7zRg1QBWHqw1f7Awi/EM2OCbhU
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add aspeed,enable-dma boolean property to indicate that DMA is
available for transfers on this I2C bus.

Also add the aspeed,global-regs phandle to reference the AST2600
global registers syscon node, containing the SoC-common I2C register
set.

These properties apply only to the AST2600 binding. Legacy DTs remain
unchanged.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v28:
- update commit message correspond with aspeed,enable-dma.
- remove aspeed,transfer-mode and add aspeed,enable-dma property and
  description.
- Fix aspeed,enable-dma description to reflect hardware capability rather
  than software behavior
Changes in v27:
- change aspeed,transfer-mode to aspeed,enable-dma.
---
 .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index de2c359037da..67b23d1a4cec 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,enable-dma:
+    type: boolean
+    description: Indicates this I2C controller instance has DMA capability.
+
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the i2c global syscon node, containing the
+      SoC-common i2c register set.
+
 required:
   - reg
   - compatible
@@ -59,4 +69,6 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
+        aspeed,enable-dma;
     };

-- 
2.34.1


