Return-Path: <linux-aspeed+bounces-5135-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BECA6002
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hywSy3CrFz2yMD;
	Mon, 05 Oct 2026 21:23:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791195794;
	cv=none; b=jSorodCxKFrgHIhFLnM2XJRqt8pdHJqijlN/6q6wQhGWYibSiwR+1OoMtip6WeY27FYd3MW7+Vfv/p645bY5/X2rv8uxD3WI9zLpCZNuN6OyGL4b2k0Ub2rVaw/u3KA9hR9dszrbvyWR/QzU+5i62pvdFS/kzGwrj8lSoS3pQE9sAEq/VflvuMJRGNDvsoCustqBsOPbn/4vWnn8O6eGZh8ZttcbBVz4wrgfoBprVLelmQx0vK+2dUNPIOvIs3tpiGGULgan6hX45y2k2DWKJNau8D2EkgNWl5NzqQZuvbBcq6+9qpEYLsDkOMdYW42hWWA+3fvZ2MYQyYvmK2VULw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791195794; c=relaxed/relaxed;
	bh=rw3bi9IheSzyKK2RaBiuI0se12nHsarG4e1gRIk3GsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QNasMf835ig34dK7gza/yohX+nHUPiMNscm7iw8T71TmqZHmf+brMk0YsQaNRjKKeHGG2uoAVVo+s2c28K5uDMrqbng54XpBNHRbs7Jt7GWRGJnsvBMRltYoCFVxrRIAeo+qyhtHiIVy6Kox2UoNCpB4PpUqZPi4nRIO/CFU6hOi3izVHcnRARa3gpf5HVvw/pUNKeqnUuER2yuZvGNihUABc/B3ZuKQeJUWSFrbcUyQMGTh13oVDLQvEqZYvyaJqcaHmwJxAWM7Lgx1UpjrP6sUUwHAijc2372zuG4tcCE6vrJyAxEQYS7onJSP1oq0lbLx/qcja2ZJk3XcqMNbIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hywSx5JRLz2y8G
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 21:23:13 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Oct
 2026 18:22:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Oct 2026 18:22:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 5 Oct 2026 18:22:53 +0800
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add syscon property for
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
Message-ID: <20261005-ast27xx-adc-upstream-v3-1-ef25552d3a59@aspeedtech.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
In-Reply-To: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=1812;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=CeLk4QqCfcUMyf15HORG2ynxSmeffa9/z/bSNsesTW8=;
 b=p8yITQ9TACsK+jl5kkQdqmqJd/sIom+z9wIsD84sc+fJMFvBVo2cJkPUv3fMVUj5y6tiGmrWG
 UlkkWtxfkhDA+kvSdc/B3+ozuLPzKNGBcra0aaxsp5vhv+odpxxcUp0
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

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
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


