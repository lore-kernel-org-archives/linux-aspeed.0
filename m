Return-Path: <linux-aspeed+bounces-2441-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72ABCCD194
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 15:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmJ791zWNz3cYg;
	Wed, 15 Oct 2025 02:29:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760455797;
	cv=none; b=aBfS9xSYYDMEXBHYL+gJGsvOwSh346XZWuayTRXg/MKODVmrVf+Bju6E5nVDNK3eGXLYu7IxmAY65ah2GGwxQkeB90TJiaCxMLhJ7eLM8lp6qZ6JaQ8O525PwTDW39TkPoHdLcUy/GakI5uNxg/e3jXAFsKupkIObVoBXM4q6VBCkQWxhhIqIDR9FDk/NMesdaPkH8uZUQ6BBCK062/7RWDg2PgFM2trOlUSgas6xkfH8vqF7R0i00cRoqh7tssJDwlyC6CxJTn2t9UVV8bhp9aeO9sDwLsJAbpMaA1otSrUf4CRQA0ONK/q+qSJsbnnubb7XRje8PbGl5MLItQ4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760455797; c=relaxed/relaxed;
	bh=WJ3wgMAYUBjmffEpxEcFsRtBghftLqNL1ylvJ36Y1bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g51uy72ToghbJLT229hoX6wV3R6Le5byV3AV0KxrnhQPHRJs6AmLn0cRwlsZIIE9ceV23nY1f8JVdcW9Uy8JjQ0KUXJe6WFkfTIavIsFY9iOJprd/kI5dCsMGTEmVa/urqiPWKgsuRwhsNQj+8pC0cn8o1QEFkeMKBB+FEiIMyMugMM5BQiN4ZVk3PRHRCc/zRH0uzzOkXhLLh49IklBUvb9sXFIOazomlnQN7zopfsi/R0dybVStwUUE2kh+cxIcf4B6ICbj6XKnsedkxurqh8aYDb03DGyWnFDq1S6ek9fNkcHcWTu0Y66hbDhhDAC/MY+ywEyzEtTHIafzXhdQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eMkaAH4V; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eMkaAH4V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmJ783XnTz2yrZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 02:29:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 85CDC6230A;
	Tue, 14 Oct 2025 15:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40A1C4CEE7;
	Tue, 14 Oct 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455793;
	bh=zYExi83W0RHyJrqMwtyqJRZDpbfqUykmcag8kOhkVUI=;
	h=From:To:Cc:Subject:Date:From;
	b=eMkaAH4VUyJhLA+HEJG27I9pneelGaB8Y6DWmSQOO2qeeoZXmbHeHdaRSz/LHr53U
	 JPYOf98BlNoLSMpffIHQoztBZpWlMtYt//Z+NMY0C8lTN6IkgBtGj+7sZaFBKvazQK
	 E9CtgO2JZrsSYLEub6xnkVsKyOp4AhLYEisIjvdpRIP1O2+7+P2jkRaUBf1tzHqlfH
	 Od4tZLfPZ1AKRu1RegKMPhC2hGkEE4jilFtA7C3oxCdksozbgdtDOoVcIe2rNQvbih
	 2H4v9pDdDYwYpxfza+OAhd/gDcolFANkctu1tFo+4aYdsjhR+LX7aiqEH1EE3GDS1/
	 ocRhZ/HwW3phw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Corey Minyard <corey@minyard.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ipmi: Convert aspeed,ast2400-ibt-bmc to DT schema
Date: Tue, 14 Oct 2025 10:29:47 -0500
Message-ID: <20251014152948.3782738-1-robh@kernel.org>
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

Convert the aspeed,ast2400-ibt-bmc binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt  | 28 ------------
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
deleted file mode 100644
index 25f86da804b7..000000000000
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Aspeed BT (Block Transfer) IPMI interface
-
-The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
-(BaseBoard Management Controllers) and the BT interface can be used to
-perform in-band IPMI communication with their host.
-
-Required properties:
-
-- compatible : should be one of
-	"aspeed,ast2400-ibt-bmc"
-	"aspeed,ast2500-ibt-bmc"
-	"aspeed,ast2600-ibt-bmc"
-- reg: physical address and size of the registers
-- clocks: clock for the device
-
-Optional properties:
-
-- interrupts: interrupt generated by the BT interface. without an
-  interrupt, the driver will operate in poll mode.
-
-Example:
-
-	ibt@1e789140 {
-		compatible = "aspeed,ast2400-ibt-bmc";
-		reg = <0x1e789140 0x18>;
-		interrupts = <8>;
-		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
-	};
diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
new file mode 100644
index 000000000000..c4f7cdbbe16b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-ibt-bmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Block Transfer (BT) IPMI interface
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-ibt-bmc
+      - aspeed,ast2500-ibt-bmc
+      - aspeed,ast2600-ibt-bmc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    bt@1e789140 {
+        compatible = "aspeed,ast2400-ibt-bmc";
+        reg = <0x1e789140 0x18>;
+        interrupts = <8>;
+        clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
+    };
-- 
2.51.0


