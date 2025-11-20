Return-Path: <linux-aspeed+bounces-2961-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A289CF256D
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 03:52:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBkvc4mF0z2yG1;
	Thu, 20 Nov 2025 14:52:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763610764;
	cv=none; b=IqwDhaNchI2ZeI8F0Drjn21jmDzbs3Efsj7Bim2dFymcdVrEwpvwWU6ul34dXMXxCw7y5XOSXGh+6OdiN9xEBsH87ODsR4r6Rpqa4ET8lRZ82TC5oHsKqOl6VnTU9vA95ziLWAUyHURnQMoo7GrE82tpi34+b0m8BGQedDho1+rYbN5OUSTQW9bEikpCYZnNQS9gf4/fnlF+drD24ZuaRg2hNOzuSVNBIi7pfNc3SrR3ohB7Jpt4sVvCriV1eqVKESTLnUbTwG3Ao6IZVlcE4d/gYLztqWbVrQywLn5wTITD+q3G2GjP0NT9YdBUS+CsOfT4Ef3XjYMl69SdhoZYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763610764; c=relaxed/relaxed;
	bh=uAJYPrM4K5gSwb8aiZs+R+QjqSI51/lCfO33+UlXeXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TwyhRCNM7iKWSPTszrYCxXLvT/okwMD7Jt5OTErNJF+SNQIZLcCVczDbaAq6rvJv7JDMrEaEInBE7Xd3vKJkMimJ4s7olJbnSfk+NLW+li/khTXtiZRJQUlkfrL54INSLagyqhPtyrCVgz/y+jyD+zDkkZj91ZLYOWuHk5Mp5pBwARaqowmfLtQQukqzcXIPHAfk08HQZAloL2A+yDlVxdIzcYYiPYLES7DFJcBOxkVrVgP+242LXurijpFoEGgKs8JckElrE+Yk38YbjmBM4mv/H3Jz5QGeWqgDDX8Dd0TpYBX5Sp8+1AWkY8Fz0+GkkBfIfj7LweoBpF6s4tXDxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBkvb5By2z2yFy
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 14:52:42 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 20 Nov
 2025 11:52:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 20 Nov 2025 11:52:26 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 20 Nov 2025 11:52:03 +0800
Subject: [PATCH net-next v2] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
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
Message-ID: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAGKQHmkC/32NwQqDMBBEf0X23JRNGtH25H8UkTSudQ8mkoRgE
 f+9wd57HN7Mmx0iBaYIj2qHQJkje1eCulRgZ+PeJHgsGRSqWkrZCBNXonFYRvaDiUk1iMIYbO9
 WT6gbDWW5Bpp4O61PcJSEoy1BX8jMMfnwOe+yPPlfc5ZCipbsC/GmprrW3a+VyM5X6xfoj+P4A
 pggdPvFAAAA
X-Change-ID: 20251117-aspeed_mdio_ast2700-aa089c4f0474
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Andrew Jeffery <andrew@aj.id.au>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763610746; l=1764;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=wmlwbzLwa1koSK2nuP5aUDcsxGgFbO+ySPwBTpaVBGE=;
 b=EQwlHKt16UBrHnbKrYwuae5GVZPaRI0ZvrdLxxtPSwzgIl19qVZQn7nEwAvXm0CflvUE215b4
 ZoofOto8IIyD90g3yw629h1lKDYScsXryAa6gTti/xdU6fbiNeZHY7F
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
to "aspeed,ast2600-mdio".

Although the MDIO controller on AST2700 is functionally the same as the
one on AST2600, it's good practice to add a SoC-specific compatible for
new silicon. This allows future driver updates to handle any 2700-specific
integration issues without requiring devicetree changes or complex
runtime detection logic.

For now, the driver continues to bind via the existing
"aspeed,ast2600-mdio" compatible, so no driver changes are needed.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v2:
- Remove AST2700 description from aspeed,ast2600-mdio.yaml
- Link to v1: https://lore.kernel.org/r/20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com
---
 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..a105dc07ed12 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -19,7 +19,12 @@ allOf:
 
 properties:
   compatible:
-    const: aspeed,ast2600-mdio
+    oneOf:
+      - const: aspeed,ast2600-mdio
+      - items:
+          - enum:
+              - aspeed,ast2700-mdio
+          - const: aspeed,ast2600-mdio
 
   reg:
     maxItems: 1

---
base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
change-id: 20251117-aspeed_mdio_ast2700-aa089c4f0474

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


