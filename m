Return-Path: <linux-aspeed+bounces-4159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A1CD6E57
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVS9x4RTwz2ySS;
	Wed, 03 Jun 2026 09:45:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780406711;
	cv=none; b=nyNMLheQmrkhmRHiBl62JmqisvQG6hw2adaU5JuGCkyNhwDYuZV6R5mWmABPXtnrYzKAr8xnkRi1geeBF2HN1AvMabGlgsNAPco5gIObyZ/VfH4yYSZwt6tTOsZsSE8nTyFvYQwvgbOcZnTlbn70vZ4RZc+zMuntzTF30MA5grQkcyZbKEE8a1m20fJOqv1WIAf0tBmbp49JA8eoOpdsRvHhseXD3RQyU2OWph2AwySSA4LK4nFAPR6qP5Xue6mAQOhimzpSrvVUI1prfyACFjnzyEhALRZ1SNetGd/5yBT07ryWSI7R5r3Edcu5PgughbNN4a5FO0FEWcxrZA59iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780406711; c=relaxed/relaxed;
	bh=6WBdBakXihmY/GJUxoEkzfwKpzjkYRjehER8DzO1pXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0K4aVMfhMrvDlLQW8fuB/3z20oTJX5hm/ySAlc3HKLsHb01kwCIXusJfRGxkRrYWT2fnZMen3fRMBc/qrMPUYqGBAMsKGGR1HMEkvRi3eioqknZ3q2Od8HNKy3bW8uSuLL1yZl0LjmT3WuzkmjBS7R3t/cPsT3+kYIc8IVBwazIUXJIiqVA1sPmtNrLFL09SQioW+uIYeOKod5eIU1OP+gq/jwkWe+NomwhBoUn1uP3xFkaSANwdxZax2ufw2dbI3G3muNjghqfmOwItpvn6PWi2EL3kLCCFKwGJAw2crZbp1vy7vIjJplPmGYTnxpm5FKDmX2ysaAOAAyu554YhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t/3oS2bQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t/3oS2bQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVBQW6vYsz2yb9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 23:25:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 159E860145;
	Tue,  2 Jun 2026 13:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5396C2BCFB;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780406704;
	bh=llREHz/Ut+hQdQkpSFZF+fPnWztP0SkUaAfxensGHXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t/3oS2bQx3Qz26Thsr/oNR+z61x6rh+qLmSTro0K53zRp7/n8hrdRKUQqEPU4svVb
	 nds41hXlAPfk+84WupbouTNmJl/DYEJE24eyBMs6458SBKFpJPSDNE/nuX4MEwuFAx
	 /jQWQ6V0V7ecPCvm72xyDmThLqrXc3btbQzLx78CoROKKV/ZOtVVzdoKfBt3Em6Roc
	 AjCqMPrkiw8IlfiNmIBwvC1GVY5SDPuFWoARvB1rsp4Ki8XEWQc47whVxRQLQe0ybq
	 xo2yxVUjFbChqROYg2WT2WsOqlg6ZMWnQL3MHuutv8LZ+GXCogG8jeevDX1P/O6VAd
	 ww4GIY9vCY7Yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27FCD6E4A;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 02 Jun 2026 21:24:59 +0800
