Return-Path: <linux-aspeed+bounces-1335-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138FC5B552
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Jun 2025 09:10:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGjgq26m2z308b;
	Tue, 10 Jun 2025 19:10:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749546647;
	cv=none; b=eM0+NQ1fWiyNYWSC1uGT+UmohQJMgXw1KsTdlCzVxtOSHFu/eP+TGlYHdDwQprrs/6jGxAy4iiYbzxmX+wEb82Do8V2ZqOVwPu6ks9lPFbpLaQsRQ8ewqvvo57AgVabWfRYUmoJF4Qgk0kvduHTRB8zvbjJgS2n3Pae7Imt3Xql55wD/gNTOjChjKYPe/huGIuhBIto3evF/fROq+SY0Tn6ErPcS2PdgEvWc3WBPDlqJfzKpnnjo7EQOkCXkKCsY9zo/4Y015d8au+80pTEr3Lp5GoSz7csP5peZk2CBmG+nSTZ38NGLRf4M19wpie2EAAi34aIyS1FrRvDU/NuMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749546647; c=relaxed/relaxed;
	bh=SWxVt0hRjs9/ZfxFEoYX6taw1WtXAg+mCWSsk2BxyPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giH3lDPSQ8vhA5fkYAAOBu8TmuLudQYV0EikkptYypiQfyfzFN92l3GoOIblRihEIE4wI2y4XbuqCshdqPsdPNgp4dyEH6zi8ZtdtYHt3CMIq+JkeA5Jvy4HEPa4oPqrEoD0MY6fiwnxbz8ewN/FAjzbsYlai2wnpe/oH2mDy8ieJ30/x0aJVGQCTfMWePi4rRA0SVc2C7HzKkEdhFSCl2tywhtBR5/eaEQdGRl4svPsyVAQAb5d6m+25EBgLiFqo9A1kgegpW0fznebeillVhdN/kRQeeuKiM4p9OGkg523YPtDVwNrPGkPotA5h0L+aFaWrkTm1yAoT2fiA4b+IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGjgp2kf4z2xjv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 19:10:46 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 17:10:27 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 17:10:27 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<jammy_huang@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series SoC
Date: Tue, 10 Jun 2025 17:10:25 +0800
Message-ID: <20250610091026.49724-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
References: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
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


