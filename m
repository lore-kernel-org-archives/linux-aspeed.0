Return-Path: <linux-aspeed+bounces-3047-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9975D2F7CE
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 09:53:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dN6C236z6z2xs1;
	Fri, 05 Dec 2025 20:53:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764928414;
	cv=none; b=N5jKpFr4Mt4B8n2pKZoGUKqds7yRxAlmXnaJr8ZHiIuITKiULyeRlO8o8MXxyWZ5qxVGsqlVIUfPqjrY0+Kg+XSBsPimaE3QzQ7Lc/Xh+q6NlTxQa1ka6UDkyHxWuQEPoraQgMlkUZiA8GRfysz40+u5JfU/pWkCz14T+HDdJ6LUOcbu9UntV0SLNKgoQk2KqzBhIIscuscjA0fbXPzs2uR+84OPKTkD1q0E9Ptx2QV9iqPv4sQdGNmorzO5FiiOp+HOyMXkOYOdDsP5OVZh7Gts5oPiIG1uaYwltrgqNT8l7yDq+e9ziX4lE1OcBUwkZcHpqe60KQI3HEmv1gmyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764928414; c=relaxed/relaxed;
	bh=iTBF0boFGNGcRcSNgjSOK4GthtALMSgzdK23GMRVvm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dXRHOjzlw2eyqfnSlPMAW3rnC1XssQiHJtovxr47aEt308D1OM9QsJuiILbauEfBKb9A8zAjIqnSNEMaqyU8caQAii5kEdDr99WuK9YPKUcCHJ11ELf9cbe9CWuG1leprSNSBrG01CjAzT8FCgthL39UFPWHztA7tkMQy1SxL/LmYHZfxCsQmvhD4EOTrSRY2UM5wKDCfywQGK+XLaJXITosaO5qxepmWx0qcVk0fsiuILLQSzthZ/PUbYvMs/uLvKri26FkQyHzkw/QzlTwZAV9VxTqUK28ahZ4yIhHh8STDP67QgUuOTRbZWZhUvMG/nDgsv5wxOEsHNhSQWixtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dN6C15xqNz2xFn
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 20:53:33 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 17:53:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 17:53:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 17:53:16 +0800
Subject: [PATCH net-next v5 2/4] ARM: dts: aspeed-g6: add aspeed,scu
 property for MAC
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
Message-ID: <20251205-rgmii_delay_2600-v5-2-bd2820ad3da7@aspeedtech.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
In-Reply-To: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928395; l=1457;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=9dqNDG0I+lA9K1duj4dGqrt41t+rr8rvRvgSUxfhoqE=;
 b=2Xt3Z+aWLT7SefnksLV1lapU//vZWvcQNMvUKICxtAaIIeXptPFeCLqB/t2auiVUk5DFBINHt
 Xn0MBOEevwsASc5fKbhAE3sNH7fD1JPxVhBtw3Y1jbiYO8wghQDAVmB
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add aspeed,scu property to let MAC driver to configure RGMII delay with
scu register.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..d85b3be63107 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -236,6 +236,7 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -244,6 +245,7 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -252,6 +254,7 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -260,6 +263,7 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 

-- 
2.34.1


