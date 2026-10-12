Return-Path: <linux-aspeed+bounces-5172-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A337CA9ED0
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Oct 2026 16:44:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Nc748htz3bpH;
	Tue, 13 Oct 2026 03:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791823495;
	cv=none; b=NPucNKu79iTw9cLn4CkpO0LuJUZes66UdtbrlPG2QIxJ8P2++0byS59755puGdLrVoNvCxQgHoYe1MA04py2LuyQgaQQZUpsgCdiR0UcuoKpqMEY/eJWo6bZFQb5Y2E+WyqasrruTZbxP4kHi/vmFmhk1atjSGZ1mdGoKKeHPTRc4YNR9FF3S/bkp6ZDzw2AWZ085NpJVRVpZTPsmEVISkTMTczr61jtnLI4bZr29DVOYpH45ba+LtcylD37S9mTopiGwEDib2AwQ2Sq2kgY6IJKtfVODMeWPL25di3pXLlIW1Q0OzgmAPNcuy6fhQQ70uSPdK+sEqYdV6QPO7hC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791823495; c=relaxed/relaxed;
	bh=2a2Cj8tEk5vMw7Wn1gUeyJZk2aTwhmeuxGORPMI1Q5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9ak56o30zTKuvBscZ4b30tJe4EmWcGPAQAL0rFwLm/jbrEsvzy+fCIv3LwLLy9nAxQ0XzC2aAl8fiAtaD/A5nAL4RDzROoIQGCBSqwMWu12M9OdPbzhSwoEaCFN4e+bLoRaGghCTd8N3bUolWuc6HMjhZWiUsZXcPMxdUPMqtdVKXyy1v7QJfSuE+5G486hJnGAKcX9OMd504v4q/Ho5tzWRy5vNjDCsw3JiqxsGrPBevpebP1xX3XRCrcIA3gvUYRBneNk/4DyrsDhfr3m1oUS3HJNqvuyDHKEBo4tfFQanEYKA2R/V0zOTfQ17rBDCWd90p5g87zgZyo/kx3wHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IGKYovP8; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IGKYovP8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Nc64Qjfz3bNr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 03:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823495; x=1823359495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WnF2LcPe+BX0udTur3Cx28pCXm0q4+ySCCvp8OhOA8=;
  b=IGKYovP89GJv47nlXJdWS9dQ9WKJwYQgjJs/8juQ6XyA4cq5N8UFe2Mk
   Cx9KrBNlm1erolXkcdaYveuw1WrnUiofVVcyFRhQdMER6ECoHvQba3390
   +QhHwo1gCwaohSv4Xma7NzstZMiVDR5ajbG+NxZDeevRMfvGYX3ncsXXW
   kdDKfS7TpZX6LVnTKJYnDdSr1iz6PsB6O5pFDECZ7W4GNQT37a27cemMH
   XpA449UUqVaLjHfP0u7GeiqVHoSujvMtSTLhn7qkzx2pxSOpQ4dFI7JNq
   icI+0M4J3NMU6VTxz9DgGhVxSR1tYV1PwSopUjseL0tRxaQao4sXD1SHP
   Q==;
X-CSE-ConnectionGUID: +aqvyJRRQBybv2RQMBpYbg==
X-CSE-MsgGUID: t/GPfrqyQBeWGGk3g7Yr7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="410120"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="410120"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:49 -0700
X-CSE-ConnectionGUID: vhZGQmn9QK+epfpr3mHmLw==
X-CSE-MsgGUID: KuSlHFXnRRqAT1hwMApLew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1004944"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:47 -0700
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
	maciej.lawniczak@intel.com
Subject: [PATCH v2 2/3] ARM: dts: aspeed: add Intel AVCRP BMC
Date: Mon, 12 Oct 2026 19:39:06 +0200
Message-ID: <12f8124fea31a6c6b1401d6aee640842c8d896a7.1791825961.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791825961.git.dawid.glazik@linux.intel.com>
References: <cover.1791825961.git.dawid.glazik@linux.intel.com>
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
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add the initial AST2600 device tree for the Intel AVCRP BMC platform.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
v2:
 - Replace bootargs console=ttyS4,115200n8 with stdout-path = &uart5
 - Remove the unreferenced video_memory reserved-memory node
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 315 ++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 767f7c7652d5..ea4645ef9872 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-rainier-4u.dtb \
 	aspeed-bmc-ibm-sbp1.dtb \
 	aspeed-bmc-ibm-system1.dtb \
