Return-Path: <linux-aspeed+bounces-1292-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38E1C61CE5
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Jun 2025 07:55:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBNKn0LjCz2yNB;
	Tue,  3 Jun 2025 17:55:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748937308;
	cv=none; b=kbHcaKF11/tncetAdMHmRbo41J8QqSGeFse1dBaReCWi/myY81IWn5aOKKbhyV37i4Hr1Xk5QQNxy/K9wKP28X6FtMSKLYSvAoWWNKNrUh/Mi0YGWfZmpso2QnWuOAFBwnWg3u4kuXsveXsR5zbpCgN+67CzCAH4VxWSyPHLy/bSipvXSVzdJfJRgP8nyorwcCCv472JSL7xgVRJ96lIVyMk9lmfEfEWnGO67tFHfoQHestjTFsvfpYp9O1fpsGVBizDtaTDow6icaTreTDO57Y19XU3uwMm0bri+gUVbLilvVXc6ffmZdK+wwYV8y3R0Uob9x6FcuiE/9/HUJvtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748937308; c=relaxed/relaxed;
	bh=mOulpnhx2iELbOi32gb4BsbCpDt1Whx1dl3wgx6V9rI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQOPDqowj4QaPqMOteN49wt2Krw5ihIaF+ZXbig+sW33sZC8QzzPnA2+y915P0LDck2j43dc89a4WoLBMez5m6jYaGFEusVIcnXrRrGpvGdIQ36gXU+23VPrdhEIG8bRH8h66ik7QRqIPUtRfLr5ebal8j36Bcclx6S6YshJQcE/4N+tnxF+D+mSYFqSjPtURDb2H8nz0PiUkrK7XKloQkyhK1gGl6LPem9snnb76i3mXQXigRMMmlQOEjNdEYm51EH/hQfjk7yBKDZ1mmTK+FhqCCaLxtUKQBFGqSxKgoS85j6jmochw5p5pbfKKbHtfNegxS23MMsRtQqvPR5d0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBNKm1XJFz2xDD
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Jun 2025 17:55:08 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Jun
 2025 15:54:50 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Jun 2025 15:54:50 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<jammy_huang@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series SoC
Date: Tue, 3 Jun 2025 15:54:49 +0800
Message-ID: <20250603075450.133604-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
References: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
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
---
 .../mailbox/aspeed,ast2700-mailbox.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
new file mode 100644
index 000000000000..27738c462e33
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
@@ -0,0 +1,61 @@
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
+    description: |
+      <&phandle channel>
+      phandle : Label name of mailbox controller
+      channel : 0-3, Channel index
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mbox@12c1c200 {
+        compatible = "aspeed,ast2700-mailbox";
+        reg = <0x0 0x12c1c200 0x0 0x200>;
+        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
-- 
2.25.1


