Return-Path: <linux-aspeed+bounces-3311-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E576D31A1B
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 07:13:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drclw0NXKz2xpm;
	Wed, 14 Jan 2026 18:13:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768374812;
	cv=none; b=CoXoZGinKvouJdbjrFr+MP9VixXfJ7vKeiZSItCi7Mfd0LnNItigX33PkbuMuVkHA1qEyBNmNPa50avyawqZ9L2LFu0Emh4afIcuMhWR4l61Y6cqemnD8+Oyq0BaVrq0X7QfmSJbphRgzD4mB0FULeKeAo/bgYUNbaQKKef5MWtpuYsAB8JaO64nuRQnM0j6e9O5HiF+0tX+NWfq9dukfkR4qZq/gIAMbTO587htwWGETuQlxZRkXwT+V13q0nU+buPVFQ0+5+KtsDbjk1xf0kfqEdJ8JyFoHPhR3gNqnbjaukB7BTp6sgehyFnVTiklvZpSob0Exb3gUaGP35WOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768374812; c=relaxed/relaxed;
	bh=H8nNZ+fiOQ49wNFJWe1zSc/m9zDzcCnDBjsvSM+Sl0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kCek5jJFatgEGgLeWsbkJ0OkGOPhnoWJbHaBJz7XgKpjyGm1l2hWhZGe4lgsjR1/yRDJ74p5kEoZKg0sCaW2XVY/P9gYqNe2F/bEfNy9wMO2GJBbxkH5pUxgU563QCcPrYSw7bUssXb1xDs52JLa8DmknldGIWcvAUCPLHlx0fnXpa7spMd+o8pt8xBoG/iHO+E8dnEJjeb0UgEZptaYjMuSm1NasAat9PFoddxZWuLM14wcwfGqV6lN9TEU+RAPfr3s44qCNb90BTflzdH1RXgoBNq4LyBOzyJvh8bDArc8kbrKCV1YDJZV3S9nJVPJ9LfhvWpT7+rc5wuXR3Q0VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drclv0RkFz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 18:13:31 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 14 Jan
 2026 15:13:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 15:13:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 14 Jan 2026 15:13:10 +0800
Subject: [PATCH 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.0 PHY
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
Message-ID: <20260114-upstream_usb3phy-v1-1-2e59590be2d7@aspeedtech.com>
References: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
In-Reply-To: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768374791; l=1696;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=mPdZt1d5Fm1RMHcr1MP6FeA1OdDIaYUAs1plqEv5OSA=;
 b=ER1DCIeIdd/WyR0rpbAiSS3yi3IU3npMCqgIHdwIjNmyqpvpDVtg4+wNVqCoYX7rwJVbZGru7
 G2GivtJrZy2AAS3LEqIQlCSt5uSLhckLf0H3GZi85TNsw3bTMEMOyiW
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Document AST2700 USB3.2 PHY. This IP is connected between
USB3 controller and PHY module.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
new file mode 100644
index 000000000000..83da224d99b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
@@ -0,0 +1,50 @@
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
+    description: USB 3.0 PHY clock
+
+  resets:
+    maxItems: 1
+    description: USB 3.0 PHY reset
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


