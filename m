Return-Path: <linux-aspeed+bounces-2717-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620EFCCFA06
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 10:52:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0T1t61tSz2ygD;
	Mon,  3 Nov 2025 21:52:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762167154;
	cv=none; b=W5kKtnLeI5ARgxD3H4YPDXb4np7jcNWlUmvd2v8/zmCyGawsjRsqo0YtNr5cKFyddIfNnYzqJAirytg37+J0oOATVdmTnJx1ukulVv/Bfv4CdA5mfFe+XsKGaMQRtv/DQ8sQRP2PnuE5qf4sLyhHm4Sf9L2mzyKoTD3U2ztH0nf6SQrSf2W1WY79OZTSacQTks39DXkfxKNx2JutgIeJozPDIxunobBDandFieixSH2YWFq8XslYtHLNouP84eWDx4mN+CoNjYMdd6WKfr7qV75TRUUIymqOiJvhrEDexFd0kvVFHnOu+qFXIwNozsAenfe8sAy7lVH/WRJLKYYpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762167154; c=relaxed/relaxed;
	bh=wSLTKZDYBJczR/hcNOPPArvh7dxErG0MtraQAm1J2lo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fK7l6RFN8f15Kt0IxMt0rmCuZinHKPXSIyFgThP5ZGty+56TTBVsm2Jskxg1rAF6ZdDqiGE44KR96ev0VMOayOzxqEZY7ZN6CJOubJm0C8aEklcVJLsJRvgUjien9wt7EB9astdbhGVSGEVnlnaRkZjtYuQf+veG5iJVam8/1QnHa7HUYljlkyp9XC0Y7f7z+HjfOOdSfCIy0aFtiBqospwNPftDfZ4PL3bLqCusmUyoUrcXTLvIhWTGBcxHK1chynr8erfvWIxzOryOd25ZsVtAttI0KTPMwsh7Qx9N+O1kWobh4BiG4A1tOjNrf8a/DoGnIfwINhJ/78NxmNVy5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0T1t1HM9z2xnx
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 21:52:32 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 18:52:17 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 18:52:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add AST2700 ADC compatible strings
Date: Mon, 3 Nov 2025 18:52:16 +0800
Message-ID: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
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

Add the compatible strings "aspeed,ast2700-adc0" and "aspeed,ast2700-adc1"
to the binding for the Aspeed ADC. These new compatibles represent the
ADC instances found on the AST2700 SoC, which are similar to the AST2600
but have their trimming data located at different SCU offset.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 5c08d8b6e995..509bfb1007c4 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -29,6 +29,8 @@ properties:
     enum:
       - aspeed,ast2600-adc0
       - aspeed,ast2600-adc1
+      - aspeed,ast2700-adc0
+      - aspeed,ast2700-adc1
     description:
       Their trimming data, which is used to calibrate internal reference volage,
       locates in different address of OTP.
-- 
2.25.1


