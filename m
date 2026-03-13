Return-Path: <linux-aspeed+bounces-3649-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D3E106FD7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 05:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXCgj4HZrz3cKT;
	Fri, 13 Mar 2026 16:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773379697;
	cv=none; b=OPvDOOYeJh7vqxFjqA8gEbxmFi3Y5adlP41Wah47poUnSC31gu4qLip2sLXUCA+gNA6u+OhE34qZXt3KlhioQh6Et4V/njdIpIqdAlshkVHp/99RzhW4hCyGEw2oWxP8+vfR8uGpbIeMU/2operTK/SueBWncvVvvoP/ivc7V2wn43QaMTWXBfORQEMiQZiHWBzD7WlFzCwxewHyHkIiDwN1dqJAQ4pn1gBXgIf4VTiQuYzWh5LMFXF/eeMEnJ7QhPbsnAzeHnSU39fjMWRj3ZZcV8zZ7t6yLXktetD0Uc2bG4ILoaoy5CS++pUS6hmKV/At+x7EtrwnedwR7ru7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773379697; c=relaxed/relaxed;
	bh=w2AZ7nJTxh85jyBMjQZ+6yTZ/5s2Z8wG6IvqnF83U6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D0UzhJutkDapvkyUkx3hzvwXuogG5ScZ18a6Mpl2h1rdNDHRFKhXEtS1TdURq7xR5RX4G4vDyKebO9xWqC2yosc7rZ3qxMqRqWf00DFNAFn4L5nqCVNe8f5xXbQOulKbS1misCS/wXIdCS7uIqVDXd9jUMgYafjou70OlEG4aH+tIWtT51/tDfwklfmQfXWbq5yJV4z7F4JfuzdmH55vKqrRKhqIC1RVB0wA8dB7n8/cVyky8vKd0axJ8hr6qGys8Qv7f3QzTaxh91R8NLnByaclsgzWFq+0cT5LVfgtifVE7E+i5TXDbjH1lOm/a/maPzKtv3I2nBc911s4FtLjfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXCgh5xd6z3cK4;
	Fri, 13 Mar 2026 16:28:16 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 13 Mar 2026 13:27:56 +0800
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
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
Message-ID: <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
In-Reply-To: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=1588;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=q02tFnoGppa7W4iZi/yxC4p7ULpWPHKGK+xBBuI6DQI=;
 b=tPuwiH/wlFeRK57OmtmPuPTeGLy5Gna1WX3SgFWWsijMl4zAe9YFqsG3IVSTnVJRi+UVewyzg
 4JPKEb8JmZPDM1xfahIUGMKwoFtm/bp1Ces22FDee1T4qdrpwWVR3Iz
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the "aspeed,ast2700-sd-controller" compatible. The ast2700 sdhci
controller requires an reset, so make the "resets" property mandatory
for this compatible to reflect the hardware requirement.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index d24950ccea95..a2ff9a94db13 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -26,6 +26,7 @@ properties:
       - aspeed,ast2400-sd-controller
       - aspeed,ast2500-sd-controller
       - aspeed,ast2600-sd-controller
+      - aspeed,ast2700-sd-controller
   reg:
     maxItems: 1
     description: Common configuration registers
@@ -37,6 +38,20 @@ properties:
   clocks:
     maxItems: 1
     description: The SD/SDIO controller clock gate
+  resets:
+    maxItems: 1
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-sd-controller
+then:
+  required:
+    - resets
+
+else:
+  properties:
+    resets: false
 
 patternProperties:
   "^sdhci@[0-9a-f]+$":
@@ -50,6 +65,7 @@ patternProperties:
           - aspeed,ast2400-sdhci
           - aspeed,ast2500-sdhci
           - aspeed,ast2600-sdhci
+          - aspeed,ast2700-sdhci
       reg:
         maxItems: 1
         description: The SDHCI registers

-- 
2.34.1


