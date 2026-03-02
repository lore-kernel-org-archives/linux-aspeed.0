Return-Path: <linux-aspeed+bounces-3570-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513C8E9B358
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 10:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPZmz5XxXz3bW7;
	Mon, 02 Mar 2026 21:24:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772447091;
	cv=none; b=JAX8k9wvDyvguobHUSAIARszBLWb3g21kaLoBktVmolsO6Y79PI3xaVsjfaZflcz6wCWfyg9Zvq/XG8D4F6plff8V1CuWHs29Uo85nhvvN1r8e0JqrglGoa/8KLiTp8EihUkcUQ3AlO4DLlQqnlTefArOhwZGLqqQUyq6s8whdIwV7K48e/ED915U7kMublHHH4vOeKkNxzFb48R1ixstvHg2bjQmjR0XbUl+rlMPmIG3C/PvpRs2N8dAnQprba20fc9R5ysv7RVQbS5R1WWjZ+Tv3xEPI+EFbp/WYlThKjIFBkooJ2l64GAGT5RWmNuD/dK4HesMSQ8r82JIyNICw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772447091; c=relaxed/relaxed;
	bh=90C5XzHvFjhq0nOW6I0PWlANFOENSaJmdkGqMXW/040=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XIKa3aFRyPq3iysWerJUuO7shxK7tIz3llVnnqxB+7AIK66aGYNJZV53455CPd/PDv/Wy+scka8HI9ob7hvnJ0cH+KUYVkZDZm38shKY8GlM+e99cEXadAluE0/vrt17PKGzbGxT5nBbfLkaDG9oYSzBHXQq4DBX6CB+SxcgzbcEL7RJK14TI2n3RaP5WwBuJpqrs6dDe4Pli89YQdPRERvDBa3beySAN533ByQgeN812LU1tQYWzZUlMkk8sw9oXIwxVcraDLJ9tpVG4194vXgVVupp/3jVH75lUVJwk0gAx8+XRVRHHLjNYBO3/KEfI+oj1bD2uiHwFDdKS6lbOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPZmz0nlFz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 21:24:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:28 +0800
Subject: [PATCH net-next v6 1/5] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
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
Message-ID: <20260302-rgmii_delay_2600-v6-1-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=3348;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=8NZwoYwb2VCG1LCRSHv+AVjZPo5V+zxxU36gRDN2zqs=;
 b=PrXtRYnWTobVOcowR92HfRVdDkG0LYGyRqdY74i9iNH9IHMIvgJ2igdf+fDectjVVH1j3VUZ4
 IAkoYlhVILJBXeARS7VrfUPv6pi7wmIWtKakW3rLfqU79Ohesamajv6
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The AST2600 contains two dies, each with its own MAC, and these MACs
require different delay configurations.
Previously, these delay values were configured during the bootloader
stage rather than in the driver. This change introduces the use of the
standard properties defined in ethernet-controller.yaml to configure
the delay values directly in the driver.

Each Aspeed platform has its own delay step value. And for Aspeed platform,
the total steps of RGMII delay configuraion is 32 steps, so the total delay
is delay-step-ps * 32.
Default delay values are declared so that tx-internal-delay-ps and
rx-internal-delay-ps become optional. If these properties are not present,
the driver will use the default values instead.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For MAC0/1, per delay step for rgmii is 45 ps
- For MAC2/3, per delay step for rgmii is 250 ps
- Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
Other compatible values remain unrestricted.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 42 +++++++++++++++++-----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..4cac216f7339 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -69,6 +69,30 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
+  aspeed,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
+      This reference is used by the MAC controller to configure the RGMII delays.
+
+  rx-internal-delay-ps:
+    description:
+      RGMII Receive Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
+      own delay step value, it is fixed by hardware design. Total delay is
+      calculated by delay-step * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
+  tx-internal-delay-ps:
+    description:
+      RGMII Transmit Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
+      own delay step value, it is fixed by hardware design. Total delay is
+      calculated by delay-step * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -77,17 +101,17 @@ required:
 allOf:
   - $ref: ethernet-controller.yaml#
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - aspeed,ast2600-mac
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - aspeed,ast2600-mac
     then:
       properties:
-        resets: true
-    else:
-      properties:
-        resets: false
+        aspeed,scu: false
+        rx-internal-delay-ps: false
+        tx-internal-delay-ps: false
 
 unevaluatedProperties: false
 

-- 
2.34.1