+	aspeed-bmc-intel-avcrp.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
new file mode 100644
index 000000000000..7c088c89d417
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2026 Intel Corporation
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Intel AVCRP BMC";
+	compatible = "intel,avcrp-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "earlycon";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>; /* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&mdio1 {
+	status = "okay";
+
+	ethphy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0>;
+		reset-gpios = <&gpio0 ASPEED_GPIO(C, 1) GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <50000>;
+	};
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>,
+		 <&syscon ASPEED_CLK_MAC2RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+};
+
+&lpc {
+	lpc_snoop: lpc-snoop@80 {
+		snoop-ports = <0x80>;
+		status = "okay";
+	};
+};
+
+&i3c_global {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&gpio0 {
+	gpio-line-names =
+		/*A0-A7*/ "", "", "", "", "SMB_CPU_PIROM_SCL", "SMB_CPU_PIROM_SDA",
+				"SMB_IPMB_STBY_LVC3_SCL", "SMB_IPMB_STBY_LVC3_SDA",
+		/*B0-B7*/ "", "", "", "FM_CPU1_ERR2_LVT3_N",
+				"RGMII_BMC_RMM4_LVC3_R_MDC", "RGMII_BMC_RMM4_LVC3_R_MDIO",
+				"FM_BMC_BMCINIT_R", "FP_ID_LED_N",
+		/*C0-C7*/ "FM_FORCE_BMC_UPDATE_N", "RST_RGMII_PHYRST_N",
+				"FM_TPM_EN_PULSE", "", "", "",
+				"FM_CPU1_ERR0_LVT3_N", "FM_CPU1_ERR1_LVT3_N",
+		/*D0-D7*/ "CPU_ERR0", "CPU_ERR1", "CPU_ERR2", "PRDY_N",
+				"FM_SPD_SWITCH_CTRL_N", "", "", "",
+		/*E0-E7*/ "FM_SKT1_FAULT_LED", "FM_SKT0_FAULT_LED",
+				"CLK_50M_CKMNG_BMCB", "ID_BUTTON", "", "", "", "",
+		/*F0-F7*/ "", "FM_DUAL_PARTITION_MODE_N",
+				"FM_STANDALONE_MODE_N", "FM_4S_8S_N_MODE",
+				"FM_NODE_ID0", "FM_NODE_ID1", "", "",
+		/*G0-G7*/ "FM_SMB_BMC_NVME_LVC3_ALERT_N", "RST_BMC_HSBP_MUX_N",
+				"FP_LED_STATUS_GREEN_N", "FP_LED_STATUS_AMBER_N",
+				"PS_PWROK", "FM_PARTITION_SEL",
+				"FM_BMC_CPU_FBRK_OUT_R_N", "DBP_PRESENT_IN_R2_N",
+		/*H0-H7*/ "SGPIO_BMC_CLK_R", "SGPIO_BMC_LD_R",
+				"SGPIO_BMC_DOUT_R", "SGPIO_BMC_DIN",
+				"PLTRST_N", "CPU_CATERR", "", "",
+		/*I0-I7*/ "", "JTAG_ASD_TDI_R", "JTAG_ASD_TCK_R", "JTAG_ASD_TMS_R",
+				"JTAG_ASD_TDO", "FM_BMC_PWRBTN_OUT_R_N",
+				"FM_BMC_PWR_BTN_N", "",
+		/*J0-J7*/ "", "", "", "", "", "", "", "",
+		/*K0-K7*/ "", "", "", "", "", "", "", "",
+		/*L0-L7*/ "", "", "", "", "PREQ_N", "TCK_MUX_SEL", "", "",
+		/*M0-M7*/ "", "", "", "", "", "", "SPA_SOUT", "SPA_SIN",
+		/*N0-N7*/ "", "", "", "", "", "", "SPB_SOUT", "SPB_SIN",
+		/*O0-O7*/ "", "", "", "", "", "", "NMI_BUTTON", "SPEAKER_BMC_R",
+		/*P0-P7*/ "RESET_BUTTON", "RESET_OUT", "POWER_BUTTON", "POWER_OUT",
+				"", "", "", "LED_BMC_HB_LED_N",
+		/*Q0-Q7*/ "", "", "", "", "", "", "", "",
+		/*R0-R7*/ "", "", "", "", "", "", "", "",
+		/*S0-S7*/ "RST_BMC_PCIE_MUX_N", "FM_BMC_TRUST_N",
+				"FM_BMC_FRU_WP_N", "", "PWRGD_CPU0_AUXPWRGD",
+				"A_P3V_BAT_SCALED_EN", "REMOTE_DEBUG_ENABLE", "",
+		/*T0-T7*/ "", "", "", "", "", "", "", "",
+		/*U0-U7*/ "", "", "", "", "", "", "", "",
+		/*V0-V7*/ "SIO_S3", "SIO_S5", "", "SIO_ONCONTROL",
+				"SIO_POWER_GOOD", "", "", "",
+		/*W0-W7*/ "LPC_LAD0_ESPI_R_IO0", "LPC_LAD1_ESPI_R_IO1",
+				"LPC_LAD2_ESPI_R_IO2", "LPC_LAD3_ESPI_R_IO3",
+				"CLK_24M_66M_LPC0_ESPI_BMC", "LPC_LFRAME_N_ESPI_CS0_BMC_N",
+				"IRQ_LPC_SERIRQ_ESPI_ALERT_N", "RST_LPC_LRST_ESPI_RST_BMC_R_N",
+		/*X0-X7*/ "", "", "PCH_BMC_THERMTRIP", "", "", "", "", "",
+		/*Y0-Y7*/ "FM_BMC_CMOS_CLR_R_N", "", "FM_BMC_SAFS_EN",
+				"IRQ_SML1_PMBUS_BMC_ALERT_N", "SPI_BMC_BOOT_R_IO2",
+				"SPI_BMC_BOOT_R_IO3", "PU_SPI_BMC_BOOT_ABR",
+				"PU_SPI_BMC_BOOT_WP_N",
+		/*Z0-Z7*/ "", "", "", "HW_STRAP_5", "HW_STRAP_6", "HW_STRAP_7",
+				"HW_STRAP_2", "HW_STRAP_3";
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	status = "okay";
+	gpio-line-names =
+		/*A, 0-7*/ "CPU1_PRESENCE", "", "CPU1_THERMTRIP", "",
+				"CPU1_VRHOT", "", "H_CPU0_MON_FAIL_LVC1_N", "",
+				"CPU1_MEM_VRHOT", "", "CPU1_MEM_THERM_EVENT", "",
+				"FM_CPU0_PROC_ID0", "", "FM_CPU0_PROC_ID1", "",
+		/*B, 8-15*/ "CPU1_MISMATCH", "LED_CPU1_CH1_DIMM1_FAULT", "",
+				"LED_CPU1_CH1_DIMM2_FAULT", "CPU2_PRESENCE",
+				"LED_CPU1_CH2_DIMM1_FAULT", "CPU2_THERMTRIP",
+				"LED_CPU1_CH2_DIMM2_FAULT", "CPU2_VRHOT",
+				"LED_CPU1_CH3_DIMM1_FAULT", "H_CPU1_MON_FAIL_LVC1_N",
+				"LED_CPU1_CH3_DIMM2_FAULT", "CPU2_MEM_VRHOT",
+				"LED_CPU1_CH4_DIMM1_FAULT", "CPU2_MEM_THERM_EVENT",
+				"LED_CPU1_CH4_DIMM2_FAULT",
+		/*C, 16-23*/ "FM_CPU1_PROC_ID0", "LED_CPU1_CH5_DIMM1_FAULT",
+				"FM_CPU1_PROC_ID1", "LED_CPU1_CH5_DIMM2_FAULT",
+				"CPU2_MISMATCH", "LED_CPU1_CH6_DIMM1_FAULT", "",
+				"LED_CPU1_CH6_DIMM2_FAULT", "", "LED_FAN1_FAULT", "",
+				"LED_FAN2_FAULT", "", "LED_FAN3_FAULT", "",
+				"LED_FAN4_FAULT",
+		/*D, 24-31*/ "", "LED_FAN5_FAULT", "", "LED_FAN6_FAULT", "",
+				"LED_FAN7_FAULT", "", "LED_FAN8_FAULT", "",
+				"LED_CPU2_CH1_DIMM1_FAULT", "", "LED_CPU2_CH1_DIMM2_FAULT",
+				"", "LED_CPU2_CH2_DIMM1_FAULT", "",
+				"LED_CPU2_CH2_DIMM2_FAULT",
+		/*E, 32-39*/ "", "LED_CPU2_CH3_DIMM1_FAULT", "",
+				"LED_CPU2_CH3_DIMM2_FAULT", "", "LED_CPU2_CH4_DIMM1_FAULT",
+				"", "LED_CPU2_CH4_DIMM2_FAULT", "",
+				"LED_CPU2_CH5_DIMM1_FAULT", "", "LED_CPU2_CH5_DIMM2_FAULT",
+				"", "LED_CPU2_CH6_DIMM1_FAULT", "CPU1_CPLD_CRC_ERROR",
+				"LED_CPU2_CH6_DIMM2_FAULT",
+		/*F, 40-47*/ "CPU2_CPLD_CRC_ERROR", "", "CPU1_CATERR_IERR", "",
+				"CPU1_CATERR_MCERR", "", "CPU2_CATERR_IERR", "",
+				"CPU2_CATERR_MCERR", "", "", "", "", "", "", "",
+		/*G, 48-55*/ "MAIN_PLD_MINOR_REV_BIT0", "", "MAIN_PLD_MINOR_REV_BIT1", "",
+				"MAIN_PLD_MINOR_REV_BIT2", "", "MAIN_PLD_MINOR_REV_BIT3", "",
+				"MAIN_PLD_MAJOR_REV_BIT0", "", "MAIN_PLD_MAJOR_REV_BIT1", "",
+				"MAIN_PLD_MAJOR_REV_BIT2", "", "MAIN_PLD_MAJOR_REV_BIT3", "",
+		/*H, 56-63*/ "", "", "WMEMX_PWR_FLT", "", "WCPUX_MEM_PWR_FLT", "",
+				"PWRGD_P3V3_FF", "", "WPSU_PWR_FLT", "", "", "",
+				"", "", "WPCH_PWR_FLT", "",
+		/*I, 64-71*/ "FM_CPU0_PKGID0", "LED_CPU1_CH7_DIMM1_FAULT",
+				"FM_CPU0_PKGID1", "LED_CPU1_CH7_DIMM2_FAULT",
+				"FM_CPU0_PKGID2", "LED_CPU1_CH8_DIMM1_FAULT",
+				"H_CPU0_MEMTRIP_LVC1_N", "LED_CPU1_CH8_DIMM2_FAULT",
+				"FM_CPU1_PKGID0", "LED_CPU2_CH7_DIMM1_FAULT",
+				"FM_CPU1_PKGID1", "LED_CPU2_CH7_DIMM2_FAULT",
+				"FM_CPU1_PKGID2", "LED_CPU2_CH8_DIMM1_FAULT",
+				"H_CPU1_MEMTRIP_LVC1_N", "LED_CPU2_CH8_DIMM2_FAULT",
+		/*J, 72-79*/ "", "", "", "", "", "", "", "",
+				"", "", "", "", "", "", "", "",
+		/*K, 80-87*/ "FM_BOARD_REV_ID0", "LED_CPU0_CH9_DIMM1_FAULT",
+				"FM_BOARD_REV_ID1", "LED_CPU0_CH9_DIMM2_FAULT",
+				"FM_BOARD_REV_ID2", "LED_CPU0_CH10_DIMM1_FAULT",
+				"FM_BOARD_SKU_ID0", "LED_CPU0_CH10_DIMM2_FAULT",
+				"FM_BOARD_SKU_ID1", "LED_CPU0_CH11_DIMM1_FAULT",
+				"FM_BOARD_SKU_ID2", "LED_CPU0_CH11_DIMM2_FAULT",
+				"FM_BOARD_SKU_ID3", "LED_CPU0_CH12_DIMM1_FAULT",
+				"FM_BOARD_SKU_ID4", "LED_CPU0_CH12_DIMM2_FAULT",
+		/*L, 88-95*/ "FM_BOARD_SKU_ID5", "LED_CPU1_CH9_DIMM1_FAULT",
+				"FM_BMC_VAL_EN", "LED_CPU1_CH9_DIMM2_FAULT",
+				"FM_SERIAL_BOOT", "LED_CPU1_CH10_DIMM1_FAULT", "",
+				"LED_CPU1_CH10_DIMM2_FAULT", "S0_PWROK",
+				"LED_CPU1_CH11_DIMM1_FAULT", "", "LED_CPU1_CH11_DIMM2_FAULT",
+				"", "LED_CPU1_CH12_DIMM1_FAULT", "",
+				"LED_CPU1_CH12_DIMM2_FAULT",
+		/*M, 96-103*/ "", "FM_SURPRISE_RESET_N", "",
+				"FM_CPU1_INTR_CLK_CONFDONE_N", "", "FM_GLOBAL_RESET_N",
+				"FM_1200VA_OC", "BMC_BOOT_DONE", "", "IRQ_BMC_CPU_NMI_P0",
+				"", "IRQ_BMC_CPU_NMI_P1", "", "", "", "",
+		/*N, 104-111*/ "", "", "", "", "", "", "", "",
+				"", "", "", "", "", "", "", "",
+		/*O, 112-119*/ "R1S_PRESENCE", "", "", "", "", "", "", "",
+				"", "", "", "", "", "", "", "",
+		/*P, 120-127*/ "", "", "", "", "", "", "", "",
+				"", "", "", "", "", "", "", "";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xCA2>;
+	status = "okay";
+};
+
+&i3c2 {
+	status = "okay";
+	i2c-scl-hz = <400000>;
+	mctp-controller;
+};
+
+&i2c5 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c6 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c7 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c8 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c9 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c13 {
+	multi-master;
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
-- 
2.43.0


