Return-Path: <linux-aspeed+bounces-96-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58313D4335A
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 12:42:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkhYG4DGjz2yGN;
	Thu,  7 Nov 2024 23:42:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730983346;
	cv=none; b=auetvRGydWy7EEn4NFVlDWN3a5HwQWwrJm2CTnR31ayPYhdz+3+UHDs/59wqC4Dr1c/1PAbXhDmo6HlLqeFQOvptXxu1ugpoSK0IG+wLjTe38ntZVn9ri6IBvc0dgSEirg5ofqniXmU42d2etCXInw1tWthe4YbMWInPaTbfyLZUU6OLB0F0+d1wKGaORVnxwsEoBoBdKGMvjSnNg+x6VEsCc8lyu8K0bAghrO2Cgy8L5BFb2uL5lvVyJn8fg8NWbXRabrmvCZf6nDRY79lUbPLX+UkKs9IJaHg/YhNBiLc1JQ0RBo6si0s+u7to5YVAxQfsL8mLUaUEecLauxPxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730983346; c=relaxed/relaxed;
	bh=kNEGN+X9jsQkgFs6oV9OB2bKgz2zTu7nBPwDRCmjXSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwuKSaM+ufsAoU3teR349zD5fuJdDTCIo0XU0iKvTILVXY0sW1yo0vGDBR7k3lWjVq4TJr62Q5cAHGZSMi1cO7Siz4pdyx/5LdVJpRvOTr4mbtVN+Igu30yBC/Gl3x81YPFor1GZdf4qQQ6nhuZaYEs3iWsMWHNpb6TiRCqNdPMu2wFk8CuUL/zZULXKV5cUDlZiZUhy1tKF5Lu6TW4567Zj7a+uSMJdN4StmPVi94JTvYbzZRqxdCt0UKG5MlQa0DAqKvMV1FdXw5Z3w/Tg/r9Aec/MKviiHwL3kN1edZDyWFmX7A2BLM3kneCvHjWTnUtN994tcv+vn90R0iR+2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CgbIt9YX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CgbIt9YX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkhYF3vtbz2xYs
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 23:42:25 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-20cf6eea3c0so9558715ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 07 Nov 2024 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983343; x=1731588143; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNEGN+X9jsQkgFs6oV9OB2bKgz2zTu7nBPwDRCmjXSM=;
        b=CgbIt9YXpw7VVuNmV/wH6/EQ63fkbpvC9Cih/92ylSvbcrPoprjti2jmbGyjCMHGyL
         CPY1WVctUJlNl9lYTu9TwsrnzZs2/8esmdGCWjqOQAWbfEAoTcMVEVPpDl9evCSoQeNI
         y1Ft9ajcaliNf5EwbNpk2s0vmI4PRKwdwwVEnGmb7blzn5CvdaFRLhfN6sLtQ9tGa44e
         t7A3fT50bIf6G4WU5/Zp7qnGC6t4SbunKkEQMzdpgy856Aw6HScMZaq26HMqFaFaXnNJ
         qGyMJw211hvBDxU/xjp30+M7n+mZ6QYhFrrTqcuFRLJ4pp86tcONP1XD08jzZHWnF4pg
         Ht2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983343; x=1731588143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNEGN+X9jsQkgFs6oV9OB2bKgz2zTu7nBPwDRCmjXSM=;
        b=QKVtgw4WqpwuiG3/c1IZHSWLvPH6LU56G0D+sqJKZ4EnoP7V4DjkGmi+96VZnZMlbe
         8qpCwWrkwlANde+RYU6GP9XBuwHRITh4qjaRjwNoSW++x0exfIGMoDByCChlPeD8dbG5
         NWavpF/ajKIH/bPYHlGUzPdPl8X+zoNqVObzKAcmdCkSkbTcl5+WEW5nbB101WRUNLSl
         aldNVfvFLoqwfoJoKIWJyjA1gXesbimtDw531m6YTJbf2c3QsYQh7DtNm/eFQo5zdQJC
         5QIE2U7lwTWTwqjoxffbRGCVqNmEPSP04JkDKXZrF+v1YqWmTMffoLWN1l873CG3KJnE
         DtOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3nNNB0PgWD3aWG33pRgjs95LhHRSImz4ODf14oIjeZ9nEV9GCC6OF7HKhq3CjhHxYUnjx+KpRwk2nbn0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXxQse24ZVrvTiyaneSQA3F+6jIxmR9L7kZG5gy/MST8WWPwUv
	RFg2g46BwAP/vPlC4+mlR3TPT9u8ypzwnWLntEAFuXp0RI6wabd9trT9uA==
