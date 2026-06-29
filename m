Return-Path: <linux-aspeed+bounces-4318-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED04EC43638
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 23:56:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq3874Jszz2xHK;
	Tue, 30 Jun 2026 09:56:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782715777;
	cv=none; b=fWDwX5S50CCYPjHZSxh1rAOcf4N0Z0XU2Z7MzFqTwHqHEwrSf8V/h0qDepvp4rDtlStpGvVNDLiiZh+igBzke8aviiSjn23ngm29hrBKVFpc30A83FjqmFkEh/1tXDatx9ysPpNN8aNZxmMWqOkX+DfNDHNOvf8M9PbfXnWAM8z5ojouJUtQlycAd3IDKmMU1W/OYwJQ0qmZpwJg6N2B0SXUhHo4pr8yisPK9oos+9yp40N8/S3oi0KZy4m+TXdQKV76Mojhl1krDlNRJCAKyvkAEdTLCT3SWZ/O9yWDL9y96r/l/V3hPXAhKpljBqk2eMzLO4qYGLf5+V/MPXTfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782715777; c=relaxed/relaxed;
	bh=Df9KJQGwN+4BY13mT7BAtNM2SG+EkBQ538Vnt+/tQFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7V9FfCxRs+ef5N0ekhTiOn60ZtEpxvzlYH3V2jYvaNLHPCNpyvLx0lnnIUUfM/TRv7Ho5dky2JzdR2+fbFv0NI0mTgFbOUEaxijlUFoi1TMH4XTc4PDbp/kLC1kWwknm+bFr9ZEMFC98UkTa3Zm6pP0qmK6ork0uCs94adRNjctRdZ1S3vTFhUR5YFjSGRFiXayxQ7g+aUlap4RidyeihFAzUgBHV40xwePoWckAR2+cwB9Qlfwx39yF7xEitm4/SN5B2r2U4traifgZWJs3bRddcWI3bOOQjFt4fPh91gV1fzAhK2VokbutjVkxJu/rkAYmzrNMstUGlAzVVf6EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SSwEZKs8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SSwEZKs8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpcMh3ND9z2ybR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Jun 2026 16:49:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3011443D98;
	Mon, 29 Jun 2026 06:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AC0C4AF0F;
	Mon, 29 Jun 2026 06:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782715774;
	bh=nBvnhkraAlhGHXXmcPBOJhkaZz0VzUTiD+ls+OA6G2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SSwEZKs83e6+QTrEKzagUVnFW/IOgcDcpy+iaAn1t081H8LzVxAcJzQf35og+tL70
	 om6TdRvoHWlIclhSpcSzpW2NmEb2AqkOG+Z8LVYS/pf7FL26td+/RevoGfni8M9Zk+
	 SFjmLdCRSonP/rLpeMecLhVDMK9uWgivKQeEKmb/aVe6VcRKg/4VE/62gqBoP102FI
	 BM9AOskNHU3MNvLb100K9x5Jju0jQuU9P9dtNryzcziwvh7Rd5cr0pyoCAPmh4tmEC
	 7kqIqTsgVheFudAo4TobAubW4RI2qufprx8wJzezum3MB2PyHR1CO+IEhlXYD+Y1DD
	 WpoXAV+9Kr7XA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA1C44500;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
From: Yu-Che Hsieh via B4 Relay <devnull+yc_hsieh.aspeedtech.com@kernel.org>
Date: Mon, 29 Jun 2026 14:49:00 +0800
Subject: [PATCH 3/4] dt-bindings: ipmi: Add optional LPC properties to
 ASPEED BT devices
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
Message-Id: <20260629-aspeed-bt-bmc-multichannel-v1-3-fc23ee337f7a@aspeedtech.com>
References: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
In-Reply-To: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
To: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782715772; l=2189;
 i=yc_hsieh@aspeedtech.com; s=20260629; h=from:subject:message-id;
 bh=z+ycFWmOaDIg3MLyJDHKU8ALQWWy3TelygSh1S01hYI=;
 b=2Z9HfF4G2QEiNPdhd3fE4XoWv99voNdrQ8WCW9S6YS9YMCZkCHI4FWveW74mN6CgGvTdjwiDC
 DSvofFpp5H7Dr21dT5wgMlRNWm301BGtmyyzOF1GLUFzkHN5ot/asz7
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=kLxUeF7g6teciq79it9N3tYNgp3yCspZ+AHlYSnZ0gs=
X-Endpoint-Received: by B4 Relay for yc_hsieh@aspeedtech.com/20260629 with
 auth_id=844
X-Original-From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Reply-To: yc_hsieh@aspeedtech.com

From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>

Allocating IO and IRQ resources to LPC devices is in-theory an operation

for the host, however ASPEED systems describe these resources through

BMC-internal configuration, as already supported by the ASPEED KCS BMC

binding.

Add aspeed,lpc-io-reg and aspeed,lpc-interrupts to the ASPEED BT BMC

binding so firmware can describe the host LPC IO address and SerIRQ

configuration using the same properties as KCS devices.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
index c4f7cdbbe16b..1803c6bbae93 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
@@ -25,6 +25,24 @@ properties:
   interrupts:
     maxItems: 1
 
+  aspeed,lpc-io-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    description: |
+      The host CPU LPC IO address for the BT device.
+
+  aspeed,lpc-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      A 2-cell property expressing the LPC SerIRQ number and the interrupt
+      level/sense encoding (specified in the standard fashion).
+
+      Note that the generated interrupt is issued from the BMC to the host, and
+      thus the target interrupt controller is not captured by the BMC's
+      devicetree.
+
 required:
   - compatible
   - reg
@@ -35,10 +53,13 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
 
     bt@1e789140 {
         compatible = "aspeed,ast2400-ibt-bmc";
         reg = <0x1e789140 0x18>;
         interrupts = <8>;
         clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
+        aspeed,lpc-io-reg = <0xe4>;
+        aspeed,lpc-interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
     };

-- 
2.34.1



