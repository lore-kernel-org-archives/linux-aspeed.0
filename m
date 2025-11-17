Return-Path: <linux-aspeed+bounces-2923-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7612CEBF92
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Nov 2025 07:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8ztN1wtXz2ynC;
	Mon, 17 Nov 2025 18:30:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763364636;
	cv=none; b=J0eeCpibfIZL58VJWxGe6IByQ7CioPEf2nbxBg703ByBBszvlDJdaHYYid7wWVpxcG/lm2XCevRq5RhyYk23Z6su54NIOaEVm9hHPLP/EAj87d0ApWz8DUFPegTzE5Onr/c0gwbVval4wz07NpS2tFSYQa8i924pP/4MSiqqOcwXcN3mzfFcfZGn2IrAqKiPcId6BwkzY9wjcSvJf2WBDqUhbVeAJfSWZw4cUoLFREGeuBYaNNoenHR1KeO0NvAXgDRaJrZpL2Myyimw7I93lW5BGkuwoeP2ojArBGiYmVRudyM2WVVLZnnUmyR95CZUU6TTl6vaDd56zAeif81jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763364636; c=relaxed/relaxed;
	bh=oK4Ve9O/PRX7M9Aw9BNaO8rFPHLoVqmtNP6LUflFsfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=l7MmH0U+37dBrfjVQIwPJeq+DbbzpaO0BSWN/tyiWDYSQnIZtDCNqE7CDnjZDrAhFWcIh+9N7N5ReTi4kKHav8/3W4rDB4RnZlWvcfEEBS6t5A18Dy8BbaFNk0Ro6upiPSVGp1pZfa7432CxaTHxHSK2vr+rEpgXV/ugb9kbGY5KEpzCnAsqak3k9V9Pv3YGILB87VUr9PLpN1rClEYT8mDzpinlgHn12KLcBnqaywlIaxgzHqY+Zc7zmMh6DYRsMzaJxNzYbGbYGvNkFBhvYDL7l8M8FnIw2EbvTsLjPFLviqd45Uj5jrBKlGU+s0aQnvVpxph9CwdNPwBNf/lAIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8ztM30Lfz2yFy
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Nov 2025 18:30:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 17 Nov
 2025 15:30:19 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 17 Nov 2025 15:30:19 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 17 Nov 2025 15:30:18 +0800
Subject: [PATCH net-next] dt-bindings: net: aspeed: add AST2700 MDIO
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
Message-ID: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAAnPGmkC/x3MQQrCMBBG4auUWRuYhEjUq4iUofmrszAtmVAKp
 Xc3uPwW7x1kqAqjx3BQxaamS+nwl4Gmj5Q3nOZuChyu3vvkxFYgj9+syyjWQmJ2Iny7T3HmmCL
 1cq2Ydf9fn1TQXMHe6HWePwe0PEVvAAAA
X-Change-ID: 20251117-aspeed_mdio_ast2700-aa089c4f0474
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Andrew Jeffery <andrew@aj.id.au>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763364619; l=1811;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Mj81EjxdRx03SMF1BDIPz2LcJycE1MUESozyiljFuRA=;
 b=w1pnZrswHVUrLtVnSbCd+/kYz2W6un9gP9YIqrCt17cyhGIyuTN64gvRCKimRyU5NtSUScT/z
 AFYvOFYRWI/AaJbK6RY9ErunXmDpLSkNe1srNsJn009Mm3M63KvZK/6
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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..1c90e7c15a44 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -13,13 +13,19 @@ description: |+
   The ASPEED AST2600 MDIO controller is the third iteration of ASPEED's MDIO
   bus register interface, this time also separating out the controller from the
   MAC.
+  The ASPEED AST2700 MDIO controller is similar to the AST2600's.
 
 allOf:
   - $ref: mdio.yaml#
 
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


