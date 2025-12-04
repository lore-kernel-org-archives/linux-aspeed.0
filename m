Return-Path: <linux-aspeed+bounces-3041-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F0D2CDE4
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Dec 2025 22:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMqcZ3SxSz2xQ1;
	Fri, 05 Dec 2025 09:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764882191;
	cv=none; b=ZSlhgAD/Ye0e/uTmGt6jmdtZR41ReU9PuH3WkLwUZmFur1DyaL+wByyrvBS0hYmsOoIXoGYub0MiF8KXObXa38PU0b81o7i/y7rKmnQyUhHhs4uZRnFe3HuYxPNSqq8NGt2+ITk1ZozmI8g3nxgr4FqYK66AVsjZiA5MtpeTR1MEGZvHdcjsqhhi7f37Qk6IgguxPfSlI+Kezh7mKhDoVfpDL+mGvdawdfAoQvzZdZsyrXBU18FxJvL0WMCzlCHGWb7ez5hCBnOIigk8zngL6YxuoAoyPBY4A7ReFHQBcsv2tSza+Jo0GL07CPKLpk+6rOa97LVhbfTLZ1x9MGa7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764882191; c=relaxed/relaxed;
	bh=l1N6mpnuv4jT9RxjXTIrytWINoWTUYc1DLbaGh34myE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqPohweBHc1nhU8aG/gardTMO7rnpccFiHUrTEGCFcORFr5RjkT/nB+VX6Q5hR1qJ6il6chMqTVDFVX6hW8N4Cp7hEWBQQf3g5SpMvgZ1xU/GBVF1z+OU+ge622bl1r8sfHGiYZeIcQ4y+Kn/5BRmzKhkUdD7oR/sXtkXhwJ1UGNkYX2CNiDH79UmSMyH0NNX3vRQkMjkRJjj1X1RQv9jNVg152tmAi0cuHfViWAuNy+yJL5qZeCfH7Bvnzy9pRiWq3Em7ETeffN3N0WvSynCdRIBJutW9L6FRln9H3TCqPKVnqSuPAQoG6qk5FTI7zdOnm0fUPqOof2H2MSuQCcYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=vqA3Apic; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=xSSmmQPu; dkim-atps=neutral; spf=pass (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=vqA3Apic;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=xSSmmQPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMn661vWPz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 08:03:10 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 52F111D00106;
	Thu,  4 Dec 2025 16:03:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 16:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764882188; x=
	1764968588; bh=l1N6mpnuv4jT9RxjXTIrytWINoWTUYc1DLbaGh34myE=; b=v
	qA3ApicXD3sptxLCPbApJNIKXbl0djgjb5oHYWXDg1QaOa9gAhCM9/8c/mLy6F2i
	e/O1aFkLqZ+BxCyQwhS2xBGaouLBktBTAfidC1J6WZs/XzGPBZJIiqPoP8cNdHWV
	iqs3Wbh7dXBS/J9r1313i8gUNYkKMZNArScHA1awR1EKT1bRuM9aHQj4zMqLJd/9
	TPFCBDO7nCVF3DuLIlnPx+F5uosmd+AgVgMYF2HTqMcc+luJl9tlFvpBnbIxWRHI
	+lwhwrUbhPAUZg1ZSb8L39axX7/4dJPe8YHYqHUdCUpqq8xnax2kYsGKxI9yua2a
	+3NtaTTp/qwBxCt9mRasw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1764882188; x=1764968588; bh=l
	1N6mpnuv4jT9RxjXTIrytWINoWTUYc1DLbaGh34myE=; b=xSSmmQPu5TsLWiffQ
	daUJbtEUGdwxthMzdYoVsm5SnRF79SqB7MXZBq7FaGrYJTL5iOpr22ijF8o59UwD
	FvJpPd0FgLlfBVCf7V6pI9oCXyXU3ZFdrpigRd8m1Smvh0aMo+/NhMRFyhCG+n/p
	+MHFrG7TARxztvS6nWKPlXD6FiJ34C93ruZsXtWIY/yIo2lrIxjMo7YrE0i6P2MG
	JkqPp+GheAWeVvB5VVpAVwD4hDDuVEwIjq7mPGwrEpHxnl2MpTJcmx8CId7Vp/VN
	ID0/oSgMsY8lTeQu0j2xBPRgo6PEMeL3kEFQkdZkRb6uVu5cnxIOmJ3//5syyflh
	JeVCQ==
X-ME-Sender: <xms:C_cxaT-uT95DfiBUP_3ItJN3U5SIAOHN2U2FrtJyITQqREDcuy9Smw>
    <xme:C_cxaX2cjK1-OhyiLPde76zHUfuYKi7JqHeKns43d72eRwsKeS70EUvNSFlxt0Ifw
    -9ZOZXeI_Z-RRp200wU7Dp9aaAI-8XCbhFb4s092k1i0fegwYqyYrQ>
X-ME-Received: <xmr:C_cxaQj9S6xKpPnOJ8Pi1eehOWIzj8XTJ4SUaLAA6UkA_K1apYqu1kcYFpgC03r_KDpKTYpXKmij77BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfgvsggvtggtrgcu
    vehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvghrnh
    epheelhfetiedvvdffgfdttdduudejiefhgfefjeevffeuhffgudehheegjeevtdejnecu
    ffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggttggrsegsshguihhordgtohhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    hosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtoheprghnughrvgifsegt
    ohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopeguvghvihgtvghtrh
    gvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C_cxafZqeic20YghDPmoQbDUL_gZopWebpGiUsIP404RpNxJRRcGOQ>
    <xmx:C_cxaUWw8DaQOCYeoGwrUvmWoal-NobPuTykg7yfzqMY-gyiRcSKVQ>
    <xmx:C_cxafGq4l2BJO23umWWhXzXWNtfv7LxZbTaiU1o3GmHec7SdxJeGQ>
    <xmx:C_cxaWZZLcwkzX64e6z0kKSi9_eDerJ0lfNDaUYKaECMAfJh2n9P2Q>
    <xmx:DPcxaZPzVRajnjvf9d3z1vKj-lZEH-jUjwYoHIDB1-uAuYKdwnEne9SW>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 16:03:06 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 3/3] dt-bindings: hwmon: (aspeed,g5-pwm-tacho) Move info from txt to yaml
