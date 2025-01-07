Return-Path: <linux-aspeed+bounces-321-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6532AE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 13:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSBJN02Pkz3bVF;
	Wed,  8 Jan 2025 00:11:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736255475;
	cv=none; b=np19p5Rz+WbXXyUFLCx3ZeyX4j+255IN7YjQj/hrchHDR6X0kuAMHSmfRyhxvKMMJaf04/BxEGXAoGH5CoMgfdV53MFyZdEYOaJ++cb4HIWV0svtJ8DpZVxNs8IU6KQlrxBgWXifmlzhJ5qoKtQn1V6SicMa1bLR//xCuA7h6bXPfEwBCK0pJAVlC54fbBbDv5/+OvJqV+V0fa/xe3FKZSUF3Waekvpd2nnxzBHHWoY+LOW25qHR5h2yLBhYwMtC1HIBg1Wg2Mt6P9y2AoHdOQm/qUojcEj6ZV79uo4K29dIR5A6YN7sWjCJ6zUi5iCDbS7L+l4KyzBcF07X+rp5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736255475; c=relaxed/relaxed;
	bh=BPSDsnf8xMzpznIKoQbetYMFd7ZBSAYbuVYrJIoIquU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bx2WxIhBREKHpM1t7VXTPHQ2yo+F9ZCe1XXqncjkruWtpzozh5jVZNmJefPVXl1a5lOUXq95PSTCePKDCui8SvITdE2hgbuSCi19wg8wEUVh7cx1g4mb7uoF+IPl9zEdZKR55xdZXVrsqcs9e2diWOyT0AH4ps5Pr31fzYJ6DM/6wOilfzMpmicxdwkQC2prcmWBy0zdSseac551OJecx+zFgOnnTn+Xw4/JudEa+D3D1NzZwxIGI2EcoBBrMXSj5ygy17HLEJL3ka1ls6gHP0RGh1vV5RYSETqvFHTFTov8DV6U2SkG9a5UomNp50txvOyZsMpe2LYn8xnodWU6iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oyi4Z30F; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oyi4Z30F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSBJL5Dkcz2xnc
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 00:11:14 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43616c12d72so24462515e9.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jan 2025 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736255471; x=1736860271; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPSDsnf8xMzpznIKoQbetYMFd7ZBSAYbuVYrJIoIquU=;
        b=oyi4Z30FQyGZ869t/hIkzVr0awb3GU2gwVXVGPq6DXSEjmI+dRzNCbf/1xquQDKX4E
         a1dfFyFUAjCsRGFBb1IV/1XjhQV6dxeN+4C26JN0cUh60/Y/6z7lxVfAkipWDqBPWhZX
         gcCTOWzPK6yjvpyBtWu/SkmdVR+Y5FS5oHyudcP+fFmmj1j6/0AHF+8Cu4Odmcy3HCQu
         pvpES7hbQTJiJ7te6/tI0YwSZDHg63qS7Dar9AJnrT87QSwKIqvjEA5ZlsPbZ8zVL14D
         xO918lHLBi+CorZbonW3FfuzL5izymhISGEj1pUj1dEDsx1wGzcSU7uT/vzH55KV+aTG
         MLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255471; x=1736860271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPSDsnf8xMzpznIKoQbetYMFd7ZBSAYbuVYrJIoIquU=;
        b=Aa36wJEFh+Abx0WST+oDw92Dj216rwq276T3cnJCNuSCWInG103Q+32imkhKnEOxjf
         AZkJ2EllLTEZqegSievjngFEQr21kwzd4XIhjvEDxr44wOYC5rdCqgVF4rmYZ1OnvYKE
         OqiNp+w5B6FOi9T32KulJH0wPaUQXMKm1TzqcrXLEBt+8VjYFH4SWQNg6Re9n0CebrUr
         GWwChCMuGtJbGW2a0UeerNdYOz5k/PXit8x5EISCmUwzmGQ5FM3LBR88CxW+9U26Tygn
         3pC06pC6qRcmHbC6kfw2U1HqxZhBiOs+Mli8MmrvD5Qh3DlcZbfgBCt8k/T/DJgKIos2
         VhRg==
