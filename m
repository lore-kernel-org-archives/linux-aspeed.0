Return-Path: <linux-aspeed+bounces-4204-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54307CD6E79
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 02:47:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZCxr5yLtz2yY0;
	Tue, 09 Jun 2026 12:47:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780973264;
	cv=none; b=fWgJKMffBjnvyx2Q67PcEZC1RvPI6o8SX9jXAgMUQ2GwFL+9XzjcUU/KcRFOD6RQTtfuGFZNoh64pe40AN72OytsTuCNckO5FeiTri1l7i35S/amgVq2/c7ss5Ey75iJmpJzrPXV9YqVccjr1EltKay028yUWgTEhHRqs0690cIU9FAzQp2oDcxdk/A7U0RXTWhVJVukOTgZyRIcc0IMKnOLXXhEbctHt441djfW1C/ELCPzyJ9SF/7FO5o4XDCkPmZL1Ijiy5KJlqn7ZTmHmzr81GEcyXtOfIKwJuuJOwXQqCnNQ+YvaPd+oCx2n1rRG97yK6Qq7e4aTs/FTGfGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780973264; c=relaxed/relaxed;
	bh=w2tWMXUEjPriEom9qLj7Dt4BtrtBcr1ocLwrZTAzWw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J8gij0wWykccJOHpwUipZjjeO2Y43qIGAM40sGaXSlgK2W7AvuIqOV7cAoaOxJBW+aDeqqIYwDck+nN2M1GSsD8RrkkvZvbIrrYq+CD3mgKvZxQU5A0e1blaLPngBgcZ3vcBK35XV1PYBLbPJa+1wHDBLrykg+3gckqulbsQls3LetdPcnIPnAYvqEpKK5mgPzjgcRSwq8209Q1HdqlEehEcg0yO9XZgF2uY82HcjjV7xoEpxgwFWp/AA9qTThEmQtsShsRnVo8C/qHQHh4re34qh34S9L+jvDSpm7E9Yixhvjn8ug5xOKyegIRbOKwT1EJLsL67y2vRXHrKTexdPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZCxp1VYgz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 12:47:42 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 9 Jun
 2026 10:47:20 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 9 Jun 2026 10:47:20 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 9 Jun 2026 10:47:20 +0800
Subject: [PATCH v9 3/4] arm64: dts: aspeed: Add initial AST27xx SoC device
 tree
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
Message-ID: <20260609-upstream_ast2700-v9-3-f631752f0cb1@aspeedtech.com>
References: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
In-Reply-To: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, "Drew
 Fustini" <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, <linux-riscv@lists.infradead.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780973240; l=62989;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=0lpZWBhZFOVw9ozNpDairZZfyge4pgYl5QmDUeWcKQI=;
 b=8ct2HSF5ZqHpaBbpIAek3f+AeDI/ROXUqUMA5RlYgrpVs/33B6u3rK6AoPt1exw1wYonBt8PK
 Q0sVBvty9AdB4kqPP9/EsLulB4fUG7zHIw+Ll7E6ZcRdXuPriIA4SHx
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add initial device tree support for the ASPEED AST27xx family, the
8th-generation Baseboard Management Controller (BMC) SoCs.

AST27xx SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

The AST27xx features a dual-SoC architecture consisting of two dies,
referred to as SoC0 and SoC1 - interconnected through an internal
proprietary bus. Both SoCs share the same address decoding scheme,
while each maintains independent clock and reset domains.

- SoC0 (CPU die): contains a quad-core Cortex-A35 cluster and two
  Cortex-M4 cores, along with high-speed peripherals.
- SoC1 (I/O die): includes the BootMCU (responsible for system
  boot) and its own clock/reset domains low-speed peripherals.

The device tree describes the SoC0 and SoC1 domains and their peripheral
layouts.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS                                        |    1 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/aspeed/Makefile                |    4 +
 .../dts/aspeed/aspeed-evb-flash-layout-128.dtsi    |   32 +
 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi      |  196 ++++
 .../boot/dts/aspeed/aspeed-g7-soc0-pinctrl.dtsi    |  225 ++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc0.dtsi     |  230 ++++
 .../boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi    | 1113 ++++++++++++++++++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  557 ++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts         |   65 ++
 10 files changed, 2424 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bd55913b2d..51d12804ad5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2683,6 +2683,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
+F:	arch/arm64/boot/dts/aspeed/
 N:	aspeed
 
 ARM/AXIADO ARCHITECTURE
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 98ec8f1b76e4..fc726b215f12 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y += amlogic
 subdir-y += apm
 subdir-y += apple
 subdir-y += arm
+subdir-y += aspeed
 subdir-y += axiado
 subdir-y += bitmain
 subdir-y += blaize
