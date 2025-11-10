Return-Path: <linux-aspeed+bounces-2851-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5922DCCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 11:10:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4n555JsHz2xqZ;
	Mon, 10 Nov 2025 22:10:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762773017;
	cv=none; b=LUHTyXnJiFQumbNIJ8lhVHYQ4wbIQB0seLxf8/LqdFnUHiY71F7EVvacwTxrny2WJ7veTG5t0hqbiFBbjrciunSpKBf8huZfeb9nks+N017RH4EgZx0ElZlJ/lipjYySRixutIoZC0GIl6Vsbw1nTwnM2yVofJ1jECHlfiFNGZgkc7KgHROhFd+4a7phEDkCqfUXwR5aphBJ5gAHGH2S+hKlhyUWTotPPlipaHSp1jfekaO3aF63pnlFiIUC5N2EIqmAQFL+tSkhRMpSIgkjlNu0DvPwc5+cngahpbPzJsNiELTJPbWHLcbiyALX5LgnVfou8qwfN3WoGXVUwS/N7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762773017; c=relaxed/relaxed;
	bh=TBFowpaou8TQo3Hgoc6cN75CAvXUcdS40ZE2kBSgpbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L4Aiwq//OSjn1OJPbb/luM/+Na3pNMthOM4SWv+o6lFnnPAgcI8vrbOb4tpDYHQ6WH4tqVRhwVP/hkz2CAqW/l9lFs4+5RI8wVh9SSxwixi92uMEUyJWfj1Yx2gk0k4vF5cF1JcgoNYLho6eZ4+i82smFhUuIvxx1hqKptM1w9waE7UKGAWI/nwDK8lfVZErEbKy1INoSXlyB+juPNhW8vLVqL+18Lc9AypeMkxGqb5xmtPeyAdNo3eM6yX9/nXhTy11it7u4z/t25U8W+r3z5p+0EPF2SeWtBIY50WhR8doY8cahxCgU1NLslxEghfYDGPk5gSbsoqToeRdgau6NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4n551Rqnz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 22:10:17 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 10 Nov 2025 19:09:25 +0800
Subject: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
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
Message-ID: <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=3254;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=zljtQnS+2Qz4N9Z49g+pp/nzPcJ7uvBhD0RAnySzk5E=;
 b=JF/pagcrYhTK7ZxwYyIybgm7E89Z7QEgnZQWmY/UkmSNk5GZp7n5T8Ktt+zlxasLZ++nuKyhZ
 86jGvJ8v9ClBUkOONO01GguRXOmbbisez7+OpQG9VQRPW8lC0VwjDpF
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The AST2600 contains two dies, each with its own MAC, and these MACs
require different delay configurations.
Previously, these delay values were configured during the bootloader
stage rather than in the driver. This change introduces the use of the
standard properties defined in ethernet-controller.yaml to configure
the delay values directly in the driver.

Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
RGMII delay in different MACs. And for Aspeed platform, the total steps
of RGMII delay configuraion is 32 steps, so the total delay is
"apseed,rgmii-delay-ps' * 32.
Default delay values are declared so that tx-internal-delay-ps and
rx-internal-delay-ps become optional. If these properties are not present,
the driver will use the default values instead.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For MAC0/1, aspeed,rgmii-delay-ps property is 45 ps
- For MAC2/3, aspeed,rgmii-delay-ps property is 250 ps
- Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
Other compatible values remain unrestricted.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..66377cff737f 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -69,6 +69,36 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
+  aspeed,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
+      This reference is used by the MAC controller to configure the RGMII delays.
+
+  aspeed,rgmii-delay-ps:
+    description:
+      Speccify the one step for RGMII delay. In AST2600, MAC0 and MAC1 are 45 ps,
+      MAC2 and MAC3 are 250 ps.
+    type: integer
+
+  rx-internal-delay-ps:
+    description:
+      RGMII Receive Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. According to the
+      aspeed,delay-ps to specify the one step delay, the total delay is
+      calculated by aspeed,delay-ps * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
+  tx-internal-delay-ps:
+    description:
+      RGMII Transmit Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. According to the
+      aspeed,delay-ps to specify the one step delay, the total delay is
+      calculated by aspeed,delay-ps * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -85,6 +115,11 @@ allOf:
     then:
       properties:
         resets: true
+        rx-internal-delay-ps: true
+        tx-internal-delay-ps: true
+      required:
+        - aspeed,rgmii-delay-ps
+        - aspeed,scu
     else:
       properties:
         resets: false

-- 
2.34.1


