Return-Path: <linux-aspeed+bounces-1431-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270AC71135
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:11:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJSCz2r8Rz30DP;
	Fri, 13 Jun 2025 15:11:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749785425;
	cv=none; b=MltTAXUqK9Rq8i5OP3BfsW17xpYqWa19fzjkFodqu+BsGiFgO0kmFAnQ1EqrCc1zDOUKm375S7+EfMStVTEj7h182EhIpwwE2zctnaMNwDmlodo/purvbq8Ikmsa3MQB5GiTBqIS8HyNAbE+ZA+WF7PqqBkU99jllEmsmHIxK0nOUPDhXXZEsUGb4/MHdnhd6xUI6RFM5qY2w3SYPlxmuoBWL+VEjbQhJPpasJSr6EZQwCfommNQPjFkgQa+zsD3rKkvLPzxuoeC/txwwHNImx0GqbSDp6WbseyiFNTfDi5VD8NsMwzJpqIT4NtGheQfXvjAqjZOAew6gptlJzb5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749785425; c=relaxed/relaxed;
	bh=65WmPHyfjPpYD7f4l43ocWMBa8yXZsusQWVewwpUjII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr5BETXqx+CU4ghLVjiGghYbZFQxLK7FaU9aEvSh1lcdiKrb1Loc2OoZVnktveqfNtvcuEXzK+5RMi5RoEeZkZzXhzb7kByzHs6IWtH6C3NFH3rzwEh8MOXzwfjxiq/kkBfUqeYbBYk9a5YsGkbNGxYbveN3nsWdtuocaeF4FNV6loeDS/dHXhQqhFQJOEADNLGKobr7lSu8R6N3HInz2r/V5ECDj7cmgVzwNU6YvILwHC2qfs56FUoqYxnz3a0b2bndAcWxR5UWJcsuwhJPo6bUqRQNqVhfmn/DIMx57Zi0/Kls92hL9zp+awgY4eue6IvUtFSgvy67HZidjHCT+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJPzj1qTKz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 13:30:25 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:02 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:02 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <elbadrym@google.com>, <romlem@google.com>, <anhphan@google.com>,
	<wak@google.com>, <yuxiaozhang@google.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 5/7] ARM: dts: aspeed-g6: Add PCIe RC node
Date: Fri, 13 Jun 2025 11:29:59 +0800
Message-ID: <20250613033001.3153637-6-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
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

The AST2600 has one PCIe RC, and add the relative configure regmap.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..d46a151e3c99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -379,6 +379,59 @@ rng: hwrng@1e6e2524 {
 				quality = <100>;
 			};
 
+			pcie_phy1: pcie-phy@1e6ed200 {
+				compatible = "aspeed,ast2600-pcie-phy", "syscon";
+				reg = <0x1e6ed200 0x100>;
+			};
+
+			pcie_cfg: pcie-cfg@1e770000 {
+				compatible = "aspeed,ast2600-pcie-cfg", "syscon";
+				reg = <0x1e770000 0x80>;
+			};
+
+			pcie0: pcie@1e7700c0 {
+				compatible = "aspeed,ast2600-pcie";
+				device_type = "pci";
+				reg = <0x1e7700c0 0x40>;
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+				bus-range = <0x80 0xff>;
+
+				ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
+					  0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
+
+				status = "disabled";
+
+				resets = <&syscon ASPEED_RESET_H2X>,
+					 <&syscon ASPEED_RESET_PCIE_RC_O>;
+				reset-names = "h2x", "perst";
+				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pcierc1_default>;
+
+				#interrupt-cells = <1>;
+				msi-parent = <&pcie0>;
+				msi-controller;
+				msi_address = <0x1e77005c>;
+
+				aspeed,ahbc = <&ahbc>;
+				aspeed,pciecfg = <&pcie_cfg>;
+				aspeed,pciephy = <&pcie_phy1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+						<0 0 0 2 &pcie_intc0 1>,
+						<0 0 0 3 &pcie_intc0 2>,
+						<0 0 0 4 &pcie_intc0 3>;
+				pcie_intc0: interrupt-controller {
+					interrupt-controller;
+					#address-cells = <0>;
+					#interrupt-cells = <1>;
+				};
+			};
+
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-- 
2.43.0


