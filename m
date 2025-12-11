Return-Path: <linux-aspeed+bounces-3077-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25275D3E786
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 08:47:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRmRR5tHXz2y8c;
	Thu, 11 Dec 2025 19:46:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765442819;
	cv=none; b=f/drc2NGNj0LYcF0aSF8CAZFks4aqRUJnSyrX59HIefy8cPWenILquf3MlaPor6NljmZ04fnsZ1oQYcuw337P3ny5DQ+BdpZKt8bld4hAM0EYStJI6dcXQplYvX+CZrwCcUUgdOesOqULW50wnYbwRTstikfi8ukOB5V1LttUfwDYCAiqhQwLNbZ7Nx23dSorx8bouhzFdAZaa2xKqK+SAcehuBWH+oW62NNZu8T0HOdw6FyA+l0VZ6fE7guMtOS6QSH6WCuSutzhGppSRPqN0ua1roWGYaEss6aHv8UBogyu/cFtYIqprCZty5kQimFwEcydH7pNffTHU0bAkGXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765442819; c=relaxed/relaxed;
	bh=xzi4Fz/8qdzZMUIpWOM8hn8WXDg65D2r48ph45pVRFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaSKIY9WaIHMKpSlbaTeCvUbdqzUC14FcfPiRJEiWuyxn4GLCOEdcoOH0I9Rq/9/mi1rRyE5CUO0ZDWDDg8WgLKHsvWOYIqnmJVL7WrjwaXV/Frpa4megqddkkxYonDpcSn4uyIV9wzEQFHs9Ns8HcfmG3T1uZ4rREND9Fnk0nqfqFb7AcBkZxOHnzQ/alOja8eV2BT/YT46NNs71hH4oZi7Z01leM28KppnTplc4jT/oW4UHAhG6ETFyXvgbZhzpplGn2zmEYR+6yBU6tDcxgs+XyxzKSVzhpsjF5nVCnanf8a6kWhqjpIFLf9R43NqIsKN4Ak5sDgnJdM73LKEsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LBexYCu5; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LBexYCu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRmRR2G5Mz2xrM;
	Thu, 11 Dec 2025 19:46:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442818;
	bh=xzi4Fz/8qdzZMUIpWOM8hn8WXDg65D2r48ph45pVRFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LBexYCu5FLXa70UuDT+IeSRE9494xvFnAQ5B1VicNIsbUW/qZG3jj6tGJ59lFFv0I
	 R46vEDyKtZxOXwmamOgLKTDcuGERt+/frBHXX6bUkc69HCtm3sg+06255Mp4KZ2dxb
	 stTMwTcVtHS/42CGKOwJLJVKUU9oFQ43SFhZtRmkpOsnn/lPqpi+y0kxyagQv+DqSG
	 H4axat0DbeF83B/6ycx3p61xRxKqi2PeoKRDTFjs+PBJOsLyADQGkNcalLG6gLIEvv
	 Cv6cuNW6EQuYeXPn9nrSIxWREXM2hmAl7sseCtAKg8d+Db5a7WdhH8NvUyOJKvGirY
	 zTGENCcHCgpMw==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7F8D67D6BB;
	Thu, 11 Dec 2025 16:46:53 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:48 +0900
Subject: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to
 sdhci-common.yaml
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
Message-Id: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-iio@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.3

Enable use of common SDHCI-related properties such as sdhci-caps-mask as
found in the AST2600 EVB DTS.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 9fce8cd7b0b6..d24950ccea95 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -41,7 +41,7 @@ properties:
 patternProperties:
   "^sdhci@[0-9a-f]+$":
     type: object
-    $ref: mmc-controller.yaml
+    $ref: sdhci-common.yaml
     unevaluatedProperties: false
 
     properties:

-- 
2.47.3