Subject: [PATCH v3 4/9] ARM: dts: aspeed: anacapa: add DVT devicetree
 inheriting EVT2
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
Message-Id: <20260602-anacapa-devlop-phase-devicetree-v3-4-7c93c5df8d9b@gmail.com>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780406700; l=6004;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=4qBFnetVkREYSIu12suaMhNwE7VlH8Jb8tWdL8ayTVM=;
 b=y4Ut/IWY6TCuDjo7AuJdNB+H+w0A5uQ76yXjqgGzhKx/3Z5t0AUeRAdSgmqT/6/n8cZCkFlg/
 i6gB8BSAipBDWZO9jDbsxjd2HnP8/VWplsQB55e35O1/YC9YusoHiPg
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Add a development-phase devicetree for the Facebook Anacapa BMC DVT
hardware revision and update the Anacapa wrapper DTS to reference
it.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts | 178 +++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     |   2 +-
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
new file mode 100644
index 000000000000..0eb547ad0ec1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-bmc-facebook-anacapa-evt2.dts"
+
+/ {
+	model = "Facebook Anacapa BMC";
+	compatible = "facebook,anacapa-bmc-dvt", "aspeed,ast2600";
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out */
+	/* A0-A7 line 0-15 */
+	"L_FNIC_FLT", "FM_CPU0_SYS_RESET_N",
+	"L_BNIC0_FLT", "CPU0_KBRST_N",
+	"L_BNIC1_FLT", "FM_CPU0_PROCHOT_trigger_N",
+	"L_BNIC2_FLT", "FM_CLR_CMOS_R_P0",
+	"L_BNIC3_FLT", "Force_I3C_SEL",
+	"L_RTM_SW_FLT", "SYSTEM_Force_Run_AC_Cycle",
+	"", "",
+	"", "",
+
+	/* B0-B7 line 16-31 */
+	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel5_leakage_present_EAM1", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
+	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
+	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
+
+	/* C0-C7 line 32-47 */
+	"RSVD_RMC_GPIO3", "RTM_MUX_L",
+	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
+	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
+	"Channel6_leakage_present_CPU_DIMM", "whdt_sel",
+	"R_EAM0_NIC_CBL_PRSNT_L", "JTAG_CPLD_TRST_R_N",
+	"R_EAM1_NIC_CBL_PRSNT_L", "",
+	"L_EAM0_NIC_CBL_PRSNT_L", "",
+	"L_EAM1_NIC_CBL_PRSNT_L", "",
+
+	/* D0-D7 line 48-63 */
+	"Channel0_leakage_present_EAM3", "",
+	"Channel1_leakage_present_EAM0", "",
+	"Channel2_leakage_present_Manifold1", "",
+	"Channel4_leakage_present_Manifold2", "",
+	"AMC_BRD_PRSNT_CPLD_L", "",
+	"Channel7_leakage_present_EAM2", "",
+	"", "",
+	"", "",
+
+	/* E0-E7 line 64-79 */
+	"L_PRSNT_B_FENIC_R2_N", "",
+	"L_PRSNT_B_BENIC0_R2_N", "",
+	"L_PRSNT_B_BENIC1_R2_N", "",
+	"L_PRSNT_B_BENIC2_R2_N", "",
+	"L_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
+
+	/* F0-F7 line 80-95 */
+	"R_PRSNT_B_FENIC_R2_N", "SGPIO_READY",
+	"R_PRSNT_B_BENIC0_R2_N", "",
+	"R_PRSNT_B_BENIC1_R2_N", "",
+	"R_PRSNT_B_BENIC2_R2_N", "",
+	"R_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
+
+	/* G0-G7 line 96-111 */
+	"L_PRSNT_EDSFF0_N", "",
+	"L_PRSNT_EDSFF1_N", "",
+	"R_PRSNT_EDSFF2_N", "",
+	"R_PRSNT_EDSFF3_N", "",
+	"HPM_EDSFF_PG", "",
+	"", "",
+	"P12V_PWR_CABLE_PRSNT_L_R", "FM_BMC_READY_PLD",
+	"PRSNT_NFC_BOARD_R", "",
+
+	/* H0-H7 line 112-127 */
+	"R_FNIC_FLT", "",
+	"R_BNIC0_FLT", "",
+	"R_BNIC1_FLT", "",
+	"R_BNIC2_FLT", "",
+	"R_BNIC3_FLT", "",
+	"R_RTM_SW_FLT", "",
+	"RBB_Cable_Present", "",
+	"LBB_Cable_Present", "",
+
+	/* I0-I7 line 128-143 */
+	"EAM0_BRD_PRSNT_R_L", "",
+	"EAM1_BRD_PRSNT_R_L", "",
+	"EAM2_BRD_PRSNT_R_L", "",
+	"EAM3_BRD_PRSNT_R_L", "",
+	"FM_TPM_PRSNT_R_N", "",
+	"PDB_L_PRSNT_R_N", "",
+	"PRSNT_EDSFF_BOOT_N", "",
+	"PRSNT_CPU0_N", "",
+
+	/* J0-J7 line 144-159 */
+	"PRSNT_L_BRIDGE_R", "",
+	"PRSNT_R_BRIDGE_R", "",
+	"BRIDGE_L_MAIN_PG_R", "",
+	"BRIDGE_R_MAIN_PG_R", "",
+	"BRIDGE_L_STBY_PG_R", "",
+	"BRIDGE_R_STBY_PG_R", "",
+	"IRQ_NFC_BOARD_R", "",
+	"RSMRST_N", "",
+
+	/* K0-K7 line 160-175 */
+	"ADC_I2C_ALERT_N", "",
+	"TEMP_I2C_ALERT_R_L", "",
+	"CPU0_VR_SMB_ALERT_CPLD_N", "",
+	"COVER_INTRUDER_R_N", "",
+	"HANDLE_INTRUDER_CPLD_N", "",
+	"IRQ_MCIO_CPLD_WAKE_R_N", "",
+	"APML_CPU0_ALERT_R_N", "",
+	"PDB_ALERT_R_N", "",
+
+	/* L0-L7 line 176-191 */
+	"L_EDSFF0_PG", "",
+	"L_EDSFF1_PG", "",
+	"R_EDSFF2_PG", "",
+	"R_EDSFF3_PG", "",
+	"HPM_CPLD_HEART_BIT", "",
+	"RBB_CPLD_HEART_BIT", "",
+	"LBB_CPLD_HEART_BIT", "",
+	"FM_BIOS_POST_CMPLT_R_N", "",
+
+	/* M0-M7 line 192-207 */
+	"EAM0_SMERR_CPLD_R_L", "",
+	"EAM1_SMERR_CPLD_R_L", "",
+	"EAM2_SMERR_CPLD_R_L", "",
+	"EAM3_SMERR_CPLD_R_L", "",
+	"CPU0_SMERR_N_R", "",
+	"CPU0_NV_SAVE_N_R", "",
+	"PDB_PWR_LOSS_CPLD_N", "",
+	"IRQ_BMC_SMI_ACTIVE_R_N", "",
+
+	/* N0-N7 line 208-223 */
+	"AMCROT_BMC_S5_RDY_R", "",
+	"AMC_RDY_R", "",
+	"AMC_STBY_PGOOD_R", "",
+	"CPU_AMC_SLP_S5_R_L", "",
+	"AMC_CPU_EAMPG_R", "",
+	"DIMM_PMIC_PG_TIMEOUT", "",
+	"EAM_MOD_PWR_GD_TIMEOUT", "",
+	"CPLD_AMC_STBY_PWR_EN", "",
+
+	/* O0-O7 line 224-239 */
+	"HPM_PWR_FAIL", "Port80_b0",
+	"FM_DIMM_IP_FAIL", "Port80_b1",
+	"FM_DIMM_AH_FAIL", "Port80_b2",
+	"AMC_THERMTRIP_ASSERT", "Port80_b3",
+	"CPU_THERMTRIP_ASSERT", "Port80_b4",
+	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
+	"CPLD_SGPIO_RDY", "Port80_b6",
+	"FM_MAIN_PWREN_RMC_EN_ISO", "Port80_b7",
+
+	/* P0-P7 line 240-255 */
+	"CPU0_SLP_S5_N_R", "NFC_VEN",
+	"CPU0_SLP_S3_N_R", "",
+	"FM_CPU0_PWRGD", "",
+	"PWRGD_RMC", "",
+	"FM_RST_CPU0_RESET_N", "RBB_CPLD_RISCV_RST",
+	"FM_PWRGD_CPU0_PWROK", "LBB_CPLD_RISCV_RST",
+	"AMC_FAIL", "HPM_CPLD_RISCV_RST",
+	"S0_ON", "";
+
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 1848ca347621..c74b211c42e6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,4 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include "aspeed-bmc-facebook-anacapa-evt2.dts"
+#include "aspeed-bmc-facebook-anacapa-dvt.dts"
 

-- 
2.34.1