X-Forwarded-Encrypted: i=1; AJvYcCWPrtfuwRXym0FDtDlcH+K8OUDc3JGnOXEZa4+9M8nJ3hcYV+ChMQg0kz4ODdIYJpngvrXXrKDxxmhxqa8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjozQBmkWQTuYlLx4ZjN+LQmzILqxJ/dBuv7mO/tN8Gi0Edn/D
	y5cTFHqvz6EHWE9q1lMQ/jBw3a50dITwb01EsdNxVieG76Twb5/WY3STUIjJhwM=
X-Gm-Gg: ASbGncudv2o78czu2Sw6SO9y9GDjMSeiWKo1NF2Kbfju532+Om9W4EZKMR6KoUcc/1R
	7w7VJhPejBG4IBC/Zi/s4b4n5IKf6+Z7xlCcymLNAgYsy7FBsAIarS9Hm503kYiyXvUQXlTTXm/
	lmIzsD7/md/gvzytn2sWAe/sTl84Lhrrsq4TQy4j1KmKOVR+bn4KDbHpnqY4JexoBLZAQgAi6R9
	wkWRnzumCGb2X3l2g/fZejHQRvJO7yM/B0MDqTyLDFwfAlddT4V3smrpy/XfKLel9RuHBE=
X-Google-Smtp-Source: AGHT+IFcDu8xWuN0TunF1FW8lTPc9ujrnA78CGY24BiMzjjLy9sHjT+/sVzeAlZ8ODcnc2aRlSGLHg==
X-Received: by 2002:a05:600c:5103:b0:431:4983:e8fe with SMTP id 5b1f17b1804b1-43668b93cb8mr217094915e9.9.1736255471085;
        Tue, 07 Jan 2025 05:11:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd1682e4sm10229135e9.1.2025.01.07.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:11:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Correct indentation and style in DTS example
Date: Tue,  7 Jan 2025 14:11:08 +0100
Message-ID: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../aspeed,ast2400-vic.yaml                   | 10 +++----
 .../brcm,bcm7120-l2-intc.yaml                 | 30 +++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
index 73e8b9a39bd7..86516cd44b9d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
@@ -52,11 +52,11 @@ additionalProperties: false
 examples:
   - |
     interrupt-controller@1e6c0080 {
-         compatible = "aspeed,ast2400-vic";
-         reg = <0x1e6c0080 0x80>;
-         interrupt-controller;
-         #interrupt-cells = <1>;
-         valid-sources = <0xffffffff 0x0007ffff>;
+        compatible = "aspeed,ast2400-vic";
+        reg = <0x1e6c0080 0x80>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        valid-sources = <0xffffffff 0x0007ffff>;
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
index 786f2426399b..0fcbe304cd05 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -130,23 +130,23 @@ required:
 examples:
   - |
     irq0_intc: interrupt-controller@f0406800 {
-      compatible = "brcm,bcm7120-l2-intc";
-      interrupt-parent = <&intc>;
-      #interrupt-cells = <1>;
-      reg = <0xf0406800 0x8>;
-      interrupt-controller;
-      interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
-      brcm,int-map-mask = <0xeb8>, <0x140>;
-      brcm,int-fwd-mask = <0x7>;
+        compatible = "brcm,bcm7120-l2-intc";
+        interrupt-parent = <&intc>;
+        #interrupt-cells = <1>;
+        reg = <0xf0406800 0x8>;
+        interrupt-controller;
+        interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
+        brcm,int-map-mask = <0xeb8>, <0x140>;
+        brcm,int-fwd-mask = <0x7>;
     };
 
   - |
     irq1_intc: interrupt-controller@10000020 {
-       compatible = "brcm,bcm3380-l2-intc";
-       reg = <0x10000024 0x4>, <0x1000002c 0x4>,
-             <0x10000020 0x4>, <0x10000028 0x4>;
-       interrupt-controller;
-       #interrupt-cells = <1>;
-       interrupt-parent = <&cpu_intc>;
-       interrupts = <2>;
+        compatible = "brcm,bcm3380-l2-intc";
+        reg = <0x10000024 0x4>, <0x1000002c 0x4>,
+              <0x10000020 0x4>, <0x10000028 0x4>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        interrupt-parent = <&cpu_intc>;
+        interrupts = <2>;
     };
-- 
2.43.0


