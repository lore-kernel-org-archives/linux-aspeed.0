Return-Path: <linux-aspeed+bounces-2523-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6E1CCD184
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 02:08:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqf345Nrvz302b;
	Mon, 20 Oct 2025 13:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760926080;
	cv=none; b=kESCSt+RzasvYECubxhWWRlpVIqP8AQ3NHP3RKCNYCHXidEvmo/KGk03gVzjPjcEsQvgffvWZRxUd2qnfohICZcecKXnBE6uZlB1Yid6tpEE2788jJSJo3GpX1hJijfLsqh+6XLh65dooXz9mG6wowCTo8PuNglx/652mz8mlKzw915K0OnPhKIaeT7SGIEBrG5UeHjUCvOxryRZx/Om2LIuQAzG0b1Sh6kTnd3m7+V4iEvNYC6+lqX98pY0fDb+rcGtkT1VTkc4hRAW3LZl/p0WrC1vWJlic384et+2Aq6YFHdTNJhcSxBnzo3F8VCVbGrRgFTeoZLroMRPtQfaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760926080; c=relaxed/relaxed;
	bh=KITnEFkQN6GzTXN6Ttblpokky9u+E4LCpKyyo2g3EC0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D51SLTuQGLBxmpJG4Ka7BcT+j3P5Q/A7VX0x85iGFfAfdNUB9gBbZhdMjRiyUxd3fiLmukT1Z4s1L5XnAyWpyvEp+xLdqjk+vSlx9ex1xj8QZTcrEtGIh4tpSk7v0kC2pqCeg5besMkMdFtxbG7IiUwWM92POex3wyxHMzPqdsiCJmChfKUUNB1yHtFQHMmpf6Qk0Gin2pO+xnbh+YeI8T8Wv55mpqz20NU1McA78ISOMW3qV9luiomh+R/mu5zZgvNLNGTCfjhkSUuDnVrTUyP0RFThM7MxtasFBKFPypwc/LbG6MLHo+QrMQs/rYWnJGxpbFPuW4D9HwHj/LCmHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqf3404FYz3020
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 13:07:59 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 20 Oct
 2025 10:07:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Oct 2025 10:07:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells range
Date: Mon, 20 Oct 2025 10:07:45 +0800
Message-ID: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..1d3f686577db 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -38,7 +38,8 @@ properties:
     maximum: 2
 
   '#size-cells':
-    const: 1
+    minimum: 1
+    maximum: 2
 
   '#clock-cells':
     const: 1
-- 
2.34.1


