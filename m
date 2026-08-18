Return-Path: <linux-aspeed+bounces-4747-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9646C5DF7E
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx25Jd7z2yGB;
	Tue, 18 Aug 2026 20:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049110;
	cv=none; b=Jo+QUJbMUFLVxVxOUG92cQpB0S8IAL5cwttUeAmwLUgf1JiMeoa8ilZanFIfHC1cq75ISdnEWkBlA/xAJK2hInajZuCKhvD0D6behPn0AKFzleFWVx6oK7ZOGI9RT/r+Lx38lvW0IN+FQNdpxtDLsi9EtkEjE1DmHDjyeIFpPJF1vUWsYyP4TqMCA9X3dznXmpEGZfcCLEcYQi2dnP/9sKxfdolRJegEV05/krbr+RkJtpH7bdMCDigDR5JgVKQfLI35r4qIW8AH8X0MXTFXrbo5j7IzPD+1ry5Pd7xY0yxoGXuMbtPSh4RaEKfWoZL5jrAIqGteW+vKaq4g9dk8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049110; c=relaxed/relaxed;
	bh=VXAR0pfuBaAQ9k+v1xXQaQosy7aMoQd3gplGbAsity0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJ9LlfCRc3V+bVNtDtnfzRnzAIj1T0mL6ecezlUWkMRfoWiZETkYioiKGNVNxt7ljiXlwOhfYKpudZrQwDGc0fFym39beuhIeRjB5PYCDo1Nk/noFYlcT5K38bXgO0+G6+kHhEYEtL/5bUikL1uwllRpg6oVrENmRVA/pySD3sNZAq5k+EWfDu7hJ6m0N+/2NTwLniIUWo3qA95QnQWjvy4DHk78k9IahTHUqcVSp9fLayjqs+uqjJLH1/Ub1TL8qwSCb6e9ZxUlpqUzLx1HL4XE+nMVrq1/kkCVwwqBlF4M1hKvn7lB8ikmnjtV3cIPJQiA+QMjSQgZ00fRI032uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SqLi3NUz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SqLi3NUz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQwz4NvGz2yFP
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:46 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5888875e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049103; x=1787653903; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXAR0pfuBaAQ9k+v1xXQaQosy7aMoQd3gplGbAsity0=;
        b=SqLi3NUzvTj+PtxPUc78g3qW+n17tcD6U0iK7qTolaCnkYER88TDEf5QKGp+/L5gWD
         dflp4w796Wfi5/vbfjTwwlPoHpY8tFjysMdEwOVkWeJ/IIjDYa8/WkB6hm3QGHTrvHQd
         yUipkaIor9FvaHyrZiMC9u5q8l1XQ7BmbhsSam/doP4W+iwqnDYJTY0UZX/lK302QKNK
         a3jAVBc9TqQq7mqfA8VosEX/aYD2G1P2+4PKUB5tI7dFkEtvTvFCwW025Mf06OFAahW6
         apAqSibRUXBc0/KYUmlkqrLZvpOlkJS9HclOJizUDncK5cQxHwzxWKc+7fagEHemyiS3
         oX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049103; x=1787653903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXAR0pfuBaAQ9k+v1xXQaQosy7aMoQd3gplGbAsity0=;
        b=k0UgCuaR+hb+ajAvSZGEXhDMIPd7/D7qRE/DxJbK7mfi6PopqNcRv0pzAvgM5gaaxB
         B0MdqDF+Jp+JsGJxf5rGHMyM9vKiILDsFIijX34q4OER+Z4t6xhm9iNZxSLYdBzyaQ1L
         vEeV+yAy5d+ZVjInBtuXVXvwonCb97R0VxopnpH96vzwQj0IpTrPpEb9tVPCkqC0SkDF
         QtD3zdHxx0kLRp/t7DHvgqXsJOh+vROiCLC4YhI3wcoERPkc2qXovbzOlfJiVym3g7kp
         uwknS1h3ZX5XH79HXGRnfaaH8p1FoXuJJZSiD7M5ySoRRzCFv/3gOVclk5t0eo1nNWuO
         5p3g==
