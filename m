Return-Path: <linux-aspeed+bounces-3367-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B81CC98318
	for <linux-aspeed@archiver.kernel.org>; Sat, 17 Jan 2026 11:17:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dtZ2C5gB7z30BR;
	Sat, 17 Jan 2026 22:17:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768648659;
	cv=none; b=lRQw6SDAQ6Qtx44wB4rZDmVMWse+iOisfC9aD7ckxWD1OZe/pEzxg9BAQwc0kfta22okQKckfMFaHR0m5prIiVOQG2kp3y3n9yRmp1nwjDHYk+bUugKaAFEQeoqHJ4Fj4l0stiWyN061ZTSq3pvW5/qr0YZOgDlCAL2jWyJBEmrK0OF41cJxM8CgMLEWfgPlGGftX/8x35ys92iUB7WrwDhuN9uA4Qy8WS5/jblyNN1NV4CpSNAtv3PfiyBnP6MQYi4EVAt4MhINg8yqeHgNqMQOi91646+Pfeb2iueD6UHGsah1EyF02zMxdAr42lqrJt+KPf5gJftF9qxpRDQf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768648659; c=relaxed/relaxed;
	bh=FN6aQXtkPGvwJazEWBzSB+8oekQEJp9xSMmX+sFap5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hzoCbu0jRg77qqH3q5btniDXjIZxd7s98zGJkfG+b5ObxrsAYlCcNP5hNcPcK3GVZg+Y/69u/BT1fxDWFCJFVJCG9WaPGj4bPOAwsssml/3cOp0ogqXGL+GwpXJp6Zgg73BtZAsolfWwbQx1rgEGhi17DdbnEiyRpYXNu/zCfoRCPKPSdyWTsmnuCH+/Zpsjl+Tq21UmT1dpU1MNrLXopC40aLEPQCQqtoHR53GVUjyTn5aykD/tRBykBXFuBuwFbn8DT9QrljR21C4vUEI/QIslppA2qMwP5B3TZYThPDUIpxayV2dcL3220LTS83dajJOxsM4tfNxj4gZPHJJs/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dtZ2C1xmHz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 17 Jan 2026 22:17:39 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 17 Jan
 2026 19:17:17 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 19:17:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Sat, 17 Jan 2026 19:17:11 +0800
Subject: [PATCH 4/5] dt-bindings: gpio: aspeed,sgpio: Support ast2700
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
Message-ID: <20260117-upstream_sgpio-v1-4-850ef3ffb680@aspeedtech.com>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
In-Reply-To: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768648637; l=1334;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=XG7pFsnR1EluRR+EFdEVQzRXxWGFIGc/mPiruNMQ0xs=;
 b=fBUpqWXZ3gZbvVmGZDnwQESir3BVUnInQZVNigV+6h1dREc3oa9lSK1yJ/gLlHqEIx3FesdjB
 wD22J7LklN4BMVLJoVCp4EMHEn3ZEOSfWnSTK3dZGETbOg7O5CMSz5d
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The AST2700 is the 7th generation SoC from Aspeed, featuring two SGPIO
master controllers: both with 256 serial inputs and outputs.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
index 1046f0331c09..974185e3478f 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
@@ -10,7 +10,8 @@ maintainers:
   - Andrew Jeffery <andrew@aj.id.au>
 
 description:
-  This SGPIO controller is for ASPEED AST2400, AST2500 and AST2600 SoC,
+  This SGPIO controller is for ASPEED AST2400, AST2500, AST2600 and AST2700 SoC,
+  AST2700 have two sgpio master both with 256 pins,
   AST2600 have two sgpio master one with 128 pins another one with 80 pins,
   AST2500/AST2400 have one sgpio master with 80 pins. Each of the Serial
   GPIO pins can be programmed to support the following options
@@ -27,6 +28,7 @@ properties:
       - aspeed,ast2400-sgpio
       - aspeed,ast2500-sgpio
       - aspeed,ast2600-sgpiom
+      - aspeed,ast2700-sgpiom
 
   reg:
     maxItems: 1

-- 
2.34.1


