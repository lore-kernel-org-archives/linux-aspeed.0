Return-Path: <linux-aspeed+bounces-4280-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3A5CDB46F
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 01:17:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknFv2S2Qz2yf9;
	Tue, 23 Jun 2026 11:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782177379;
	cv=none; b=JvIB19tP9JcsmqjbKznzr4Gfcw9+Uy9C5lj1tKyyDEV0McBGFjtBI7JMrTicA+MvMx0qT8Y1lnRZWTXl5U/OjgURtmMGomADxhCapVWyFDWJlXr6HoStEzwqc2wOXmxQuQnMOkDIzkK94ifcCEoo1M/3NmyKdLtqRd7drbmLIGLKDBN32ALLtZEtRziXG3yv2cPASUQkFM9IBuv9QqHz2vkJrdQs4H4mOZsa/ANE9qCbX4+f+tjqDVkWGg0VSGuf+gxvlDlXOOzrYc3nunthbMXNzldDGBWALN/k2TylPRpR3Klqj26KWJs3lgQn8vBLDPxfA12XXEHMhLhsNH8DKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782177379; c=relaxed/relaxed;
	bh=dJ0ypID1O9Q93DezS4iROQXKtdNNTDRs5MtDYM7giKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B87KGqjKSGLxKGDQchGatXsJ96zJeTV1MiIYF3svU6DUzxg1dVJjqOUfareWcufJTtU8a/I8CLPV3qFKMF6nyB7ot4+oA98inHxdWBp0aTz5onk5xHHBMQe7zIiwYU/zLSMigSoAE6v0fQD/QQi1y7zBi29tA6CntTS53Uchub8OnuX8THKrXwSJqF91TcN3VndUQv7tojwbjfbrFzQHULeYLvlqxbjG3kstCuhgxFmsnm+FpNo3ew/VFjLgtuGkbrdYbPjHe+PAYj4+JUiO0eiDX0yNQ5IAAg8NaPyss9ToOVU8fpa2m/Hc2p+DcfJ9hb14iWiR7+oHtUehojkbHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknFt1sGhz2yb9;
	Tue, 23 Jun 2026 11:16:18 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 23 Jun
 2026 09:15:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Jun 2026 09:15:54 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 23 Jun 2026 09:15:52 +0800
Subject: [PATCH v33 3/5] dt-bindings: i2c: ast2600-i2c.yaml: Add
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
Message-ID: <20260623-upstream_i2c-v33-3-6d5338fc56ed@aspeedtech.com>
References: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
In-Reply-To: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782177354; l=3063;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=r2T5rQ6TN/II/E6wQiYvjiwSm3+xG1X8ZJATJXCx5iE=;
 b=t16vyiD/JNqUz/ELVPfVtDMcu/RE3b4r4LvUoW/X9/qKSAFphZeZcex+3dwBuTBJG3HeIf0AB
 b46VNOhSJ2pAH4Ozs1z8yfuXnWtiuqjO69AD+A1ol+aP6tPXNu6tVl+
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the aspeed,global-regs phandle to reference the AST2600 global
registers syscon node, containing the SoC-common I2C register set.

These properties apply only to the AST2600 binding. Legacy DTs remain
unchanged.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v32:
- Add if/then conditional schema: when aspeed,global-regs is present,
  require reg to have at least two items. The new driver unconditionally
  maps resource index 1 (the buffer SRAM region); a DT with one reg
  entry and aspeed,global-regs passes schema validation but fails probe.
  The constraint makes the schema consistent with driver behaviour.
- Fix binding example to use the correct AST2600 clock header
  (ast2600-clock.h) and ASPEED_CLK_APB2 instead of the legacy
  aspeed-clock.h, where index 26 (ASPEED_CLK_APB) maps to the
  UART5 gate clock on AST2600 rather than the APB2 bus clock
  used by the I2C controller.

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
 .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index abc614315dff..eb6e316c112f 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -48,6 +48,12 @@ properties:
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
@@ -55,19 +61,28 @@ required:
   - resets
   - interrupts
 
+if:
+  required:
+    - aspeed,global-regs
+then:
+  properties:
+    reg:
+      minItems: 2
+
 unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     i2c@80 {
         compatible = "aspeed,ast2600-i2c-bus";
         reg = <0x80 0x80>, <0xc00 0x20>;
         #address-cells = <1>;
         #size-cells = <0>;
-        clocks = <&syscon ASPEED_CLK_APB>;
+        clocks = <&syscon ASPEED_CLK_APB2>;
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
     };

-- 
2.34.1


