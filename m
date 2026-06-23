Return-Path: <linux-aspeed+bounces-4289-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F08FCDB47C
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:54:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMNy0F6nz2yYd;
	Wed, 24 Jun 2026 09:54:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782224985;
	cv=none; b=JguFur4X2QkUEPS+CkDyTbGVKiVkzSxVKbFN8N0UA6+LYtD9Hh8BHWHCe1xEmo5KgQoOvWbnlviYAeawR+ip/+oKmxL4IHrGuCLDBwpl7+6WwsLCDhqDlbK+0Qhbi5aWVwcPLyJEXSRYzDbH2nllq0cVNrgaIPmqYJuIBGHcZQiKrOtQ8uJ7sIRNmPxtDKLvv25b/v4qf6Itbt4SqHej6nIZYu72xCGmX1g9Tp8kc4d4NQ9XisqGpnvAODSUTNsxJC3Smb0Zj+UG/pwtPjceRDOWrojPTyI2VT5YIh/RlDa3dkWZbTjFSiFNDg+JZxI9SsKzlmqbKJXuOJQJfIs3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782224985; c=relaxed/relaxed;
	bh=srD079C+hrmcly29x/1Ya3b2fC/C4R7QLaFAjvjgVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P07/rAp2ZlWkmU5cnVIDhlNNCw8wpZRC2JciSUa4kygq4ZziLWIqSXESMoLwQW7msymUEFwwza7gsWVJ/+S/B5hWMLYIWijuL9e9VYJqviu5aiqML+M7+nAzAl8SnTpYC4O7M/7tFmagrRON66sszZAVMYRLXvwAfzHyvIbpNgIOka0aOeMB2AG+51LBEAD33g9kyIdmDmXV29Cvm/AIMwuMtTo57ZdF6TnWI9x7davrTcLQRmYkhWLS7LrI7ISeAnrpWSMI8EHi8kTvQj0tSZEgluyQ31ZLFW6nfffKPpGfxu5nNCm80rTPbKZx8KIc0JMhKHN9eHXiZmePUaKiJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=DzIUz0WC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=DzIUz0WC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sN61Kqz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:29:44 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49241a577d8so29742215e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224982; x=1782829782; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srD079C+hrmcly29x/1Ya3b2fC/C4R7QLaFAjvjgVg8=;
        b=DzIUz0WC/CF8YSSsL1Rr2ATAE5TuhGYaQ3cYCtHnCBeBgLrA+6bDthC4Wh9NTPXuny
         J3xT+Lr6CuR2putTKs0LL+r/CTcJn6TEtS07QGnnzi1FVPHgpC1Rwek8QaWoVRivZ9Ki
         g/4Q3fB4b35kzsuwHNuFyc8lfK71qx3noEijOjp1MBEyGAsskSwPiChPKyb4ItZXdmBk
         vj2HUs51gjXmem6iE3eEpqG3wHlTzDJx8EyDEkWaY2JI/f+RLS1kgyyg6B+CJvr8upgL
         DdAP49jjEsEXWwte03OoNmt1NldRAWrcdV8HZMiquz95AWz9AyMRTnLp1Zk0T2GXuz7t
         Q4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224982; x=1782829782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srD079C+hrmcly29x/1Ya3b2fC/C4R7QLaFAjvjgVg8=;
        b=DJ9owaAXAfFTYWFTVtOr3lhfGMxJj4BtYGW30N87Lb50ebyb6xkKezORUzd4euN/8o
         hpHrFLR9Ph6+/zyWy4pckrBjRhTvFQJvW+O1bvBAafoNFkP796IuCW1M2Qsu62rHmIkD
         /PjwfG1bkNpK4Buk9m+n11vbkiZ0BTnEM73k5U/eJSpuBG8ki9lmjrzItr6PuECnqxxK
         aS2qfMR1znu7SGLJdNXE9pe10+0S44dYaOtU4/qIp2LacJo9YQfTwxNljbQpPMc7ajze
         l8VIAP2U80BPNNjxrFsI+Ue5BfCwmq2bazEo2RWKgyNKYwc8oubx7GMnUV2RRsKudvKS
         EHDA==
X-Forwarded-Encrypted: i=1; AFNElJ/jn7PGDFTwjxv5F+JA4bCUmLVqLSQQyOaiGjp86aAcwYz2kQC+ptnqGxbLgGiWpQDx+A6tVB++Vgw0rcs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxc4Mn1Z/6SpLS+/5GKwoZ97X/nADdaT7rjCKQ1N79Ega0DK84u
	wfVUwwcF8UuOSDXgKkDiVbNO1bZnQ4xLseeesjGXjqUtc+UZEIA0z7BOWJ8UyXgVIcA=
X-Gm-Gg: AfdE7ckMtYTwUahv3Mkzb/091/zXvs+eBDRFXedJjEA18UIdI8jwDohqI0Jw5yuCnwg
	w+zyGSEZSe2K9Hsmr04dmz7SBgAOngQKcwlXjm+KFdxQ5arzexkIsigpC3JLogAECuTmnMgAvGJ
	L4N8bpJ+K/gri44NbH+3HzRAt2UaxtLxR7kJF1XtJJrfbO1aBrSBXYMJKzcsX/4Ta5z91qqofyK
	wVJKc0ZsKs61DRvXmrPlz5oFKGo6hwQXnmYfAhlE9NluBEtlUZjEGBjWNkdIkRD5WcGuWcPXr6e
	gWUV/AIEiqekLahVBVYeqXPCtxBjTkfYuDTWeGmudDFFx30ymlaHM5uNaGqfU62JUnQ3G0ayN7G
	AniqSI1z+naAsQ452aSdrOvq7W2o3uf6/Iea0t3IUnz568NT5rVdacs1bjAEP3VM7sZlMuq9VRw
	5gdL1FbzX4CIGchYPVe1hE1czSGBunm1SFJGVFzR6oitwNLNFL51komA9SBcj2rPZyEyULWvVl4
	nmxl/7Xi7HBx1UVHb+3bbLftVM0
X-Received: by 2002:a05:600d:10b:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49240e9544dmr224625985e9.28.1782224982083;
        Tue, 23 Jun 2026 07:29:42 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:41 -0700 (PDT)
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
Subject: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
Date: Tue, 23 Jun 2026 14:25:40 +0000
Message-ID: <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
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

The ASPEED AST2600 has 2 VUART accessible over PCI.
This boolean can be set to specify if the VUART is used over PCI.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 3cbd0f532e15..b03797f4674d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -26,6 +26,14 @@ allOf:
           anyOf:
             - const: aspeed,ast2500-vuart
             - const: aspeed,ast2600-vuart
+  - if:
+      anyOf:
+        - required:
+            - aspeed,vuart-over-pci
+    then:
+      properties:
+        compatible:
+          const: aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -312,6 +320,13 @@ properties:
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
       applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
+  aspeed,vuart-over-pci:
+    type: boolean
+    default: false
+    description: |
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
 required:
   - reg
   - interrupts
-- 
2.54.0


