Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD32606A319
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hy0fML5Y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8ztg4xJbz2yDm;
	Thu, 22 Oct 2026 06:31:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792611115;
	cv=none; b=kf5O1V6aa/+tyXR397BC4+42BaLO/8ojKRojs2PgutPaDs5kZ4hLxBgE0qzgZdAs7jAFPl5PyKht7isXJjvwWsxbMKljnDppKpap+TctOqCsilXL3PEKJZuF/h4QmJtfqIoUulQDYL76e28iPFWp38AWpbFtnMIGM7qO+z/BVIQb1PjNlE0rKfgdI6AZC48gOlFJTIsFKjPd5fdXlLFoS2TEVNd1xT8yE0MalDMgQNEagKvLzj/aYHLvx/BLov0rZSXyDap/6RwWTNUQcTfcddo/ddreWC/qtkGWjgTecHHpW6fGhhXryz04ZrBm7/66ay0/29N/J3WjvI8MxZ8frA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792611115; c=relaxed/relaxed;
	bh=M0e56pUsZC6h1nsirS1qJ7H5bNpP7pMCwPwc6QaN6uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfivzUeTuGGueDenmIohBTmQPlUIhYlNDHn1tB/OC0Oim7FJJaH+uFq6AZDnt8uIX7fCw2OlmJnfN3S58GR3Q+1Xsg5db1OLYWvby5B65wua8YiMFIn3Kvpjz9rVSQMAwPDe8rZ/1XrzbPndSUEHYyIzI4Vmo2XM1uuU4lM/YXwO0/+YP/Hn3lwgyPMWU3lcjxaJ7OYk14+cx9W14qvxtG3XheMIJOANA6SQjnqyW399O4HQfjol2zcSRcDgl6izxUI3Ap/n0UYEgBXGwgcjGl0wouGkQnfpENo+lhQnAKqgcpxAXMhJcWsml9RHSISgvNNPFMtwV/0fmTzkA2t2GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hy0fML5Y; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hy0fML5Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8ztf5PmTz2y8Z
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 06:31:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792611115; x=1824147115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4KnIuqLQdcMUh13r9RuCTYbhXJrdP0hn2ceXs9y2fec=;
  b=Hy0fML5Y+HQlEvXQuixTrUwU1Hif+sv5Osaj+qhFnp4TxDKbm+q7noW9
   ux2nOvtJk/vS+y6FSTgvdosb056vqnfozcHDhXFhQfNKnHIRdcSY0pVrq
   6SYC64D2b9swV14Zz2y/a9de72OkoxnOpTMPd6KFVnjDmNjOpwzhdIa+b
   AfwBzKDm5oYhxvZddnCScPnpf1SnLg5+E5jonB9w8+ckuwQVRaABlZgy9
   5q7YvE4YlsMDjmEYIjf9t1ErX0QSkjlklP+VD8WEyaCj6doGCoevQMm/4
   sb5pUP0AY4mk0JUJAhMAI0a1sPfwDIHs4cLouTBoxUToDG80Ip/8Wa2nV
   Q==;
X-CSE-ConnectionGUID: sDKnm9m4Q8SucZYK+UZoUA==
X-CSE-MsgGUID: 5F4im4fKS62MeRUrFWmMoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1382545"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1382545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:52 -0700
X-CSE-ConnectionGUID: fpRHLT0QSnugO5kStplgTA==
X-CSE-MsgGUID: kxd4kgYKRVuNN0xx+hdNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3170408"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:50 -0700
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
Subject: [PATCH v3 3/3] ARM: dts: aspeed: add Intel JNCRP BMC
Date: Wed, 21 Oct 2026 22:26:42 +0200
Message-ID: <202a66934cde5273507b7b05dd3cbc28b98ebcda.1792613583.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792613583.git.dawid.glazik@linux.intel.com>
References: <cover.1792613583.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the initial AST2600 device tree for the Intel JNCRP BMC platform.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
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
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 276 ++++++++++++++++++
 2 files changed, 277 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index ea4645ef9872..f0d665b3dcee 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-sbp1.dtb \
 	aspeed-bmc-ibm-system1.dtb \
 	aspeed-bmc-intel-avcrp.dtb \
+	aspeed-bmc-intel-jncrp.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
new file mode 100644
index 000000000000..e66ea7f00fed
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
@@ -0,0 +1,276 @@
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
+		bootargs = "earlycon";
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


