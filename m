Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF488606A338
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTyQIFNM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNbMM34WXz2yDc;
	Tue, 10 Nov 2026 03:48:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794242911;
	cv=none; b=icoHMbQDHLyrgRTK66+iPBfmRNasHKOZSjtpBbpDecmnd1WhW4tmU2L3/Od9h4aGNuu51r+MbyEWTq503KaU+jBhsYJxiwx3SOOCdCcTd2VCgcc1kqpWWESzizP8ewpE5SUsfUlQdSV2seV5EMxmRx1VpLYS7y9Oykrdj0joCX1MhV4iBJOsUzjV+5U1YJFY2JkRKqoiGiU/0MhGACuLYNm7Hw8LzPXV03ymzIDisteKRUO9EAj2xsohj6+4FlSa2YLTjOwMx9cy3FXHGpvyhigMuIrv7YU4nGgv4qQngtRe+vZjnXVpD7fDk1VqBrz0yCHCgOtqOBKizb6Rgu6qjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794242911; c=relaxed/relaxed;
	bh=+5v5Ttjena30jfUMPKvSfLufFX76fSDkM2lEOhLq3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiY93wN9lGr7ZTEso1nle9sZFiInPZH+CzO4ghQpBAc/6ISkc6+jB2csK2CC0awNjWiq90NQgD1H2rW8YAYwQkDOefW20GW68B8m9vFKN18vRoUPEKG/lyV1470/VO3+m7zaob7K/DX5TOYAWUaSYvPZFx46rUad/kalUZ4OVn8bpgSBKfsiH0TtYjXf9RQI2HIbNQx11J9lIbFgMVteP5NNBw1SvaYceDVaj9hhAqSdGPFjzZrt12ov+Abs31gd4DsXO6pitD+cymfJ3pnSXCmqPl6ueskiGqk2hJRrgwNOk5zDTOyB0F0NlnEx06LTVqR2GzQzRn9vWGL+SE9w2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTyQIFNM; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTyQIFNM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNbML3kqkz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 03:48:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794242911; x=1825778911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M1b1/GbiyTfc4Q78ILPO1E4527CoyWz8aeTyI7F8/Jk=;
  b=eTyQIFNMjYKjtsEirK+QE2j57sRwiT9F9BI5IsjPknST/2seqQImzV2G
   znywyH27voJxScfhDLWZNZiNxlJUHeJjlypp61xr0+yBSTRkLx8j+bU33
   wWSQFRNcfuqMaQP9O9gFxbusVQfD9D3wClnvLK484TVwy7xMniiswKdOa
   4/N9FDrEbArUuON4FqxG+g2GlVdA6Rces6SULUWYpdt6LNs6+x2Qg5+gy
   hcHR3Qns5jphhlhTS0wWj3HWk+ccv1ilty7Hy1D9HkiPvJB623mhAHc3R
   vzc/J7wmSCujnYYdrLScRNGVzdxY5MV0ctXGr5l/m7ZGS8+iWq0dnVqBb
   A==;
X-CSE-ConnectionGUID: aWIZx4O8TZ2C2U+8mKzBrA==
X-CSE-MsgGUID: Ec+8HWT/RZO59KEEarZnoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3010746"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3010746"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:30 -0800
X-CSE-ConnectionGUID: FJpT0kT/TKydi9996leiSw==
X-CSE-MsgGUID: LCdXuJGeRdGvpav7gVtRLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8481268"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:27 -0800
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 3/3] ARM: dts: aspeed: Add Intel JNCRP BMC
Date: Mon,  9 Nov 2026 18:41:50 +0100
Message-ID: <ed2ff52e2b160f5d9ff8d293f9d4e7a6f350112f.1794242015.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794242015.git.dawid.glazik@linux.intel.com>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

JNCRP is an Intel x86 server platform equipped with an ASPEED
AST2600 BMC. The BMC is used for out-of-band management, platform
monitoring, and system control.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5:
  - Removed bootargs from the chosen node
  - Added a description of the platform to the commit message, written
    in the style of other boards upstream (Facebook, Lenovo, Ampere)
  - Rebased onto the current aspeed/arm/dt
  - Capitalised the first word of the subject
v4:
  - Rebased onto aspeed/arm/dt of bmc/linux.git, no other changes
v3:
  - Sorted nodes alphabetically
  - Sorted properties per dts-coding-style
  - Removed lpc-snoop label
  - Removed &i3c_global since it's enabled by default
  - Added &kcs3 and replaced flash layout with 128MB one
  - Restored Reviewed-by from Andrew Lunn, dropped by mistake in v2
v2:
  - Reviewed-by: Andrew Lunn for nodes: &mdio1, &mac1
  - Replace bootargs console=ttyS4,115200n8 with stdout-path = &uart5
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 275 ++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 1e4154f12228..5e685a625883 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-sbp1.dtb \
 	aspeed-bmc-ibm-system1.dtb \
 	aspeed-bmc-intel-avcrp.dtb \
