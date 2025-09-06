Return-Path: <linux-aspeed+bounces-2159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F9CCA0FED
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Sep 2025 01:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJbjZ2mtvz2yrV;
	Sat,  6 Sep 2025 11:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757123346;
	cv=none; b=fg7qKV5eNGIsgj/NOho+XW1I2FDJnsJ7jvIVEt2SU3/mPJf6AvNqEsU+2nb1K+6benYg4OZLDuldkhmAlbiKI0NWKhkrLeoGbJLy6fnmOQlK0uoBSDt6swVKUpGT4HjAxFmSuOJfKGTzs6ytmCL8Ww3cTQSmV3uBcUjZrIKbk6ISle6uGACWLbv7+6Pj4TkzT9uXLMFlfygA9Fq3PO5tvjjTdPPUeDJVjC/111V3hN4k8MNGPrYC9IVUaL4UTY973Lm2+xyTewwotvH8H6IwQSniTd+HKZiDMbFeyOwV13jMTRlW6TAtH548iEC1OG/i7VmiVMBOdaeumuAphHEK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757123346; c=relaxed/relaxed;
	bh=xUkwLhvxo+qlP8q48NozHmrayNsql7bqJa9Izys7F4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs8JtUllkBPL1FeowRMRaetr7FY5S14y50GOTYDmF5MFXnLZx6dwGB9Lyo1kKK+lPFpgXB8Lg/7oJH0fc4t4gWdbidGL2lAShUiOTrjmvVMt2rSv7n3xEHK5NgNZQEnTynFxVcADARnKFG0/ii4+6WgDWQBmyJ18TnFZJCjuOji4RdX+h9JagwTtAL9/aE2+Pnv6bZlqvdR+rEZtf5tDNmN7/d46HzjiZ99BABde6QPfMrk2H4GVKETSi0mAmzNXCDkfC6OCzxjFJydC7uH95dKq5PhnNVGeyH15bluNCZITJeP/9K8L2bgmjo2uwIWNSYhv/fCAH2Iv9Nh6P7Qk3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJbjY6HkSz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Sat,  6 Sep 2025 11:49:05 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 6 Sep
 2025 09:48:46 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 6 Sep 2025 09:48:46 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
Date: Sat, 6 Sep 2025 09:48:44 +0800
Message-ID: <20250906014846.861368-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
References: <20250906014846.861368-1-ryan_chen@aspeedtech.com>
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

Add SCU interrupt controller compatible strings for the AST2700 SoC:
scu-ic0 to 3. This extends the MFD binding to support AST2700-based
platforms.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..67be6d095fe4 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -75,6 +75,10 @@ patternProperties:
             - aspeed,ast2500-scu-ic
             - aspeed,ast2600-scu-ic0
             - aspeed,ast2600-scu-ic1
+            - aspeed,ast2700-scu-ic0
+            - aspeed,ast2700-scu-ic1
+            - aspeed,ast2700-scu-ic2
+            - aspeed,ast2700-scu-ic3
 
   '^silicon-id@[0-9a-f]+$':
     description: Unique hardware silicon identifiers within the SoC
-- 
2.34.1


