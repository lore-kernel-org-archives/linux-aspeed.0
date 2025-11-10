Return-Path: <linux-aspeed+bounces-2852-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14780CD13CF
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 11:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4n563NdKz2xqj;
	Mon, 10 Nov 2025 22:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762773018;
	cv=none; b=lfCxeWg0kpHkPnoKGyiABP/NIifCm9zH0p/+WhpCD9khGQsW9qt/IgotBSijg2yCsM7SIX77O2haxTEJMaxhyPJukI9SCq79UPL0qeakygmzj+kygdq6EGJSjZ3ZXRmVLZv8tD7kplQ0yfNUoTTNjkZ0he+/EUeHtcEE/a6yd9IB8gY2He7ZifmXGHor+eUCIGmgyOkNXm0h6NKYQkDKRCPq03Gj8RQiWqAZTMlpAD92mKkGPEstIGgKPPKxP+5E4yp3FQ4WQIy2C+QxAGjONMqy2w8c/7h7XPsy+Ctshm42MoeoMys+quRyP+rsj65wT4/QM396XbKhUDvNTW1fsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762773018; c=relaxed/relaxed;
	bh=7pshh3/ohF8LFsLQ/xzQ4p9xxjkmwL/S66KpWKvtBpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dxzSfB6z+SNlmnN4vv9PAV8tH3/0nXD0BBPbnqNo++xAigk5QA+X/3V6P2zI3QtBQ28F2FvHEsowx/SyzbaZpOAk5fIPV1Ub2ABm/OB3H5gdWHRK2NppF+cK92WK9b+KT66M0cS+I90UPn/sBc1yh7ZqyDepJQckG893TCD7n5X8wEMbTg0X1RULyXIyLiO+ieltSPtu7Z9cfa4NhmyrhU+RxYnAnu4AvwqhKdq+rYcRFiQarYlr6InpwqBxYE7kJ+A99LM9MuQbl0aCw/4D6p0Akjcj/SFWLT/jwaCyBrWGQ1/zhVkmJgNEqG6lzkNJ2rexEXsmWHggXkDfuMwlAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4n556Rbgz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 22:10:17 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 10 Nov 2025 19:09:26 +0800
Subject: [PATCH net-next v4 2/4] ARM: dts: aspeed-g6: Add scu and rgmii
 delay value per step for MAC
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
Message-ID: <20251110-rgmii_delay_2600-v4-2-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=1849;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Ucy3rhfxQTjHXt1MgABc4IxBLFYdHjTHFrycXzSTtU8=;
 b=llLXoEPg+i9Q5ddiJeB8AraApg6XuBFJzIozUdNkWWm6HsLi+kGPbYzew6CQkYJPUPYh/IbIm
 ZHJsiTy/9TRCDR0xy27GU0Eclc97RWjr/9tXuqX/LUNL0eEoDHMf5u8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The RGMII delay is configured in SCU region in Aspeed AST2600,
therefore, add aspeed,scu property in dtsi for rgmii delay.
And the RGMII delay value in each MAC is different.
List below:
MAC0 and MAC1 -> 45 ps
MAC2 and MAC3 -> 250 ps
Add "aspeed,rgmii-delay-ps" property for each MAC to specify the
corresponding delay value.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..2c71e691c547 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -236,6 +236,8 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <45>;
 			status = "disabled";
 		};
 
@@ -244,6 +246,8 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <45>;
 			status = "disabled";
 		};
 
@@ -252,6 +256,8 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <250>;
 			status = "disabled";
 		};
 
@@ -260,6 +266,8 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
+			aspeed,rgmii-delay-ps = <250>;
 			status = "disabled";
 		};
 

-- 
2.34.1


