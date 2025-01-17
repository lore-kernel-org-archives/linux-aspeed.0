Return-Path: <linux-aspeed+bounces-521-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC94CC02188
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jan 2025 09:52:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFQf2g9tz3chF;
	Fri, 17 Jan 2025 20:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107562;
	cv=none; b=S8TnbqaGmrMXHE8lDtIG4sqGPkT1ZaTw5lLcHZlHpRTlmA+ec2KtU98v6uaFnsJQS0llct05zmL5uD4W3WWs84I3TxsNcS/UqQwFfDZMTtN4l+qDyfGN3Zqe0Akl7/lRrveQUg925nEaskaV7S7k9nFbSxIlb9R5ZmEYofFi7rvKBSUk6V/YtcjClaNoNWhBgWGvv0IObYdRYXNfa6ARGqJskFS5y+GAP0HDUPycbjsIelv5KG2CfK879KPNVfZKoKFENh1ZzUQ/PSZC9B98LpHNFgFkrEHwwVe0t0OtaOTT0GJrX+H7xNLHSpidVav+MGSRUv7grPVIwx+xPsKSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107562; c=relaxed/relaxed;
	bh=aa5QaNYOW2oOBLPWGenpaGtAyXRyDyKvHVOQ8KRPF1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2v4xhp2CYx3PKk3+rzvE7z1GTs5Lv1Kphm17bbmrx8HZKwlDnXMkiPSCPJyXb9oJ7a92thoglXz1EECGVeb4yu2gzRB+8z/wnlhWipBdJJh0ZcfrIdiskaa5/JyU3kBNMKxd/JKp1HP1btYx/UE+s4INkpdYC/TRi7J+cDu7MOvKe9xFGCuN9VXEhUU3cTFAV4Nh0ms5PgZvjRrSgkIQwx0GLEqMxPSrIT6r+5m+De8wmUyt/Ao7RZnGE7zHUxOXZyGjxKxNWwTlDU9hHP2swP6qFL+VO08DpJvlGOvaenZIQM1BbHVIQkC2UhpFteTavYj+e8f726SEwtG1x5fvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFQd50WSz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 20:52:41 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 17 Jan
 2025 17:52:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 17 Jan 2025 17:52:20 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <elbadrym@google.com>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
Date: Fri, 17 Jan 2025 17:52:15 +0800
Message-ID: <20250117095217.661070-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../bindings/soc/aspeed/lpc-pcc.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml b/Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml
new file mode 100644
index 000000000000..6c2134497de2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2024 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Post Cost Capture Controller
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+description:
+  The Aspeed PCC control allow to capture POST code from Host.
+
+  This driver is for the BMC side. POST code data can be access by
+  /dev/aspeed-lpc-pcc0. For example, POST code data is below.
+  ~# hexdump /dev/aspeed-lpc-pcc0
+  0000000 40b3 40a0 40a3 40a2 40a2 40b4 40a5 40ee
+  0000010 40ee 40ee 40ee 40ee 40ee 40ee 40ee 40ee
+  0000020 40ee 40ee 40ee 40ee 40ee 40ee 40ee 40a6
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2600-lpc-pcc
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    lpc: lpc@1e789000 {
+        compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
+        reg = <0x1e789000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e789000 0x1000>;
+
+        lpc_pcc: lpc-pcc@0 {
+          compatible = "aspeed,ast2600-lpc-pcc";
+          reg = <0x0 0x140>;
+        };
+    };
-- 
2.34.1


