Return-Path: <linux-aspeed+bounces-4445-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B59EC44506
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:31:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ9C6W6Xz2yf9;
	Thu, 09 Jul 2026 09:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525113;
	cv=none; b=cV03DrE33n8N2i11Xi4bVbXSTKf5wZ5LOFDMF5wtUapEe1evBABa+1PSSyhpOmTwdEOZg/PWgFGekbRGNvJsswgn0vfWIBxXSj1PQRBwexFFGi5SSX7FIJorDCKrF0cuXl+4lBjTVdhybBDuQNW073S+1q6Er0wdpiANfWBVnN00uugXSY3Lsm1VcdWfcqarZcDFLJiFWUA1R8g+IuFC3fNX39LDDxRmCsb4mVzhTPCgQzRUIkijFVDWzKNGA2x3g30CTYdHKhWt4/62GQvZ1R3r4Zu3eCuovdH6HLVjACS416/N5pZh9HPpcYQIn0BO8YFre7lM7q60AECsuaYEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525113; c=relaxed/relaxed;
	bh=aX3VKusEpXR9oPYMG8wA1f/3Abd5fn9FdmFI4yazez0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxZ3FE9zcJm+o1HT1kz/eLax1pA+cyBNjbRrz1vLkHDzu1LCtCSn9rgQhXcutbqBI5sufgv6AjKnV25x76cBx0Dh4ZQSWOFtvuPE8GIXjbHLAYVkhbQaiGONxXaCJAkfZ2VpBJ2JeGqcJRQzUeQtk6FTOb/b5YL0ZE6NVmhOfsvUSXEQSQewRA1DNHMB9lYVSZQeTJwWrOrqkDCs6JMPnNGHUDwS/xSRX2g+eXvXOn6SP4/PcPNiAhhajkuz2kuTsjA4fqIc45i4Rd2UsMD1gJPEg43uh4xFcBXTsX1UYgHEj4YRleWSwXsWSWgNf3TjgcmnxarEiS2ufsRTrLOboA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KHmqiAwI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KHmqiAwI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMgr6139z2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:32 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-47d6c634f45so643115f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525110; x=1784129910; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aX3VKusEpXR9oPYMG8wA1f/3Abd5fn9FdmFI4yazez0=;
        b=KHmqiAwI6TRySUwpNWJ0E4nB930dt/umOyogZUaFZXi5Bmi/p+R/Rk6uVEJ+BrZU3b
         kUQqd4FMnq1ujrhOFZ2uQYjxNt3tNSqrCe6M/FQHOlmXPjEGS9a+NjPaHAM12kGaHOM1
         3qAaVvHfqiV9pt9aXn/ak+6S+Q8IC0g7MSP4ZTFIiMiIccHk8sIVNNkExx89U8eqZlNS
         QVcPI30hNS49IE6piCMyj3DnpSp3hhPszyJ6YidliTUCeYwjEC3FqaTX021KdKltv/Zy
         e97wTSM0Jq7GS3JqCMTNTEz+Jw6imNpFcDnZGyaTI9w8nrE4edRQKEwjy47CUtHwymHZ
         sJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525110; x=1784129910;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aX3VKusEpXR9oPYMG8wA1f/3Abd5fn9FdmFI4yazez0=;
        b=KTkGsYwrLj12+GK2WYbGbaZ92jYGzwVskw45iVfpm5OWx1YTeS2TeN4pPJPe8hCmOz
         QYwkd+XKxzk24By9QJrc3dEZaytu5rCkgKDApSly8m7iYwE83IUx2L5TRJYv4bZTLgOt
         wLxd/UGSMk8qO9wQFNAeLcWfTlvSsYZ7EsbdZuLssxjl+W55ps9XEao1FZUEmRWphp2j
         /mQYAzaQRsoL00pFNmsjnZMH/CpKohj2KK5tc2QiuY9aSmzkYIIQyDLRPFdb8UCe8soy
         xoj4hQ6F5SNI7F1QbHw0T7DUG2XGAf+Ox4BAA6VDigDg0U9wNftRZVWqnnxBU5T4AQb8
         51UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8woj/ZqxSVIDardcorWcU0xNdbbdqFn9ZRmph9cYSYuwGJamR3vJ1Ekz+72VGOOpUI5IvibmIItV75/A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytlNMZ2w3ph6cd2yO5afTUrdJNoOiPgDIT4Oc7WlSmcmvupY28
	CAHDeVPmQsD+GyytjnF6XqQfAoGFOx93zhjJRjZnIDJjMflyKDxznmGf0q2xSqN2CBM=