X-Forwarded-Encrypted: i=1; AHgh+RolVJJ1zjw7MQ9z12cu82RFtQvgl9Y+3WjzPyFesN0y9M3tkdOIAC+8Zm+7/3jERkh3AsVEtFtPqqJLn3U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzr7hKchJn9CLd02+/dLWNL4GnCIsFoe1u9+LudMrqwKJMtgwjD
	LT2E3cv4/cJ194N2K8rr74CC8qoaySniDt7zdMtUuoU4iuUcalnr3NQ04E5ztp+Obyw=
X-Gm-Gg: AR+sD13GYrUAjSUCKPVlOImgt+VLVTTewNLMT7zHLodPp/qCZaJdANO6hBrV8u4sbSw
	WCxi+MugA3QLFpO6vjbQsLnzQRXZ4kdrhwhgej7HCHwhp1FU1FagDj5W1wRnnck82ejjA+4zlLp
	bvHRfCE1aYk9x6X78rb0AGtRxOJASY0ybs04okktiiSg2ipCO6YfC3SRL2Fpk9fgFFbaBN5jsu5
	RHHAGYCO0+bTeeGpyKZ62CZn34MqnkN6sHO9amHLkUCkdmG7QLeJR93NczMrXz+ptKXPhr+4icg
	S/gtKTsievRBkHvMVwEGx3eGo9SFZMw8nvOHt5tUD6YdNirHMKYrHqac1+efW7sd9FHXqvf5diy
	aFZxbNWKSXmcalbCGmhcCkidV8q6MXKDVXz0m0Uo0jFZehkOymfhX2joSjQwzfycMcMyGRzZN7+
	9YPldeuAx1wjY6D6jljfSCMRwpkt+ldJ/ho3CaCbzzmnR3eRjaqwi27QEA975/YrCYiIYr43Fdu
	NxYNzplyTcD6MKi7OFz2tHMaFvOF8Bel6HqsbB+JkPNkVE4D+OEXsHVjkrT
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499a206a553mr70558395e9.6.1787049103159;
        Tue, 18 Aug 2026 03:31:43 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:42 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:14 +0000
Subject: [PATCH v6 1/6] dt-bindings: serial: 8250: aspeed: add ast2600 and
 aspeed,vuart-over-pci
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-1-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The ASPEED AST2600 can be used as a PCI device.
The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
2 Virtual UART can be exposed to the host via this PCI device.
These are 8250-compatible register sets and can be used to have UART
communication between the PCI BMC and the host.

This boolean can be set to specify if a VUART is used over PCI. A VUART
over PCI needs access to the SCU syscon to set the enable bits of the
PCI device.
On the aspeed's chips, the clocks phandle already points at the SCU node.
But deriving the regmap from the clock provider would misuse the clocks
binding. An explicit scu-syscon phandle states the dependency directly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..8dd4b7af0c0d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -18,12 +18,34 @@ allOf:
             - aspeed,lpc-io-reg
         - required:
             - aspeed,lpc-interrupts
+    then:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2500-vuart
+              - aspeed,ast2600-vuart
+  - if:
+      anyOf:
         - required:
             - aspeed,sirq-polarity-sense
     then:
       properties:
         compatible:
           const: aspeed,ast2500-vuart
+  - if:
+      required:
+        - aspeed,vuart-over-pci
+    then:
+      required:
+        - aspeed,scu-syscon
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-vuart
+    else:
+      properties:
+        aspeed,scu-syscon: false
   - if:
       properties:
         compatible:
@@ -106,6 +128,9 @@ properties:
       - const: ns16850
       - const: aspeed,ast2400-vuart
       - const: aspeed,ast2500-vuart
+      - items:
+          - const: aspeed,ast2600-vuart
+          - const: aspeed,ast2500-vuart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
@@ -297,7 +322,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 1
     description: |
-      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
 
   aspeed,lpc-interrupts:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -306,7 +332,19 @@ properties:
     description: |
       A 2-cell property describing the VUART SIRQ number and SIRQ
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
-      applicable to aspeed,ast2500-vuart.
+      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
+
+  aspeed,vuart-over-pci:
+    type: boolean
+    description:
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
+  aspeed,scu-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU syscon, used to enable the VUART over the BMC PCI
+      device. Only applicable to aspeed,ast2600-vuart.
 
 required:
   - reg

-- 
2.54.0