diff --git a/arch/arm64/boot/dts/aspeed/Makefile b/arch/arm64/boot/dts/aspeed/Makefile
new file mode 100644
index 000000000000..ffe7e15017cc
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	ast2700-evb.dtb
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi
new file mode 100644
index 000000000000..b54915f06efd
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot@0 {
+		reg = <0x0 0x400000>; // 4MB
+		label = "u-boot";
+	};
+
+	u-boot-env@400000 {
+		reg = <0x400000 0x20000>; // 128KB
+		label = "u-boot-env";
+	};
+
+	kernel@420000 {
+		reg = <0x420000 0x900000>; // 9MB
+		label = "kernel";
+	};
+
+	rofs@d20000 {
+		reg = <0xd20000 0x52E0000>; // 82.875MB
+		label = "rofs";
+	};
+
+	rwfs@6000000 {
+		reg = <0x6000000 0x2000000>; // 32MB
+		label = "rwfs";
+	};
+};
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
new file mode 100644
index 000000000000..ef283d95649a
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for AST27xx SoC Family
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+	secondary {
+		#address-cells = <2>;
+		/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/address.c?h=v6.16#n491 */
+		#size-cells = <0>;
+		/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/address.c?h=v6.16#n430 */
+
+		ssp_nvic: interrupt-controller@1,e000e100 {
+			compatible = "arm,v7m-nvic";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <1 0xe000e100>;
+			arm,num-irq-priority-bits = <3>;
+			status = "disabled";
+		};
+	};
+
+	tertiary {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		tsp_nvic: interrupt-controller@2,e000e100 {
+			compatible = "arm,v7m-nvic";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <2 0xe000e100>;
+			arm,num-irq-priority-bits = <3>;
+			status = "disabled";
+		};
+	};
+
+	bootmcu {
+		bootmcu_hlic: interrupt-controller {
+			compatible = "riscv,cpu-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci {
+			compatible = "arm,psci-1.0";
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
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+	};
+
+	gic: interrupt-controller@12200000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x12200000 0 0x10000>, /* GICD */
+		      <0 0x12280000 0 0x80000>, /* GICR */
+		      <0 0x40440000 0 0x1000>;  /* GICC */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+	};
+
+	soc0: bus@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x10000000 0x0 0x10000000 0x0 0x4000000>;
+	};
+
+	soc1: bus@14000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x14000000 0x0 0x14000000 0x2 0xec000000>;
+	};
+};
+
+#include "aspeed-g7-soc0.dtsi"
+#include "aspeed-g7-soc1.dtsi"
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0-pinctrl.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0-pinctrl.dtsi
new file mode 100644
index 000000000000..ed58ee41973b
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0-pinctrl.dtsi
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+// Copyright 2025 ASPEED Corp.
+
+&pinctrl0 {
+	pinctrl_emmc_default: emmc-default-state {
+		function = "EMMC";
+		groups = "EMMCG1";
+	};
+	pinctrl_emmcg4_default: emmcg4-default-state {
+		function = "EMMC";
+		groups = "EMMCG4";
+	};
+	pinctrl_emmcg8_default: emmcg8-default-state {
+		function = "EMMC";
+		groups = "EMMCG8";
+	};
+	pinctrl_emmcwpn_default: emmcwpn-default-state {
+		function = "EMMC";
+		groups = "EMMCWPN";
+	};
+	pinctrl_emmccdn_default: emmccdn-default-state {
+		function = "EMMC";
+		groups = "EMMCCDN";
+	};
+	pinctrl_vb1_default: vb1-default-state {
+		function = "VB";
+		groups = "VB1";
+	};
+	pinctrl_vb0_default: vb0-default-state {
+		function = "VB";
+		groups = "VB0";
+	};
+	pinctrl_tsprstn_default: tsprstn-default-state {
+		function = "TSPRSTN";
+		groups = "TSPRSTN";
+	};
+	pinctrl_ufsclki_default: ufsclki-default-state {
+		function = "UFSCLKI";
+		groups = "UFSCLKI";
+	};
+	pinctrl_vgaddc_default: vgaddc-default-state {
+		function = "VGADDC";
+		groups = "VGADDC";
+	};
+	pinctrl_usb3axhd_default: usb3axhd-default-state {
+		function = "USB3AXHD";
+		groups = "USB3A";
+	};
+	pinctrl_usb3axhpd_default: usb3axhpd-default-state {
+		function = "USB3AXHPD";
+		groups = "USB3A";
+	};
+	pinctrl_usb3axh_default: usb3axh-default-state {
+		function = "USB3AXH";
+		groups = "USB3AAP";
+	};
+	pinctrl_usb3axhp_default: usb3axhp-default-state {
+		function = "USB3AXHP";
+		groups = "USB3AAP";
+	};
+	pinctrl_usb3axh2b_default: usb3axh2b-default-state {
+		function = "USB3AXH2B";
+		groups = "USB3ABP";
+	};
+	pinctrl_usb3axhp2b_default: usb3axhp2b-default-state {
+		function = "USB3AXHP2B";
+		groups = "USB3ABP";
+	};
+	pinctrl_usb2axhd1_default: usb2axhd1-default-state {
+		function = "USB2AXHD1";
+		groups = "USB2A";
+	};
+	pinctrl_usb2axhpd1_default: usb2axhpd1-default-state {
+		function = "USB2AXHPD1";
+		groups = "USB2A";
+	};
+	pinctrl_usb2ad1_default: usb2ad1-default-state {
+		function = "USB2AD1";
+		groups = "USB2ADAP";
+	};
+	pinctrl_usb2axh_default: usb2axh-default-state {
+		function = "USB2AXH";
+		groups = "USB2AAP";
+	};
+	pinctrl_usb2axhp_default: usb2axhp-default-state {
+		function = "USB2AXHP";
+		groups = "USB2AAP";
+	};
+	pinctrl_usb2axh2b_default: usb2axh2b-default-state {
+		function = "USB2AXH2B";
+		groups = "USB2ABP";
+	};
+	pinctrl_usb2axhp2b_default: usb2axhp2b-default-state {
+		function = "USB2AXHP2B";
+		groups = "USB2ABP";
+	};
+	pinctrl_usb2ahpd0_default: usb2ahpd0-default-state {
+		function = "USB2AHPD0";
+		groups = "USB2AH";
+	};
+	pinctrl_usb2ad0_default: usb2ad0-default-state {
+		function = "USB2AD0";
+		groups = "USB2AHAP";
+	};
+	pinctrl_usb2ah_default: usb2ah-default-state {
+		function = "USB2AH";
+		groups = "USB2AHAP";
+	};
+	pinctrl_usb2ahp_default: usb2ahp-default-state {
+		function = "USB2AHP";
+		groups = "USB2AHAP";
+	};
+	pinctrl_usb3bxhd_default: usb3bxhd-default-state {
+		function = "USB3BXHD";
+		groups = "USB3B";
+	};
+	pinctrl_usb3bxhpd_default: usb3bxhpd-default-state {
+		function = "USB3BXHPD";
+		groups = "USB3B";
+	};
+	pinctrl_usb3bxh_default: usb3bxh-default-state {
+		function = "USB3BXH";
+		groups = "USB3BBP";
+	};
+	pinctrl_usb3bxhp_default: usb3bxhp-default-state {
+		function = "USB3BXHP";
+		groups = "USB3BBP";
+	};
+	pinctrl_usb3bxh2a_default: usb3bxh2a-default-state {
+		function = "USB3BXH2A";
+		groups = "USB3BAP";
+	};
+	pinctrl_usb3bxhp2a_default: usb3bxhp2a-default-state {
+		function = "USB3BXHP2A";
+		groups = "USB3BAP";
+	};
+	pinctrl_usb2bxhd1_default: usb2bxhd1-default-state {
+		function = "USB2BXHD1";
+		groups = "USB2B";
+	};
+	pinctrl_usb2bxhpd1_default: usb2bxhpd1-default-state {
+		function = "USB2BXHPD1";
+		groups = "USB2B";
+	};
+	pinctrl_usb2bd1_default: usb2bd1-default-state {
+		function = "USB2BD1";
+		groups = "USB2BDBP";
+	};
+	pinctrl_usb2bxh_default: usb2bxh-default-state {
+		function = "USB2BXH";
+		groups = "USB2BBP";
+	};
+	pinctrl_usb2bxhp_default: usb2bxhp-default-state {
+		function = "USB2BXHP";
+		groups = "USB2BBP";
+	};
+	pinctrl_usb2bxh2a_default: usb2bxh2a-default-state {
+		function = "USB2BXH2A";
+		groups = "USB2BAP";
+	};
+	pinctrl_usb2bxhp2a_default: usb2bxhp2a-default-state {
+		function = "USB2BXHP2A";
+		groups = "USB2BAP";
+	};
+	pinctrl_usb2bhpd0_default: usb2bhpd0-default-state {
+		function = "USB2BHPD0";
+		groups = "USB2BH";
+	};
+	pinctrl_usb2bd0_default: usb2bd0-default-state {
+		function = "USB2BD0";
+		groups = "USB2BHBP";
+	};
+	pinctrl_usb2bh_default: usb2bh-default-state {
+		function = "USB2BH";
+		groups = "USB2BHBP";
+	};
+	pinctrl_usb2bhp_default: usb2bhp-default-state {
+		function = "USB2BHP";
+		groups = "USB2BHBP";
+	};
+	pinctrl_jtagm0_default: jtagm0-default-state {
+		function = "JTAGM0";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_psp_default: jtag-psp-default-state {
+		function = "JTAGPSP";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_ssp_default: jtag-ssp-default-state {
+		function = "JTAGSSP";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_tsp_default: jtag-tsp-default-state {
+		function = "JTAGTSP";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_ddr_default: jtag-ddr-default-state {
+		function = "JTAGDDR";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_usb3a_default: jtag-usb3a-default-state {
+		function = "JTAGUSB3A";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_usb3b_default: jtag-usb3b-default-state {
+		function = "JTAGUSB3B";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_pciea_default: jtag-pciea-default-state {
+		function = "JTAGPCIEA";
+		groups = "JTAG0";
+	};
+	pinctrl_jtag_pcieb_default: jtag-pcieb-default-state {
+		function = "JTAGPCIEB";
+		groups = "JTAG0";
+	};
+	pinctrl_pcierc0_perst_default: pcierc0-perst-default-state {
+		function = "PCIERC0PERST";
+		groups = "PCIERC0PERST";
+	};
+	pinctrl_pcierc1_perst_default: pcierc1-perst-default-state {
+		function = "PCIERC1PERST";
+		groups = "PCIERC1PERST";
+	};
+};
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0.dtsi
new file mode 100644
index 000000000000..db42db2592e0
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc0.dtsi
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for AST27xx SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+&soc0 {
+	sram0: sram@10000000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x10000000 0x0 0x20000>;
+		ranges = <0x0 0x0 0x10000000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		soc0-sram@0 {
+			reg = <0x0 0x20000>;
+			export;
+		};
+	};
+
+	vhuba1: usb-vhub@12011000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x12011000 0x0 0x820>;
+		interrupts-extended = <&intc0 32>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTA_VHUB>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2axhpd1_default>;
+		status = "disabled";
+	};
+
+	vhubb1: usb-vhub@12021000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x12021000 0x0 0x820>;
+		interrupts-extended = <&intc0 36>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTBUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTB_VHUB>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2bxhpd1_default>;
+		status = "disabled";
+	};
+
+	uhci0: usb@12040000 {
+		compatible = "aspeed,ast2700-uhci", "generic-uhci";
+		reg = <0x0 0x12040000 0x0 0x100>;
+		interrupts-extended = <&intc0 10>;
+		#ports = <2>;
+		clocks = <&syscon0 SCU0_CLK_GATE_UHCICLK>;
+		resets = <&syscon0 SCU0_RESET_UHCI>;
+		status = "disabled";
+	};
+
+	vhuba0: usb-vhub@12060000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x12060000 0x0 0x820>;
+		interrupts-extended = <&intc0 33>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTA_VHUB_EHCI>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2ad0_default>;
+		status = "disabled";
+	};
+
+	ehci0: usb@12061000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x12061000 0x0 0x100>;
+		interrupts-extended = <&intc0 33>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTA_VHUB_EHCI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2ah_default>;
+		status = "disabled";
+	};
+
+	vhubb0: usb-vhub@12062000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x12062000 0x0 0x820>;
+		interrupts-extended = <&intc0 37>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTBUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTB_VHUB_EHCI>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2bd0_default>;
+		status = "disabled";
+	};
+
+	ehci1: usb@12063000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x12063000 0x0 0x100>;
+		interrupts-extended = <&intc0 37>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTBUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTB_VHUB_EHCI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2bh_default>;
+		status = "disabled";
+	};
+
+	emmc_controller: sdc@12090000 {
+		compatible = "aspeed,ast2700-sd-controller", "aspeed,ast2600-sd-controller";
+		reg = <0 0x12090000 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x12090000 0x10000>;
+		clocks = <&syscon0 SCU0_CLK_GATE_EMMCCLK>;
+		resets = <&syscon0 SCU0_RESET_EMMC>;
+		status = "disabled";
+
+		emmc: sdhci@100 {
+			compatible = "aspeed,ast2700-sdhci", "aspeed,ast2600-sdhci";
+			reg = <0x100 0x100>;
+			sdhci,auto-cmd12;
+			interrupts-extended = <&intc0 15>;
+			clocks = <&syscon0 SCU0_CLK_GATE_EMMCCLK>;
+			status = "disabled";
+		};
+	};
+
+	intc0: interrupt-controller@12100000 {
+		compatible = "aspeed,ast2700-intc0";
+		reg = <0x0 0x12100000 0x0 0x3c00>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		aspeed,interrupt-ranges =
+			<0 128 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* linear range 1 to 1*/
+			<144 8 &gic GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* sw int SSP */
+			<152 8 &gic GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>, /* sw int TSP */
+			<192 10 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* M0-M9 intm */
+			<208 10 &gic GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, /* M30-M39 intm */
+			<224 10 &gic GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* M40-M49 intm */
+			<256 128 &ssp_nvic 0 0 >, /* linear to SSP */
+			<384 10 &ssp_nvic 160 0 >, /* cascaded to SSP via M10-M19 */
+			<400 8 &ssp_nvic 144 0 >, /* sw int PSP */
+			<408 8 &ssp_nvic 152 0 >, /* sw int TSP */
+			<426 128 &tsp_nvic 0 0 >, /* linear to TSP */
+			<554 10 &tsp_nvic 160 0 >, /* cascaded to TSP via M20-M29 */
+			<570 8 &tsp_nvic 144 0 >, /* sw int PSP */
+			<578 8 &tsp_nvic 152 0 >; /* sw int TSP */
+	};
+
+	syscon0: syscon@12c02000 {
+		compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+		reg = <0x0 0x12c02000 0x0 0x1000>;
+		ranges = <0x0 0x0 0x12c02000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		silicon-id@0 {
+			compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+			reg = <0x0 0x4>;
+		};
+
+		scu_ic0: interrupt-controller@1d0 {
+			compatible = "aspeed,ast2700-scu-ic0";
+			reg = <0x1d0 0xc>;
+			interrupts-extended = <&intc0 97>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
+		scu_ic1: interrupt-controller@1e0 {
+			compatible = "aspeed,ast2700-scu-ic1";
+			reg = <0x1e0 0xc>;
+			interrupts-extended = <&intc0 98>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
+		pinctrl0: pinctrl@400 {
+			compatible = "aspeed,ast2700-soc0-pinctrl";
+			reg = <0x400 0x318>;
+		};
+	};
+
+	gpio0: gpio@12c11000 {
+		#gpio-cells = <2>;
+		gpio-controller;
+		compatible = "aspeed,ast2700-gpio";
+		reg = <0x0 0x12c11000 0x0 0x1000>;
+		interrupts-extended = <&intc0 11>;
+		gpio-ranges = <&pinctrl0 0 0 12>;
+		ngpios = <12>;
+		clocks = <&syscon0 SCU0_CLK_APB>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	uart4: serial@12c1a000 {
+		compatible = "ns16550a";
+		reg = <0x0 0x12c1a000 0x0 0x1000>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+		interrupts-extended = <&intc0 8>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	mbox0: mbox@12c1c200 {
+		compatible = "aspeed,ast2700-mailbox";
+		reg = <0x0 0x12c1c200 0x0 0x100>, <0x0 0x12c1c300 0x0 0x100>;
+		reg-names = "tx", "rx";
+		interrupts-extended = <&intc0 103>;
+		#mbox-cells = <1>;
+	};
+
+	mbox1: mbox@12c1c600 {
+		compatible = "aspeed,ast2700-mailbox";
+		reg = <0x0 0x12c1c600 0x0 0x100>, <0x0 0x12c1c700 0x0 0x100>;
+		reg-names = "tx", "rx";
+		interrupts-extended = <&intc0 107>;
+		#mbox-cells = <1>;
+	};
+};
+
+#include "aspeed-g7-soc0-pinctrl.dtsi"
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi
new file mode 100644
index 000000000000..72d93323593d
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi
@@ -0,0 +1,1113 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+// Copyright 2025 ASPEED Corp.
+
+&pinctrl1 {
+	pinctrl_sgpm0_default: sgpm0-default-state {
+		function = "SGPM0";
+		groups = "SGPM0";
+	};
+
+	pinctrl_dsgpm0_default: dsgpm0-default-state {
+		function = "SGPM0";
+		groups = "DSGPM0";
+	};
+
+	pinctrl_sgpm1_default: sgpm1-default-state {
+		function = "SGPM1";
+		groups = "SGPM1";
+	};
+
+	pinctrl_sgps_default: sgps-default-state {
+		function = "SGPS";
+		groups = "SGPS";
+	};
+
+	pinctrl_adc0_default: adc0-default-state {
+		function = "ADC0";
+		groups = "ADC0";
+	};
+
+	pinctrl_adc1_default: adc1-default-state {
+		function = "ADC1";
+		groups = "ADC1";
+	};
+
+	pinctrl_adc2_default: adc2-default-state {
+		function = "ADC2";
+		groups = "ADC2";
+	};
+
+	pinctrl_adc3_default: adc3-default-state {
+		function = "ADC3";
+		groups = "ADC3";
+	};
+
+	pinctrl_adc4_default: adc4-default-state {
+		function = "ADC4";
+		groups = "ADC4";
+	};
+
+	pinctrl_adc5_default: adc5-default-state {
+		function = "ADC5";
+		groups = "ADC5";
+	};
+
+	pinctrl_adc6_default: adc6-default-state {
+		function = "ADC6";
+		groups = "ADC6";
+	};
+
+	pinctrl_adc7_default: adc7-default-state {
+		function = "ADC7";
+		groups = "ADC7";
+	};
+
+	pinctrl_adc8_default: adc8-default-state {
+		function = "ADC8";
+		groups = "ADC8";
+	};
+
+	pinctrl_adc9_default: adc9-default-state {
+		function = "ADC9";
+		groups = "ADC9";
+	};
+
+	pinctrl_adc10_default: adc10-default-state {
+		function = "ADC10";
+		groups = "ADC10";
+	};
+
+	pinctrl_adc11_default: adc11-default-state {
+		function = "ADC11";
+		groups = "ADC11";
+	};
+
+	pinctrl_adc12_default: adc12-default-state {
+		function = "ADC12";
+		groups = "ADC12";
+	};
+
+	pinctrl_adc13_default: adc13-default-state {
+		function = "ADC13";
+		groups = "ADC13";
+	};
+
+	pinctrl_adc14_default: adc14-default-state {
+		function = "ADC14";
+		groups = "ADC14";
+	};
+
+	pinctrl_adc15_default: adc15-default-state {
+		function = "ADC15";
+		groups = "ADC15";
+	};
+
+	pinctrl_pwm0_default: pwm0-default-state {
+		function = "PWM0";
+		groups = "PWM0";
+	};
+
+	pinctrl_pwm1_default: pwm1-default-state {
+		function = "PWM1";
+		groups = "PWM1";
+	};
+
+	pinctrl_pwm2_default: pwm2-default-state {
+		function = "PWM2";
+		groups = "PWM2";
+	};
+
+	pinctrl_pwm3_default: pwm3-default-state {
+		function = "PWM3";
+		groups = "PWM3";
+	};
+
+	pinctrl_pwm4_default: pwm4-default-state {
+		function = "PWM4";
+		groups = "PWM4";
+	};
+
+	pinctrl_pwm5_default: pwm5-default-state {
+		function = "PWM5";
+		groups = "PWM5";
+	};
+
+	pinctrl_pwm6_default: pwm6-default-state {
+		function = "PWM6";
+		groups = "PWM6";
+	};
+
+	pinctrl_pwm7_default: pwm7-default-state {
+		function = "PWM7";
+		groups = "PWM7";
+	};
+
+	pinctrl_pwm8_default: pwm8-default-state {
+		function = "PWM8";
+		groups = "PWM8";
+	};
+
+	pinctrl_pwm9_default: pwm9-default-state {
+		function = "PWM9";
+		groups = "PWM9";
+	};
+
+	pinctrl_pwm10_default: pwm10-default-state {
+		function = "PWM10";
+		groups = "PWM10";
+	};
+
+	pinctrl_pwm11_default: pwm11-default-state {
+		function = "PWM11";
+		groups = "PWM11";
+	};
+
+	pinctrl_pwm12_default: pwm12-default-state {
+		function = "PWM12";
+		groups = "PWM12";
+	};
+
+	pinctrl_pwm13_default: pwm13-default-state {
+		function = "PWM13";
+		groups = "PWM13";
+	};
+
+	pinctrl_pwm14_default: pwm14-default-state {
+		function = "PWM14";
+		groups = "PWM14";
+	};
+
+	pinctrl_pwm15_default: pwm15-default-state {
+		function = "PWM15";
+		groups = "PWM15";
+	};
+
+	pinctrl_tach0_default: tach0-default-state {
+		function = "TACH0";
+		groups = "TACH0";
+	};
+
+	pinctrl_tach1_default: tach1-default-state {
+		function = "TACH1";
+		groups = "TACH1";
+	};
+
+	pinctrl_tach2_default: tach2-default-state {
+		function = "TACH2";
+		groups = "TACH2";
+	};
+
+	pinctrl_tach3_default: tach3-default-state {
+		function = "TACH3";
+		groups = "TACH3";
+	};
+
+	pinctrl_tach4_default: tach4-default-state {
+		function = "TACH4";
+		groups = "TACH4";
+	};
+
+	pinctrl_tach5_default: tach5-default-state {
+		function = "TACH5";
+		groups = "TACH5";
+	};
+
+	pinctrl_tach6_default: tach6-default-state {
+		function = "TACH6";
+		groups = "TACH6";
+	};
+
+	pinctrl_tach7_default: tach7-default-state {
+		function = "TACH7";
+		groups = "TACH7";
+	};
+
+	pinctrl_tach8_default: tach8-default-state {
+		function = "TACH8";
+		groups = "TACH8";
+	};
+
+	pinctrl_tach9_default: tach9-default-state {
+		function = "TACH9";
+		groups = "TACH9";
+	};
+
+	pinctrl_tach10_default: tach10-default-state {
+		function = "TACH10";
+		groups = "TACH10";
+	};
+
+	pinctrl_tach11_default: tach11-default-state {
+		function = "TACH11";
+		groups = "TACH11";
+	};
+
+	pinctrl_tach12_default: tach12-default-state {
+		function = "TACH12";
+		groups = "TACH12";
+	};
+
+	pinctrl_tach13_default: tach13-default-state {
+		function = "TACH13";
+		groups = "TACH13";
+	};
+
+	pinctrl_tach14_default: tach14-default-state {
+		function = "TACH14";
+		groups = "TACH14";
+	};
+
+	pinctrl_tach15_default: tach15-default-state {
+		function = "TACH15";
+		groups = "TACH15";
+	};
+
+	pinctrl_jtagm1_default: jtagm1-default-state {
+		function = "JTAGM1";
+		groups = "JTAGM1";
+	};
+
+	pinctrl_mdio0_default: mdio0-default-state {
+		function = "MDIO0";
+		groups = "MDIO0";
+	};
+
+	pinctrl_mdio1_default: mdio1-default-state {
+		function = "MDIO1";
+		groups = "MDIO1";
+	};
+
+	pinctrl_mdio2_default: mdio2-default-state {
+		function = "MDIO2";
+		groups = "MDIO2";
+	};
+
+	pinctrl_rgmii0_default: rgmii0-default-state {
+		function = "RGMII0";
+		groups = "RGMII0";
+	};
+
+	pinctrl_rgmii1_default: rgmii1-default-state {
+		function = "RGMII1";
+		groups = "RGMII1";
+	};
+
+	pinctrl_rmii0_default: rmii0-default-state {
+		function = "RMII0";
+		groups = "RMII0";
+	};
+
+	pinctrl_rmii0_rclko_default: rmii0-rclko-default-state {
+		function = "RMII0RCLKO";
+		groups = "RMII0RCLKO";
+	};
+
+	pinctrl_rmii1_default: rmii1-default-state {
+		function = "RMII1";
+		groups = "RMII1";
+	};
+
+	pinctrl_rmii1_rclko_default: rmii1-rclko-default-state {
+		function = "RMII1RCLKO";
+		groups = "RMII1RCLKO";
+	};
+
+	pinctrl_sgmii_default: sgmii-default-state {
+		function = "SGMII";
+		groups = "SGMII";
+	};
+
+	pinctrl_fwspi_quad_default: fwspi-quad-default-state {
+		function = "FWQSPI";
+		groups = "FWQSPI";
+	};
+
+	pinctrl_fsi0_default: fsi0-default-state {
+		function = "FSI0";
+		groups = "FSI0";
+	};
+
+	pinctrl_fsi1_default: fsi1-default-state {
+		function = "FSI1";
+		groups = "FSI1";
+	};
+
+	pinctrl_fsi2_default: fsi2-default-state {
+		function = "FSI2";
+		groups = "FSI2";
+	};
+
+	pinctrl_fsi3_default: fsi3-default-state {
+		function = "FSI3";
+		groups = "FSI3";
+	};
+
+	pinctrl_spi0_default: spi0-default-state {
+		function = "SPI0";
+		groups = "SPI0";
+	};
+
+	pinctrl_spi0_quad_default: spi0-quad-default-state {
+		function = "QSPI0";
+		groups = "QSPI0";
+	};
+
+	pinctrl_spi0_cs1_default: spi0-cs1-default-state {
+		function = "SPI0CS1";
+		groups = "SPI0CS1";
+	};
+
+	pinctrl_spi1_default: spi1-default-state {
+		function = "SPI1";
+		groups = "SPI1";
+	};
+
+	pinctrl_spi1_quad_default: spi1-quad-default-state {
+		function = "QSPI1";
+		groups = "QSPI1";
+	};
+
+	pinctrl_spi1_cs1_default: spi1-cs1-default-state {
+		function = "SPI1CS1";
+		groups = "SPI1CS1";
+	};
+
+	pinctrl_spi2_default: spi2-default-state {
+		function = "SPI2";
+		groups = "SPI2";
+	};
+
+	pinctrl_spi2_quad_default: spi2-quad-default-state {
+		function = "QSPI2";
+		groups = "QSPI2";
+	};
+
+	pinctrl_spi2_cs1_default: spi2-cs1-default-state {
+		function = "SPI2CS1";
+		groups = "SPI2CS1";
+	};
+
+	pinctrl_espi0_default: espi0-default-state {
+		function = "ESPI0";
+		groups = "ESPI0";
+	};
+
+	pinctrl_espi1_default: espi1-default-state {
+		function = "ESPI1";
+		groups = "ESPI1";
+	};
+
+	pinctrl_lpc0_default: lpc0-default-state {
+		function = "LPC0";
+		groups = "LPC0";
+	};
+
+	pinctrl_lpc1_default: lpc1-default-state {
+		function = "LPC1";
+		groups = "LPC1";
+	};
+
+	pinctrl_vpi_default: vpi-default-state {
+		function = "VPI";
+		groups = "VPI";
+	};
+
+	pinctrl_sd_default: sd-default-state {
+		function = "SD";
+		groups = "SD";
+	};
+
+	pinctrl_hvi3c0_default: hvi3c0-default-state {
+		function = "I3C0";
+		groups = "HVI3C0";
+	};
+
+	pinctrl_hvi3c1_default: hvi3c1-default-state {
+		function = "I3C1";
+		groups = "HVI3C1";
+	};
+
+	pinctrl_hvi3c2_default: hvi3c2-default-state {
+		function = "I3C2";
+		groups = "HVI3C2";
+	};
+
+	pinctrl_hvi3c3_default: hvi3c3-default-state {
+		function = "I3C3";
+		groups = "HVI3C3";
+	};
+
+	pinctrl_i3c4_default: i3c4-default-state {
+		function = "I3C4";
+		groups = "I3C4";
+	};
+
+	pinctrl_i3c5_default: i3c5-default-state {
+		function = "I3C5";
+		groups = "I3C5";
+	};
+
+	pinctrl_i3c6_default: i3c6-default-state {
+		function = "I3C6";
+		groups = "I3C6";
+	};
+
+	pinctrl_i3c7_default: i3c7-default-state {
+		function = "I3C7";
+		groups = "I3C7";
+	};
+
+	pinctrl_i3c8_default: i3c8-default-state {
+		function = "I3C8";
+		groups = "I3C8";
+	};
+
+	pinctrl_i3c9_default: i3c9-default-state {
+		function = "I3C9";
+		groups = "I3C9";
+	};
+
+	pinctrl_i3c10_default: i3c10-default-state {
+		function = "I3C10";
+		groups = "I3C10";
+	};
+
+	pinctrl_i3c11_default: i3c11-default-state {
+		function = "I3C11";
+		groups = "I3C11";
+	};
+
+	pinctrl_hvi3c12_default: hvi3c12-default-state {
+		function = "I3C12";
+		groups = "HVI3C12";
+	};
+
+	pinctrl_hvi3c13_default: hvi3c13-default-state {
+		function = "I3C13";
+		groups = "HVI3C13";
+	};
+
+	pinctrl_hvi3c14_default: hvi3c14-default-state {
+		function = "I3C14";
+		groups = "HVI3C14";
+	};
+
+	pinctrl_hvi3c15_default: hvi3c15-default-state {
+		function = "I3C15";
+		groups = "HVI3C15";
+	};
+
+	pinctrl_tach0_default: tach0-default-state {
+		function = "TACH0";
+		groups = "TACH0";
+	};
+
+	pinctrl_tach1_default: tach1-default-state {
+		function = "TACH1";
+		groups = "TACH1";
+	};
+
+	pinctrl_tach2_default: tach2-default-state {
+		function = "TACH2";
+		groups = "TACH2";
+	};
+
+	pinctrl_tach3_default: tach3-default-state {
+		function = "TACH3";
+		groups = "TACH3";
+	};
+
+	pinctrl_tach4_default: tach4-default-state {
+		function = "TACH4";
+		groups = "TACH4";
+	};
+
+	pinctrl_tach5_default: tach5-default-state {
+		function = "TACH5";
+		groups = "TACH5";
+	};
+
+	pinctrl_tach6_default: tach6-default-state {
+		function = "TACH6";
+		groups = "TACH6";
+	};
+
+	pinctrl_tach7_default: tach7-default-state {
+		function = "TACH7";
+		groups = "TACH7";
+	};
+
+	pinctrl_tach8_default: tach8-default-state {
+		function = "TACH8";
+		groups = "TACH8";
+	};
+
+	pinctrl_tach9_default: tach9-default-state {
+		function = "TACH9";
+		groups = "TACH9";
+	};
+
+	pinctrl_tach10_default: tach10-default-state {
+		function = "TACH10";
+		groups = "TACH10";
+	};
+
+	pinctrl_tach11_default: tach11-default-state {
+		function = "TACH11";
+		groups = "TACH11";
+	};
+
+	pinctrl_tach12_default: tach12-default-state {
+		function = "TACH12";
+		groups = "TACH12";
+	};
+
+	pinctrl_tach13_default: tach13-default-state {
+		function = "TACH13";
+		groups = "TACH13";
+	};
+
+	pinctrl_tach14_default: tach14-default-state {
+		function = "TACH14";
+		groups = "TACH14";
+	};
+
+	pinctrl_tach15_default: tach15-default-state {
+		function = "TACH15";
+		groups = "TACH15";
+	};
+
+	pinctrl_thru0_default: thru0-default-state {
+		function = "THRU0";
+		groups = "THRU0";
+	};
+
+	pinctrl_thru1_default: thru1-default-state {
+		function = "THRU1";
+		groups = "THRU1";
+	};
+
+	pinctrl_thru2_default: thru2-default-state {
+		function = "THRU2";
+		groups = "THRU2";
+	};
+
+	pinctrl_thru3_default: thru3-default-state {
+		function = "THRU3";
+		groups = "THRU3";
+	};
+
+	pinctrl_ncts5_default: ncts5-default-state {
+		function = "NCTS5";
+		groups = "NCTS5";
+	};
+
+	pinctrl_ndcd5_default: ndcd5-default-state {
+		function = "NDCD5";
+		groups = "NDCD5";
+	};
+
+	pinctrl_ndsr5_default: ndsr5-default-state {
+		function = "NDSR5";
+		groups = "NDSR5";
+	};
+
+	pinctrl_nri5_default: nri5-default-state {
+		function = "NRI5";
+		groups = "NRI5";
+	};
+
+	pinctrl_i2c0_default: i2c0-default-state {
+		function = "I2C0";
+		groups = "I2C0";
+	};
+
+	pinctrl_i2c1_default: i2c1-default-state {
+		function = "I2C1";
+		groups = "I2C1";
+	};
+
+	pinctrl_i2c2_default: i2c2-default-state {
+		function = "I2C2";
+		groups = "I2C2";
+	};
+
+	pinctrl_i2c3_default: i2c3-default-state {
+		function = "I2C3";
+		groups = "I2C3";
+	};
+
+	pinctrl_i2c4_default: i2c4-default-state {
+		function = "I2C4";
+		groups = "I2C4";
+	};
+
+	pinctrl_i2c5_default: i2c5-default-state {
+		function = "I2C5";
+		groups = "I2C5";
+	};
+
+	pinctrl_i2c6_default: i2c6-default-state {
+		function = "I2C6";
+		groups = "I2C6";
+	};
+
+	pinctrl_i2c7_default: i2c7-default-state {
+		function = "I2C7";
+		groups = "I2C7";
+	};
+
+	pinctrl_i2c8_default: i2c8-default-state {
+		function = "I2C8";
+		groups = "I2C8";
+	};
+
+	pinctrl_i2c9_default: i2c9-default-state {
+		function = "I2C9";
+		groups = "I2C9";
+	};
+
+	pinctrl_i2c10_default: i2c10-default-state {
+		function = "I2C10";
+		groups = "I2C10";
+	};
+
+	pinctrl_i2c11_default: i2c11-default-state {
+		function = "I2C11";
+		groups = "I2C11";
+	};
+
+	pinctrl_i2c12_default: i2c12-default-state {
+		function = "I2C12";
+		groups = "I2C12";
+	};
+
+	pinctrl_i2c13_default: i2c13-default-state {
+		function = "I2C13";
+		groups = "I2C13";
+	};
+
+	pinctrl_i2c14_default: i2c14-default-state {
+		function = "I2C14";
+		groups = "I2C14";
+	};
+
+	pinctrl_i2c15_default: i2c15-default-state {
+		function = "I2C15";
+		groups = "I2C15";
+	};
+
+	pinctrl_salt0_default: salt0-default-state {
+		function = "SALT0";
+		groups = "SALT0";
+	};
+
+	pinctrl_salt1_default: salt1-default-state {
+		function = "SALT1";
+		groups = "SALT1";
+	};
+
+	pinctrl_salt2_default: salt2-default-state {
+		function = "SALT2";
+		groups = "SALT2";
+	};
+
+	pinctrl_salt3_default: salt3-default-state {
+		function = "SALT3";
+		groups = "SALT3";
+	};
+
+	pinctrl_salt4_default: salt4-default-state {
+		function = "SALT4";
+		groups = "SALT4";
+	};
+
+	pinctrl_salt5_default: salt5-default-state {
+		function = "SALT5";
+		groups = "SALT5";
+	};
+
+	pinctrl_salt6_default: salt6-default-state {
+		function = "SALT6";
+		groups = "SALT6";
+	};
+
+	pinctrl_salt7_default: salt7-default-state {
+		function = "SALT7";
+		groups = "SALT7";
+	};
+
+	pinctrl_salt8_default: salt8-default-state {
+		function = "SALT8";
+		groups = "SALT8";
+	};
+
+	pinctrl_salt9_default: salt9-default-state {
+		function = "SALT9";
+		groups = "SALT9";
+	};
+
+	pinctrl_salt10_default: salt10-default-state {
+		function = "SALT10";
+		groups = "SALT10";
+	};
+
+	pinctrl_salt11_default: salt11-default-state {
+		function = "SALT11";
+		groups = "SALT11";
+	};
+
+	pinctrl_salt12_default: salt12-default-state {
+		function = "SALT12";
+		groups = "SALT12";
+	};
+
+	pinctrl_salt13_default: salt13-default-state {
+		function = "SALT13";
+		groups = "SALT13";
+	};
+
+	pinctrl_salt14_default: salt14-default-state {
+		function = "SALT14";
+		groups = "SALT14";
+	};
+
+	pinctrl_salt15_default: salt15-default-state {
+		function = "SALT15";
+		groups = "SALT15";
+	};
+
+	pinctrl_ltpipsi2c0_default: ltpipsi2c0-default-state {
+		function = "I2C0";
+		groups = "LTPI_PS_I2C0";
+	};
+
+	pinctrl_ltpipsi2c1_default: ltpipsi2c1-default-state {
+		function = "I2C1";
+		groups = "LTPI_PS_I2C1";
+	};
+
+	pinctrl_ltpipsi2c2_default: ltpipsi2c2-default-state {
+		function = "I2C2";
+		groups = "LTPI_PS_I2C2";
+	};
+
+	pinctrl_ltpipsi2c3_default: ltpipsi2c3-default-state {
+		function = "I2C3";
+		groups = "LTPI_PS_I2C3";
+	};
+
+	pinctrl_can_default: can-default-state {
+		function = "CANBUS";
+		groups = "CANBUS";
+	};
+
+	pinctrl_di2c0_default: di2c0-default-state {
+		function = "I2C0";
+		groups = "DI2C0";
+	};
+
+	pinctrl_di2c1_default: di2c1-default-state {
+		function = "I2C1";
+		groups = "DI2C1";
+	};
+
+	pinctrl_di2c2_default: di2c2-default-state {
+		function = "I2C2";
+		groups = "DI2C2";
+	};
+
+	pinctrl_di2c3_default: di2c3-default-state {
+		function = "I2C3";
+		groups = "DI2C3";
+	};
+	pinctrl_di2c8_default: di2c8-default-state {
+		function = "I2C8";
+		groups = "DI2C8";
+	};
+
+	pinctrl_di2c9_default: di2c9-default-state {
+		function = "I2C9";
+		groups = "DI2C9";
+	};
+
+	pinctrl_di2c10_default: di2c10-default-state {
+		function = "I2C10";
+		groups = "DI2C10";
+	};
+
+	pinctrl_di2c11_default: di2c11-default-state {
+		function = "I2C11";
+		groups = "DI2C11";
+	};
+
+	pinctrl_di2c12_default: di2c12-default-state {
+		function = "I2C12";
+		groups = "DI2C12";
+	};
+
+	pinctrl_di2c13_default: di2c13-default-state {
+		function = "I2C13";
+		groups = "DI2C13";
+	};
+
+	pinctrl_di2c14_default: di2c14-default-state {
+		function = "I2C14";
+		groups = "DI2C14";
+	};
+
+	pinctrl_di2c15_default: di2c15-default-state {
+		function = "I2C15";
+		groups = "DI2C15";
+	};
+
+	pinctrl_ncts0_default: ncts0-default-state {
+		function = "NCTS0";
+		groups = "NCTS0";
+	};
+
+	pinctrl_ndcd0_default: ndcd0-default-state {
+		function = "NDCD0";
+		groups = "NDCD0";
+	};
+
+	pinctrl_ndsr0_default: ndsr0-default-state {
+		function = "NDSR0";
+		groups = "NDSR0";
+	};
+
+	pinctrl_nri0_default: nri0-default-state {
+		function = "NRI0";
+		groups = "NRI0";
+	};
+
+	pinctrl_ndtr0_default: ndtr0-default-state {
+		function = "NDTR0";
+		groups = "NDTR0";
+	};
+
+	pinctrl_nrts0_default: nrts0-default-state {
+		function = "NRTS0";
+		groups = "NRTS0";
+	};
+
+	pinctrl_uart0_default: uart0-default-state {
+		function = "UART0";
+		groups = "UART0";
+	};
+
+	pinctrl_ncts1_default: ncts1-default-state {
+		function = "NCTS1";
+		groups = "NCTS1";
+	};
+
+	pinctrl_ndcd1_default: ndcd1-default-state {
+		function = "NDCD1";
+		groups = "NDCD1";
+	};
+
+	pinctrl_ndsr1_default: ndsr1-default-state {
+		function = "NDSR1";
+		groups = "NDSR1";
+	};
+
+	pinctrl_nri1_default: nri1-default-state {
+		function = "NRI1";
+		groups = "NRI1";
+	};
+
+	pinctrl_ndtr1_default: ndtr1-default-state {
+		function = "NDTR1";
+		groups = "NDTR1";
+	};
+
+	pinctrl_nrts1_default: nrts1-default-state {
+		function = "NRTS1";
+		groups = "NRTS1";
+	};
+
+	pinctrl_uart1_default: uart1-default-state {
+		function = "UART1";
+		groups = "UART1";
+	};
+
+	pinctrl_uart2_default: uart2-default-state {
+		function = "UART2";
+		groups = "UART2";
+	};
+
+	pinctrl_uart3_default: uart3-default-state {
+		function = "UART3";
+		groups = "UART3";
+	};
+
+	pinctrl_ncts5_default: ncts5-default-state {
+		function = "NCTS5";
+		groups = "NCTS5";
+	};
+
+	pinctrl_ndcd5_default: ndcd5-default-state {
+		function = "NDCD5";
+		groups = "NDCD5";
+	};
+
+	pinctrl_ndsr5_default: ndsr5-default-state {
+		function = "NDSR5";
+		groups = "NDSR5";
+	};
+
+	pinctrl_nri5_default: nri5-default-state {
+		function = "NRI5";
+		groups = "NRI5";
+	};
+
+	pinctrl_ndtr5_default: ndtr5-default-state {
+		function = "NDTR5";
+		groups = "NDTR5";
+	};
+
+	pinctrl_nrts5_default: nrts5-default-state {
+		function = "NRTS5";
+		groups = "NRTS5";
+	};
+
+	pinctrl_uart5_default: uart5-default-state {
+		function = "UART5";
+		groups = "UART5";
+	};
+
+	pinctrl_ncts6_default: ncts6-default-state {
+		function = "NCTS6";
+		groups = "NCTS6";
+	};
+
+	pinctrl_ndcd6_default: ndcd6-default-state {
+		function = "NDCD6";
+		groups = "NDCD6";
+	};
+
+	pinctrl_ndsr6_default: ndsr6-default-state {
+		function = "NDSR6";
+		groups = "NDSR6";
+	};
+
+	pinctrl_nri6_default: nri6-default-state {
+		function = "NRI6";
+		groups = "NRI6";
+	};
+
+	pinctrl_ndtr6_default: ndtr6-default-state {
+		function = "NDTR6";
+		groups = "NDTR6";
+	};
+
+	pinctrl_nrts6_default: nrts6-default-state {
+		function = "NRTS6";
+		groups = "NRTS6";
+	};
+
+	pinctrl_uart6_default: uart6-default-state {
+		function = "UART6";
+		groups = "UART6";
+	};
+
+	pinctrl_uart7_default: uart7-default-state {
+		function = "UART7";
+		groups = "UART7";
+	};
+
+	pinctrl_uart8_default: uart8-default-state {
+		function = "UART8";
+		groups = "UART8";
+	};
+
+	pinctrl_uart9_default: uart9-default-state {
+		function = "UART9";
+		groups = "UART9";
+	};
+
+	pinctrl_uart10_default: uart10-default-state {
+		function = "UART10";
+		groups = "UART10";
+	};
+
+	pinctrl_uart11_default: uart11-default-state {
+		function = "UART11";
+		groups = "UART11";
+	};
+
+	pinctrl_pcierc2_perst_default: pcierc2-perst-default-state {
+		function = "PCIERC";
+		groups = "PE2SGRSTN";
+	};
+
+	pinctrl_usb2cud_default: usb2cud-default-state {
+		function = "USB2C";
+		groups = "USB2CUD";
+	};
+
+	pinctrl_usb2cd_default: usb2cd-default-state {
+		function = "USB2C";
+		groups = "USB2CD";
+	};
+
+	pinctrl_usb2ch_default: usb2ch-default-state {
+		function = "USB2C";
+		groups = "USB2CH";
+	};
+
+	pinctrl_usb2cu_default: usb2cu-default-state {
+		function = "USB2C";
+		groups = "USB2CU";
+	};
+
+	pinctrl_usb2dd_default: usb2dd-default-state {
+		function = "USB2D";
+		groups = "USB2DD";
+	};
+
+	pinctrl_usb2dh_default: usb2dh-default-state {
+		function = "USB2D";
+		groups = "USB2DH";
+	};
+
+	pinctrl_wdtrst0n_default: wdtrst0n-default-state {
+		function = "WDTRST0N";
+		groups = "WDTRST0N";
+	};
+
+	pinctrl_wdtrst1n_default: wdtrst1n-default-state {
+		function = "WDTRST1N";
+		groups = "WDTRST1N";
+	};
+
+	pinctrl_wdtrst2n_default: wdtrst2n-default-state {
+		function = "WDTRST2N";
+		groups = "WDTRST2N";
+	};
+
+	pinctrl_wdtrst3n_default: wdtrst3n-default-state {
+		function = "WDTRST3N";
+		groups = "WDTRST3N";
+	};
+
+	pinctrl_wdtrst4n_default: wdtrst4n-default-state {
+		function = "WDTRST4N";
+		groups = "WDTRST4N";
+	};
+
+	pinctrl_wdtrst5n_default: wdtrst5n-default-state {
+		function = "WDTRST5N";
+		groups = "WDTRST5N";
+	};
+
+	pinctrl_wdtrst6n_default: wdtrst6n-default-state {
+		function = "WDTRST6N";
+		groups = "WDTRST6N";
+	};
+
+	pinctrl_wdtrst7n_default: wdtrst7n-default-state {
+		function = "WDTRST7N";
+		groups = "WDTRST7N";
+	};
+};
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
new file mode 100644
index 000000000000..bc990f79e693
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for AST27xx SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+&soc1 {
+	fmc: spi@14000000 {
+		reg = <0x0 0x14000000 0x0 0xc4>, <0x1 0x00000000 0x0 0x80000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "aspeed,ast2700-fmc";
+		status = "disabled";
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		interrupts-extended = <&intc1 121>;
+		num-cs = <3>;
+
+		flash@0 {
+			reg = < 0 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+
+		flash@1 {
+			reg = < 1 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+
+		flash@2 {
+			reg = < 2 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+	};
+
+	spi0: spi@14010000 {
+		reg = <0x0 0x14010000 0x0 0xc4>, <0x1 0x80000000 0x0 0x80000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "aspeed,ast2700-spi";
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		interrupts-extended = <&intc1 122>;
+		status = "disabled";
+		num-cs = <2>;
+
+		flash@0 {
+			reg = < 0 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+
+		flash@1 {
+			reg = < 1 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+	};
+
+	spi1: spi@14020000 {
+		reg = <0x0 0x14020000 0x0 0xc4>, <0x2 0x00000000 0x0 0x80000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "aspeed,ast2700-spi";
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		interrupts-extended = <&intc1 123>;
+		status = "disabled";
+		num-cs = <2>;
+
+		flash@0 {
+			reg = < 0 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+
+		flash@1 {
+			reg = < 1 >;
+			compatible = "jedec,spi-nor";
+			spi-max-frequency = <50000000>;
+			spi-rx-bus-width = <2>;
+			status = "disabled";
+		};
+	};
+
+	spi2: spi@14030000 {
+		reg = <0x0 0x14030000 0x0 0x1f0>, <0x2 0x80000000 0x0 0x80000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "aspeed,ast2700-spi";
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		resets = <&syscon1 SCU1_RESET_SPI2>;
+		interrupts-extended = <&intc1 124>;
+		num-cs = <2>;
+		status = "disabled";
+	};
+
+	mdio0: mdio@14040000 {
+		compatible = "aspeed,ast2700-mdio", "aspeed,ast2600-mdio";
+		reg = <0 0x14040000 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mdio0_default>;
+		status = "disabled";
+	};
+
+	mdio1: mdio@14040008 {
+		compatible = "aspeed,ast2700-mdio", "aspeed,ast2600-mdio";
+		reg = <0 0x14040008 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mdio1_default>;
+		status = "disabled";
+	};
+
+	mdio2: mdio@14040010 {
+		compatible = "aspeed,ast2700-mdio", "aspeed,ast2600-mdio";
+		reg = <0 0x14040010 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mdio2_default>;
+		status = "disabled";
+	};
+
+	sdio_controller: sdc@14080000 {
+		compatible = "aspeed,ast2700-sd-controller", "aspeed,ast2600-sd-controller";
+		reg = <0 0x14080000 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x14080000 0x10000>;
+		clocks = <&syscon1 SCU1_CLK_GATE_SDCLK>;
+		resets = <&syscon1 SCU1_RESET_SD>;
+		status = "disabled";
+
+		sdhci: sdhci@100 {
+			compatible = "aspeed,ast2700-sdhci", "aspeed,ast2600-sdhci";
+			reg = <0x100 0x100>;
+			sdhci,auto-cmd12;
+			interrupts-extended = <&intc1 161>;
+			clocks = <&syscon1 SCU1_CLK_GATE_SDCLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd_default>;
+			status = "disabled";
+		};
+	};
+
+	pwm_tach: pwm-tach-controller@140c0000 {
+		compatible = "aspeed,ast2700-pwm-tach", "aspeed,ast2600-pwm-tach";
+		reg = <0x0 0x140c0000 0 0x100>;
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		resets = <&syscon1 SCU1_RESET_PWM>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	uhci1: usb@14110000 {
+		compatible = "aspeed,ast2700-uhci", "generic-uhci";
+		reg = <0x0 0x14110000 0x0 0x100>;
+		interrupts-extended = <&intc1 155>;
+		#ports = <2>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UHCICLK>;
+		resets = <&syscon1 SCU1_RESET_UHCI>;
+		status = "disabled";
+	};
+
+	vhubc: usb-vhub@14120000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x14120000 0x0 0x820>;
+		interrupts-extended = <&intc1 156>;
+		clocks = <&syscon1 SCU1_CLK_GATE_PORTCUSB2CLK>;
+		resets = <&syscon1 SCU1_RESET_PORTC_VHUB_EHCI>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2cd_default>;
+		status = "disabled";
+	};
+
+	ehci2: usb@14121000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x14121000 0x0 0x100>;
+		interrupts-extended = <&intc1 156>;
+		clocks = <&syscon1 SCU1_CLK_GATE_PORTCUSB2CLK>;
+		resets = <&syscon1 SCU1_RESET_PORTC_VHUB_EHCI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2ch_default>;
+		status = "disabled";
+	};
+
+	vhubd: usb-vhub@14122000 {
+		compatible = "aspeed,ast2700-usb-vhub";
+		reg = <0x0 0x14122000 0x0 0x820>;
+		interrupts-extended = <&intc1 157>;
+		clocks = <&syscon1 SCU1_CLK_GATE_PORTDUSB2CLK>;
+		resets = <&syscon1 SCU1_RESET_PORTD_VHUB_EHCI>;
+		aspeed,vhub-downstream-ports = <7>;
+		aspeed,vhub-generic-endpoints = <21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2dd_default>;
+		status = "disabled";
+	};
+
+	ehci3: usb@14123000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x14123000 0x0 0x100>;
+		interrupts-extended = <&intc1 157>;
+		clocks = <&syscon1 SCU1_CLK_GATE_PORTDUSB2CLK>;
+		resets = <&syscon1 SCU1_RESET_PORTD_VHUB_EHCI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2dh_default>;
+		status = "disabled";
+	};
+
+	sram1: sram@14b80000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x14b80000 0x0 0x40000>;
+		ranges = <0x0 0x0 0x14b80000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		soc1-sram@0 {
+			reg = <0x0 0x40000>;
+			export;
+		};
+	};
+
+	adc0: adc@14c00000 {
+		compatible = "aspeed,ast2700-adc0";
+		reg = <0x0 0x14c00000 0 0x100>;
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		resets = <&syscon1 SCU1_RESET_ADC>;
+		interrupts-extended = <&intc1 80>;
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
+	adc1: adc@14c00100 {
+		compatible = "aspeed,ast2700-adc1";
+		reg = <0x0 0x14c00100 0x0 0x100>;
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		resets = <&syscon1 SCU1_RESET_ADC>;
+		interrupts-extended = <&intc1 80>;
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
+	syscon1: syscon@14c02000 {
+		compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+		reg = <0x0 0x14c02000 0x0 0x1000>;
+		ranges = <0x0 0x0 0x14c02000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		scu_ic2: interrupt-controller@100 {
+			compatible = "aspeed,ast2700-scu-ic2";
+			reg = <0x100 0x8>;
+			interrupts-extended = <&intc1 160>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
+		scu_ic3: interrupt-controller@108 {
+			compatible = "aspeed,ast2700-scu-ic3";
+			reg = <0x108 0x8>;
+			interrupts-extended = <&intc1 186>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
+		pinctrl1: pinctrl@400 {
+			compatible = "aspeed,ast2700-soc1-pinctrl";
+			reg = <0x400 0x2a0>;
+		};
+	};
+
+	gpio1: gpio@14c0b000 {
+		#gpio-cells = <2>;
+		gpio-controller;
+		compatible = "aspeed,ast2700-gpio";
+		reg = <0x0 0x14c0b000 0x0 0x1000>;
+		interrupts-extended = <&intc1 82>;
+		gpio-ranges = <&pinctrl1 0 0 216>;
+		ngpios = <216>;
+		clocks = <&syscon1 SCU1_CLK_AHB>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sgpiom0: sgpiom@14c0c000 {
+		#gpio-cells = <2>;
+		gpio-controller;
+		compatible = "aspeed,ast2700-sgpiom";
+		reg = <0x0 0x14c0c000 0x0 0x100>;
+		interrupts-extended = <&intc1 85>;
+		ngpios = <256>;
+		clocks = <&syscon1 SCU1_CLK_APB>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		bus-frequency = <12000000>;
+		status = "disabled";
+	};
+
+	sgpiom1: sgpiom@14c0d000 {
+		#gpio-cells = <2>;
+		gpio-controller;
+		compatible = "aspeed,ast2700-sgpiom";
+		reg = <0x0 0x14c0d000 0x0 0x100>;
+		interrupts-extended = <&intc1 88>;
+		ngpios = <256>;
+		clocks = <&syscon1 SCU1_CLK_APB>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		bus-frequency = <12000000>;
+		status = "disabled";
+	};
+
+	intc1: interrupt-controller@14c18000 {
+		compatible = "aspeed,ast2700-intc1";
+		reg = <0 0x14c18000 0 0x400>;
+		interrupt-controller;
+		interrupt-parent = <&intc0>;
+		#interrupt-cells = <1>;
+		aspeed,interrupt-ranges =
+			<0 6 &intc0 480>,   /* M0  ~ M5  */
+			<10 6 &intc0 490>,   /* M10 ~ M15  */
+			<20 6 &intc0 500>,   /* M20 ~ M25  */
+			<30 6 &intc0 510>,   /* M30 ~ M35  */
+			<40 6 &intc0 520>,   /* M40 ~ M45  */
+			<50 1 &bootmcu_hlic 11>; /* only 1 pin to BootMCU */
+	};
+
+	uart0: serial@14c33000 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33000 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART0CLK>;
+		interrupts-extended = <&intc1 135>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart1: serial@14c33100 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33100 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART1CLK>;
+		interrupts-extended = <&intc1 136>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart2: serial@14c33200 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33200 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART2CLK>;
+		interrupts-extended = <&intc1 137>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart3: serial@14c33300 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33300 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART3CLK>;
+		interrupts-extended = <&intc1 138>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart5: serial@14c33400 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33400 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART5CLK>;
+		interrupts-extended = <&intc1 139>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart6: serial@14c33500 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33500 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART6CLK>;
+		interrupts-extended = <&intc1 140>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart7: serial@14c33600 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33600 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART7CLK>;
+		interrupts-extended = <&intc1 141>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart8: serial@14c33700 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33700 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART8CLK>;
+		interrupts-extended = <&intc1 142>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart9: serial@14c33800 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33800 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART9CLK>;
+		interrupts-extended = <&intc1 143>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart10: serial@14c33900 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33900 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART10CLK>;
+		interrupts-extended = <&intc1 144>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart11: serial@14c33a00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33a00 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART11CLK>;
+		interrupts-extended = <&intc1 145>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart12: serial@14c33b00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33b00 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+		interrupts-extended = <&intc1 146>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart13: serial@14c33c00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33c00 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_UART13>;
+		interrupts-extended = <&intc1 23>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	uart14: serial@14c33d00 {
+		compatible = "ns16550a";
+		reg = <0x0 0x14c33d00 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&syscon1 SCU1_CLK_UART14>;
+		interrupts-extended = <&intc1 55>;
+		no-loopback-test;
+		status = "disabled";
+	};
+
+	wdt0: watchdog@14c37000 {
+		compatible = "aspeed,ast2700-wdt";
+		reg = <0x0 0x14c37000 0x0 0x80>;
+	};
+
+	wdt1: watchdog@14c37080 {
+		compatible = "aspeed,ast2700-wdt";
+		reg = <0x0 0x14c37080 0x0 0x80>;
+	};
+
+	wdt2: watchdog@14c37100 {
+		compatible = "aspeed,ast2700-wdt";
+		reg = <0x0 0x14c37100 0x0 0x80>;
+		status = "disabled";
+	};
+
+	wdt3: watchdog@14c37180 {
+		compatible = "aspeed,ast2700-wdt";
+		reg = <0x0 0x14c37180 0x0 0x80>;
+		status = "disabled";
+	};
+
+	mbox2: mbox@14c39200 {
+		compatible = "aspeed,ast2700-mailbox";
+		reg = <0x0 0x14c39200 0x0 0x100>, <0x0 0x14c39300 0x0 0x100>;
+		reg-names = "tx", "rx";
+		interrupts-extended = <&intc1 177>;
+		#mbox-cells = <1>;
+	};
+
+	fsim0: fsi@21800000 {
+		compatible = "aspeed,ast2700-fsi-master";
+		reg = <0x0 0x21800000 0x0 0x94>;
+		interrupts-extended = <&intc1 166>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fsi0_default>;
+		clocks = <&syscon1 SCU1_CLK_GATE_FSICLK>;
+		resets = <&syscon1 SCU1_RESET_FSI>;
+		status = "disabled";
+	};
+
+	fsim1: fsi@23800000 {
+		compatible = "aspeed,ast2700-fsi-master";
+		reg = <0x0 0x23800000 0x0 0x94>;
+		interrupts-extended = <&intc1 167>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fsi2_default>;
+		clocks = <&syscon1 SCU1_CLK_GATE_FSICLK>;
+		resets = <&syscon1 SCU1_RESET_FSI>;
+		status = "disabled";
+	};
+};
+
+#include "aspeed-g7-soc1-pinctrl.dtsi"
diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
new file mode 100644
index 000000000000..fe8f0b80fb2c
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source AST2700 EVB
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+/dts-v1/;
+#include "aspeed-g7-a35.dtsi"
+
+/ {
+	model = "AST2700 EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	aliases {
+		serial0 = &uart12;	/* console port */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x0 0x40000000>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_fwspi_quad_default>;
+	pinctrl-names = "default";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+#include "aspeed-evb-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "fmc0:1";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@2 {
+		status = "disabled";
+		m25p,fast-read;
+		label = "fmc0:2";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&uart12 {
+	status = "okay";
+};

-- 
2.34.1


