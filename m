Return-Path: <linux-aspeed+bounces-2078-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62939CA0FF9
	for <linux-aspeed@archiver.kernel.org>; Fri, 29 Aug 2025 23:04:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cDDPH5jr3z2yrq;
	Sat, 30 Aug 2025 09:04:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756508691;
	cv=none; b=J0HXnCavjzToAvbNySz0Aa02vXkgMi81CQquMfmkvzpTFzzOeSu3fgbZVwQPjzdKV3HI3ysrmxaydCiJBQcuxnf5B0JJ201zc8ajhcuoSvfU7AjPntIYOg50uzoU78LptQvfoyGwR9qtFGdF7t1gYhINC6dE1bvSTQYAR4hU1ntMoRX6v9pm/sppCZi4jYlrjypyAyXIStCCMm/47mCIikbQ1edMLCs+aMRDBAlM8z+DuQ+yt5EkBVc99ksIzMfHQ+hUJpaorLJ+flHLH51dKsBMI/4PRTFwAq3in+VgEabJ4c+SYeEaGVs3XQruZDIFpl2zBSP8vQkHii2BWPqukg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756508691; c=relaxed/relaxed;
	bh=xkCZhodwr3RomP8vx5KfiL+DMYSIm6v8A61e1GuVIto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOf36arevDJ03GKF0jAJ5/H5MSohhNRzGEpEZBFCTa1OruGOkH/mye0zosIV+ICQrOURKRIjtDm+YU4FK8zVbGbFbaq4DtbnyakiRZupU4+m/VGDWCPKj5/Z8vJE93/bLmawrNSahp9G2NVtVZAegP8PHC689pzGJy/BNIaVpjupDti2nHc62REZbKT/9V4yCJud/8e6ftR6QzEp4I/wUoqySxdawO1rlHnG7dgm5VrOjOKi/f461l+e3NFi3Rn6B11tV+wp37CCzLJbLUzvsugqxEkZUIY+KI4AldycwGhO3ztKdp77cM9FiZ0F4clNPCAxnZhrh63jU7r3IXv+MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n40IqzHf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n40IqzHf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cDDPF5Zrsz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Sat, 30 Aug 2025 09:04:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F1FE6014D;
	Fri, 29 Aug 2025 23:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12622C4CEF0;
	Fri, 29 Aug 2025 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756508687;
	bh=lVy0nGCp4W9LsUGnCrLcZC8nGhc9aZD0sfWzO1ugqb0=;
	h=From:To:Cc:Subject:Date:From;
	b=n40IqzHf8NlGH+zlDQkwIjiMqxccwyPOgUi2Gb97TUhyJ0HxLOqJBAgDX/+Ruqrn2
	 VGsGBVNI6hYorMB0LNfKslKl/xi6j1aEkFz5hRGbFm1MrZiPpLVNItHg7mVbW0Uuom
	 yLXEkP8LY3BW/7XulqzHf4v6FbZy0xC4EHYRm0roxM3lCLz2QweX9EQVMczT6uTnXg
	 IXL0w2yvzWfotuDdrbCoAYa3kw44y185fDNL3IbiY6+EDuqEwNL3xyOuZ9D+IXFzVQ
	 wjvPjr8hfrAFVbxIiPjqDb13MgyUy2G318dovaYNXLWqU/hs5XByEtw7hU89n2o3/w
	 V0EV0ZL8fXwhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: Convert aspeed,ast2400-gfx to DT schema
Date: Fri, 29 Aug 2025 18:04:40 -0500
Message-ID: <20250829230442.1495926-1-robh@kernel.org>
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

Convert the ASpeed GFX Display Controller binding to DT schema format.
There was a duplicate, incomplete binding in mfd which can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/gpu/aspeed,ast2400-gfx.yaml      | 58 +++++++++++++++++++
 .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -------------
 .../devicetree/bindings/mfd/aspeed-gfx.txt    | 17 ------
 MAINTAINERS                                   |  2 +-
 4 files changed, 59 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt

diff --git a/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml b/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
new file mode 100644
index 000000000000..77ec5ad10ac6
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/aspeed,ast2400-gfx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED GFX Display Controller
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2500-gfx
+          - aspeed,ast2400-gfx
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+    description:
+      a reserved-memory region to use for the framebuffer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    display@1e6e6000 {
+        compatible = "aspeed,ast2500-gfx", "syscon";
+        reg = <0x1e6e6000 0x1000>;
+        clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+        resets = <&syscon ASPEED_RESET_CRT1>;
+        interrupts = <0x19>;
+        memory-region = <&gfx_memory>;
+    };
diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
deleted file mode 100644
index 958bdf962339..000000000000
--- a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Device tree configuration for the GFX display device on the ASPEED SoCs
-
-Required properties:
-  - compatible
-    * Must be one of the following:
-      + aspeed,ast2500-gfx
-      + aspeed,ast2400-gfx
-    * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
-      be present
-
-  - reg: Physical base address and length of the GFX registers
-
-  - interrupts: interrupt number for the GFX device
-
-  - clocks: clock number used to generate the pixel clock
-
-  - resets: reset line that must be released to use the GFX device
-
-  - memory-region:
-    Phandle to a memory region to allocate from, as defined in
-    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-
-
-Example:
-
-gfx: display@1e6e6000 {
-	compatible = "aspeed,ast2500-gfx", "syscon";
-	reg = <0x1e6e6000 0x1000>;
-	reg-io-width = <4>;
-	clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-	resets = <&syscon ASPEED_RESET_CRT1>;
-	interrupts = <0x19>;
-	memory-region = <&gfx_memory>;
-};
-
-gfx_memory: framebuffer {
-	size = <0x01000000>;
-	alignment = <0x01000000>;
-	compatible = "shared-dma-pool";
-	reusable;
-};
diff --git a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
deleted file mode 100644
index aea5370efd97..000000000000
--- a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Device tree bindings for Aspeed SoC Display Controller (GFX)
-
-The Aspeed SoC Display Controller primarily does as its name suggests, but also
-participates in pinmux requests on the g5 SoCs. It is therefore considered a
-syscon device.
-
-Required properties:
-- compatible:		"aspeed,ast2500-gfx", "syscon"
-- reg:			contains offset/length value of the GFX memory
-			region.
-
-Example:
-
-gfx: display@1e6e6000 {
-	compatible = "aspeed,ast2500-gfx", "syscon";
-	reg = <0x1e6e6000 0x1000>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 11a58d3279ec..536a0403edda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7592,7 +7592,7 @@ M:	Joel Stanley <joel@jms.id.au>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+F:	Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
 F:	drivers/gpu/drm/aspeed/
 
 DRM DRIVER FOR AST SERVER GRAPHICS CHIPS
-- 
2.50.1


