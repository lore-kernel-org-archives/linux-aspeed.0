Return-Path: <linux-aspeed+bounces-1538-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9940C7115C
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Jun 2025 02:45:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQXWP3cnyz2xRq;
	Mon, 23 Jun 2025 12:45:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750646737;
	cv=none; b=lOHtaKONuEPH6PAj9G/hUvL6Q6dfcQDiamKO0j4NaP3yDmW11vfIOgM1buVPyHFxCercm+KPqa9KpoKnjLInEai+WuYqu3RS2Wtrj4562nPBODHpMqIFtFzE5GocPR14H128NbT3wcxQDuBBegIXdhLtrKKkgy4sD8LYt4iFOC1gjm/2jgmgF8o0p/Mml6Qcsah1VdBTWqe9yzuSGKn++qJIiyxfvgQ5E4jrTV/w/XSMC9ovrP+Ob8zCtP0tjxUpqPRB0OdUSTwFXaqiQPRAWu01nFQlUxYIwq0JnuRdc6utMhIeozxzAUC6rfSipTRakmmw+QEjM/geffJDbWkaag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750646737; c=relaxed/relaxed;
	bh=6v+xBt9oEhbm3iR4M4ZHnmqCI9RVitupBeDxsn3h+eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QintiBc9pm1Gv1gGF1ME7mDqxnj+tL42QIw4yUiPUnaSmMsB+cvMeVsS4txq3vypAb7VINUHDZQyT2Oj+tIDCsqggXYU3zEEDbYRNrpTTd8MIYBu4f0z8+1NMRfeTv+WxE3vpufOCZd/nPlEYUEJv1EWXCZWb4DheTo09ANjMIc01JQtn8SFAAFGs8+Z28h83QVqeMwDZXdQn1ws4mU76WS8Am1gJWlSSampm07chY/aDOMyI2rG59DmTv1KmHsYzvVO7fUdLWeHtl39ZUyeWu2pyV4K8wMr8SCiD+8ir9cnnLchptsBlB71bMVA0UfsUcioCKuL6jQguDKdiQCjAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQXWN3NmQz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 12:45:36 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Jun
 2025 10:44:56 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Jun 2025 10:44:56 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series SoC
Date: Mon, 23 Jun 2025 10:44:55 +0800
Message-ID: <20250623024456.2068370-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce the mailbox module for AST27XX series SoC, which is responsible
for interchanging messages between asymmetric processors.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../mailbox/aspeed,ast2700-mailbox.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
new file mode 100644
index 000000000000..9c5d7028e116
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/aspeed,ast2700-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2700 mailbox controller
+
+maintainers:
+  - Jammy Huang <jammy_huang@aspeedtech.com>
+
+description:
+  ASPEED AST2700 has multiple processors that need to communicate with each
+  other. The mailbox controller provides a way for these processors to send
+  messages to each other. It is a hardware-based inter-processor communication
+  mechanism that allows processors to send and receive messages through
+  dedicated channels.
+  The mailbox's tx/rx are independent, meaning that one processor can send a
+  message while another processor is receiving a message simultaneously.
+  There are 4 channels available for both tx and rx operations. Each channel
+  has a FIFO buffer that can hold messages of a fixed size (32 bytes in this
+  case).
+  The mailbox controller also supports interrupt generation, allowing
+  processors to notify each other when a message is available or when an event
+  occurs.
+
+properties:
+  compatible:
+    const: aspeed,ast2700-mailbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@12c1c200 {
+        compatible = "aspeed,ast2700-mailbox";
+        reg = <0x12c1c200 0x200>;
+        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
-- 
2.25.1


