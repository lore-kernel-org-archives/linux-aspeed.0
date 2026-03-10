Return-Path: <linux-aspeed+bounces-3636-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903A3FD88CC
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Mar 2026 23:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVqBg6fT4z3bmM;
	Wed, 11 Mar 2026 10:01:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136194;
	cv=none; b=W/sSD+jkssojNCScGAcyYJbJs2LG3vI2u//r1qw3elv8k4n4IVBPe6+WQLjLqApKfLEYVhQNBXfq9juq2xm4TzZ0iz7jIndUunFdptpJrAucD3cCpTnwsuyTzbGGrspuEQc2WbFySC+Z6/gK9ZfK6ijIiidAlFr/NVWwHobgdwvtEPIsKnemyBLumV0wRRS+mDkckKJruiJtei9kIuzKxd2+o9shZFpsCCw995bP4Ms9FzbJCn1vNy5Lq6CCSLSCA9nd9KMPYPf6vbz/040cJnLriQAScgmx4OrWMVvI+Qqx7F2XVjwICiU7pdKgJ7sG0ENENQHdXYDQHwOo5L1Klg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136194; c=relaxed/relaxed;
	bh=JRV4bgMFvwTiPj1crtu8ZWYHwIXJvbIRCeZGSRG6JB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6BZ1O/g1L0KtWV6gnLF8Tvg8V1t7/+hKOZ6qgoEiS1f7OAwy5JJNrn+XOUvdnXft6M2gLAomAwzWAh7AX2C7vVy90WQ+5cTJFCwUkEhqOrXWFEy8fy3iagSe9a8/y9rKS+ouLa9Qox1Vus9SWnaK65XdKH1wAtMqJRiyYAX9w9LvFhxKAfPutM9XLx/AC5UDNbNzWp1n6KDVhJCdjPNsq579yEmmdBPz0q5CsiJbmh6iCI9P7F7G043LMvlp/NBWd2MXQEYR99xb/oPuSsNq/wBobvmlImFW/b+myaD2F+hvC4sJXJTvADaVZ8m55Abmh7NnCALxIBlIQw1+S5gtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QuC15FXy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QuC15FXy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTcy2n1mz3cBG
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 20:49:54 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ad617d5b80so85211545ad.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136193; x=1773740993; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRV4bgMFvwTiPj1crtu8ZWYHwIXJvbIRCeZGSRG6JB8=;
        b=QuC15FXy+Jyy04QiXo3A5qx2vn8IXh9T3WtQCJD0/4q4BFB9uGdF0HN3Bdh/jJb+9s
         H9qas2wIQHz+K95i1wKD3DhNEvxWzdfj2TsoS8c/pjIdDMLH8X9qzbm/717/tFoVGLzV
         FVDrnfZ6CnfGqPsspI27GZNQVTuoWMD4xOlFEXGLNp4Ae41xh34vlEl2odBcFDG1NTL2
         602Lr3CvJ90XB1YcfGL/Getr9URU8cwiS8tQpzzneGBj4UriLfpX30km/IfBYH3dkR8t
         FkhIHQ/75JS0klDcDkfrGcPJRQFkzdND2bQsSW2KVe0i0Gh84D7xVFxIdlgCcfRnSjc5
         jbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136193; x=1773740993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JRV4bgMFvwTiPj1crtu8ZWYHwIXJvbIRCeZGSRG6JB8=;
        b=T69GPYyw5daFxEAgxSTAwthUNdk1sYTDFzxA+i94XgYr7VwSI7DLmNCMNZRJKaXeRe
         f/9zSHVFQKy5/MW6zI0MSsaCj73BtF8vNej/zPHTAbovcycWSQaLrmj93sNpsTy9F7fN
         XLdqpy20r2T4yYVy22qZunqVFxfFSHpNt/0J5CoitaaZPYR1jA9YgHpG1QdqVXfdBsXP
         U7BqYPiT0SAOSCleiW2FHBpXS/quFzNIeR7vVKcXGCgiD9dBT0tCMZS3NZFBWx4nYtww
         le5ZPRDAS5reue47UnnP3xCEUZK7sd0quYXUAKDaGQ3NX/k0jF+YHG8McE95atF8D6mN
         Snew==
