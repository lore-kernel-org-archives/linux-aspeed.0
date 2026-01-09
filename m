Return-Path: <linux-aspeed+bounces-3270-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D8AD232E2
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Jan 2026 06:35:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnX8N4WsRz2xQ1;
	Fri, 09 Jan 2026 17:35:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767940532;
	cv=none; b=HyW/t1Q6ih2c6WXFmLO2pWbPUv+oHx7/73Z1W5pcRkGkJPQLelm4szbTMjU88A3THQoBcIXmM5pl+kY7/zVmxgyQSbFLyxoFYf+Q8BWooOYj78e2ApJCuTmSoezEXdtQ2vrFvwjNQJNIkV7qkCbfCEucRrwIjRhjicglqr8P9jdYCVTG2ShsO3RepF0CqpeBw/qZmYjE6XUIvLZR7sbaOTUuuxCIkRPi332jlJY9RU1w8bXkSYWHzcRPbHq/kjdUdHW+o7FxXOsllNiNCX2PuyauVJ3Us2W2MozZEqd49FhR+mt5Xzr1oNmLpgMTlo+5OH9eWH+I+3Kz/rsUuspF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767940532; c=relaxed/relaxed;
	bh=eiZT9sXBg4HL79BKEk2OPu5rQrW7DOHG5+KhdLse1nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k7jGY9ZfOuaDYbL/rz35jSB+UGHsmSD2YIQAsjZtGQHpf1tFkKEA6pqxmzo8Bn9c0mX1Xr1e+xtMI+beOcrvp2VXBILbsDF4F9SIeUzxvakMsxbcQPnv3Z8mIS5p2tUY4+TZy4df4B90zVc40YDDPQpqSkUB1qk8++tJdhS7cRzFYqdYU+Rf97GLhR1dxW54vDOrCsNRsjoJFq2Vw9Tr3xGB7q4mKmIZ4GLn3oIOw3rRvO8MhltZq8N3Dndn7iA7YHsTzdhOWuJDTGYoLwp14gDjj2ivv+oNkVpwig5+IIM9L0w0SKG+5nJ1LYdYwF1U0LudbanmBY+BBH9cePq1UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=beS2t433; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=beS2t433;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnX8N0vPcz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Jan 2026 17:35:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767940531;
	bh=eiZT9sXBg4HL79BKEk2OPu5rQrW7DOHG5+KhdLse1nM=;
	h=From:Date:Subject:To:Cc;
	b=beS2t433FJ6u6bIljM3aTHPk6T49f9Toc1y6B8godI9KhHF6D/lmHoIogkf36Iqyf
	 YMG5T18VIity3jOkFohkmYR6an3bP08DqZcAbTsTQwV7T8epMUYpGPvIUCGmHC7pxD
	 oe2D7QNlcYRP5uCa5Fby4FUbBKjA1CzAxSHw/WX7IPj7ck/QQjIdMnxB3+W/mXwA4B
	 QDiF2qdinPXMhiUXAsZdfAEtxnw5cWw/4BSJ9EMDKmgGm2XBtor/qn98V4PLrL6tLQ
	 sEugBUA7pg7ws0cSduUJQNSvLgnYVYGW/fpyjMV5j0Wm/roL21s1BqXzGeHNX3wZ7n
	 ACMQsT7TfWZbw==
Received: from [127.0.1.1] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5CBB97C834;
	Fri,  9 Jan 2026 14:35:30 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 09 Jan 2026 17:05:18 +1030
Subject: [PATCH] dt-bindings: mfd: Document smp-memram subnode for
 aspeed,ast2x00-scu
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
Message-Id: <20260109-dev-dt-warnings-mfd-v1-1-1aabe37e9a14@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAKWhYGkC/x3MPQqAMAxA4atIZgNtwd+riIOatGawSisqFO9uc
 fyG9xJEDsIR+iJB4Eui7D5DlwUs6+Qdo1A2GGVqpVWHxBfSifcUvHgXcbOEc9Ww4s7SYlvI5RH
 YyvNfh/F9P4+sds5lAAAA
X-Change-ID: 20260109-dev-dt-warnings-mfd-b57e0e9fdcf8
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.3

The platform initialisation code for the AST2600 implements the custom
SMP bringup protocol, and searches for the relevant compatible. As a
consequence, define the requisite node and the compatible string, which
in-turn tidies up the dtb check results.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Hello,

This change was original part of an RFC series tidying up the AST2600
EVB devicetree at [1]. Many of those ended up being merged directly, so
I'm splitting out what remains into separate, smaller series.

Please review.

Changes since RFC:
- Address the warning from Rob's bot
- Tidy a description line that was dropped unnecessarily
- Remove RFC label

Link: https://lore.kernel.org/all/20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au/ [1]
---
 .../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index da1887d7a8fe..a87f31fce019 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -130,6 +130,23 @@ patternProperties:
           - description: silicon id information registers
           - description: unique chip id registers
 
+  '^smp-memram@[0-9a-f]+$':
+    description: Memory region used for the AST2600's custom SMP bringup protocol
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: aspeed,ast2600-smpmem
+
+      reg:
+        description: The SMP memory region
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
 required:
   - compatible
   - reg

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260109-dev-dt-warnings-mfd-b57e0e9fdcf8

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


