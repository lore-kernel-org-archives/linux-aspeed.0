Return-Path: <linux-aspeed+bounces-2964-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B18CF8844
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 11:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBwgR2HLVz2yrT;
	Thu, 20 Nov 2025 22:12:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763637171;
	cv=none; b=OVeDC0hjmLNMrXZGtP/W6520oteq+jT8wyCQ6L3ikobsEKlW2qAzSHMQB7ZtXl1JD5kYNJiRbcH7447pl7Fp30B+6JFzF2iMlETNhzRODQ0CMaJ5a2SOefYXJ6u1CzmMU7Br1latZaPQkC6LXqEAvlBnqmJWgPWjhyoc5yrUcRxcDEmT9+UvtjJykI4ZTCx3LjEbaEgBOc95U89+CwWx8v/JRi9XAlNlgTMAAIeZ+I4IgkZls3ujAjrIgbfHGXjV/pbRbSypunT3a4gaedMBbafJ0tdXc09cPni99WdTxunxpxFx5eHbbpo3ax++l7ZacvZBWt0+bNjGis+n1uQELA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763637171; c=relaxed/relaxed;
	bh=5Pu2yznAKM69Fw0nbx2D6T8syxRy3vzkc5nzKJ06SAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X/YKdxInChRBoWbUGhw8I16Kh54CvHsI5Hd49SPlW2BF/7JGdJKYOEY1DbsE/JRPfZnGDcjq378W4bQs0vlvS1cmFgvj5vM3tT2EuQB0uda7ImPmum0vxhZniM5yFihqvsL1Op2IT/TMbw3X1OwJVgBe4wXtTQguo1JGYakYyLwLkZMdbts8IGYf8E3Ikw72v0raF2IAYK7iYEzhwgrwTc+nLbLBbyMbNoa+SZ5tAjwidsPuclFwMGmbzZLqp/0aw5CjbBvIFaC9Gnz1Zn+AymakBx2r4Qv9+qUP+aNHLUet0mLWUqYHcWpH9Dau06n+XU1GbgZ8IrXiKT6CXRVBtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBwgQ5YgXz2yFq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 22:12:50 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 20 Nov
 2025 19:12:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 20 Nov 2025 19:12:34 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 20 Nov 2025 19:12:31 +0800
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add AST2700 compatible
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
Message-ID: <20251120-upstream_pwm_tach-v3-1-eaa2f9b300a2@aspeedtech.com>
References: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
In-Reply-To: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763637154; l=1136;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=jrpiq8xW/VHPB3RrV1Az+oFlae8Vnr8Mhyy66AqgzTc=;
 b=M6A3kKIiiCGLB1Q6l96/zkUfNG6Ml7CYM8l6u6kb7CTnAN8GwRcGj+Bj6X8OtBaE20UAsPs6O
 0lp+U3FB+LnBJBr+OGdp6nEuHnGVMLJzLrpZ2F8y3fqrLkU3wJr2gzn
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Adds support for the AST2700 PWM/Tach controller by extending the
compatible string enumeration in the device tree binding.

The AST2700 PWM/Tach hardware is compatible with the existing binding
schema and requires no additional properties or modifications beyond
the new compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..851fb16ec7fa 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -18,8 +18,11 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2600-pwm-tach
+    oneOf:
+      - items:
+          - const: aspeed,ast2700-pwm-tach
+          - const: aspeed,ast2600-pwm-tach
+      - const: aspeed,ast2600-pwm-tach
 
   reg:
     maxItems: 1

-- 
2.34.1


