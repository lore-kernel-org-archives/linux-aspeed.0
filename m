Return-Path: <linux-aspeed+bounces-4996-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A16C88E7F
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 00:38:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl0Nz0fXDz2y7Y;
	Wed, 16 Sep 2026 10:38:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789519107;
	cv=none; b=RdRf8KHgxaPnJSJ8fK7+2016KsI16LqKToHexy/LQ06yOrqL9FrW9R9gyQGNMSMUB0pCMGNUu70NIp9PVBtI6b+L9DAl4UipRkZYqjmgiKOcVkwPIaIPXRMc+ocvTr+mbKLikIKFLV/MNu7MSxuIgDgcPqA2a4Cp2p7xcNmWsHZlSN5P5DswoaaJMqBahRyxYwB5f6b2YbIWSYEY3kPGDi5JZ/Av49ZPnC3RqasL6W5oN5zUkHJmv7QYS4xjy0L1ivvWgxj8on7zZ9vuhB3c+QkuAIg/9i0ZKUkvmGaEwB0QbG3SVd/kzVi59r8g4oMwudIfD2p/0DN5v4mcuKP7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789519107; c=relaxed/relaxed;
	bh=kE/N0vN69medp+vXugoWC5YJHHyKjYfDG3kqyOYqQXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B4CB5PaueFsGbQMIaMnoT2l/Xz0ZgTiMR6DK1Gh84tfGGJV3PePrxw86AwZJgRpjy+xHHvRpcfjSg+nKZwOg/cQN3q1TPWagS2jRH69cxUum6CGNyGyFWmUpl9gnLIai7LR5lwRe0yiKLmEak4zeIWe1yl1jPdlx7OVWu1MVx9gkP86+kbr5hXsuAT/d8+/jlHOl7eNHBDnnIoNqZONsqXuRFgIxVon0tG1p5zWOpwPIeRjcIj/knOlGcu1rjbhkPX9vOUThslUN3EaXen4YipSXvDmwm3mM98si5ZDB7cyLUeGn1UFm2gc6UXOtwBX+39YaXv/8ZhIbE6z/p4Muow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl0Ny00HVz2xkr
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 10:38:25 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 08:38:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 08:38:02 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 08:38:01 +0800
Subject: [PATCH v4 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.2
 PHY
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
Message-ID: <20260916-upstream_usb3phy-v4-1-812e76037d01@aspeedtech.com>
References: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
In-Reply-To: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Manivannan Sadhasivam <mani@kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789519082; l=1769;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=VCUzkus2cRoY6FjtrTdhyQ8jas/yMZZbuY4PWUxTEt8=;
 b=fU4mzaiCTLYpJbJQNykvE1wPtKB1kptHqX+QJYIBWXoztOczEgLDmBn/tQFgqONf0X50RafC8
 p620j8lqbLwAFi9KPsMKrjznTq4SWbuClBVCR/IJA9YsVbDFeN4uOf0
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Document AST2700 USB3.2 PHY. This IP is connected between
USB3 controller and PHY module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
new file mode 100644
index 000000000000..b83037aa0438
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/aspeed,ast2700-usb3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2700 USB 3.2 PHY
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+properties:
+  compatible:
+    const: aspeed,ast2700-usb3-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed,ast2700-scu.h>
+    #include <dt-bindings/reset/aspeed,ast2700-scu.h>
+
+    usb-phy@12010000 {
+        compatible = "aspeed,ast2700-usb3-phy";
+        reg = <0x12010000 0xc0>;
+        clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+        resets = <&syscon0 SCU0_RESET_PORTA_PHY3>;
+        #phy-cells = <0>;
+    };

-- 
2.34.1


