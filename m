Return-Path: <linux-aspeed+bounces-2560-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83013CCF9E0
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 07:06:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs0Z12hBrz2yjx;
	Wed, 22 Oct 2025 18:06:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761116761;
	cv=none; b=N8H3jRNiBVGw/F5cedO92ETMt+a7hmR8/9lbc7iaj5PFKpFf5MBfWMfzrHNvRWh1cfb+hS+qqY6GFDgjH6LWhyMEy8BCQOp2wSq8Y5X9xFXAdB0xeGrIOsvXVCAwdMkuPzC1UR0CkfNmT8HVZ1VVPaLRPJHGompxt4WI5+Y9xOlYWqWWHzRBXk7P5r7aOXcD9a1JeTYh6Qo7I1f1MeZYxMxJIauO5Ikxe+0C+dBZcifxTWlxO9FuXfHlnYJluXR6xHe1HCndhZpjmumheJtvefMzu5Q+9BNMNi4EE8Q7Qmotr3YNcXWTgkHX0l06+KTXtWsiK6LX5hot+xOO6D2sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761116761; c=relaxed/relaxed;
	bh=51t1/iNVM2HBzkz2QiorIEzKBR09AqSE5Y7aDiEpWvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9ZSvBaliLEdQG4ghpQQRsYx2kwkmpMHedxA8XxiMVuzd8ezDfkyr9dY+Dg7adOcVaN1iRGQ7Bv+I+dwamcad2ycendR7EZ7Jqhs28FfdFwo4/xu7Rgx7KDsfh3HulM3liPliQ4FIZgkWPwKKS4ul7VppUvAtAJRmkPFCFrMdHWVhye15alfIeRIlzE7frEm3CH4xpMQC61CIrEVVUxtoNYHiNxsqrPALuV6JjRX+psThmdgoaveyRPn6QWzAK49mKgf6VxHu72W8WCAWoZZsalhPiwc5oVV2yA5JEF2WDResSw6m9zoobmQJ4bMEwldQSMOt8OYl2Fu1VyOxItP9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs0Z0658mz2yjs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 18:06:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 15:05:44 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 15:05:44 +0800
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
Subject: [PATCH v6 3/6] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells range
Date: Wed, 22 Oct 2025 15:05:40 +0800
Message-ID: <20251022070543.1169173-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
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

The #size-cells property in the Aspeed SCU binding is currently
fixed to a constant value of 1. However, newer SoCs (ex. AST2700)
may require two size cells to describe certain subregions or
subdevices.

This patch updates the schema to allow #size-cells values in
the range of 1 to 2. This makes the binding more flexible
while maintaining compatibility with existing platforms.
It also resolves dt-binding validation warnings reported
by `make dt_binding_check`.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index da1887d7a8fe..ee7855845e97 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -38,7 +38,7 @@ properties:
     maximum: 2
 
   '#size-cells':
-    const: 1
+    enum: [1, 2]
 
   '#clock-cells':
     const: 1
-- 
2.34.1


