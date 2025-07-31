Return-Path: <linux-aspeed+bounces-1873-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7543FC87FDA
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcc405rz2yD5;
	Fri,  1 Aug 2025 08:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999968;
	cv=none; b=Nt9m44thVDpXjqErD0sS4sncuiP9iZsHdLGyGwp41b2H2cglFijEEUVUMsA6oRU/nAdbpnJVOooMxnm0JdsWNwzVW3NOmlDJAlDEAphJPJ2/lerJpmvZz76abHotV2YcTfQuxVOD4okcNZ7087er6f/13Sr2/Iz25p4V+9K/sAQ7VdedNeR53zTKDAggkriNnFxmZX9FUD512lGuhJJ+YT2f6HUfyUFVo1eeUedKL90N+Dfw5IB67mOJslkBED0qv/xu2PAVuYfh/Epd7g/+rGjcCJvElvnAgaPmdW6Gj5KqfkqfPI0gfOzHsSoqSzPJZJCeFolj0boAnu3/LLZizg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999968; c=relaxed/relaxed;
	bh=cIuHZJr3d0IkRmCu/kJiMSIaqasjuHpmTpf21AWXoDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0Mif3VykWl0rfxRsfPTGuTfbXrVfFMoNkygWpkSSxtVP+QJqyEZA8m6wtsb3/HoOXafT/Sf/1XVF7ed1kKz2Q0Hys/hCdOOHI9a7YK33/iueUil3DkKpla/dECdlgK2Humtwnn4M4+BLAfBnMpm7QPUWny1sgPqOAQL3aDxn+49FUciu/lFQaNhKerNrKsvxxcTvMXuAeBhxOAfN0dddW+yV9Aewm+GdFccduPVvy22wVr0LtWa1w4xqUni3wUtDGojF2WY9ncrDZQQfkrChXZV16Gdlldo9wUiW2Ynr+YIFHGg0uEuYOrl/LBThhwCGqK5jrkfVqCCzdg1c0LKwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WiPdH8bJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WiPdH8bJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcZ5Bjkz2yKq;
	Fri,  1 Aug 2025 08:12:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 353494353A;
	Thu, 31 Jul 2025 22:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E7C4CEEF;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999965;
	bh=ynT/7P19nBEbnk4v3wUHrwMTXAlpxpXmfSbDLW7QBow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WiPdH8bJVZiPwaVYPbRRr523yZEzOPQ+ie6pu6R67AsJQNNDlJEGT7ay45wD7eDkq
	 LWt9adqI1IaCuV8oC5dgyWEPfcpu0QWaFm81n00/ylYgb66xnFkzMEFgIWG0FbBJYp
	 dvh8q5g065Hf5jP+cXZ/eg+BAU2Td+fwPUhef4xpkbzfSeI9FKX7sA1ba+y8me/2hc
	 pN0WY4/A4lK+hUzEbMPDIDPoHZR9R8cdk48SP3pV7KbsIJVTOSEsyyO2ucOLBciLMB
	 iyTpyCCDMz7xlXpajr2lRYL/VBzx0bxlOT3SDiWhTKYXg4flf5djaa4SSIWFt0u6xI
	 ZCFD5xkDIvBkg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:23 -0500
Subject: [PATCH 6/6] dt-bindings: fsi: Convert aspeed,ast2400-cf-fsi-master
 to DT schema
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
Message-Id: <20250731-dt-fsi-cleanups-v1-6-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

Convert the ASpeed Coldfire offloaded GPIO FSI master.

Drop the "fsi-master" compatible as it has not be used consistently and
doesn't represent anything.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml | 81 ++++++++++++++++++++++
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  | 36 ----------
 2 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
new file mode 100644
index 000000000000..690b6c936f18
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/aspeed,ast2400-cf-fsi-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASpeed ColdFire offloaded GPIO-based FSI master
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+allOf:
+  - $ref: /schemas/fsi/fsi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-cf-fsi-master
+      - aspeed,ast2500-cf-fsi-master
+
+  clock-gpios:
+    maxItems: 1
+    description: GPIO for FSI clock
+
+  data-gpios:
+    maxItems: 1
+    description: GPIO for FSI data signal
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO for enable signal
+
+  trans-gpios:
+    maxItems: 1
+    description: GPIO for voltage translator enable
+
+  mux-gpios:
+    maxItems: 1
+    description:
+      GPIO for pin multiplexing with other functions (eg, external FSI masters)
+
+  memory-region:
+    maxItems: 1
+    description:
+      Reference to the reserved memory for the ColdFire. Must be 2M aligned on
+      AST2400 and 1M aligned on AST2500.
+
+  aspeed,cvic:
+    description: Reference to the CVIC node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  aspeed,sram:
+    description: Reference to the SRAM node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - clock-gpios
+  - data-gpios
+  - enable-gpios
+  - trans-gpios
+  - mux-gpios
+  - memory-region
+  - aspeed,cvic
+  - aspeed,sram
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi-master {
+      compatible = "aspeed,ast2500-cf-fsi-master";
+      clock-gpios = <&gpio 0>;
+      data-gpios = <&gpio 1>;
+      enable-gpios = <&gpio 2>;
+      trans-gpios = <&gpio 3>;
+      mux-gpios = <&gpio 4>;
+      memory-region = <&coldfire_memory>;
+      aspeed,cvic = <&cvic>;
+      aspeed,sram = <&sram>;
+    };
diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
deleted file mode 100644
index 3dc752db748b..000000000000
--- a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
-------------------------------------------------------------------------
-
-Required properties:
- - compatible =
-	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
-   or
-	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
-
- - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
- - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
- - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
- - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
- - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
-                                          functions (eg, external FSI masters)
- - memory-region = <phandle>;		: Reference to the reserved memory for
-                                          the ColdFire. Must be 2M aligned on
-					  AST2400 and 1M aligned on AST2500
- - aspeed,sram = <phandle>;		: Reference to the SRAM node.
- - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
-
-Examples:
-
-    fsi-master {
-        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
-
-	clock-gpios = <&gpio 0>;
-        data-gpios = <&gpio 1>;
-        enable-gpios = <&gpio 2>;
-        trans-gpios = <&gpio 3>;
-        mux-gpios = <&gpio 4>;
-
-	memory-region = <&coldfire_memory>;
-	aspeed,sram = <&sram>;
-	aspeed,cvic = <&cvic>;
-    }

-- 
2.47.2


