Return-Path: <linux-aspeed+bounces-3751-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09235F532C7
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 03:07:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffw1L70Xhz2ynW;
	Tue, 24 Mar 2026 14:06:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774321606;
	cv=none; b=SnPKWzlkXsrWUfLxUC1CkWOG1dIAkW89KerWqt2YRj19Qjha0fb2Vq0a6RURETqZ2I15nGUzEUyLpzvzPpI+Mh9L+HIGyxKnAHKwL4bVZWIbF1wbJRqwJ+g5bl1wUIqHolBlzrMfuIj/zCdll2s+MqnqmdAQZqNIOU/lPvnOyjS9vQlY1g9LV9nuApDPfddjyOOZ38Z6kIB0Tzp0B5D8bb5FcmbBLT12V86HhP6IaxlWuyV8QqH9JDuVGvNMwxwGODAZgd7tBkyPmNU8+RogzyAsy77akpCIaYV6MpMOYpcrY2LJ5xHOLgbYPMDMrjFY9BpOqZce1Wo9YhGdALv8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774321606; c=relaxed/relaxed;
	bh=CbofNrtL4RM4GUaLb07396poHJ2XKEvS/xWnwefq2qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QTlloj1epAnMdpn6ARAG9wrtTGiW0LZk9gxyBhIwxouL3f/Ua4zrHxrQwU6/vJTr2sRiANvUTyv83kDItdfmv/wTjcgYUxaj/OyghV4B720+lLx69uw2gLgk1RoFUbjeGx5viU4J41ne5qtL8pE6MKNV6cLzGYhkn8/CCvCmnDM47a7iTiCarNTZhLwaLcpoy3kXjAy1YV96ouY5BBlvQGFTZpC/6Wiv/u6Z8gPI7Poc7oLpNWiiEsS95IDDsxZbFYZcPbWcF2TNipwXUNUQiR6shOCGZFRreddCtmn7xwzn1i5ekvGY8v0vlSK9YZquEG5XFEhz96w1zRlaGN3PZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffw1L0Y8dz2yks;
	Tue, 24 Mar 2026 14:06:46 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 24 Mar
 2026 11:06:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 11:06:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 24 Mar 2026 11:06:27 +0800
Subject: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
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
Message-ID: <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
In-Reply-To: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774321586; l=2054;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=j6iiCZ6NtY6WSfhbc1aYsPcrOaYpNW/B3+ibpEA+lx4=;
 b=4KxVSsac4MIz68nC2Lhh6d4zQSCBHVUIVkcCZ4AF/trsBU69F3s2wAW80OuWAOSaVSBla93wn
 RBvM5zwjHWtAyS2+IQO7p/zIREPDCS0eHl0zBnTaSXrAYLm21Byxqk+
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2600 I2C controller supports three transfer modes (byte, buffer,
DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
method per controller instance. Also add the "aspeed,global-regs"
phandle to reference the AST2600 global registers syscon/regmap used by
the controller.

These properties apply only to the AST2600 binding and are not part of
the legacy binding, which uses a mixed controller/target register layout
and does not have the split register blocks or these new configuration
registers. Legacy DTs remain unchanged.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v27:
- change aspeed,transfer-mode to aspeed,enable-dma.
---
 .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index de2c359037da..38da6fc6424f 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -37,6 +37,21 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,enable-dma:
+    type: boolean
+    description: |
+      I2C bus enable dma mode transfer.
+
+      ASPEED ast2600 platform equipped with 16 I2C controllers that share a
+      single DMA engine. DTS files can specify the data transfer mode to/from
+      the device, either DMA or programmed I/O.
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
@@ -59,4 +74,6 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
+        aspeed,transfer-mode = "buffer";
     };

-- 
2.34.1


