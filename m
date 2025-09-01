Return-Path: <linux-aspeed+bounces-2096-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7697CA0FFD
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Sep 2025 05:59:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cFdVz5fLfz2yrm;
	Mon,  1 Sep 2025 15:59:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756706379;
	cv=none; b=VAcOeWEgluaf64FgSBetEIZ007Kg2pd/90vK/i3KrRIN/1G9PGQCS3P77c087fdJtx3WkgkCOLW9rPoGretZ6/OipA0rkhwjv+VPSmQaJJA8bBdvAZMeUMXgbhSa4irhF4+vflY6+MyiIc1Cx0+umbvB+AOarVDjzs3H3HWAwHiXo6gSY2Zk8P5b5vXf12nfx8GLRtadsR/tnYTik4EjqMrCNSgSFFRPnZsADEB/XNNv77K1489Kr/c8sGuB4ex2MNe5kwFCLT49bviGFD4IVv813KUkwrTEqLU2O4uxT/CnFXa22rGE0EZ7uHq+vXzVQmjQajzLjeFM3E/Hh5oCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756706379; c=relaxed/relaxed;
	bh=Zb2e1UJDlseKMMev+81jfZOWccINvEhFRYBkYXxN2lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJFmhsDikYS7xiOlqg3iGGL6PdtJIwPXS7MjhUrqE7IrH7d1jOSKkSfR/tagwOxCRAhPloX7BvgHk6O3tleaFWxTEMeh1OPlpbQGwJ3EsaOKgi4pGPoCIyMDT3jqyiknGSsLWFRocaFD7HJNpOH1gD+IxTIEU5ta7o4sinBb0HmjtknJq/GA/+syM1x6eJ5HaCltcEB81h/7rGmp6ym+kr6gBBJv5kcRlSndKhf/vsVB7acm+4E1s/hYMAQNYxHb1Tc1Sfti6MXtjfGSkMEXlCvLsHuWwrSChSJIVMsVIeyNGRv+cNGS+0t7JF7laRwoGqk4zp/yyGSZyzFimHVc5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cFdVy5Tppz2yt0;
	Mon,  1 Sep 2025 15:59:38 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 01/10] dt-bindings: soc: aspeed: Add ASPEED PCIe Config
Date: Mon, 1 Sep 2025 13:59:13 +0800
Message-ID: <20250901055922.1553550-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
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

Add the ASPEED PCIe configuration syscon block. This shared register
space is used by multiple PCIe-related devices to coordinate and manage
common PCIe settings. The binding describes the required compatible
strings and register space for the configuration node.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../soc/aspeed/aspeed,ast2700-pcie-cfg.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
new file mode 100644
index 000000000000..c1a90bb6a785
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe Configuration
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description:
+  The ASPEED PCIe configuration syscon block provides a set of registers shared
+  by multiple PCIe-related devices within the SoC. This node represents the
+  common configuration space that allows these devices to coordinate and manage
+  shared PCIe settings, including address mapping, control, and status
+  registers. The syscon interface enables for various PCIe devices to access
+  and modify these shared registers in a consistent and centralized manner.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2700-pcie-cfg
+      - const: syscon
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
+    soc0 {
+      #address-cells = <2>;
+      #size-cells = <1>;
+
+      syscon@12c02a00 {
+        compatible = "aspeed,ast2700-pcie-cfg", "syscon";
+        reg = <0 0x12c02a00 0x80>;
+      };
+    };
-- 
2.43.0


