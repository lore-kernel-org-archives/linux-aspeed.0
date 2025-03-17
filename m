Return-Path: <linux-aspeed+bounces-1019-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E5C28B28
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 23:01:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGr7F54lZz2ygm;
	Tue, 18 Mar 2025 10:01:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742180385;
	cv=none; b=kXfcb8G80oosrv8qp6h/lmtfMi0kfly5a1Gddz7PyeK8+oIflJfnkeLsdePahGb+VMuYicYS7GBXEQfVDyukX+4hsqeXPfw0xEtjnzyFdD4L8McXk9NYju0csmTGyymPH3ASYOF/OoloTFVYWO7Ct47YkYyObqleNP+19fgBP0O2L1nh+KP3HVpFx1abZt7tYacDsbc6b5suHIt1lHyX8ewPjPvjhMEYsCG/yOHsDzYNZ25oUuh38LQZgiShojNyDx2kwkXHDXU+WnN151BOyMcOjDFZUlbOVmsCGSvoCXo8jQVW7ed5nqSB6J3sYeLmnGSGfasYhVWt3kPwWB6OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742180385; c=relaxed/relaxed;
	bh=pbcumU2ifuiNtuXVGGwdbDs+0MQ0RaTtxOStGoUTBn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GI0xri8R4ECYW9hEw1YHpf0vjJeLheELM/sYMp8ptmYZkraqjeWDjIYpvhLLDaHq0kaMSPJ0Uef1cbyLBYDjp+jHaNpVk2zf33sYQoUchpcLexgjOoOStPL4qnwvl8T16J9TyfLSdPGNkV54hXqfG2fcTKa9tTewgrPkf9f1Yzv7UrZLqDHnQDIJapy65Dg5jHyMqLfr8zAeITUtLqBI/Do0vtHGO1Ww0yER+Q8nYRdgoE/RH0bbSoncyE2kvjFZQnI9kTERTPbPz6AUTxeSgZ+eSnjfFevcvQZ3jWYpOqjImk0crh0WXl72vrJvDmEMQ9hj2knt+Bc5KUvMa5sygA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGKSx31Sdz2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 13:59:45 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay properties
Date: Mon, 17 Mar 2025 10:59:21 +0800
Message-ID: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
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
Content-Type: text/plain

Add tx-internal-delay-ps and rx-internal-delay-ps to
configure the RGMII delay for MAC. According to
ethernet-controller.yaml, they use for RGMII TX and RX delay.

In Aspeed desgin, the RGMII delay is a number of ps as unit to
set delay, do not use one ps as unit. The values are different
from each MAC. So, here describes the property values
as index to configure corresponding scu register.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..c5904aa84e05 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -66,6 +66,20 @@ properties:
     type: boolean
     deprecated: true
 
+  rx-internal-delay-ps:
+    description:
+       Setting this property to a non-zero number sets the RX internal delay
+       for the MAC. Use this property value as a index not a ps unit to
+       configure the corresponding delay register field. And the index range is
+       0 to 63.
+
+  tx-internal-delay-ps:
+    description:
+       Setting this property to a non-zero number sets the TX internal delay
+       for the MAC. Use this property value as a index not a ps unit to
+       configure the corresponding delay register field. And the index range is
+       0 to 63.
+
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
@@ -102,4 +116,4 @@ examples:
                 reg = <1>;
             };
         };
-    };
+    };
\ No newline at end of file
-- 
2.34.1


