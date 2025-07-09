Return-Path: <linux-aspeed+bounces-1679-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE09C83F1B
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 02:49:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfCjV05jrz2y8W;
	Sat, 12 Jul 2025 12:49:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752044913;
	cv=none; b=TXEZClfod6B3oLzuasekmERH+0OkNpxP5d3F9gvY7smPXdF/k+a+asaImV7EYSqAF125tafeZtNb4bMdEGcxJtO7sXgBwQIOYo8vgi9b9Wnz0L3rZZnBq1VB+oIvMoAH6JdEgUvT90D/fjrxUMsi4OrYYL++4YDlwPoX/yWA4Ap/+owULduJQMKCaMxx/ckCdzd+li5Xek0hoeCN+lJSHB15sxTSR1njhFYDuWnaF7kL4z9ixJt8Pae6MEGooaZULTiLl/SFmGaxDt0Ff7x+Ltutg10MJsSMYgyFZKFzSK4FJczex+W8cJhNVaNb0EmS45GwQhDxI2CtBVqHWAYIug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752044913; c=relaxed/relaxed;
	bh=rrk9GAN2URkaYwLpGd77Qq3lmojo+nmXH6DFkgvm9Eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhJPErIK0S3A/EtTtGdox4gEYhhJEFPAUBRcNRDxFJBEMMK97vvhIs7YRjkI/I9Oac1myPRdRmn2Sqo3lo+VfVBm2k+Y11s2RSPXo5nJEtrwtRu86+IVQzQo7kAQHIyy6/Auw5mQPJy0AEFU1VvfL/ws/Y0pumNV1jChUNBsio3qdC0+0jsNJ5o7xBeJJwh82oOLwbp9yx+oS1eRxoeHgeYHNXeSeBaW0iMYtvk2uh1eXilETMBEtxBZNOzLBFaCEozPlK85Zvtjs4qINbK+HspAZEyYT5//57Qi9q2hSPfsRVbvtDhwhFziEnAI1i9tp+Vqlrf75Een5WcaZnznnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcTbN4Mnlz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Wed,  9 Jul 2025 17:08:32 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 15:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 15:08:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v4 1/4] dt-bindings: net: ftgmac100: Add resets property
Date: Wed, 9 Jul 2025 15:08:06 +0800
Message-ID: <20250709070809.2560688-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
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

In Aspeed AST2600 design, the MAC internal delay on MAC register cannot
fully reset the RMII interfaces, it may cause the RMII incompletely.
Therefore, we need to add resets property to do SoC-level reset line to
reset the whole MAC function that includes ftgmac, RGMII and RMII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/net/faraday,ftgmac100.yaml       | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..d14410018bcf 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Faraday Technology FTGMAC100 gigabit ethernet controller
 
-allOf:
-  - $ref: ethernet-controller.yaml#
-
 maintainers:
   - Po-Yu Chuang <ratbert@faraday-tech.com>
 
@@ -35,6 +32,9 @@ properties:
       - description: MAC IP clock
       - description: RMII RCLK gate for AST2500/2600
 
+  resets:
+    maxItems: 1
+
   clock-names:
     minItems: 1
     items:
@@ -74,6 +74,21 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2600-mac
+    then:
+      properties:
+        resets: true
+    else:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


