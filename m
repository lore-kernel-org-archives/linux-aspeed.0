Return-Path: <linux-aspeed+bounces-2020-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B36DCA0FE0
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 08:02:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6wls563Gz30gC;
	Thu, 21 Aug 2025 18:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755763353;
	cv=none; b=JhR8ZLUkb84a+4tLesBYZtN7csMjnBzNVFP+yC3PukAjJ/cQprD2Tta4erMcKiCIPmUquwsAWG9eB/5Lt4HYrVXk92HpdSsQIaGZ3dDxjHyRRivzkvuUoQQj7o+pQR0QOWLhgBlSR05steRzD1t0AzlpWvGYPIpLVS3z7GCmQFGOj+yiAL005C7L0mYXxHYjqgiGUDbshP2uVHhV/cikzYkdGA0ev5pjLIo2HEYIK/H9/Glfm4AIzrca3EFK0PXBCxzS5KnKWIfijAuZAtomLX+VUTAr1OXKkJ5Uae2pgil/Z3/lqWKbaC1Z0GzFDNZwj9LpGESbrOzBFWr6s8CE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755763353; c=relaxed/relaxed;
	bh=XSGFFLiDYIg7P5gCvpJu+x4HYD0MOpR3hko0i64En2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvAHxyFMME7inQSSiihEokPhQC1zZyWk1g9xc3+8xaVmSuEk9HX7Q+uKOrnhJrppJVIKCJbbF0GjQ7vYYzUcEY9vEG5LhYf/vaznvcwN7NtPWeqFZZW5B2tSulaAB+77fiwFfFd3hqihM4qbyD/XCfaQxivWib/jc4bsA+QsjTbYQCnX1k+B26MQXjIL8lqnIVH5uMSq3G7Dlx5Sc9HbWgDRh4KOCjgX7dlaO822F/bU2CBC0ueWoSFoCXE7rcJSL0TZAwKxy+x4a5DMJn+TECiME3WZ3nr6g00T0XQ6a8kT5h2AvDlncaE0Fgskb73JKbfbfrmwYnOxZ9fPrUASSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6wlr75Kxz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 18:02:32 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 Aug
 2025 16:02:15 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 21 Aug 2025 16:02:15 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, Mo Elbadry <elbadrym@google.com>, Rom Lemarchand
	<romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang
	<yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v4 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Date: Thu, 21 Aug 2025 16:02:12 +0800
Message-ID: <20250821080214.513090-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
References: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
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

Add initial device tree for the ASPEED 7th BMC SoC family.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 452 ++++++++++++++++++++++
 1 file changed, 452 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..4816b017f987
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+		};
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x0 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee-core@430080000 {
+			reg = <0x4 0x30080000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+	};
+
+	gic: interrupt-controller@12200000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x12200000 0 0x10000>, /* GICD */
+		      <0 0x12280000 0 0x80000>, /* GICR */
+		      <0 0x40440000 0 0x1000>;  /* GICC */
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+	};
+
+	soc0: soc@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		intc0_11: interrupt-controller@12101b00 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x12101b00 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			silicon-id@0 {
+				compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+				reg = <0 0x0 0 0x4>;
+			};
+
+		};
+
+		gpio0: gpio@12c11000 {
+			#gpio-cells = <2>;
+			gpio-controller;
+			compatible = "aspeed,ast2700-gpio";
+			reg = <0x0 0x12c11000 0x0 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			ngpios = <12>;
+			clocks = <&syscon0 SCU0_CLK_APB>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uart4: serial@12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x0 0x1000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			no-loopback-test;
+			status = "disabled";
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mdio0: mdio@14040000 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040000 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		mdio1: mdio@14040008 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040008 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		mdio2: mdio@14040010 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040010 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1";
+			reg = <0x0 0x14c02000 0x0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc1_0: interrupt-controller@14c18100 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18100 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 0>;
+		};
+
+		intc1_1: interrupt-controller@14c18110 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18110 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 1>;
+		};
+
+		intc1_2: interrupt-controller@14c18120 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18120 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 2>;
+		};
+
+		intc1_3: interrupt-controller@14c18130 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18130 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 3>;
+		};
+
+		intc1_4: interrupt-controller@14c18140 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18140 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 4>;
+		};
+
+		intc1_5: interrupt-controller@14c18150 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x14c18150 0x0 0x10>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&intc0_11 5>;
+		};
+
+		uart0: serial@14c33000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33000 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART0CLK>;
+			interrupts-extended = <&intc1_4 7>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart1: serial@14c33100 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33100 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART1CLK>;
+			interrupts-extended = <&intc1_4 8>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart2: serial@14c33200 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33200 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART2CLK>;
+			interrupts-extended = <&intc1_4 9>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart3: serial@14c33300 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33300 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART3CLK>;
+			interrupts-extended = <&intc1_4 10>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart5: serial@14c33400 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33400 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART5CLK>;
+			interrupts-extended = <&intc1_4 11>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart6: serial@14c33500 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33500 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART6CLK>;
+			interrupts-extended = <&intc1_4 12>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart7: serial@14c33600 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33600 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART7CLK>;
+			interrupts-extended = <&intc1_4 13>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart8: serial@14c33700 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33700 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART8CLK>;
+			interrupts-extended = <&intc1_4 14>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart9: serial@14c33800 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33800 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART9CLK>;
+			interrupts-extended = <&intc1_4 15>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart10: serial@14c33900 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33900 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART10CLK>;
+			interrupts-extended = <&intc1_4 16>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart11: serial@14c33a00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33a00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART11CLK>;
+			interrupts-extended = <&intc1_4 17>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33b00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+			interrupts-extended = <&intc1_4 18>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart13: serial@14c33c00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33c00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART13>;
+			interrupts-extended = <&intc1_0 23>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart14: serial@14c33d00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33d00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART14>;
+			interrupts-extended = <&intc1_1 23>;
+			no-loopback-test;
+			status = "disabled";
+		};
+	};
+};
-- 
2.34.1


