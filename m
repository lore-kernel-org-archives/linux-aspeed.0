Return-Path: <linux-aspeed+bounces-2817-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E27CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 05:56:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2pGl6vy5z3bt1;
	Fri,  7 Nov 2025 16:56:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762495007;
	cv=none; b=ZQ18/i7elrbytEuIqfui8K0Oa7nV83k5PLfM8xWmqt9aqaac16Tc+Ih8FBzqBanFAGfAIpdHtecpIKW2te0ijmWm9u8U+bBl7SAkjkUEK5cCE6enYcRiUWrhffss2vHUMPZ5fPeP6ZRDZdWcfxQkopdNQzYeiTNLbUnwNSjH/dVXS44I3Kk07Yx5oYyCOSUnUgjGAF9WoNw5XFdi0Z+s+GOhVVoNsNM+lWf/Nd2QQP4ns+N1u5+wH9XVGN8R9GL4MJCSNRowkDeLn7/+NqEJhoImvEL+ftOCcbhirfN3+JtLZLdNtqhJkSy76wEgv4UekM4UThwELvAmaY66r5xEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762495007; c=relaxed/relaxed;
	bh=Vz0IKsDXEV/iEkAiGPoQTBssbJuJT4Ke4vWuoRvmiu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkSSRvonT68TE8jxbNxN2Lvx9+fUVa6wGOryU7o3n9pDxq/qFRCnuz5kcZqTeIb3xR+tjASO0CyvZZOI2jy8QNZZ8pyD8h4UOb816Vl2DtmYrfbrAmsO/7YPR8J3L0y6vHoOA1QkrZq6DEvUWYfA30jzfMMGRf/NxmQ47LiN5C3uNRyqzSBvdJf1eghQn1YKSG0DZmnWs6+uYOmJGzUuMtLj2tYnRLIBudqdf2d34OnEvR7RhkQxZsknsXeQdy8A1EhyxACHuxxqI8ZVIg7Yu8CcVygVl5R9Ss/GyTpoDhFi9/FbwaeEEPZpIJszGw7CKS5/vcqicnndnxIX3cVj0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2pGl3LDkz3bfN
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 16:56:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 7 Nov
 2025 13:56:30 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 7 Nov 2025 13:56:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/5] dt-bindings: arm: aspeed: Add AST2700 board compatible
Date: Fri, 7 Nov 2025 13:56:25 +0800
Message-ID: <20251107055629.4075519-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
References: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
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

Add device tree compatible string for AST2700 based boards
("aspeed,ast2700-evb" and "aspeed,ast2700") to the Aspeed SoC
board bindings. This allows proper schema validation and
enables support for AST2700 platforms.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..1c1a12fc3a91 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -109,4 +109,10 @@ properties:
               - ufispace,ncplite-bmc
           - const: aspeed,ast2600
 
+      - description: AST2700 based boards
+        items:
+          - enum:
+              - aspeed,ast2700-evb
+          - const: aspeed,ast2700
+
 additionalProperties: true
-- 
2.34.1