+	aspeed-bmc-intel-jncrp.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
new file mode 100644
index 000000000000..5d395986802f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Intel Corporation
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	compatible = "intel,jncrp-bmc", "aspeed,ast2600";
+	model = "Intel JNCRP BMC";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+
+		status = "okay";
+
+#include "openbmc-flash-layout-128.dtsi"
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+		/*A0-A7*/ "", "", "", "", "", "", "", "",
+		/*B0-B7*/ "PWRGD_AUX_PWRGD_BMC_CPU", "", "", "", "", "", "",
+				"FP_ID_LED_N",
+		/*C0-C7*/ "FM_FORCE_BMC_UPDATE_N", "RST_RGMII_PHYRST_N",
+				"FM_TPM_EN_PULSE", "", "", "",
+				"DBP_HOOK3_CPU_FBRK_OUT_R_N", "DBP_PRSNT_IN_N",
+		/*D0-D7*/ "CPU_ERR0_N", "CPU_ERR1_N", "CPU_ERR2_N", "DBP_ASD_BMC_PRDY_N",
+				"FM_SPD_SWITCH_CTRL_N", "", "", "",
+		/*E0-E7*/ "", "", "", "ID_BUTTON", "", "", "", "",
+		/*F0-F7*/ "", "", "FM_AGGREGATOR_MODE_N", "", "", "",
+				"FP_LED_STATUS_GREEN_R_N", "FP_LED_STATUS_AMBER_R_N",
+		/*G0-G7*/ "", "", "", "", "", "", "", "",
+		/*H0-H7*/ "", "", "", "", "", "", "", "",
+		/*I0-I7*/ "", "", "", "", "", "", "", "",
+		/*J0-J7*/ "", "", "", "", "", "", "", "",
+		/*K0-K7*/ "", "", "", "", "", "", "", "",
+		/*L0-L7*/ "", "", "", "", "PREQ_N", "FM_P3V3_SW_ENA", "", "",
+		/*M0-M7*/ "", "", "", "", "", "", "", "",
+		/*N0-N7*/ "", "", "", "", "", "", "", "",
+		/*O0-O7*/ "", "", "", "", "", "", "NMI_BUTTON", "",
+		/*P0-P7*/ "RESET_BUTTON", "RESET_OUT", "POWER_BUTTON", "POWER_OUT",
+				"", "", "", "LED_BMC_HB_LED_N",
+		/*Q0-Q7*/ "", "", "", "", "", "", "", "",
+		/*R0-R7*/ "", "", "", "", "", "", "", "",
+		/*S0-S7*/ "CPU_CATERR_IERR_N", "CPU_CATERR_MCERR_N", "FM_BMC_FRU_WP_N",
+				"FM_INTRUSION_CABLE_PRES_N", "PWRGD_CPU_AUXPWRGD",
+				"FM_P3V_BAT_SCALED_EN", "REMOTE_DEBUG_ENABLE", "",
+		/*T0-T7*/ "", "", "", "", "", "", "", "",
+		/*U0-U7*/ "", "", "", "", "", "", "", "",
+		/*V0-V7*/ "SIO_S3", "SIO_S5", "", "SIO_ONCONTROL",
+				"SIO_POWER_GOOD", "", "", "",
+		/*W0-W7*/ "", "", "", "", "", "", "", "",
+		/*X0-X7*/ "", "", "POST_COMPLETE", "", "", "", "", "",
+		/*Y0-Y7*/ "FM_BMC_CMOS_CLR_R_N", "PLTRST_N", "FM_BMC_SAFS_EN",
+				"IRQ_PSU_ALERT_LVC3_N", "", "", "", "",
+		/*Z0-Z7*/ "", "", "", "", "", "", "", "";
+
+	status = "okay";
+
+	spd-switch-cpu-hog {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c8 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c9 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c10 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c13 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	multi-master;
+
+	status = "okay";
+};
+
+&i3c1 {
+	i2c-scl-hz = <1000000>;
+	mctp-controller;
+
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+
+	status = "okay";
+};
+
+&lpc {
+	lpc-snoop@80 {
+		snoop-ports = <0x80>;
+
+		status = "okay";
+	};
+};
+
+&mac1 {
+	clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>,
+		 <&syscon ASPEED_CLK_MAC2RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_rgmii2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdio1 {
+	status = "okay";
+
+	ethphy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <50000>;
+		reset-gpios = <&gpio0 ASPEED_GPIO(C, 1) GPIO_ACTIVE_LOW>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	bus-frequency = <2000000>;
+	gpio-line-names =
+		/*A, 0-7*/ "CPU0_VRHOT_N", "LED_POSTCODE_0_LSB",
+				"CPU0_THERMTRIP_N", "LED_POSTCODE_1",
+				"CPU0_MEMTRIP_N", "LED_POSTCODE_2",
+				"CPU0_MEM_VRHOT_N", "LED_POSTCODE_3",
+				"CPU0_MEM_HOT_N", "LED_POSTCODE_4",
+				"CPU0_MON_FAIL_N", "LED_POSTCODE_5",
+				"CPU1_VRHOT_N", "LED_POSTCODE_6",
+				"CPU1_THERMTRIP_N", "LED_POSTCODE_7_MSB",
+		/*B, 8-15*/ "CPU1_MEMTRIP_N", "FM_ASYNC_WARM_RESET_REQ",
+				"CPU1_MEM_VRHOT_N", "HPM_FRU_READ_DONE",
+				"CPU1_MEM_HOT_N", "FM_ASYNC_GLOBAL_RESET_REQ",
+				"CPU1_MON_FAIL_N", "BMC_BOOT_DONE",
+				"CPU2_VRHOT_N", "NMI_OUT",
+				"CPU2_THERMTRIP_N", "AGGREGATOR_MODE",
+				"CPU2_MEMTRIP_N", "RST_I3C_PCIE_HUB_N",
+				"CPU2_MEM_VRHOT_N", "",
+		/*C, 16-23*/ "CPU2_MEM_HOT_N", "HPM0_PRESENT",
+				"CPU2_MON_FAIL_N", "HPM1_PRESENT",
+				"CPU3_VRHOT_N", "HPM2_PRESENT",
+				"CPU3_THERMTRIP_N", "HPM3_PRESENT",
+				"CPU3_MEMTRIP_N", "HPM0_SOURCE_TO_DESTINATION_FAIL",
+				"CPU3_MEM_VRHOT_N", "HPM1_SOURCE_TO_DESTINATION_FAIL",
+				"CPU3_MEM_HOT_N", "HPM2_SOURCE_TO_DESTINATION_FAIL",
+				"CPU3_MON_FAIL_N", "HPM3_SOURCE_TO_DESTINATION_FAIL",
+		/*D, 24-31*/ "FM_BMC_VAL_EN", "HPM0_FRU_VALID",
+				"FM_SERIAL_BOOT", "HPM1_FRU_VALID",
+				"FM_INTRUSION_CABLE_PRES_N", "HPM2_FRU_VALID",
+				"USB_OC_P2_3_N", "HPM3_FRU_VALID",
+				"FM_SYSTEM_COOLING_MODE0", "FM_S2D_DISCOVERY_DONE",
+				"FM_SYSTEM_COOLING_MODE1", "", "", "", "", "",
+		/*E, 32-39*/ "DBP_PMODE_S0_PWROK", "", "DBP_PMODE_PLTRST", "",
+				"DBP_PMODE_GLOBALRESET", "", "DBP_PMODE_CPU_PWRGD", "",
+				"FM_SMBUS_RDY", "", "FM_LEAK_DETECTION", "",
+				"FM_LEAK_CBL_PRSNT_N", "", "FM_LEAK_CBL_FAULT_N", "",
+		/*F, 40-47*/ "CPU0_SKTOCC1_N", "CPU0_SKT_FAULT_LED",
+				"CPU0_SKTOCC2_N", "CPU1_SKT_FAULT_LED",
+				"CPU0_MISMATCH", "CPU2_SKT_FAULT_LED",
+				"CPU1_SKTOCC1_N", "CPU3_SKT_FAULT_LED",
+				"CPU1_SKTOCC2_N", "", "CPU1_MISMATCH", "",
+				"CPU2_SKTOCC1_N", "", "CPU2_SKTOCC2_N", "",
+		/*G, 48-55*/ "CPU2_MISMATCH", "", "CPU3_SKTOCC1_N", "",
+				"CPU3_SKTOCC2_N", "", "CPU3_MISMATCH", "",
+				"HPM0_PRSNT_N", "", "HPM1_PRSNT_N", "",
+				"HPM2_PRSNT_N", "", "HPM3_PRSNT_N", "",
+		/*H, 56-63*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*I, 64-71*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*J, 72-79*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*K, 80-87*/ "FM_BOARD_REV_ID0", "", "FM_BOARD_REV_ID1", "",
+				"FM_BOARD_REV_ID2", "", "FM_BOARD_SKU_ID0", "",
+				"FM_BOARD_SKU_ID1", "", "FM_BOARD_SKU_ID2", "",
+				"FM_BOARD_SKU_ID3", "", "FM_BOARD_SKU_ID4", "",
+		/*L, 88-95*/ "FM_BOARD_SKU_ID5", "", "FM_BOARD_SKU_ID6", "",
+				"FM_BOARD_SKU_ID7", "", "", "", "", "", "", "",
+				"", "", "", "",
+		/*M, 96-103*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*N, 104-111*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*O, 112-119*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		/*P, 120-127*/ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "";
+	ngpios = <128>;
+
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.43.0


