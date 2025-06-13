Return-Path: <linux-aspeed+bounces-1427-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763ACC7114A
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:04:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJS4F1Lk8z30Pn;
	Fri, 13 Jun 2025 15:04:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749785423;
	cv=none; b=W1jnhRWtzOsa+Ko88PzDnAmceIJ79uNIbTUuOwe8W7HeR918+8TyKS8gT40GwmqN3gZqB6gFeZqXovC2ZJgZbS3rhaMoDu6aXCCkS7lqqGJr4SCZm+xCOSvl0ggqWyVf2oOMhRI180BOLJT7bO/xHMq4K/jEXwz67OsIrfXQtM5WiPfbzM4OpJoR8ss1gNTM+BOYHJyb0coJ3vdxBlGvBKhyX0xMW0WVE3Kd1V2L9V9OKuSCUBGtueoEbP06SnPd0e4LXQqcaA+2m+ASLiMkALQa181Vdn4OHeg2cSz6eww5wPfBjk69+e0SdPjubYTkDejw+q8r7bk48XOC2j7UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749785423; c=relaxed/relaxed;
	bh=ikr3dTDpoNwdMjkzgVmJfQtwwrinqMudBYZMTTOrxqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDcaF6VTK8OXqWIZaxkMWxvTDvDmCCV8CzoVCQZg5hPUHTz2agfUeVLq+LjTWvD8Cy7jvhnNTqpLsrd22lFH0P5bGQO3WCO4r3JED4zLyBjBKqyx/c+ceIZn2SQmn+MMUREDXy7jESS4utQW7JDtZrcVqInf0xBxYbkBxCDYMzOuGo5PdIrWCaJSzBIOKE/WhxNZ4F1bKXp8Ns85LMVz9oZcAZQvlXE9mvaRvO54xNt/fWVhem/8A8yXDk5WcsJPSj9CyVeDt7IHkiEMk4V8WlwPuCXl6m1NI860g3jDeiUx+Uf0zwN3DiclHr8c2o69Q8iT/RjQxYR+x68xAGPceg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJPzg1np8z2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 13:30:23 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:02 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:02 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <elbadrym@google.com>, <romlem@google.com>, <anhphan@google.com>,
	<wak@google.com>, <yuxiaozhang@google.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/7] dt-bindings: pci: Add document for ASPEED PCIe Config
Date: Fri, 13 Jun 2025 11:29:56 +0800
Message-ID: <20250613033001.3153637-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
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

Add device tree binding documentation for the ASPEED AST2600/AST2700 PCIe
configuration syscon block. This shared register space is used by multiple
PCIe-related devices to coordinate and manage common PCIe settings.
The binding describes the required compatible strings and register space
for the configuration node.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/pci/aspeed-pcie-cfg.yaml         | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml

diff --git a/Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml b/Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
new file mode 100644
index 000000000000..6b51eedf4c47
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/aspeed-pcie-cfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe Configuration
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description: |
+  The ASPEED PCIe configuration syscon block provides a set of registers shared
+  by multiple PCIe-related devices within the SoC. This node represents the
+  common configuration space that allows these devices to coordinate and manage
+  shared PCIe settings, including address mapping, control, and status
+  registers. The syscon interface enables Linux drivers for various PCIe devices
+  to access  and modify these shared registers in a consistent and centralized
+  manner.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pcie-cfg
+      - aspeed,ast2700-pcie-cfg
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie-cfg@1e770000 {
+      compatible = "aspeed,ast2600-pcie-cfg";
+      reg = <0x1e770000 0x80>;
+    };
-- 
2.43.0


