Return-Path: <linux-aspeed+bounces-2293-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E0CAC592
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Sep 2025 19:53:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cT38z2Ynmz2xcB;
	Sat, 20 Sep 2025 05:53:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758311619;
	cv=none; b=gZ3qFwSxkERZkeyuCuKN0LtkmTztTcFpxWfuj8ZECqUNXnS4kTNSav1BdChrVt/5LOGAIIbTt+CssOeG7q4koYfhz89pnPWK9kTSv7LI0VGC0AERKyDMJmWCRXZGK9e8NzPgGFh7xq50akNWSQkC1gwuSwxKiMOV+kfxwKcHA2veTNRScvBR6rA/3G6ljk20PIo/a7bYMM7IRgmk1TVU73C1igRCVE8Feur935fWS6ViE942pPiFSejhLj7/GyXUBRjnQlaNkWQvMZuHOnBjbzanPuQ6cge4zF2jmCapoEAUuwCfP6AZUtBQzq2IzFM3LBJ96ORBpXoik4Nt0Kll/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758311619; c=relaxed/relaxed;
	bh=QvzknwcqOGAIf0MQXaclEmaRkfVstN6hzNjrF+yWVco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jiCBDRaxFojdodMxsXNB5mfR3ybqhQTBxFR48IVsDqMQhV6OBgJWhwA4Ey90QwhX4OxmxsFwN5nUi5lY4CF3v9T033dYLH6Mqqm9vx/uWYjdhpCvh0NEk12GHYacQrWFXnptrPJDJheOWPoq+qBIVZE7qR818keRA7NF3ipeo/IlwVC/yBJRumYmh6zKeLjAzuuT84OKj+GVPjDNTDvo+3DBnvZe4Vl6RE49WRQsZmKr7nrUhOzzWby+ppTur5e4dq6hZCVrXFBP/jL/8ppeSPG9eP8hxHoyNcDcEETuEmCH+Ad9VUaeqHReH5w6l0fEyAAreImfAWJD3EKVF2SHEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hz3mMJ8r; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hz3mMJ8r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cT38y1FlTz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 05:53:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A85E44A19;
	Fri, 19 Sep 2025 19:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE43C4CEF7;
	Fri, 19 Sep 2025 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758311616;
	bh=BhNfeUjBhFH3Y3XO7HytlVMbwMMe+nuaGzu6cpTp5HM=;
	h=From:To:Cc:Subject:Date:From;
	b=Hz3mMJ8rxvRkBOSq9Jl5+9krcajggcFHmyy/8scaXT+Kvjirh6Fh8Ylsyv2h56ulQ
	 46cQAlRB1NWdUxXmIX3+WMHHTgSKp0uyXRSO0gZ3oYtrt3tXwfPEKDOPYCfWkaY0qz
	 ryUgP1C4NloC6qW9/EWMgVU3ISCij13e18BPdHW7Q5zrQ63AmU0wJhiw0Kg2/X+1Tp
	 HT8VH//kDlU3vIY61E0eqATpUFLgRpMce/4wcV9G1DCl2tfu9jWOes3G5vmGDoEWkt
	 rqnDkyzqO1uY1cmstFFfI1tp13naHvdenJ8dTBuFFieSs6jXWQhtcaWs40Fyw6plaI
	 tZHYct2FIXyxg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefan Schaeckeler <sschaeck@cisco.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to DT schema
Date: Fri, 19 Sep 2025 14:53:24 -0500
Message-ID: <20250919195326.2079446-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../edac/aspeed,ast2400-sdram-edac.yaml       | 48 +++++++++++++++++++
 .../bindings/edac/aspeed-sdram-edac.txt       | 28 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 49 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
new file mode 100644
index 000000000000..09735826d707
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed BMC SoC SDRAM EDAC controller
+
+maintainers:
+  - Stefan Schaeckeler <sschaeck@cisco.com>
+
+description: >
+  The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports SECDED (single bit error correction, double bit
+  error detection) and single bit error auto scrubbing by reserving 8 bits for
+  every 64 bit word (effectively reducing available memory to 8/9).
+
+  Note, the bootloader must configure ECC mode in the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-sdram-edac
+      - aspeed,ast2500-sdram-edac
+      - aspeed,ast2600-sdram-edac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sdram@1e6e0000 {
+        compatible = "aspeed,ast2500-sdram-edac";
+        reg = <0x1e6e0000 0x174>;
+        interrupts = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
deleted file mode 100644
index 8ca9e0a049d8..000000000000
--- a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Aspeed BMC SoC EDAC node
-
-The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
-correction check).
-
-The memory controller supports SECDED (single bit error correction, double bit
-error detection) and single bit error auto scrubbing by reserving 8 bits for
-every 64 bit word (effectively reducing available memory to 8/9).
-
-Note, the bootloader must configure ECC mode in the memory controller.
-
-
-Required properties:
-- compatible: should be one of
-	- "aspeed,ast2400-sdram-edac"
-	- "aspeed,ast2500-sdram-edac"
-	- "aspeed,ast2600-sdram-edac"
-- reg:        sdram controller register set should be <0x1e6e0000 0x174>
-- interrupts: should be AVIC interrupt #0
-
-
-Example:
-
-	edac: sdram@1e6e0000 {
-		compatible = "aspeed,ast2500-sdram-edac";
-		reg = <0x1e6e0000 0x174>;
-		interrupts = <0>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index ec0aba646e7e..b6800e86286a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8848,7 +8848,7 @@ F:	drivers/edac/armada_xp_*
 EDAC-AST2500
 M:	Stefan Schaeckeler <sschaeck@cisco.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+F:	Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 F:	drivers/edac/aspeed_edac.c
 
 EDAC-BLUEFIELD
-- 
2.51.0


