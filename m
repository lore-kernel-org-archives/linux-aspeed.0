Return-Path: <linux-aspeed+bounces-2160-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C0CAC580
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Sep 2025 01:49:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJbjb3HG0z2yrX;
	Sat,  6 Sep 2025 11:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757123347;
	cv=none; b=PjaYCt5VUu8O88sfSdKStyFZrNBOJHCJHAJmBLX3kHY5Yu6pjtb9UWyiw96ZsPZut7hKmiMEe3LzA/ljICx3rFO0AcrhI20j36U/pYnXJ+MlFumpgwBDCczykszeBXOREo7x/uXbWwPYXE5BWPdxsF7NDLfz+v1BfQjQIFGEHyJoPHEwvduaWw63FoIyVvvNk9dmMqa5v/0W9DVILieTvBODQVcm0uZPp4onOM6rcVduN66I8UmUU5BrNCX7EcNVtc59EOcuphFSsBlIwt2C1JBO8bTqJedbjW61YLFIaSFqwtIZDpRDyHvKOstSgkTuUum9DS6o+rfAB0/p9UqlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757123347; c=relaxed/relaxed;
	bh=oc9QtlnivrmyRdWiEc2S9LYTB9UqgUtEatt5XHUCLvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHjb8X8sVPNx9JhoKFse6rVjUKnekqD9zD6LcRDM00DJQOpWYppbDdiLS3oM+a48VG4ctYMSUxV/fN+xcnOPmw3JJ67zWExvRhmt8SAydYLcvlV0WjeOOHbh3gED2/sUlp7kfjtbD3T0KUjQkhq1WtLJEztFeXzMMHEC3NdhoRubhOJP/eL1+jeag+XFvi4/lknBpTrWchcYzZUJALduQ0MjOnR2Yjl0Bkc1L8Wss/v5qj+VKdUoq2MWd/eGqnqbQxRpOpP3Y9804dx6PoTIHNvCjzkZPcQXnLfsLR/dWAXsfPRTxCJkmMNGikg6Rh70XB9VB9Y5sKn8BK3kw7jkRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJbjZ44h2z2xWc
	for <linux-aspeed@lists.ozlabs.org>; Sat,  6 Sep 2025 11:49:06 +1000 (AEST)
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
Subject: [PATCH v3 3/4] dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC compatibles
Date: Sat, 6 Sep 2025 09:48:45 +0800
Message-ID: <20250906014846.861368-4-ryan_chen@aspeedtech.com>
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

Add compatible strings for the four SCU interrupt controller instances
on the AST2700 SoC (scu-ic0 to 3), following the multi-instance model used
on AST2600.

Also define interrupt indices in the binding header.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../aspeed,ast2500-scu-ic.yaml                     |  6 +++++-
 .../interrupt-controller/aspeed-scu-ic.h           | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
index d5287a2bf866..d998a9d69b91 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-ic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+title: Aspeed AST25XX, AST26XX, AST27XX SCU Interrupt Controller
 
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
@@ -16,6 +16,10 @@ properties:
       - aspeed,ast2500-scu-ic
       - aspeed,ast2600-scu-ic0
       - aspeed,ast2600-scu-ic1
+      - aspeed,ast2700-scu-ic0
+      - aspeed,ast2700-scu-ic1
+      - aspeed,ast2700-scu-ic2
+      - aspeed,ast2700-scu-ic3
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
index f315d5a7f5ee..7dd04424afcc 100644
--- a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -20,4 +20,18 @@
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
 #define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
 
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC0_PCIE_PERST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC1_PCIE_RCRST_HI_TO_LO	2
+
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_LO_TO_HI	3
+#define ASPEED_AST2700_SCU_IC2_PCIE_PERST_HI_TO_LO	2
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC2_LPC_RESET_HI_TO_LO	0
+
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_LO_TO_HI	1
+#define ASPEED_AST2700_SCU_IC3_LPC_RESET_HI_TO_LO	0
+
 #endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
-- 
2.34.1


