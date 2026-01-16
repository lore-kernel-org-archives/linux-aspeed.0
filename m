Return-Path: <linux-aspeed+bounces-3358-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ACDD4A5EB
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 02:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dskvC43mgz2xqj;
	Fri, 16 Jan 2026 13:53:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768532023;
	cv=none; b=b5i7ErBrVN/VPrCdHS4og2s//SP1ieEDCyemeBcJzUyAZP8gGMxRpUBkb5+p9uIuRw6u9fVsI1Y/xdsFtcKpw6aD7WPcHZbLJYg6PfzQLJqZIFvfnC35X/PO35/nLzIJ8IVfVTl+WQ/IWyxMqgf7SPxgDDkEJ7WObXZk2pC/cwsag/gXncGvx419JEPLnwGQhivwV2+uNB/ujmeHFXk9SlqAKXnu7qOcpOzQpnsxz3HVHRcacQoLI4Y/ZmIIlfhyO3ahQMlg09RvdKQvw+YtFb6WM7wb9Ente8N+hvRt0pBtBlC7Ghqm4HNRg7/OQBQj45LhBLwmp7vww7WOr7k2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768532023; c=relaxed/relaxed;
	bh=2cDWAX9dpSwu/8ZcRsjcTdGBy0V1WWHu7jJ4DmW0EWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R84wt+37q5A5lfnTY06qwpuKK/RmbpTjQqndS1NytIC6V4+8T0M4lKGVFbsiVG4zOOGocnD91/MoFC324x2pKNA/uqRkEb7Eng0E/rojJNtEXWu/AVtwIWwbsdaYNGefei9PDnR25rDvwueXvxYLah/sSqWyiqUY0XRjaq9ZTNpIoXntJafaVMqKQdli1ismuLt57SVfCX+M2gnGJ8S+kYT+stpTY2NaKtn6nr2zPYSJzj0m71CZGEBGCiIJVFu/MVT68aHrA+1jCANbQilbMM/m5sf7io2W1SvdNHtFyLWzWVh0ibnXKNiz828Zexumxo0FlZkaquaCQY4T2qXH3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dskvB5h5Cz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 13:53:42 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:53:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:53:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:53:24 +0800
Subject: [PATCH v2 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.0
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
Message-ID: <20260116-upstream_usb3phy-v2-1-0b0c9f3eb6f4@aspeedtech.com>
References: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
In-Reply-To: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768532005; l=1695;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=PMotyQehgGrEVoSSxouKDsCZuOfMr0EXxz1QwPMc58k=;
 b=TLOnZh02m+/Up0zRoHQbLThVN/r3iglizLZ8jmW6X+BGCPJ45K/Mrt14d+2RLPQ7FAawyRpnO
 tjqBYK2LhvbDEbSpKHUiH2NfesEDTtfn8WStcS7gVBuV8ZNsv0HVFS4
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Document AST2700 USB3.2 PHY. This IP is connected between
USB3 controller and PHY module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


