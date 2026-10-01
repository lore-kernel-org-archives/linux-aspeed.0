Return-Path: <linux-aspeed+bounces-5101-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D4ECA5FD4
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 09:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwRxW45mXz2yYf;
	Thu, 01 Oct 2026 19:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790848255;
	cv=none; b=BPwVkLUEVl4DCUFZQuTmZBb4rifLT16AzdJuOJ4C+IiuPdK6l5fWg+/lQPTj8Jrwsz5n5tQRVv39mXZspLL2z5BJDkQ15x9ZGuNPbcNsMhIi9zGIuJ8G/8GPGxYm+1p5niFllBK1NHPPgWFrqd5pMnlKXYVCG4cVxYEteI8JnmxSqzIszD8cpI5LUYcmGlKf9p5VBABX1wj2mgYlg7TMo676GjzJRyLAP9E5vxmOmlm4pyWgQAv5zursVeFgf63IOwtHrMWpS41hPxXPZG1mXdhEK7yYHsvZE+YK7z0afCgYZGOdzUDL3RbW/7RiJ6cUNz3Q2Z4onI+gIxGiJa7VtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790848255; c=relaxed/relaxed;
	bh=p196Zu+ADoTwWr126OPgVrgR+fG86N4JdlXEGkivh+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rn6802GEXBuM/0Wedz/b/JDkmxk8riaGU8jblgZvxfDOmcfWzmnGSnN/7tjf+42iRSAIPABoHp2BNXNN4Twh6uSQybLN8V4vf1c14K6plPtBxNWQTeGP3DQ3UZNoyu3QrlENTYQNXTCwoNXx0DreNecwlKZajU40OXdXJn+W+71l3De87rAM3wA6YxG1lIg8H4mZCZ7cnobDskiEc4y48Siw7G2T79kEBmKsBf2mdty8i/Cfg8ESxApoOreW7ALL+QK0rTFbY2Q8IQideS3cX9EsEgVJfeVted5GK9uIEKKcwlydCc8ccHh6CrGdWdsle1GR7FiepryBwMY/VFAyxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwRxV562Mz2y2Z
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 19:50:54 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 17:50:36 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 17:50:36 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 1 Oct 2026 17:50:36 +0800
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
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
Message-ID: <20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790848236; l=1758;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=tp+ZL00ZpW/x/t6XI1PN7QQrlbk5nVmlhmyp4kv36NQ=;
 b=38gXMLJY70kc0aMsuRjE9csWAkbYdTIIbxXBFNe4p/XGP8nq/u41OOVzsPLsOYuqxMYBsX7Hu
 zbqexKzzVsaBpAMu9hCRd2cGgB5CEUNHmZQ9UNTIPFaStnxtOg+8E69
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a System Control
Unit (SCU) register. SoCs with a single SCU instance let the driver
locate it without any additional information, but SoCs such as AST2700
that expose more than one SCU node need an explicit phandle to
disambiguate which one holds the trimming data.

Add an "aspeed,trim-syscon" phandle property, and require it for the
AST2700 compatibles since they are the first multi-SCU SoCs supported
by this driver.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 249101b55cf4e..140d7034e2196 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -67,6 +67,11 @@ properties:
     description:
       Inform the driver that last channel will be used to sensor battery.
 
+  aspeed,trim-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU holding the ADC's reference-voltage trimming data.
+
 required:
   - compatible
   - reg
@@ -74,6 +79,18 @@ required:
   - resets
   - "#io-channel-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2700-adc0
+              - aspeed,ast2700-adc1
+    then:
+      required:
+        - aspeed,trim-syscon
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


