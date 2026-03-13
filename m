Return-Path: <linux-aspeed+bounces-3662-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85078105F78B
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:10:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv72WWcz3cMH;
	Fri, 13 Mar 2026 21:08:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396515;
	cv=none; b=O+PiHtoVZkknh6aXLihpa/S0qABxhhGQqA60miAR8WVsQ9PAZ64Ij2A8u7lqt91xGPSnttb1g6LoUgHd3yNxbakcCccJ0+Phi9pFciGJFZ0hHxna00SuxZAYekJkewEZD048hEix1JhPReng0RejshN1/3H7+jtOTg6tAwbXmqS0M5Cn7E5oSuvvpIBAVOQjkC8qqhfi7VSUa0eimHcttLPEDq5evkS/uIARLnV0vU446HdTgKZRUPgadL4xiihrIckNjrTtVfh7fkWnI4MS4CdfufaXn44uUKqYkrfdnBj8hRDNg9iatFmuTqpE9sYp7EAjdmwMY+N8pypiy0q4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396515; c=relaxed/relaxed;
	bh=Ph5gDdkCZ+xgn/xu1To049+phmQgTK5P4O8QXh/ouZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e7Jzj7AAAjsw1EIk4H4pyzSYcQxon8eh6emvC6X7/FQqxTjI2T7wGeBE4UZ2j4M955qbyOdw/2lAzRDMbuxBqtIS3nTyKqhZXOhXW56s5WP4dfzS0GdpltO3SyF0w+kZybjkLglzO0LqC5SMHxgGi1o/sO2GXDJFvqQ/ClVWLtg0nQbbIbQy7zOsx6WTK6HOXRimB+FFQzLrb2XifP425J3Fg/N/U+rpeEtlSPPax4uqfWnix5SvnACP9IRQXImsXd9y8Io/tIUIuZvs+wA5d94UGuCp5pfYzIryIz9s72B6AFnoEPpub3pAcp+3Z9b4RBe7FqMgKdve78x1Fvj2Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKv64XCFz3cMg;
	Fri, 13 Mar 2026 21:08:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:07:42 +0800
Subject: [PATCH 7/7] arm: dts: aspeed: Add eSPI node for AST2600
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
Message-ID: <20260313-upstream_espi-v1-7-9504428e1f43@aspeedtech.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
In-Reply-To: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <maciej.lawniczak@intel.com>, aspeedyh
	<yh_chung@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=1060;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=X4P9bqw/tIokZle3LT7wc0YRJfPr51Mfgbm0e+Wf97I=;
 b=kK0C0gMsRBFk9Iv1JxhBwvqxNK7ufbtGNrD4kw1oHLHc35n/Xyibin/aLRLMjakvBubMHuRUp
 n8kx0NtlapOC4TQXotHHwzP3cvScPvveTms/jil7qyQOqdBRtdJO8C3
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

Add the AST2600 eSPI controller node with the register region,
interrupt, clock, reset and pinctrl properties.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..84aec45f39e7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -408,6 +408,17 @@ adc1: adc@1e6e9100 {
 				status = "disabled";
 			};
 
+			espi: espi@1e6ee000 {
+				compatible = "aspeed,ast2600-espi";
+				reg = <0x1e6ee000 0x1000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+				resets = <&syscon 57>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_espi_default>;
+				status = "disabled";
+			};
+
 			sbc: secure-boot-controller@1e6f2000 {
 				compatible = "aspeed,ast2600-sbc";
 				reg = <0x1e6f2000 0x1000>;

-- 
2.34.1


