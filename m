Return-Path: <linux-aspeed+bounces-1400-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD070C71143
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 10:09:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHyv82wtlz2xlL;
	Thu, 12 Jun 2025 20:09:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749722996;
	cv=none; b=T427GsCmp1nH4GNc3r0By0Qr4ZfysoWPmN4DBj+Rhf8IOl9ZPXWwaT3PweF6fCo7/MuDxLur0IHkjWCMdKx3eE84yZ8H9cXi1U9q843r8AcMtt0FxPlljwJpThBbjTbIjOPL7npyvWv9pvk2wjH3GvDNjEeSF3W2rqH3io8mDg1fTdlrV/OcOo260j9dEb5c8XLcT6TU/eMEZ6ygdXAVL9eF8sRrtAKvcKi9WUzeEi0qZsyMoDyRThC2oS4YdJPnEzGNIFJEx+puV1SKGhFMLy0jvw4BCbBujxfXziUHQVYBn/sOgOikqq3YwYSTmRQkKP3WbhFsWYvJKyUsJwWfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749722996; c=relaxed/relaxed;
	bh=oGdZgxrn0tMGbWaO4ypRnn0aOZ4kIPbtRk8VYoe9no4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh0abdAySHP8evtvy4lP9R9zlg7OyokkgrLmv8iWvClnOgRumpS+scULVJQ15vKU19bewaXDFLURAo40NhFvQbgxScpz0z+TRIIjqO0VFF3ttYkspJvhvohIWYwpYNqMhJ1SMYKo4W6eNFLGZZqf08ObVlxKZ05lN/T5grBtCa7Xbteo+7G0KQA1vygxFoq+km60UoHZtDKNscfkgmCUb3bOG7YeH0yWTVHZbBwj9g6NOsyP8lJPFkruuLEZbJrltWVKZWF50MjPQepPELNjAouHbNShQEd8WcF50zhFHOWo8Dp34k3Uq1onrypLqTc0aSyGQoOeYVLwBtJg0SwDPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHyv74QBjz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 20:09:55 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 12 Jun
 2025 18:09:33 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 12 Jun 2025 18:09:33 +0800
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
Subject: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Date: Thu, 12 Jun 2025 18:09:31 +0800
Message-ID: <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
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

This add the initial device tree support for the ASPEED AST2700 SoC.

- Add top-level compatible string "aspeed,ast2700" and set up
address-cells/size-cells for 64-bit address space.
- Describe a quad-core ARM Cortex-A35 CPU cluster with L2 cache,
including cache properties and PSCI enable-method.
- Add PMU and ARMv8 timer nodes with correct PPI interrupt wiring.
- Model the dual-SoC architecture with two simple-bus nodes:
soc0 (@0x10000000) and soc1 (@0x14000000).
- Add syscon nodes for both SoCs (syscon0, syscon1) with clock/reset
cell definitions and address mapping.
- Add GICv3 interrupt controller node under soc0, with full register
mapping and interrupt properties.
- Hierarchical interrupt controller structure:
  - intc0 under soc0, with child intc0_11 node.
  - intc1 under soc1, with child intc1_0~intc1_5 nodes.
- Add serial4 node under soc0, others serial node under soc1.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 380 ++++++++++++++++++++++
 1 file changed, 380 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..d197187bcf9f
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
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
+			enable-method = "psci";
+			reg = <0x0 0x1>;
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
+			enable-method = "psci";
+			reg = <0x0 0x2>;
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
+			enable-method = "psci";
+			reg = <0x0 0x3>;
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
+	soc0: soc@10000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x10000000 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x1000>;
+			ranges = <0x0 0x0 0 0x12c02000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		gic: interrupt-controller@12200000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x12200000 0x10000>, /* GICD */
+			      <0 0x12280000 0x80000>, /* GICR */
+			      <0 0x40440000 0x1000>;  /* GICC */
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-parent = <&gic>;
+		};
+
+		serial4: serial@12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x1000>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x14000000 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x1000>;
+			ranges = <0x0 0x0 0x0 0x14c02000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		serial12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33b00 0x100>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+			interrupts-extended =
+				<&intc1_4 18 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};
+
+&soc0 {
+	intc0: interrupt-controller@12100000 {
+		compatible = "simple-mfd";
+		reg = <0 0x12100000 0x4000>;
+		ranges = <0x0 0x0 0x0 0x12100000 0x4000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		intc0_11: interrupt-controller@1b00 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x1b00 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+				     <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+				     <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+				     <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+				     <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+				     <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+};
+
+&soc1 {
+	intc1: interrupt-controller@14c18000 {
+		compatible = "simple-mfd";
+		reg = <0 0x14c18000 0x400>;
+		ranges = <0x0 0x0 0x0 0x14c18000 0x400>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		intc1_0: interrupt-controller@100 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x100 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		intc1_1: interrupt-controller@110 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x110 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		intc1_2: interrupt-controller@120 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x120 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		intc1_3: interrupt-controller@130 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x130 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		intc1_4: interrupt-controller@140 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x140 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		intc1_5: interrupt-controller@150 {
+			compatible = "aspeed,ast2700-intc-ic";
+			reg = <0x0 0x150 0x10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended =
+				<&intc0_11 5 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	serial0: serial@14c33000 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33000 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART0CLK>;
+		interrupts-extended = <&intc1_4 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial1: serial@14c33100 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33100 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART1CLK>;
+		interrupts-extended = <&intc1_4 8 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial2: serial@14c33200 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33200 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART2CLK>;
+		interrupts-extended = <&intc1_4 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial3: serial@14c33300 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33300 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART3CLK>;
+		interrupts-extended = <&intc1_4 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial5: serial@14c33400 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33400 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART5CLK>;
+		interrupts-extended = <&intc1_4 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial6: serial@14c33500 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33500 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART6CLK>;
+		interrupts-extended = <&intc1_4 12 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial7: serial@14c33600 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33600 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART7CLK>;
+		interrupts-extended = <&intc1_4 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial8: serial@14c33700 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33700 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART8CLK>;
+		interrupts-extended = <&intc1_4 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial9: serial@14c33800 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33800 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART9CLK>;
+		interrupts-extended = <&intc1_4 15 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial10: serial@14c33900 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33900 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART10CLK>;
+		interrupts-extended = <&intc1_4 16 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial11: serial@14c33a00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33a00 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART11CLK>;
+		interrupts-extended = <&intc1_4 17 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial12: serial@14c33b00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33b00 0x100>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+		interrupts-extended = <&intc1_4 18 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		pinctrl-names = "default";
+	};
+
+	serial13: serial@14c33c00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33c00 0x100>;
+		clocks = <&syscon1 SCU1_CLK_UART13>;
+		interrupts-extended = <&intc1_0 23 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	serial14: serial@14c33d00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33d00 0x100>;
+		clocks = <&syscon1 SCU1_CLK_UART14>;
+		interrupts-extended = <&intc1_1 23 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+};
+
-- 
2.34.1