Date: Thu,  4 Dec 2025 14:02:36 -0700
Message-ID: <20251204210238.40742-4-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204210238.40742-1-rebecca@bsdio.com>
References: <20251204210238.40742-1-rebecca@bsdio.com>
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

Move the documentation for the aspeed,ast2400-pwm-tacho and
aspeed,ast2500-pwm-tacho devices from a text file to yaml file.

This allows for dts files containing these devices to be validated.

Where the text file documenation of required properties differ from the
implementation, prefer the implementation and update the schema to
match.

"#size-cells" was 1 but implementation is 0.
"#cooling-cells" was marked as required but appears optional.

In the fan subnode, "cooling-levels" is optional according to the code
in drivers/hwmon/aspeed-pwm-tacho.c.

Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
---
 Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml | 91 ++++++++++++++++++++
 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt  | 73 ----------------
 2 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
new file mode 100644
index 000000000000..b23c3519604b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2023 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2400/AST2500 PWM and Fan Tacho controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support up to 8 PWM outputs. The ASPEED Fan
+  Tacho controller can support up to 16 Fan tachometer inputs.
+
+  There can be up to 8 fans supported. Each fan can have one PWM output and
+  one/two Fan tach inputs.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-pwm-tacho
+      - aspeed,ast2500-pwm-tacho
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
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
+patternProperties:
+  "^fan@[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    properties:
+      aspeed,fan-tach-ch:
+        description:
+          The tach channel used for the fan.
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+
+    required:
+      - reg
+      - aspeed,fan-tach-ch
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - pinctrl-names
+  - pinctrl-0
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    pwm_tacho: pwmtachocontroller@1e786000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #cooling-cells = <2>;
+        reg = <0x1E786000 0x1000>;
+        compatible = "aspeed,ast2500-pwm-tacho";
+        clocks = <&syscon ASPEED_CLK_APB>;
+        resets = <&syscon ASPEED_RESET_PWM>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+
+        fan@0 {
+                reg = <0x00>;
+                cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+                aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+        };
+
+        fan@1 {
+                reg = <0x01>;
+                aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt b/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
deleted file mode 100644
index 8645cd3b867a..000000000000
--- a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-ASPEED AST2400/AST2500 PWM and Fan Tacho controller device driver
-
-The ASPEED PWM controller can support upto 8 PWM outputs. The ASPEED Fan Tacho
-controller can support upto 16 Fan tachometer inputs.
-
-There can be upto 8 fans supported. Each fan can have one PWM output and
-one/two Fan tach inputs.
-
-Required properties for pwm-tacho node:
-- #address-cells : should be 1.
-
-- #size-cells : should be 1.
-
-- #cooling-cells: should be 2.
-
-- reg : address and length of the register set for the device.
-
-- pinctrl-names : a pinctrl state named "default" must be defined.
-
-- pinctrl-0 : phandle referencing pin configuration of the PWM ports.
-
-- compatible : should be "aspeed,ast2400-pwm-tacho" for AST2400 and
-	       "aspeed,ast2500-pwm-tacho" for AST2500.
-
-- clocks : phandle to clock provider with the clock number in the second cell
-
-- resets : phandle to reset controller with the reset number in the second cell
-
-fan subnode format:
-===================
-Under fan subnode there can upto 8 child nodes, with each child node
-representing a fan. If there are 8 fans each fan can have one PWM port and
-one/two Fan tach inputs.
-For PWM port can be configured cooling-levels to create cooling device.
-Cooling device could be bound to a thermal zone for the thermal control.
-
-Required properties for each child node:
-- reg : should specify PWM source port.
-	integer value in the range 0 to 7 with 0 indicating PWM port A and
-	7 indicating PWM port H.
-
-- cooling-levels: PWM duty cycle values in a range from 0 to 255
-                  which correspond to thermal cooling states.
-
-- aspeed,fan-tach-ch : should specify the Fan tach input channel.
-                integer value in the range 0 through 15, with 0 indicating
-		Fan tach channel 0 and 15 indicating Fan tach channel 15.
-		At least one Fan tach input channel is required.
-
-Examples:
-
-pwm_tacho: pwmtachocontroller@1e786000 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	#cooling-cells = <2>;
-	reg = <0x1E786000 0x1000>;
-	compatible = "aspeed,ast2500-pwm-tacho";
-	clocks = <&syscon ASPEED_CLK_APB>;
-	resets = <&syscon ASPEED_RESET_PWM>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
-
-	fan@0 {
-		reg = <0x00>;
-		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
-	};
-
-	fan@1 {
-		reg = <0x01>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
-	};
-};
-- 
2.47.3