X-Forwarded-Encrypted: i=1; AJvYcCW2hx1oHo6qehOrwsQfTDHIhmnqMBNfm2mfKRK0mzoo4/jiB7tPc2wdeI3UyV4HRkw0gjMwKXiUmX0BTq4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzuSqNDu7WpZVOXK6I6HndG0O1yIpTnFsFRJO6RLJg7BDJ8lxL
	ZpzHLd0DRqGuVW+t221HvVkdFQpI5IRs7agHoF8STKudBHLdBVODabHg
X-Gm-Gg: ATEYQzxv70UkIgxVcf8TD+R8yakNXFkPaKWShUAd+Jk1+UCjB2s7yfBJB5duFjuHUXy
	0YMz6HeIM130nWbT3JwNKZTwht7d/2ZKnoseUxzzkkSFo1AThJU+KzmCYxVrLacHymTuYmswGJ4
	yNKW9I2XDk3hbG3JdRhHwLelXT0/hfKO8ygQuTOhAgkmjdF7lc6Ndsy6yvQBnnJxFKr8TfP0mL2
	KefUBpPo8eUNq7FJq4Vxnm2fn0OXJsd3L3f10g3cFLkRmdG1r6awpjYMjCCAu5u9EIZFgfnqbP1
	ngR4R1LlpAmo720Vi3z8AAQwRicflmlZbcb+iKX3Kz6l8ftcR5vfTmgBCiV/k69cmy72lXMrhts
	0nzwxPaqBGlHBw+SqHDo1rCf48wLzVP+H8UnNfGifzNvWqfWHP7lIT4gw2rYXajdkmeR2mX7cV6
	HH0IGK0R8qXgnSss1RAcw=
X-Received: by 2002:a17:902:c946:b0:2ae:5655:b42 with SMTP id d9443c01a7336-2ae823ff2e7mr146847895ad.12.1773136192671;
        Tue, 10 Mar 2026 02:49:52 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm199459775ad.61.2026.03.10.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:49:52 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Tue, 10 Mar 2026 17:49:36 +0800
Subject: [PATCH v3 2/3] ARM: dts: aspeed: anacapa: update SGPIO mappings
 for DFT integration
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
Message-Id: <20260310-anacapa-dts-sgpio-v3-2-12d9b7f1202e@gmail.com>
References: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
In-Reply-To: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com, 
 Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773136185; l=6745;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=v/LRXhLIF0yd7V29cZg5G1XTEDL1TBrOYIcbE+/BVbc=;
 b=Hq0F8fihREKMsfW+ctFW+xs2hNYwsN7OOcZmVaIlEsBoYlO5juDIcQwMZ/v9oJIGcRZhngGVW
 pqliDEpcGmzAD40ZtczhMDbQLrQZbn9jlk8s0Xn5HTG69FTbLwU9vJR
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

Update SGPIOM0 GPIO line names and signal mappings to align with the
latest DFT (Design For Tooling) integration requirements.

