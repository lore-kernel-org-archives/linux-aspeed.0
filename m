Return-Path: <linux-aspeed+bounces-4443-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C8AC44501
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ9C2PCwz2yfD;
	Thu, 09 Jul 2026 09:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525117;
	cv=none; b=i1965zwPmOCUWEy5DNJegq9Ydk42r6PTxg061IFmoia39Zht5wfU3CBnnSiwcubriaT2z5AnUO9dhniCgsYi31GC37LAXNaL/g+zCYAt+RrAsz5G+jYWu1hFtR1fVl5+JEGs1CtsW9MzK1Nq4KZQH7KfuoXsfI3kBD4pNL1nG0T9vOIhKyoSaMeAfAZgNE3CmSGU1Vz7yPgciKw5+GMRLfFF2544AIlXdCRP465utMR5ULYMtBcO+E/TrackwB5HoFzXCT9oC7a4D85lEt9Z6zRRHm0mAyz6G7Yi8/i84VhTVU70wuuiI0csbKyM5Objf16PbGGq6UnMozbQMhGvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525117; c=relaxed/relaxed;
	bh=IsD4MhplgL6wFfLDJdfUVLAz4oGDfnauFOzTWjsK6XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtZJ/a5NmICQcrdORKScYmj0G+BOtzJq5iO1/myNL/YaZrXXtmfzRw8Sz1w7TUaAAFbG5ZisSjAm/pKp0ImZ+HGNFW07gnNTqllTIc7RftlYWtzMXS/Zmm5Kbur11S1lsXxNDNQP49jR6HmgZLeVtTppRN3Nnh+GlY2scW/35CtlWohWcOfMo2qNyecZTvnyx1Qr8QdzskdQlX/k+qszjMMyaJPnwxpCSuHTrpGtX6B+7nWM5JpYsI4tcrJ8SPsSXfn106K0wPYI3TTbHh00LeW3kpbCnm2WUHkr94IGxGJG0D/mw67OLh2z8xE4jhLnClr6VmzKFNNEvuScT2FaCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gCyZCZ9N; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gCyZCZ9N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMgw64xsz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:36 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-493c55d5c7aso8625085e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525114; x=1784129914; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsD4MhplgL6wFfLDJdfUVLAz4oGDfnauFOzTWjsK6XA=;
        b=gCyZCZ9NtRWZUPYiIE+xAAJ70Xi2k7KX+hErXCsiT8uszU7EI0dJLMwSPRy090NrGF
         ou9Qu9WvN7hqkBbxiNzPN2ZiUaajidQkfRiXcpFujpFzqxb2oXN/NW9Fl8KsI4W2Vwbw
         QIzL+7f3x9A0i8fcH/JqvS5Mv7q0IBwJC7TQXLkREYxsAflKIWuYj4j+Pq6lFxUYq5+J
         omymf1m56qUhn7CTQxf6zoXryTWDRexYvGfh0aBYqyEulaAHT/OoT2Y3V5sVHGWuxhRK
         gUL1M+ODwhHPNC56YRjDuo2gwLB8rolGKMiWODx8pz4ZXu+CT50yYVGaQlcHBIC+S6oA
         D8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525114; x=1784129914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsD4MhplgL6wFfLDJdfUVLAz4oGDfnauFOzTWjsK6XA=;
        b=Bg2znniVWjhJjINehkFXXCRoqfIVpGgze5F2WPRFVXi3uABZTUQmxR7t1DCrW6j1Ab
         e54rmWUC9GbtcrvXWJIzJsOgxBVfCGiYMiGszJ0VaNx0D4RNxkVoStU7rgtFbG7B9GYH
         HofV+iFjiaoMfur4Laf8l8A8zDpUgEKi0s/thL25hRcJqRR5jq3y10H++WizGRvr3dXD
         FXmbo80WVFlayNM5T5LdOhBsomdbm4QOK1uZEyn2+uajymS8iINDgYEhwv3wzyO7UOOW
         bqZ6uccgYjlCPCtquK7QdffAqwhgCP6nLEWeT81S2bihKvCEuPkrhktUahSDwD78rMhm
         kaSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp46akJoYRYYK7kJx5oZToI0pAUZk9uOMCcz3ZGf7W3nOwhw2okrTkRKhHmHtyeFgkOMYoECC/eC+qJlnI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzdq0itk4RQKKCXU3JabGNwyAgFH8hMd/ZEPa6ucGKMb6S1VQvr
	hx3COo7JrreFIp2p0Zr2ZUUNRgSN2rDHktCc33CfvJee+7Lirj1pS1l98A1luSAfefw=
X-Gm-Gg: AfdE7clwA3N0ZWDiiMwSTqwZOOtLlU5XtTO3rcw4A0E74cp2uFEPdh7EVcL7mrOJfWJ
	K7NYYiuzCbs1xtWmC7Ns8hBcqdllkX/Rn8ncmM/SmVh+zzWM8VrGONw+K6dMzvj9xsDDvcLGnNX
	2nLZy1hX6yvNePSDT065Ya/VOqHutws16xQWdikNKgC2MMNoNhzoN1Zc66c9ztnJkVH8vf75/WP
	6XanZ8Ez+SUNqEQR6jjuzxV5drLkrsibG/aweL5gIPOKuTl+288hpMeocnrl9MED4Td+maytyPd
	cPYKZP2gHy5bEeq7R7dZ6fgtUJEu/hldVm1dmyQFVW0Pq51Nv0pZsgj08TNMI3gJatLJSYD48GF
	wQKZd5pKJO5pvvqUV6Dn6uPxeVWERaxGuDtqY31wtri8hsLfEm6zhhDDKQNCT7EPgIRkyMqG/RD
	qxHWC9umksDKxrQa3yCmhDM89PmmpHFoHBjHQyF63dOI4m1hhWrw630bTEcsfHuoA0C2QclHchh
	IMId8LPO4vqmJZfKN6nSLzEfmYj
X-Received: by 2002:a05:600c:1395:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-493e68ce31cmr32926785e9.27.1783525113666;
        Wed, 08 Jul 2026 08:38:33 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:33 -0700 (PDT)
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
Subject: [PATCH v4 2/7] dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
Date: Wed,  8 Jul 2026 15:35:54 +0000
Message-ID: <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>
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
 .../devicetree/bindings/serial/8250.yaml      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 8f22121381fc..2ea8981bba80 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -27,6 +27,16 @@ allOf:
             enum:
               - aspeed,ast2500-vuart
               - aspeed,ast2600-vuart
+  - if:
+      required:
+        - aspeed,vuart-over-pci
+    then:
+      required:
+        - syscon
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -223,6 +233,12 @@ properties:
           - const: uartclk
           - const: reg
 
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU syscon, used to enable the VUART over the BMC PCI
+      device. Only applicable to aspeed,ast2600-vuart.
+
   dmas:
     minItems: 1
     maxItems: 4
@@ -316,6 +332,12 @@ properties:
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
       applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
+  aspeed,vuart-over-pci:
+    type: boolean
+    description:
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
 required:
   - reg
   - interrupts
-- 
2.54.0


