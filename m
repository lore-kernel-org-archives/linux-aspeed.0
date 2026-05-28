Return-Path: <linux-aspeed+bounces-4145-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2A8CD5BD5
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 May 2026 07:42:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQz2w21Msz2yFC;
	Thu, 28 May 2026 17:42:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779954120;
	cv=none; b=ki4MbvomVcjhkZGQB/CBbmDDiRBtrVLA25wLSjLlxwHqjeNRL9GUeRfHV0MBxT/w2ghoobkPLHlxPPkFEzMTXLfhT0RWRSfh2+INaJUzP2FaI5FNkT0wWjJ1391xi+LrM0DxE/ObR2m0/tpMXVauCEQ675yBozXi/PP5X3OquW1ObjVp68ng4t3xBkYq8FSeYk8DVVy/RFdGYwbRmZjGEbSU5GVWzrPilo98UZErY2SYHG3rIN+EFA0C3O7gqIXxLkye7U2isLEl9YiB1UdxF8fpQzSAPIiLHcqQleISOLB+N9pnwJW/LqdeH+DhBZaIdjorFeiI8AlSnrYYMIDY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779954120; c=relaxed/relaxed;
	bh=s0W5IynKjZb9qrF9//+WtLwUT+g/PsxlXT4pC7Ev7e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N/BeBV/IxyrN1JVRS+5Xuw4ermymvLhokbSBabPFya5IxtZwgvEtJaiZg435D5btssIXdYtw8LQYq0Db0tLFqBBYobW/F9OKANbTleJKDVRjgInDe8M2lUtHjy+hPWYnqRVmvCKrseIcSPaYE+IGg1R3oDJiFQWhseVDXvwGegeBxh4VFiMlTS9OIPj+WfmqBG3uEFVYTJhxYxBthXfDB4bW5FLCwln4kWVoFDUhkrWeSUCFRtIBPgzWHokUSWrEGMEpX6wuHSH8IogV1j+/r8xaco6k736oAsZtBNllqACBPy1jVuzW0c4auw84qSIXuoWn5VRWToctzsv/uc1VrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQz2v4JLzz2yVM;
	Thu, 28 May 2026 17:41:59 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 28 May
 2026 15:41:37 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 28 May 2026 15:41:37 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 28 May 2026 15:41:38 +0800
Subject: [PATCH v30 3/5] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
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
Message-ID: <20260528-upstream_i2c-v30-3-5d4f9adc3530@aspeedtech.com>
References: <20260528-upstream_i2c-v30-0-5d4f9adc3530@aspeedtech.com>
In-Reply-To: <20260528-upstream_i2c-v30-0-5d4f9adc3530@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779954097; l=1769;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=P8FOm2OlqLJ/+F1CLt832mjsrW8d4pnBuooTxj2MoGw=;
 b=9RcsccAr7/LeQQf+xwQ/ed2Utjtd7clCzGfYU+c/I7tLJTs//0QE6LpQ0GM0HlRJ1nuRPxzyw
 livbGJaSY3nBo8Zm0IJgzxAirZdTsQMuuu8fmmImaN+lbwNWema46YS
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the aspeed,global-regs phandle to reference the AST2600 global
registers syscon node, containing the SoC-common I2C register set.

These properties apply only to the AST2600 binding. Legacy DTs remain
unchanged.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v29:
- remove aspeed,enable-dma properties.

Changes in v28:
- update commit message correspond with aspeed,enable-dma.
- remove aspeed,transfer-mode and add aspeed,enable-dma property and
  description.
- Fix aspeed,enable-dma description to reflect hardware capability rather
  than software behavior

Changes in v27:
- change aspeed,transfer-mode to aspeed,enable-dma.
---
 Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index abc614315dff..21469715d845 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -48,6 +48,12 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the i2c global syscon node, containing the
+      SoC-common i2c register set.
+
 required:
   - reg
   - compatible
@@ -70,4 +76,5 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
     };

-- 
2.34.1


