Return-Path: <linux-aspeed+bounces-4916-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE16C624D7
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:16:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNYw0Tb0z2xLd;
	Wed, 02 Sep 2026 10:16:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264948;
	cv=none; b=LpzMOvzcXdwH1Dlmd+FV8lzFbJT/X9afBMbyBtadopUUBqo0aazNhjVzn9s5Jp3JjpTPj5DL7gd64c4Yn8hJxFLEee/PfxDOvc8zsNHtiOz8hQ5huTPPDeklxnIPRmCPtJmqGdDEcjuNRhoq+3gSRaJe0Eno5m/jTDPSN13DWSUk+2+x2/OPtoEGGrZ3I34UpB8lqZNCNUZTWvKajoXt8YpjRNETXOTrg2So7RRrYzRs33lSwKrVHPicRedkUna6brEhLPKE6NlypBUwmzC7SJ40/xu6EV4P43zOa0uL6asr00gspIYrJeod12zGkmI/G8Z6O4Np7W+TC/QozrZ7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264948; c=relaxed/relaxed;
	bh=4LP3veYPqKg+gKjk0eGaSfANcwccnpGVN0j49w1Uld4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anEH+tSO1Y8ms45fjJ0bErus7KmfkO1GTa681kv3mS1X03gAEwi9VtXvDfA7ypbhKCVuYkbHPKZh/sylqiNTQ6ayetz8KX9nUyGqjVo+3za7OFxdgjgdQbJqlg6xNYZnTvuy2AsNgyB0n4yQVbBhcDvmEK29kDCiXh0uSrnTZrxih/KYb0JIZYE3NiqSZoIlc3eqQWWtPxddcH98W4vaS/blBeSUEWvwpG9gevZR/poWnOjpWQTSe8lQc3tfwkrNl4G/Pnu4+tWa9DHUlrVpRNoOiUlf7Xt/icK00AbJFP5kgPncEHCDbdPCCLHGzAk84VBKdxuER6L/f54kNYMnrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ni6PS6i/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ni6PS6i/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZV1Jtzz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29BE360A65;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9E51C2BD01;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264942;
	bh=4nypNrniWp3eqve1zmIIKA6gIOeb5bFs/UeSEdf9lmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ni6PS6i/x0YAn6pGKtP+PrsAkzhjnmBoWaivs9SPmNGTqPkwKkyi/HaON61Np0/kP
	 6p92cT68bPO2Id/P55vCMlHJEb8hQU2iTBI7hFmej46MiiJaQ8qKmEI/DU3c4ql/m1
	 du0uen3zUO7XwoIjsGqv+5aNMjkKQ//5D2rtd/LpxDXPVd6uzA3eQn44uNWLWpafXZ
	 E1eppcIx41qSr4hzlJw5lcKnhvC0zWtcUJ3HwpBMkWqab2PWT5njG6q7YSc+AgnKs8
	 nkoWcDUe1i8c2zGG96GtTTw8zoo15ckUMfLjMo8F/DUAi50hKlWpYxNlUCdVBw6Bfz
	 Hej4TqTCOX2mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB1C624C6;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 20:15:18 +0800
Subject: [PATCH v7 03/11] ARM: dts: aspeed: anacapa: Add DVT devicetree
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
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-3-0bd71d2e0105@gmail.com>
References: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
In-Reply-To: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264931; l=5821;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=4ml06jQJiEoobNrMMJWAbP3q4PdFYbQCxhC+nrzCsp0=;
 b=l4orMrcYTYcJUWkwFxGxw+5SQay2/8wiQP13juW+Fw5Si5+o8l1ParayozHz2jJP/ryP+tYwK
 dEvkHwXbOpUCV5hJSAoM+SQroZP6e+KZctW6ujBh5nZ9Yqz+bR8gAEP
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
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 168 +++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     |   2 +-
 2 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
new file mode 100644
index 000000000000..6650a5e4e130
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
+
+&sgpiom0 {
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
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index af90a04235a0..640e31a199ce 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,3 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
+#include "aspeed-bmc-facebook-anacapa-dvt.dtsi"

-- 
2.34.1



