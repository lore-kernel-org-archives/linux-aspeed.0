Return-Path: <linux-aspeed+bounces-2543-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7600ECCD1A2
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Oct 2025 01:36:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crFHs2vRcz30Qk;
	Tue, 21 Oct 2025 12:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761010569;
	cv=none; b=cHwU/ugQ0MQ6kY5Ca2T0u+RLWMZZDBMbu3a//vBpwPhFlemvV8VtUecVyzXIos5goex19kjQ0juN2ZmRT1q7qAxtUkSl3hS2H5lRHf0xFwAnNQQx3XidoURoWcf0EH8SfWe7MTXRUAnPolpx1U2FnYP38BIr4Qg5LBjJZNm+e7reoW/pOzfx2S2Ha+sU1oFbz5sWjZXJWpMGGMOOv/vGSSHbWTSDshDuSaTdIQMsUTAj/KqWVHNTpJnjhvXPClmloGhI4XrGM6GKtxtHbzRUP9ALPSLQWHl2VnOwS/qt3kABGfcMQiKnDYD4tWrf3+Assr/oFB6M1XGYxLh4ewlYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761010569; c=relaxed/relaxed;
	bh=CCqoC6BKQrWU+ySMETGzqT0UGonmnocN2eNCWqkxZ+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9x92PB+EeUbskGl1smLlKJmRxodxw/X8nyzrcAu3yCWJhO+b6PMywXCBooEsqYeOcr1n0saUtnHZXMtymFaVDBx7OYohPOQpydUbGn5rxbeKVUe+2MRS4Cs2JLPB/D02Et91FTDn0MrUn5T57bPKhD94PczvCJmOSM0+ZcXL0OaCGi9mNtL6+1lfb8DTDz/h015sVsiZpu9aBuETCQAl2nTnBEGr6VDfMKghvWM6LC3VZWqQTWUNsbTOoMhJHa5lZlNKZ3MmE37Mw0NcsqyxNU0sy9IN6uMEiNhwMzPNK0W6gwmN3IuY4q5Wvh8MnE+zJhsANR0G3GDDiuVgqeOWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crFHr53SSz30MY;
	Tue, 21 Oct 2025 12:36:08 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 21 Oct
 2025 09:35:48 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 21 Oct 2025 09:35:48 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <benh@kernel.crashing.org>, <joel@jms.id.au>,
	<andi.shyti@kernel.org>, <jk@codeconstruct.com.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andrew@codeconstruct.com.au>,
	<p.zabel@pengutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<naresh.solanki@9elements.com>, <linux-i2c@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add global-regs and transfer-mode properties
Date: Tue, 21 Oct 2025 09:35:46 +0800
Message-ID: <20251021013548.2375190-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021013548.2375190-1-ryan_chen@aspeedtech.com>
References: <20251021013548.2375190-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain

The AST2600 I2C controller supports three transfer modes: byte,
buffer, and DMA. To allow board designers and firmware to
explicitly select the preferred transfer mode for each controller
instance. "aspeed,transfer-mode" to allow device tree to specify
the desired transfer method used by each I2C controller instance.

And AST2600 i2c controller have two register mode, one is legacy
register layout which is mix controller/target register control
together, another is new mode which is separate controller/target
register control.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/i2c/ast2600-i2c.yaml  | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/ast2600-i2c.yaml
index 6ddcec5decdc..9fd6976cd622 100644
--- a/Documentation/devicetree/bindings/i2c/ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ast2600-i2c.yaml
@@ -42,11 +42,39 @@ properties:
     description: frequency of the bus clock in Hz defaults to 100 kHz when not
       specified
 
+  aspeed,transfer-mode:
+    description: |
+      ASPEED ast2600 platform equipped with 16 I2C controllers each i2c controller
+      have 1 byte transfer buffer(byte mode), 32 bytes buffer(buffer mode), and
+      share a DMA engine.
+      Select I2C transfer mode for this controller. Supported values are:
+        - "byte": Use 1 byte for i2c transmit (1-byte buffer).
+        - "buffer": Use buffer (32-byte buffer) for i2c transmit. (default)
+                    Better performance then byte mode.
+        - "dma": Each controller DMA mode is shared DMA engine. The AST2600 SoC
+                 provides a single DMA engine shared for 16 I2C controllers,
+                 so only a limited number of controllers can use DMA simultaneously.
+                 Therefore, the DTS must explicitly assign which controllers are
+                 configured to use DMA.
+      On AST2600, each controller supports all three modes.
+      If not specified, buffer mode is used by default.
+    enum:
+      - byte
+      - buffer
+      - dma
+
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the i2c global syscon node, containing the
+      SoC-common i2c register set.
+
 required:
   - reg
   - compatible
   - clocks
   - resets
+  - aspeed,global-regs
 
 unevaluatedProperties: false
 
@@ -57,10 +85,12 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "aspeed,ast2600-i2c-bus";
-      reg = <0x40 0x40>;
+      reg = <0x80 0x80>, <0xc00 0x20>;
+      aspeed,global-regs = <&i2c_global>;
       clocks = <&syscon ASPEED_CLK_APB>;
       resets = <&syscon ASPEED_RESET_I2C>;
       bus-frequency = <100000>;
       interrupts = <0>;
       interrupt-parent = <&i2c_ic>;
+      aspeed,transfer-mode = "buffer";
     };
-- 
2.34.1


