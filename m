Return-Path: <linux-aspeed+bounces-3656-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C65105F78B
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:08:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv12qggz3cGf;
	Fri, 13 Mar 2026 21:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396509;
	cv=none; b=MoXZ2nToCuCLgshcVj7JbSzdD+Vb9kqe9tf3qAyeKkcaM/HzhDM6Q3EcZPsJK6NEpSUPyzrx9qLo4oJyqgVWYe7UdFaAEZYcqfhlZnfu9jLNCCzDaytA13iXey6/61Mw5XtkqLHI/QrE6u116oQIefhxg8YpBlzdL+nwAu+hjl5bqAZ+6CEL6uI0XC6wkIROZtg4ukLfCQ5Ad8CxlEy4GurlMUDDzBnSrchxJc0M5oz3ZMFL+8GY59w1NImLjvr0wfGozx6okTCN4kJpon4T+lHYao33JzzZ4fwro/rP2GWxWlUxsgoCkpuzj33CPnjCYAXbEtY5DDnsOUH+oFOh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396509; c=relaxed/relaxed;
	bh=3am9h0UreIAmfBcg5OY6/nPf9X32cvawrvLxpyxPi3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HUsROgLk8k8YMDr5PCpMhmdjeFHE4SzIMW8qqEFkLdrpGYAbCFHH/fdf892F+yqdv20ntFsZIPgUsxsESD3m0A2UiN55X/A4bZTYOhPa1CjjbwJvDyGVrm3Wv/Y4Iv8Gnf5J1p0WdGaFDIojkYZvsiNkNTdu6xlWU/YerfHupNu0rMX2UL8Yc7+M2lpTp+GnNobWC+UCyFvmfyXUxhlqZLuNGujqXv+afDLM9NCnffqT3DCHx6dydfAjEm86+wNRnnSskesmC0QdIPydFmra6MqrvcdWq35FUfNZWvF6RspUCxn435AUMqFPZJiOoPLDljgWn5E0bkLpycGQLq9H0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKv02R4Qz3cK4;
	Fri, 13 Mar 2026 21:08:28 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:07:36 +0800
Subject: [PATCH 1/7] dt-bindings: soc: aspeed: Add AST2600 eSPI controller
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
Message-ID: <20260313-upstream_espi-v1-1-9504428e1f43@aspeedtech.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
In-Reply-To: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <maciej.lawniczak@intel.com>, aspeedyh
	<yh_chung@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=2633;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=cX0+TYSUBKoylJRqFstuVfh4bOO8RZJolgiew1xGVtM=;
 b=PUEJ+M2Nits91wx+TswvF6gJSlfKAGjDKkzDIcVwArjw8jrWaV+Qx8qHXzgwlBTNIAeAVoX78
 8knw1gDRx/oA4BXT+fpRLDOVbo/5ZHo24B5cj88KAVBN4vOp/TH3apZ
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

Introduce the device-tree bindings for the Enhanced Serial
Peripheral Interface (eSPI) controller found on AST2600
BMC SoCs.

The controller operates as the BMC-side eSPI slave and provides the
peripheral, virtual wire, out-of-band, and flash channels used for
host-BMC communication.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 .../bindings/soc/aspeed/aspeed,ast2600-espi.yaml   | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2600-espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2600-espi.yaml
new file mode 100644
index 000000000000..e22a10111138
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2600-espi.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2026 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,ast2600-espi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 eSPI Controller
+
+maintainers:
+  - Yun-Hsuan Chung <yh_chung@aspeedtech.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description: |
+  The ASPEED AST2600 BMC SoC provides an Enhanced Serial Peripheral
+  Interface (eSPI) controller used for host-BMC communication.
+
+  The controller supports the eSPI channels used for peripheral,
+  virtual wire, out-of-band, and flash communication.
+
+properties:
+  compatible:
+    const: aspeed,ast2600-espi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt from the GIC for the eSPI controller.
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  pinctrl-names:
+    const: default
+
+  pinctrl-0:
+    maxItems: 1
+
+  aspeed,flash-dma-mode:
+    type: boolean
+    description:
+      Enable DMA support for eSPI flash channel
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/aspeed-clock.h>
+    espi: espi@1e6ee000 {
+        compatible = "aspeed,ast2600-espi";
+        reg = <0x1e6ee000 0x1000>;
+        interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+        resets = <&syscon 57>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_espi_default>;
+        aspeed,flash-dma-mode;
+    };

-- 
2.34.1


