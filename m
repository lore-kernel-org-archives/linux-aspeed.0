Return-Path: <linux-aspeed+bounces-4620-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB041C55ABA
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTyY0Bgsz2yMl;
	Wed, 05 Aug 2026 22:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932436;
	cv=none; b=lAqVZT0Y4BA92og/B59Aw0T2E7Xg1vab61497x9Gy0FzSXSq1W1myIEjHufeIAIwJ48TkQ8fzKXc4KwNRddPi86AqyfqeacBO0xgRa7zx/0RqP5hp1tvvgnJ7aRbvmL6Bxt882QVtmjRoWxkpNc6HwWtLQ8zxEirzo8BVjg0nWZeXQ0oKDC/w8IKhVzER5Xya8L9AFYGl3XrYbivkLL4ukPBZKaquYYVARpTjTWprOpAWjuMif/DN5jgJFG7Pvr4YVUhKcB4ggpew/VDEW4yD+HfrMGigar0zckP8Pj0/BPunTcvKX+w9W72AYZxAdwCNiMB4IJDSEZ1++K7k1ZElA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932436; c=relaxed/relaxed;
	bh=bz6C6stmStVMzEFUIQDnKapYsxwqb3V9iw0SJh4YNFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPmSgMR4Zw5LyV9CBnt6+prgFAtcEjbVtFMZ/1adX3a/UiaLbvhcfisMWi6kJ62bE5y2M+b9n1sjF8NwP0Mlhes22cFgH26R+wI/drmh1mIGyEXbZW0EIvtWZ6oBG5gA+YJ+4Q+dYo+ObetOxlo8p5uecLb+dXLqblXnITow7mU047wB1bOOvemglXGsF5bdFLn+P1mF67npXCIj8xJiVtlT2QZQU64sZmgvseHXeFFAkCvbkMIASPwVVaJyhWZOOPeah5pPd7mEIMkMBligl2cf7yd3fmbG2bsOiHVlkfuWAsXtCsby5DZHXqXh1bdVNgSSByyjxoR6vTKWvxiRVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=D88rX6zQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=D88rX6zQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyX03WCz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:36 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4955158f26aso5636415e9.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932432; x=1786537232; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz6C6stmStVMzEFUIQDnKapYsxwqb3V9iw0SJh4YNFs=;
        b=D88rX6zQlR6Fu8OA8oQSlr/r1XRVsODAp3/iiMqLdkVfda5Fmp5TXcvhayj6X/rz50
         KBS5vMCrGq5PHvgYzwG1fRi6PsiG0CNXLWVaINjYSNep9rpdJYgqF3h9NMsLj9Gakzew
         XtwaUfws9BE1FuGxRjWQSvhdmrm3/yszrCA5N9vrAUQiNhXHCfukz443QzbkGa6TGFct
         ReHdA/KgJna8Bm75JMZXL3gUz5sap6l0zDfzs5ePJmhM7hVxuDP2B42luee3SJBsdcio
         IOpLS28lpOUyrmHzVtNlnzMZHNBeLSpvO79AJiGAtVZgLe+81hRAy89EVt/5rrAAby2z
         t71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932432; x=1786537232;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz6C6stmStVMzEFUIQDnKapYsxwqb3V9iw0SJh4YNFs=;
        b=X+rX71I8MFdi+zzPFRDLa/Jt/pBRlrNEohtPJSMMPls9dpRCUPIgP3+xGksnGyeSQ1
         r//UwHIxf0fNQDT7PMagTQZVapVQYwjtBR8iFKarLF8+RMzbwiaSZC95cy9rgeqNQ4fS
         uKZxS7Ty0ZyB46UJpD/baD06oXJqR9mHROB7oJBFZs1Z1l2VmgbqLdPL5H90YJ4d4fw4
         YHBNp/aP4QYQ5lZIj1IieM3Tpz+qtUso3QH9Acvb13ZlBDlfoDnP/RJmnEvIqa3Iuyzt
         bItEQWCf9aHL7EUGwbQufqklwPjzAmTl+04gqRSQdO68u4ry7ONYROllh+o83dX4gPw/
         AVPA==
X-Forwarded-Encrypted: i=1; AHgh+Rpl9fJIPTXk94NXxCGHfTqI+bMt+W0GAqi+E14bYCm6CpGhAUG/Oi4yPD3zvoHibi+0e9Fs7h8BjzpGvFc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZkTzFZoyDp86s7E0yGjPUH8kqrsTNCv3shgupLk6H0Dgg3tZf
	I7Cy+EuM6s5AhBncdKjDyBE53gvMwnz+m1nceCz1iNGFcULtCxkmZryhlogxHu3r/ok=
X-Gm-Gg: AR+sD138vuh/KUxjoLr73TTjTvOGw+x2/BMGQrj3fFvt9fako0zzosJJjYf4D9ho/yA
	xYFn0hCsH9NbkCsdLKtmt7j8n85MnzX7r5tJPhpA3T+H9bq6TQpyncvUHCPzFi+7SYfeoF9jkWT
	TNyzuwni5Tj7w9VSBQ9DTDTrPy4WSuFiMcafd7aiePVas3ZrXyDdouZv5gBBJPFqxFfU6yIh53N
	mDrvhzJfVmC8rakyputYpgZsuUuvkKdDIj6rJVl3NESfftTYDJahvWE9p+oKPXNSOw7+QH8Csr1
	la3qPClWIgwUNjBM4mfaKt8uYzOPTT6zQi+kyMJV+fHSDF3gsyD0UqzxkJGyT8cT3YOuvQS+sbU
	wNAo3+9gVV8v25KWcPSLYxYSWuxnz8yODKN8j5Zny2IoREZIjbSuc4A/G1Q+7xniP10v+oaEshv
	GwqCNRMVzh0Fk4/VblcNO3ozXLMtfM4V6SH2G+ei2S7v5DqJHoeN2BOrtmN1cRLONBhnI6LZecS
	kgTNW7hny74aPs6xRsUA+X0ivBG4VEHQsp5sx1QuimztnT9nUXfkUJr/7e4wYk3PbbN7ehLoTVq
X-Received: by 2002:a05:600c:198f:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4994e7cc5a4mr72969715e9.15.1785932431891;
        Wed, 05 Aug 2026 05:20:31 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:31 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 1/6] dt-bindings: serial: 8250: aspeed: add ast2600 and aspeed,vuart-over-pci
Date: Wed,  5 Aug 2026 14:19:48 +0200
Message-ID: <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
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

The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
The ASPEED AST2600 can be used as a PCI device.
2 Virtual UART can be exposed to the host via this PCI device.
These are 8250-compatible register sets and can be used to have UART
communication between the PCI BMC and the host.

This boolean can be set to specify if a VUART is used over PCI. A VUART
over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
which is used to set the enable bits of the PCI device.
On the aspeed's chips, the clocks phandle already points at the SCU node.
But deriving the regmap from the clock provider would misuse the clocks
binding. An explicit syscon phandle states the dependency directly.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 42 ++++++++++++++++++-
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


