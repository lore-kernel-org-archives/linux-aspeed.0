Return-Path: <linux-aspeed+bounces-3000-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE512D1038C
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Nov 2025 08:26:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGXj626tPz2yvH;
	Wed, 26 Nov 2025 19:26:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764145610;
	cv=none; b=AEAjTc6xukGGv3+MdUcsqG4LetXnibXE1H2J6hrYR+WzAkJNPJVn1vXZHJgkn0PNWj2eMTVi3XrWWu3yGKvzTGMiEUBB/HMw4Htcf5uQKngwVQjcLROsmNnaG7A3n+V/9Yo7r0sP4Jjyba60fSBsQM04KFqS36GMUN69XRJ95scsuQz+N8nSf3VZiTcM6Z+CZBsfPV9dTKFFt+V7uuT2iGHHdxSlvS3234dYhuxBUyBnli5pgMZwj78vw/4vJPSdmo6yJhBJuZNCRsz7bRDRv4Jd9Ob0Nk6/WJHV/daxwNnkzerq2mACbcqCGm621Z7PUK7i76sk+O9VXFhsvqitPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764145610; c=relaxed/relaxed;
	bh=p1a16dCHqSoV1bGYQwsQfBHDNzGYIAnms9DNH2Gqpd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KeQps8ZOPZNWH58RZdAEWwfVI+Rf/1idt3w2mgP6OIvhUGIX6NgY9m4vQZre5c7PIyJ02icyQ4vxXwfre4YD0rC8qeh9G57n949dTBHrtdpNhQyM+xtHyNszHHS8pQbZODV5YpsHfAwqCkRo4V9AI9VXrGsDAtAbNhSjgdSkn4tPrsfPz0+l+ibLJgmX9w7WGXdUoJp1IVtg8Yfr+h2sPtJh1B5oSC+N3OnP5Lsoinw0EfG+p/9LjZX0Vc9czvp35zGFpdaKtwBtsZWivUJ7xRXVWcT9ZnILphG85Ao8Qw3HJyZrdTRI0LN2UN8eFBIGbuN/goZ7T/rpoR9IXnoC0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGXj55K2jz2xPy
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 19:26:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 26 Nov
 2025 16:26:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 26 Nov 2025 16:26:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 26 Nov 2025 16:26:30 +0800
Subject: [PATCH 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700 support
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
Message-ID: <20251126-upstream_vhub-v1-1-910709937ee0@aspeedtech.com>
References: <20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com>
In-Reply-To: <20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764145590; l=1317;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=HEzWWYIHW1xKDw5/cUq64msPdNcRWYQ7CNoSj8s7Tc0=;
 b=/akVg1W5dYhU+EFX3V4YbmlsHawqShE/aW/7otTU9xNBzwfv2BAVdGtZjeZCZLSeEanHdxVzb
 hGiaFh5PeyOAdlM0Qi8k8o2S393xmdPTdzTBUGRyQozqnU+4MNQoe0D
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the "aspeed,ast2700-usb-vhub" compatible. The ast2700 vhub
controller requires an reset, so make the "resets" property
mandatory for this compatible to reflect the hardware requirement.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
index 7f22f9c031b2..c9ebb6e004d1 100644
--- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -26,6 +26,7 @@ properties:
       - aspeed,ast2400-usb-vhub
       - aspeed,ast2500-usb-vhub
       - aspeed,ast2600-usb-vhub
+      - aspeed,ast2700-usb-vhub
 
   reg:
     maxItems: 1
@@ -33,6 +34,9 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
@@ -107,6 +111,16 @@ required:
   - aspeed,vhub-downstream-ports
   - aspeed,vhub-generic-endpoints
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-usb-vhub
+
+then:
+  required:
+    - resets
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


