Return-Path: <linux-aspeed+bounces-198-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52118E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 15:54:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8H9G4QSGz30W1;
	Fri, 13 Dec 2024 02:54:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734018898;
	cv=none; b=ofqTb642SimDy8BRJ2t3dzXjKm7w/ix27/tSXnY8FjnoWvq0Nqu1fUWUii4aVZyOEXlcaxDL87HtXsGUyE/2mOYDmDdnccb7SDDeqsoJo0WH3F3GpwezRhPKUdBZHP1hXZu0QSOzUe0ve8G4qVKnML46ANzqSUwkSniwyX1IZuKXEoGFZALY66xIhWToWAbaDGLYJqf4G6NqKL9FcXfuNJ6x4JMDImzY3PzVNSxxoQrueqbLz8X/7seaH8HU9Ct4VoWJSd54Fm7+PlilU/tAcaLQ8RLha2mslPhLOjK1fqA0JyUqAF690CbVMIdIO+09n4QzitnLTF4jom9j9iFneg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734018898; c=relaxed/relaxed;
	bh=eaGxJdLY0/ARpzrgNvOLD64IjmvrqELeAdsZUdNbUF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkfZssTGnjYh8vb/Is0ftbCQCFB3qnOoy1a27pb49dAcqr3llFj4el37rguh/I5mkvralKNXzm1QeRYvV7ZG03fpbZg1CVT+fD/SpVsySo9UUf5pKy+nK72E7Vb1yRg4IighL/dwqpsRrMAB3o0P2q+71P09C6oPo5vvqJzRuXTzgA8BGNQitzBD6Fk9kzHf/vMeqzOcqNSa1nYlbdjRdMV7shrC2HwQW6/5jZm0MPqC5HsTQSdUifvQGX9/fy0kBe/8cpW8tDvxjvhV5KYhatPwfle61g1G3usc65LM5mP5CEAAQPoTezpeF+ln55pbQvM/jpj6ulwSYQDT6IaTsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8H9F2xzmz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 02:54:40 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
Date: Thu, 12 Dec 2024 23:52:32 +0800
Message-ID: <20241212155237.848336-4-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
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

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..20191fee1f5b 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -101,4 +101,10 @@ properties:
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


