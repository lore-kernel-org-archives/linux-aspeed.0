Return-Path: <linux-aspeed+bounces-2079-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB3CA0FF9
	for <linux-aspeed@archiver.kernel.org>; Fri, 29 Aug 2025 23:05:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cDDPQ4lCtz2ytT;
	Sat, 30 Aug 2025 09:04:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756508698;
	cv=none; b=SO5ecTPgLCLhoxvTjNmYq/Z/PVTj4xCJr+f03d5i2gUlxwW5EdNd8BFn6bR2xxK0in+KAMf67HP9o3MxhFS7BV8OAFfce69WZcvKsk07ePSvAQWdv2T9UOO1YOJDlEHdJzRjliyOcVehLz6yxecyDdTRxgiW+PpdJSY8kBPjMfxZrd/dlec/Owp88+ILpd7Ieub2c3d9UptrSb4zvh8WINc5b6pg1LUhzHPhUaeeD0NSXxAyLugKWzGxlV6eteSLTYjkIMmJZ4fU1ulsfPWvCoWlU7Ev4h+JRb+sVUH2xj2P10vaj2JU2FJ7jDkRZyQbqkeJGA1f/UOyeFC0x+X14A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756508698; c=relaxed/relaxed;
	bh=PclyMMgbbDGjur67rW5mJJ9OrsByZ4KCKPvr04JE9L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYRfTD24zz7BSXyMxllFbbuwkdkaQtx5DyiJZATzC6eMLhlp0Ui9SrGNlNhlonNN+VNAs9vr4QX/o5yKqjLY1oA94ouwI9b3qb2POjlyxyDdMpC8kDPDF7o0xsd+eaWb85kp2JYoA7pzwofwX/37U4J7O/KCZs8UhEbVpYJJdxGtIA4t1cU0A0Ud+Znq0dhvrHAVq5mqt0zTH7e3K3jY+v7Gw+W7H6XXj3rtnxgtsMDRqi2yE21zCSeSAdA/VWF9OAvqVnRFeIJDvDDTNmOqyC686YtnZqxhXL8diJapIlSBBlmS3VfdcGEVIqQVUy6wFBq1x1ElHJrY7mUb9/hP1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VQWJI8lu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VQWJI8lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cDDPQ05chz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Sat, 30 Aug 2025 09:04:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E568543D9D;
	Fri, 29 Aug 2025 23:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA53C4CEF0;
	Fri, 29 Aug 2025 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756508695;
	bh=cKMacLufL0Sp3xKcp2iVoauAa71+tRMKOtJUQm7TvL8=;
	h=From:To:Cc:Subject:Date:From;
	b=VQWJI8lunJdXCat2wSxvf1PIhGKg4VXqvOMHKs1L/fyq2QteJo8FIXHCA0V85r81X
	 GInwbhqCJ7F1ejqHbzMMDPfRLMCDQBt5nrV1kXSwXJMO3NZm0jlUYkc0P3kvn9MCm+
	 9I3ebWWQQ3+rHdTZ/Mej30ZJHmGFag4zXBZyH9fN57IEnLjUHveG0GZ07vNxdjQiWh
	 iqIaA8qgF1QFZNVmAj8hD+FNrllDuy590NmEFJUtO7xeedVW6S05LipOQ/tYgE/zFp
	 lSTr1SIVMYbYdB+7hXc7liv+zIeomgASI4gTb6dNTxnTT5KcwSHrXVH3Lz5jkIy1hF
	 6bDnrOTMNcB6Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT schema
Date: Fri, 29 Aug 2025 18:04:49 -0500
Message-ID: <20250829230450.1496151-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
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

Convert the aspeed,ast2x00-p2a-ctrl binding to DT schema format. The schema
is simple enough to just add it to the parent aspeed,ast2x00-scu binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 33 ++++++++++++-
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 46 -------------------
 2 files changed, 32 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..5adb7f6aca45 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -48,8 +48,34 @@ properties:
 
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
-    description: See Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+    description: >
+      PCI-to-AHB Bridge Control
+
+      The bridge is available on platforms with the VGA enabled on the Aspeed
+      device. In this case, the host has access to a 64KiB window into all of
+      the BMC's memory. The BMC can disable this bridge. If the bridge is
+      enabled, the host has read access to all the regions of memory, however
+      the host only has read and write access depending on a register
+      controlled by the BMC.
     type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2400-p2a-ctrl
+          - aspeed,ast2500-p2a-ctrl
+      reg:
+        maxItems: 1
+
+      memory-region:
+        maxItems: 1
+        description:
+          A reserved_memory region to be used for the PCI to AHB mapping
+
+    required:
+      - compatible
+      - reg
 
   '^pinctrl(@[0-9a-f]+)?$':
     type: object
@@ -123,6 +149,11 @@ examples:
         #size-cells = <1>;
         ranges = <0x0 0x1e6e2000 0x1000>;
 
+        p2a-control@2c {
+            compatible = "aspeed,ast2400-p2a-ctrl";
+            reg = <0x2c 0x4>;
+        };
+
         silicon-id@7c {
             compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
             reg = <0x7c 0x4>, <0x150 0x8>;
diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
deleted file mode 100644
index f2e2e28b317c..000000000000
--- a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-======================================================================
-Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
-======================================================================
-
-The bridge is available on platforms with the VGA enabled on the Aspeed device.
-In this case, the host has access to a 64KiB window into all of the BMC's
-memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
-has read access to all the regions of memory, however the host only has read
-and write access depending on a register controlled by the BMC.
-
-Required properties:
-===================
-
- - compatible: must be one of:
-	- "aspeed,ast2400-p2a-ctrl"
-	- "aspeed,ast2500-p2a-ctrl"
-
-Optional properties:
-===================
-
-- reg: A hint for the memory regions associated with the P2A controller
-- memory-region: A phandle to a reserved_memory region to be used for the PCI
-		to AHB mapping
-
-The p2a-control node should be the child of a syscon node with the required
-property:
-
-- compatible : Should be one of the following:
-		"aspeed,ast2400-scu", "syscon", "simple-mfd"
-		"aspeed,ast2500-scu", "syscon", "simple-mfd"
-
-Example
-===================
-
-g4 Example
-----------
-
-syscon: scu@1e6e2000 {
-	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
-	reg = <0x1e6e2000 0x1a8>;
-
-	p2a: p2a-control {
-		compatible = "aspeed,ast2400-p2a-ctrl";
-		memory-region = <&reserved_memory>;
-	};
-};
-- 
2.50.1