This change reworks SGPIO input/output assignments, replaces legacy
or reserved placeholders, and updates signal naming to match the
definitions provided by the CPLD on 2026-03-03. The update improves
signal clarity and correctness across leakage detection, presence,
fault, power-good, and debug-related GPIOs.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 143 ++++++++++++---------
 1 file changed, 83 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 3e297abc5ba4..85b7e027daef 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -862,89 +862,106 @@ &sgpiom0 {
 	ngpios = <128>;
 	bus-frequency = <2000000>;
 	gpio-line-names =
-	/*in - out - in - out */
+	/*in - out */
 	/* A0-A7 line 0-15 */
-	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
-	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
-	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
-	"", "", "", "",
+	"L_FNIC_FLT", "FM_CPU0_SYS_RESET_N",
+	"L_BNIC0_FLT", "CPU0_KBRST_N",
+	"L_BNIC1_FLT", "FM_CPU0_PROCHOT_trigger_N",
+	"L_BNIC2_FLT", "FM_CLR_CMOS_R_P0",
+	"L_BNIC3_FLT", "Force_I3C_SEL",
+	"L_RTM_SW_FLT", "SYSTEM_Force_Run_AC_Cycle",
+	"", "",
+	"", "",
 
 	/* B0-B7 line 16-31 */
 	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
 	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
 	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
 	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "",
-	"Channel5_leakage_EAM1", "",
-	"Channel6_leakage_CPU_DIMM", "",
-	"Channel7_leakage_EAM2", "",
+	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
+	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
+	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
 
 	/* C0-C7 line 32-47 */
-	"RSVD_RMC_GPIO3", "", "LEAK_DETECT_RMC_N", "",
-	"", "", "", "",
-	"", "", "", "",
-	"", "", "", "",
+	"RSVD_RMC_GPIO3", "RTM_MUX_L",
+	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
+	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
+	"No_Leak_Sensor_flag", "whdt_sel",
+	"", "",
+	"", "",
+	"", "",
+	"", "",
 
 	/* D0-D7 line 48-63 */
-	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
-	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
-	"", "", "", "",
+	"PWRGD_CHAD_CPU0_FPGA", "",
+	"PWRGD_CHEH_CPU0_FPGA", "",
+	"PWRGD_CHIL_CPU0_FPGA", "",
+	"PWRGD_CHMP_CPU0_FPGA", "",
+	"AMC_BRD_PRSNT_CPLD_L", "",
+	"", "",
+	"", "",
+	"", "",
 
 	/* E0-E7 line 64-79 */
-	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
-	"", "", "", "",
-	"", "", "", "",
+	"L_PRSNT_B_FENIC_R2_N", "",
+	"L_PRSNT_B_BENIC0_R2_N", "",
+	"L_PRSNT_B_BENIC1_R2_N", "",
+	"L_PRSNT_B_BENIC2_R2_N", "",
+	"L_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
 
 	/* F0-F7 line 80-95 */
-	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
-	"PWRGD_PVDDCR_CPU0_P0", "",
-	"", "", "", "",
-	"", "", "", "",
+	"R_PRSNT_B_FENIC_R2_N", "SGPIO_READY",
+	"R_PRSNT_B_BENIC0_R2_N", "",
+	"R_PRSNT_B_BENIC1_R2_N", "",
+	"R_PRSNT_B_BENIC2_R2_N", "",
+	"R_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
 
 	/* G0-G7 line 96-111 */
-	"PWRGD_PVDDCR_SOC_P0", "",
-	"PWRGD_PVDDIO_P0", "",
-	"PWRGD_PVDDIO_MEM_S3_P0", "",
-	"PWRGD_CHMP_CPU0_FPGA", "",
-	"PWRGD_CHIL_CPU0_FPGA", "",
-	"PWRGD_CHEH_CPU0_FPGA", "",
-	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
+	"L_PRSNT_EDSFF2_N", "",
+	"L_PRSNT_EDSFF3_N", "",
+	"R_PRSNT_EDSFF2_N", "",
+	"R_PRSNT_EDSFF3_N", "",
+	"", "",
+	"", "",
 	"", "",
+	"PRSNT_NFC_BOARD_R", "",
 
 	/* H0-H7 line 112-127 */
-	"PWRGD_P3V3", "",
-	"P12V_DDR_IP_PWRGD_R", "",
-	"P12V_DDR_AH_PWRGD_R", "",
-	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
-	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
-	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
-	"PWRGD_PVDD18_S5_P0_PG", "",
-	"PWRGD_PVDD33_S5_P0_PG", "",
+	"R_FNIC_FLT", "",
+	"R_BNIC0_FLT", "",
+	"R_BNIC1_FLT", "",
+	"R_BNIC2_FLT", "",
+	"R_BNIC3_FLT", "",
+	"R_RTM_SW_FLT", "",
+	"", "",
+	"", "",
 
 	/* I0-I7 line 128-143 */
 	"EAM0_BRD_PRSNT_R_L", "",
 	"EAM1_BRD_PRSNT_R_L", "",
 	"EAM2_BRD_PRSNT_R_L", "",
 	"EAM3_BRD_PRSNT_R_L", "",
-	"EAM0_CPU_MOD_PWR_GD_R", "",
-	"EAM1_CPU_MOD_PWR_GD_R", "",
-	"EAM2_CPU_MOD_PWR_GD_R", "",
-	"EAM3_CPU_MOD_PWR_GD_R", "",
+	"FM_TPM_PRSNT_R_N", "",
+	"PDB_PRSNT_R_N", "",
+	"PRSNT_EDSFF0_N", "",
+	"PRSNT_CPU0_N", "",
 
 	/* J0-J7 line 144-159 */
-	"PRSNT_L_BIRDGE_R", "",
-	"PRSNT_R_BIRDGE_R", "",
+	"PRSNT_L_BRIDGE_R", "",
+	"PRSNT_R_BRIDGE_R", "",
 	"BRIDGE_L_MAIN_PG_R", "",
 	"BRIDGE_R_MAIN_PG_R", "",
 	"BRIDGE_L_STBY_PG_R", "",
 	"BRIDGE_R_STBY_PG_R", "",
-	"", "", "", "",
+	"IRQ_NFC_BOARD_R", "",
+	"RSMRST_N", "",
 
 	/* K0-K7 line 160-175 */
 	"ADC_I2C_ALERT_N", "",
@@ -957,10 +974,14 @@ &sgpiom0 {
 	"PDB_ALERT_R_N", "",
 
 	/* L0-L7 line 176-191 */
-	"CPU0_SP7R1", "", "CPU0_SP7R2", "",
-	"CPU0_SP7R3", "", "CPU0_SP7R4", "",
-	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
-	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
+	"CPU0_SP7R1", "",
+	"CPU0_SP7R2", "",
+	"CPU0_SP7R3", "",
+	"CPU0_SP7R4", "",
+	"CPU0_CORETYPE0", "",
+	"CPU0_CORETYPE1", "",
+	"CPU0_CORETYPE2", "",
+	"FM_BIOS_POST_CMPLT_R_N", "",
 
 	/* M0-M7 line 192-207 */
 	"EAM0_SMERR_CPLD_R_L", "",
@@ -978,17 +999,19 @@ &sgpiom0 {
 	"AMC_STBY_PGOOD_R", "",
 	"CPU_AMC_SLP_S5_R_L", "",
 	"AMC_CPU_EAMPG_R", "",
-	"", "", "", "",
+	"DIMM_PMIC_PG_TIMEOUT", "",
+	"EAM_MOD_PWR_GD_TIMEOUT", "",
+	"CPLD_AMC_STBY_PWR_EN", "",
 
 	/* O0-O7 line 224-239 */
 	"HPM_PWR_FAIL", "Port80_b0",
 	"FM_DIMM_IP_FAIL", "Port80_b1",
 	"FM_DIMM_AH_FAIL", "Port80_b2",
 	"HPM_AMC_THERMTRIP_R_L", "Port80_b3",
-	"FM_CPU0_THERMTRIP_N", "Port80_b4",
+	"cpu_thermtrip_detect", "Port80_b4",
 	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
 	"CPLD_SGPIO_RDY", "Port80_b6",
-	"", "Port80_b7",
+	"FM_MAIN_PWREN_RMC_EN_ISO", "Port80_b7",
 
 	/* P0-P7 line 240-255 */
 	"CPU0_SLP_S5_N_R", "NFC_VEN",
@@ -997,8 +1020,8 @@ &sgpiom0 {
 	"PWRGD_RMC", "",
 	"FM_RST_CPU0_RESET_N", "",
 	"FM_PWRGD_CPU0_PWROK", "",
-	"wS5_PWR_Ready", "",
-	"wS0_ON_N", "PWRGD_P1V0_AUX";
+	"AMC_FAIL", "",
+	"wS0_ON_N", "";
 	status = "okay";
 };
 

-- 
2.34.1


