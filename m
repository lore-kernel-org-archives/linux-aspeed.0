Return-Path: <linux-aspeed+bounces-4262-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CA7CD98D2
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 03:30:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfXYq4fZJz3bwX;
	Tue, 16 Jun 2026 13:30:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781580623;
	cv=none; b=eJuLCTwfsjoiCPk6A8qHu2sTF12NCPq2i6qTsOs8/MfBUk9AJMfCZzrK63ASyvFRw1Pht6Lv5PKv6FirEyt0i2G4mPlv5AM9yL6yIAc5JBtVFtSaR7pqBB7Bi8X269tKOYEtiV2hvZJfwm496LYPZ89sZw1gSzbBk27KldoGVHLs1UmuLkIX2gw9LbL9xSPYieeszNEIltlWMb2qVchB4/Pz9TSXFMy2xwk/5qvsF8Uj+IHCwrVAnrous+I6AhHZ/TKbLrpV928RLUa2TyxVdDgH+CfqW8/f6fBxE+9GuprX2z+OPF8G/DTFwSbZZ6Oa3hGJtUZOwvUri2h7z0Bz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781580623; c=relaxed/relaxed;
	bh=VMf9sNjHJw2BsEQrYgeWnW9Ukxa/ro2TiiasJQRS3SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D5TAWW88z9OKe/SgBAfz5ZxRDmpceB2jxX1ek2xaVvgfvcBaMYyeSMoxDFw70bHQY1aTZqQKwFA6cNqFcmJWBYHyPPVTwGu7k+eB7d7exAAZHdZig0Gq62Q0kSB2DjA7aJdQqJ8Hy4IpeQViyh5eaOoQ8GyBUGxmOQgAhnEwOCmn2YvsjAX6ywRkU7ydnXNXeZUkk3WHIlXnvSGnNipJtANw3VBAdZwsPyCz8GJsYqwAWBNGUwgaMnShaimXthQ76KWxtTeXR9Yu4R418uczV5vq7RGVDnrIwpqbITFfuiY1GgLcPvicD/li8z1ysNI41/SdQ8QqENAlHCU1qIXYmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfXYp6Qsgz3c18;
	Tue, 16 Jun 2026 13:30:22 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 16 Jun
 2026 11:30:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 16 Jun 2026 11:30:02 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 16 Jun 2026 11:30:01 +0800
Subject: [PATCH 1/2] dt-bindings: pinctrl: aspeed,ast2700-soc1: Add
 JTAGM1TRST group
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
Message-ID: <20260616-pinctrl-fix-v1-1-621036e45c7c@aspeedtech.com>
References: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
In-Reply-To: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Linus Walleij
	<linusw@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>
CC: <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Billy Tsai" <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781580601; l=1070;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=GQ3UQ5BFqq5w8PmNHkkbD3GB5wPV3CqM9yPcj5KE00g=;
 b=bHIkg0RFnCrvD4WKwjeopVECkuhuV/dk2dW8dRMWJM/DDZ9aLi/6fkU5tjS07KZJZyRxeo96e
 YPaQoo8uQWzCEr9WtIWN3OHGitlQEd35PnEnK3QyQrt8WPpA2/Dcq72
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The TRST signal of the JTAG master is optional and may not be wired on
every design, but it is only selectable as part of the JTAGM1 group,
which forces the D12 ball to be muxed whenever the JTAG master is used.

Add a separate JTAGM1TRST group so boards can enable TRST independently
of the other JTAG master signals.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml
index 76944fd14e2c..fe7cef4fef6a 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml
@@ -356,6 +356,7 @@ patternProperties:
           - I3C8
           - I3C9
           - JTAGM1
+          - JTAGM1TRST
           - LPC0
           - LPC1
           - LTPI

-- 
2.34.1