X-Google-Smtp-Source: AGHT+IHw/mIi4fwHrLjEvutGISRpw2hBcjcLrIxv45YZ6jpB08x+XFdXcXJdJpfX20IYT1A5uLofKw==
X-Received: by 2002:a17:902:f712:b0:20c:9821:6998 with SMTP id d9443c01a7336-210c6872732mr605679035ad.10.1730983343366;
        Thu, 07 Nov 2024 04:42:23 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e412d8sm11101975ad.113.2024.11.07.04.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:23 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 07 Nov 2024 20:39:57 +0800
Subject: [PATCH v2 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-catalina-cpld-ioexp-update-v2-1-d7742eabc0e6@gmail.com>
References: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
In-Reply-To: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730983338; l=5178;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=1KzXfE/phY4WB98wge7x+4YWA7p6w9FVqaeKow5FPSk=;
 b=NF2Z2IzMN510NJ9FefMB9c/twk4An6ui3Mq83g5ytYdN4WzcYsXz5D1tHkzQGQH4nG7H2tVKS
 BkJ8NKmke4PBLoCY8hubUHyq1XcrWFhs2T3JsdPHSGAkXsLMx+wEVj7
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Due to there are huge changes of PDB CPLD IOEXP pin definitions since
DVT version, Update the CPLD IOEXP nodes and GPIO linename of each PDB
CPLD IO expander based on latest DVT CPLD firmware.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 99 +++++++---------------
 1 file changed, 29 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..10a9fca1b803 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -802,26 +802,6 @@ io_expander12: gpio@13 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
-
-	// PDB CPLD IOEXP 0x14
-	io_expander13: gpio@14 {
-		compatible = "nxp,pca9555";
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
-		reg = <0x14>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	// PDB CPLD IOEXP 0x15
-	io_expander14: gpio@15 {
-		compatible = "nxp,pca9555";
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
-		reg = <0x15>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &i2c15 {
@@ -1040,71 +1020,50 @@ &io_expander8 {
 
 &io_expander9 {
 	gpio-line-names =
-		"LEAK3_DETECT_R","LEAK1_DETECT_R",
-		"LEAK2_DETECT_R","LEAK0_DETECT_R",
-		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS1_LEAK_Q_N_PLD",
-		"CHASSIS2_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
-		"P12V_AUX_FAN_ALERT_PLD_N","P12V_AUX_FAN_OC_PLD_N",
-		"P12V_AUX_FAN_FAULT_PLD_N","LEAK_DETECT_RMC_N_R",
-		"RSVD_RMC_GPIO3_R","SMB_RJ45_FIO_TMP_ALERT",
-		"","";
+		"wSequence_Latch_State_N","wP12V_N1N2_RUNTIME_FLT_N",
+		"wP12V_FAN_RUNTIME_FLT_N","wP12V_AUX_RUNTIME_FLT_N",
+		"wHost_PERST_SEQPWR_FLT_N","wP12V_N1N2_SEQPWR_FLT_N",
+		"wP12V_FAN_SEQPWR_FLT_N","wP12V_AUX_SEQPWR_FLT_N",
+		"wP12V_RUNTIME_FLT_NIC1_N","wAUX_RUNTIME_FLT_NIC1_N",
+		"wP12V_SEQPWR_FLT_NIC1_N","wAUX_SEQPWR_FLT_NIC1_N",
+		"wP12V_RUNTIME_FLT_NIC0_N","wAUX_RUNTIME_FLT_NIC0_N",
+		"wP12V_SEQPWR_FLT_NIC0_N","wAUX_SEQPWR_FLT_NIC0_N";
 };
 
 &io_expander10 {
 	gpio-line-names =
 		"FM_P12V_NIC1_FLTB_R_N","FM_P3V3_NIC1_FAULT_R_N",
-		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
-		"P12V_AUX_NIC1_SENSE_ALERT_R_N",
 		"FM_P12V_NIC0_FLTB_R_N","FM_P3V3_NIC0_FAULT_R_N",
-		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N",
-		"P12V_AUX_NIC0_SENSE_ALERT_R_N",
+		"P48V_HS2_FAULT_N_PLD","P48V_HS1_FAULT_N_PLD",
+		"P12V_AUX_FAN_OC_PLD_N","P12V_AUX_FAN_FAULT_PLD_N",
+		"","",
+		"","",
+		"","FM_SYS_THROTTLE_N",
+		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
+		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N";
+};
+
+&io_expander11 {
+	gpio-line-names =
 		"P12V_AUX_PSU_SMB_ALERT_R_L","P12V_SCM_SENSE_ALERT_R_N",
+		"P12V_AUX_NIC1_SENSE_ALERT_R_N","P12V_AUX_NIC0_SENSE_ALERT_R_N",
 		"NODEB_PSU_SMB_ALERT_R_L","NODEA_PSU_SMB_ALERT_R_L",
-		"P52V_SENSE_ALERT_PLD_N","P48V_HS2_FAULT_N_PLD",
-		"P48V_HS1_FAULT_N_PLD","";
+		"P12V_AUX_FAN_ALERT_PLD_N","P52V_SENSE_ALERT_PLD_N",
+		"PRSNT_RJ45_FIO_N_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
+		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS2_LEAK_Q_N_PLD",
+		"CHASSIS1_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
+		"","SMB_RJ45_FIO_TMP_ALERT";
 };
 
-&io_expander11 {
+&io_expander12 {
 	gpio-line-names =
 		"FAN_7_PRESENT_N","FAN_6_PRESENT_N",
 		"FAN_5_PRESENT_N","FAN_4_PRESENT_N",
 		"FAN_3_PRESENT_N","FAN_2_PRESENT_N",
 		"FAN_1_PRESENT_N","FAN_0_PRESENT_N",
-		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS1_LEAK_CABLE_R_N",
-		"PRSNT_CHASSIS2_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N",
-		"PRSNT_RJ45_FIO_N_R","PRSNT_HDDBD_POWER_CABLE_N",
-		"PRSNT_OSFP_POWER_CABLE_N","";
-};
-
-&io_expander12 {
-	gpio-line-names =
-		"RST_OCP_V3_1_R_N","NIC0_PERST_N",
-		"OCP_SFF_PERST_FROM_HOST_ISO_PLD_N","OCP_SFF_MAIN_PWR_EN",
-		"FM_OCP_SFF_PWR_GOOD_PLD","OCP_SFF_AUX_PWR_PLD_EN_R",
-		"HP_LVC3_OCP_V3_1_PWRGD_PLD","HP_OCP_V3_1_HSC_PWRGD_PLD_R",
-		"RST_OCP_V3_2_R_N","NIC1_PERST_N",
-		"OCP_V3_2_PERST_FROM_HOST_ISO_PLD_N","OCP_V3_2_MAIN_PWR_EN",
-		"FM_OCP_V3_2_PWR_GOOD_PLD","OCP_V3_2_AUX_PWR_PLD_EN_R",
-		"HP_LVC3_OCP_V3_2_PWRGD_PLD","HP_OCP_V3_2_HSC_PWRGD_PLD_R";
-};
-
-&io_expander13 {
-	gpio-line-names =
-		"NODEA_NODEB_PWOK_PLD_ISO_R","PWR_EN_NICS",
-		"PWRGD_P12V_AUX_FAN_PLD","P12V_AUX_FAN_EN_PLD",
-		"PWRGD_P3V3_AUX_PLD","PWRGD_P12V_AUX_PLD_ISO_R",
-		"FM_MAIN_PWREN_FROM_RMC_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
-		"PWRGD_RMC_R","PWRGD_P12V_AUX_FAN_PLD",
-		"P12V_AUX_FAN_EN_PLD","FM_SYS_THROTTLE_N",
 		"HP_LVC3_OCP_V3_2_PRSNT2_PLD_N","HP_LVC3_OCP_V3_1_PRSNT2_PLD_N",
-		"","";
+		"PRSNT_HDDBD_POWER_CABLE_N","PRSNT_OSFP0_POWER_CABLE_N",
+		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS2_LEAK_CABLE_R_N",
+		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
 };
 
-&io_expander14 {
-	gpio-line-names =
-		"","","","","","","","",
-		"FM_BOARD_BMC_SKU_ID3","FM_BOARD_BMC_SKU_ID2",
-		"FM_BOARD_BMC_SKU_ID1","FM_BOARD_BMC_SKU_ID0",
-		"FAB_BMC_REV_ID2","FAB_BMC_REV_ID1",
-		"FAB_BMC_REV_ID0","";
-};

-- 
2.31.1