X-Gm-Gg: AfdE7cni/pILSm28+95dA9fVFUEZ3/X9avgMpGKKad5mAcCl3iqX1yE+Ri1VyUUmNrU
	qpoB/IpLMUqewI10jNYITUAgB8kgm6oG6/0vl4FoZXBKiCWlbvmMTyL8an07zbbIq5sApc5nY2z
	/Ra2tyMNZOyOhpU5ry73jpv8JF1PiS3rtiJ9AvHcqs5vwszPh3uKHKb7CdPM7EevqLuKoT4SO9B
	eNJfffR17NWhs96cDy5HfN0/fyqDib/lkdXABO5lKxgIadJYPEY9PuA/mu4GsDaUCYX4fUPdRm3
	5llUWGclPLFWnETHXLvddxhUZBC6hdRO6mvcIBBoPe41ang4GJrbETfv7K3y5cBRfR7U/vtzcrC
	CyROaCqucN0s4OCXq6dFSOOS3GntfmWozqsaV2T0B+qI7yWGfcvB1Wwx0NqXtSZSqNpNgGf35BI
	I4X5l7+OX5DssL+xvReM8S6gBAxXfPFz+Kc/GsZWhqCJUQf7py3MQcL6U4sxXZMxfcLKtuqvXAu
	VzCXd0NrBL+JYovxCIHEF2/9IJpUNuttpNVY34=
X-Received: by 2002:a05:6000:25c8:b0:474:9dd3:981 with SMTP id ffacd0b85a97d-47df07314bbmr3555871f8f.26.1783525110073;
        Wed, 08 Jul 2026 08:38:30 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:29 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
Date: Wed,  8 Jul 2026 15:35:53 +0000
Message-ID: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ast2600 was using the ast2500 vuart compatible string.
Make it possible to have ast2600-specific properties.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..8f22121381fc 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -23,7 +23,10 @@ allOf:
     then:
       properties:
         compatible:
-          const: aspeed,ast2500-vuart
+          contains:
+            enum:
+              - aspeed,ast2500-vuart
+              - aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -106,6 +109,9 @@ properties:
       - const: ns16850
       - const: aspeed,ast2400-vuart
       - const: aspeed,ast2500-vuart
+      - items:
+          - const: aspeed,ast2600-vuart
+          - const: aspeed,ast2500-vuart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
@@ -287,17 +293,19 @@ properties:
   aspeed,sirq-polarity-sense:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: |
-      Phandle to aspeed,ast2500-scu compatible syscon alongside register
-      offset and bit number to identify how the SIRQ polarity should be
-      configured. One possible data source is the LPC/eSPI mode bit. Only
-      applicable to aspeed,ast2500-vuart.
+      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible syscon
+      alongside register offset and bit number to identify how the SIRQ
+      polarity should be configured. One possible data source is the LPC/eSPI
+      mode bit. Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
     deprecated: true
 
   aspeed,lpc-io-reg:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 1
     description: |
-      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+      The VUART LPC address. Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
 
   aspeed,lpc-interrupts:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -305,8 +313,8 @@ properties:
     maxItems: 2
     description: |
       A 2-cell property describing the VUART SIRQ number and SIRQ
-      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
-      applicable to aspeed,ast2500-vuart.
+      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
+      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
 required:
   - reg
-- 
2.54.0


