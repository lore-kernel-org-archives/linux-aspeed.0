Return-Path: <linux-aspeed+bounces-2911-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9049CE7AAA
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 10:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CZs0PKjz302l;
	Fri, 14 Nov 2025 21:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763115061;
	cv=none; b=k29sAbI3ITRmt83icrWuObky1Qd9jEkHoyIv/7YYFmXb9U7tk2lqu6krxraxdgl+QqYOD12zcbI1loamwpQCmnwSQ97ha5fuyELwI+YMXaF+TSmu4eBKFPN0eZw+RZD20VW27UXOVr0F2nyFy7rda+qpDORB2v6Z9nf32ec6XmQAaE6w5XqY+jPN+VDdTHklQqf1N7IsNZa8+mt+10rigm7wVaHjFcXhCsu1PngS0Q4hwYGXQOXRDD1nukeWhp8lYPb9CFtGtmbixplhHLkbip/bGCh+anX+IT89EK9Gx1hQjglhoVN3eXLqWbfG52wTPM52ISZ4Q9yk65iE+BHS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763115061; c=relaxed/relaxed;
	bh=hXKhvnbnRDnIlJt2E/ftcbaIRr7slR2nNVEf95+X+NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYuLiyQcLYrf/idFu3UvGTdIVH6o22nbtCSxpHlWf7ZDbDOLsPVt9NoV4Rb3LbLLdGbUmXRswoc2oe7gbb6lv2NJY7kci5BGYt3LjFGC0iQ9cKejxwpzPoSMAQuZYCzIYUs1Kx6hvqgwsQKUoRtgH8Krz1iSJzqqmL6YSOSJFmT50FdxelLaLVtbCKw7k4+HQQfdSIuHCYSM4Ui9FTC7djVKW9wGqlXsH3z7kNhADqU5DIa4ydcJeiXFVRZ8UWgN+1OQIHEutpfHnipHZqzKrwOlGMlS3XheWniWrzD+qzxY0LO1i3DMnzElL8urhshpwsFBy7/jWo1bhYMBVeAfCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CZr3hxsz2yxl;
	Fri, 14 Nov 2025 21:11:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 14 Nov
 2025 18:10:42 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 14 Nov 2025 18:10:42 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
Date: Fri, 14 Nov 2025 18:10:39 +0800
Message-ID: <20251114101042.1520997-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
References: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
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

Add AST2700 to the list of supported SoCs in the ASPEED FMC/SPI bindings.
AST2700 FMC/SPI controllers are not compatible with AST2600 due to the
following hardware differences:

- Address decoding unit uses 64KB granularity (AST2600 uses 1MB).
- Segment register semantics are changed.
    AST2600: start <= range <= end
    AST2700: start <= range < end
- Hardware limitations in AST2600 address decoding registers have been
  resolved in AST2700, so extra callback function used for bug fixup
  is no longer required.

These differences require distinct compatible strings for AST2700.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index 57d932af4506..80e542624cc6 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   This binding describes the Aspeed Static Memory Controllers (FMC and
-  SPI) of the AST2400, AST2500 and AST2600 SOCs.
+  SPI) of the AST2400, AST2500, AST2600 and AST2700 SOCs.
 
 allOf:
   - $ref: spi-controller.yaml#
@@ -20,6 +20,8 @@ allOf:
 properties:
   compatible:
     enum:
+      - aspeed,ast2700-fmc
+      - aspeed,ast2700-spi
       - aspeed,ast2600-fmc
       - aspeed,ast2600-spi
       - aspeed,ast2500-fmc
-- 
2.34.1


