Return-Path: <linux-aspeed+bounces-3789-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CDC10AB83C
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Mar 2026 01:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkM85X3mz2xmX;
	Fri, 27 Mar 2026 12:58:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774576708;
	cv=none; b=oNURr542duLWOWhpKagoIeKgXp+zzVCU3HBltU6WxHHMdB9gTSzWmJcdq32dlsMUs+0OdWmpNYqRUmN59YIhoyrHfrEz8JOmTzhf3k72TJJ55ro3eIMCh5svgM0rly8xaLNR1DrX/kp2TJYlBnHzdGhXS1lM0BvtPQuyon1ki0uxY0c0h5GAq8qtg7pUBAiprkHZHmlWDlRgIIy+QySeopHz3jkTw9gKw+Evw3s7Eb99uqHWz59Z1sx2OkaggFK+SLsr9LEl8yM0Rn1o+XakgTJ6s6j7KsjGe4UNfIqmz6/QXWqGL1nYZfAhhSA0Qj7sIoNbEO1oGkghRWphNdQEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774576708; c=relaxed/relaxed;
	bh=QyLoJUmAgNCnAFnoeNpvktSfvyFwusmaX6JdA7PKVoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lYmJcvEXZzGBhcruWMNIIT4kWlwWBGwxgLQmDhZe8Ro0wy8QlS8ed9bvS6qQg01oX8gSK5vSXNVNFWQALiVwI4m7h/uy6v4xdB6m8Bg9EbVKU4z7bFQacMMzUxavybIaptHxzBiLrs1XTE3rJv4RQOgUjFutYnha6jOCathLwDPJgVJQi8N/Goi5BTy6edoLtb8nRG9i94PdshoNVzpoaLdnIkECNgriFa1uztMfpupPipmRCzNEfq9vR9n9Wc7XNewyECzPUalbVnevc8My3IMcO+iIAI2ITNWntr4kLpCqTu9Z5p3Cas8uvbP1UWaoio/TasCDQu43xmrbhlmvVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkM749pQz2xR4
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Mar 2026 12:58:26 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 27 Mar
 2026 09:58:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 27 Mar 2026 09:58:11 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 27 Mar 2026 09:58:05 +0800
Subject: [PATCH] ARM: dts: aspeed: g6: Add missing uart nodes
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
Message-ID: <20260327-upstream_g6_dts_uart-v1-1-26e72b47bc97@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIACzkxWkC/x3MSwqAMAwA0atI1ha0RSteRaRUjZqFH5JWBPHuF
 pdvMfOAIBMKtNkDjBcJHXtCmWcwrn5fUNGUDLrQdWG0VfGUwOg3t9RuCuKi56Bs46sRzaAbayC
 lJ+NM97/t+vf9AKJ8+8RmAAAA
X-Change-ID: 20260327-upstream_g6_dts_uart-78a5ce3b2873
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jammy Huang
	<jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774576691; l=2359;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=zjsrYiyS5R3u3HNSn/zBZPIrCD0+6PLtVmbqWN2NWeQ=;
 b=7sG1WokGh6V3U460lJfPkX2JUl/SXsBpfuofApq8t65i0n+ASmk6qw5GnKxScpETF95CXWtN5
 R2AMlKXJAuiC7O7Am6yHahgpW3cCRyPCJYmMhrObBVCZ463dA3ngdvt
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=

Add nodes for uart10/11/12/13.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47..0ffe386fa9d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -835,6 +835,62 @@ uart9: serial@1e790300 {
 				status = "disabled";
 			};
 
+			uart10: serial@1e790400 {
+				compatible = "ns16550a";
+				reg = <0x1e790400 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART10CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart10_default>;
+
+				status = "disabled";
+			};
+
+			uart11: serial@1e790500 {
+				compatible = "ns16550a";
+				reg = <0x1e790500 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART11CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart11_default>;
+
+				status = "disabled";
+			};
+
+			uart12: serial@1e790600 {
+				compatible = "ns16550a";
+				reg = <0x1e790600 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART12CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart12g1_default>;
+
+				status = "disabled";
+			};
+
+			uart13: serial@1e790700 {
+				compatible = "ns16550a";
+				reg = <0x1e790700 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART13CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart13g1_default>;
+
+				status = "disabled";
+			};
+
 			i2c: bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;

---
base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
change-id: 20260327-upstream_g6_dts_uart-78a5ce3b2873

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>


