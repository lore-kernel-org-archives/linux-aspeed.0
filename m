Return-Path: <linux-aspeed+bounces-3571-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8E1E9B359
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 10:24:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPZn04Lm1z3bkL;
	Mon, 02 Mar 2026 21:24:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772447092;
	cv=none; b=LmJMgW5xvFptQzNMQ1gkXjnHjEbJtHigd0ZMBPol1PnmbUpSa7qVmkctLYHGabrlegLQ/HKE3GXrkS/diEPP8DXYbCwGNRgpq/BUDBTOoeGaggIzM4G8lD16UdPHYSM72jxGlIjvN60EerbzbiLuaMOYapeIChjv185CjwDWAqzIySQjJt9OXWcHb/J7Pok6HHH8u7gtTFXFV19H+5Fpov8jVBYjP8+XBBKaw+U3lYZUCSDe0UYYg9KqLEapu6KJ+GwBpb+g8S0EogCfu+OB9cl5GMX01FHwbs/nKharotEYbhO9/FAzETv51JzQP0Pmn/GZMSTsAo0+4MLFSHzujA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772447092; c=relaxed/relaxed;
	bh=1mVh0r0uRZ3OiF/z9fHWwrjCycqCs19HSECJOn0iOZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DjcbQRwpHnMM0LbjOZXCYQdcqyRktHDjppC6NW34uy1qXH6kfWfGkXtLKeK8wzqjbQfAblb9O6gP+4Rf26fsr9Xj7r7denp2gcBGAtN+6NHqvKcV1966UzSEin13JzDtPaxaOT0XExSNCT1YFUl3oeuv7oZFj87l/IrfHM5cEK+8Hryq7mkzAIGPBWyAyfCCl2ltj78q4+eCfl39aw5iVKfCMQOkXKqX5myVj4ySxDp1Q+TBjKHEQydbsked8sAe0x/O/i535GTWnQnepKY76mNmDiQvtqcYc4lBY5uZAnZ1EpO+x1HPpQwOwcP0nNRF6nnbCj8VqytV68aMiOM19w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPZmz6txJz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 21:24:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:29 +0800
Subject: [PATCH net-next v6 2/5] ARM: dts: aspeed-g6: add aspeed,scu
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
Message-ID: <20260302-rgmii_delay_2600-v6-2-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=1457;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=aZtDNdr61OwweI7vby67wVIteWF+rJrRIBVHhHKQGhE=;
 b=AXmZ0lSoz1tSsrNTPqSr8OhapxV4yxEady0AEJi725vT8llR3TAbxTAXgpQE8otpoSQj+DJ9M
 5XXUXwU8FxuBvN1sBZ/0QQuDmszHZgWhD8W55Az/igxDzBMj/K7GkEF
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add aspeed,scu property to let MAC driver to configure RGMII delay with
scu register.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..cbcdc1c6eadb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -235,6 +235,7 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -243,6 +244,7 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -251,6 +253,7 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -259,6 +262,7 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 

-- 
2.34.1


