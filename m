Return-Path: <linux-aspeed+bounces-1872-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D58AC87FD2
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcc0508z2xRs;
	Fri,  1 Aug 2025 08:12:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999967;
	cv=none; b=oTd9zY0PPzgN9kQMo9DhqQWTCaAkgZUZNVbNnnyKNyhWr23o18/w7B69R7HL9kXL3ihkksK6Ff+Do4VvSlNrAIFR1qqJax9gvNoQ8VtXaAdEGyPAwGo6fR5SFlm8l1mmdwBKUhstYFFX5VqKLTSBsi19ZrPQrzdHowvawjctNTPySYyE/Urtg+sLcFVXeWZFntNxgUz+rtdpPFSQ+1tu6buy40DUYvecM209Rzc6R+pB5GxJFZpDA1pjzfF41yCCFMDIeo+joEOQGh5wkbsY8LE2CQq84ctxfNGy5A5Dx3iAfcFcg88Or2PADQom/RZ9Xms/fjHoorcfNsne4we37A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999967; c=relaxed/relaxed;
	bh=3NZ6SufYrkjXdgD6YyUWmxuMnyEMDpHdR4fnqfnN0PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLVSd2JZL+Be1qd5ZbRH4+gPasa89Kg2VtzCXvzzsxoAlI2/BKcEe/+e7dThjwsTQAKSa9YMrnK3ltLKvO1/iSAB9nVGjn+E5CmAKG2lnjXuu+R1l8Bo2JzGDhwqJXvIwXQ9eE3qBjuvFwj9hxOXETRXuq0n2VzEhrpYa5TnBGsRYfgy+wVFCKr2TfDumsHP/0u/x/7IZ6Aj2TiMqIk3r2KjyXdD9KP4P8mnEPT8vKaa7ytJktlimQyZ8w3bNyKtv+FMAnOVyRB+VPmAJVi3dq7NsCSl6ntYNMRfWLHt5cRiCUsUJDzcdWbhUn/HDIJdkjE4LdrAl/Dq32R4xU88Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSufTE42; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSufTE42;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcZ0Hg8z2yD5;
	Fri,  1 Aug 2025 08:12:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DE32463F8;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE92C4CEEF;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999964;
	bh=0kFL/C/HEWZ7M63kG+iOdTn4GO2S1xBbGOGTtJ8z7AU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSufTE42qvM3qg+eoMVzRekmq5HV2zU9DsPTV8PcbUnk49s3/opccp9/r9nRriXgw
	 DfePqI1+sRuRDtI6hXXQcIBcbwMOHQ84oVunKRVMq/mWGjhaU6WVRgrAt9DEZld6k/
	 yJFyW0NhLIZqoU+FBDxvijhVyqZfVn+Ah31oNJyjfyJjpxLHRZkbFGrydB0fLx+vFI
	 i2bB+B/Bt8a1qxDu3NSZjDYrlqTwZh1q3DO1AqQiAJPMufBUI7qDBvfzlg3z3ItNLu
	 FBKPrtcbhMbI+VmIpBxNI68r85IMFrhmBbRFQ8ZamDDj90JEmJq0tc/ZeeeRO3Yn7o
	 NjnK6AoKUlPOg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:22 -0500
Subject: [PATCH 5/6] dt-bindings: fsi: Convert fsi-master-gpio to DT schema
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
Message-Id: <20250731-dt-fsi-cleanups-v1-5-e7b695a29fc3@kernel.org>
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

Convert the GPIO-based FSI master binding to DT schema format.

Drop the "fsi-master" compatible as it has not be used consistently and
doesn't represent anything.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 28 ----------
 .../devicetree/bindings/fsi/fsi-master-gpio.yaml   | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
deleted file mode 100644
index 1e442450747f..000000000000
--- a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-tree bindings for gpio-based FSI master driver
------------------------------------------------------
-
-Required properties:
- - compatible = "fsi-master-gpio";
- - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
- - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
-
-Optional properties:
- - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
- - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
- - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
-                                          functions (eg, external FSI masters)
- - no-gpio-delays;			: Don't add extra delays between GPIO
-                                          accesses. This is useful when the HW
-					  GPIO block is running at a low enough
-					  frequency.
-
-Examples:
-
-    fsi-master {
-        compatible = "fsi-master-gpio", "fsi-master";
-        clock-gpios = <&gpio 0>;
-        data-gpios = <&gpio 1>;
-        enable-gpios = <&gpio 2>;
-        trans-gpios = <&gpio 3>;
-        mux-gpios = <&gpio 4>;
-    }
diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml
new file mode 100644
index 000000000000..21bfbad595b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/fsi-master-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: fsi-master-gpio
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+allOf:
+  - $ref: /schemas/fsi/fsi-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - const: fsi-master-gpio
+
+  clock-gpios:
+    description: GPIO for FSI clock
+    maxItems: 1
+
+  data-gpios:
+    description: GPIO for FSI data signal
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO for enable signal
+    maxItems: 1
+
+  trans-gpios:
+    description: GPIO for voltage translator enable
+    maxItems: 1
+
+  mux-gpios:
+    description: GPIO for pin multiplexing with other functions (eg, external
+      FSI masters)
+    maxItems: 1
+
+  no-gpio-delays:
+    description:
+      Don't add extra delays between GPIO accesses. This is useful when the HW
+      GPIO block is running at a low enough frequency.
+    type: boolean
+
+required:
+  - compatible
+  - clock-gpios
+  - data-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi-master {
+        compatible = "fsi-master-gpio";
+        clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+    };

-- 
2.47.2


