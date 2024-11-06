Return-Path: <linux-aspeed+bounces-86-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7FD29FB8
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 09:01:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xjzhr654tz2yxj;
	Wed,  6 Nov 2024 20:01:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730883692;
	cv=none; b=Hf2c0FXO5FE37NoDbkZoTTwNgKxQELS9A+zBYu7FxirlDrzwV5AjFJPKGdbSi0yJVf119ivUiyrpm5UH6V4UQ1UzGm+R70IWVo0WLgW+zsUr+WmIMHUAwzCL01i8lJ5vBBobvRbscsB2Pk4VVMu3Xno+xeFQ1PTjpE2UD+ZkPEwv37U3DcxqVz9dHc305sS3dHu2QPqWV3k6cbe/quUSjohQsayjNbaGMUMYeio73wc0zxE6/jOq83Eytn/1NwRsaMkXZsm9F3yCQMj0aUJnYqzRs08S6GmTgGu6HfSiUTQ+NAHREwnIFUZr01biz7CzP4SzNGmsFf7qxKsyauHZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730883692; c=relaxed/relaxed;
	bh=gkHWyYIKfFDhAZ5vn6/ZhGd9wV02p4FQmn3m/eJ5Tsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYpDZFzCQIRDZTIA8gzIbusWV6KSyf7IHt4f7fPH6u8CKgIf/zYRzW8HRT8Ov0ErKJNediAVzL+DvjEyN9pHsCXblziwJmf1kcV+jWRtucnOx92S2l7h/DS0LKLoSVG6lB1L4IXGmFhmONTvaXQZtw9MPnLHUcFa3zDE1fjlfgHx/hG13CF6DV2BWqPfvHxpVVia+A1fzTvfPW0OoOp4Y1TaQZVSl7x246k7511Cq3wGSnkF2wPjWFC51E0NyjqtHyXoJnK3hLk67QyFCRXozuaujvebFekKNAyzssWGL9pvJJvCxDbbrg7Ot7A2N/1pDjtej4An/ssuHUTLUXWe8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2v2gOLf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2v2gOLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xjzhq6bmRz2yRD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 20:01:31 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21145812538so29144305ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 06 Nov 2024 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883687; x=1731488487; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkHWyYIKfFDhAZ5vn6/ZhGd9wV02p4FQmn3m/eJ5Tsc=;
        b=G2v2gOLfZW7RYmrn4lOKMsCaXCJY6TjQzLMvi0d5zc9avtWS95gw4/dPXu9FPJI138
         r8QI2zmRRfScAT7dMLWDxXlF2O1TMKpmxHJH8IOCmjrRJU3w4y/JWxFCZjfb+XxOaMQp
         p2XDlOX/aZMXboyRzE+SNuumQEIx+nKhcLP2R8z7cWNa6tbZ2FCrkk+x4zkQNFNMZlCC
         oVWun7LQoPa6KWOkrxlM9pJWuDfzAwNiWDLLb44nTkBzeqad1aNz+tSgy8iUU5hD3RcS
         srjwpqtvtKg7hHkjuvzfojXSpVLNFYEtVsQJDLt46hs2JI5PXWT61J3wGlu4WD7AfPs6
         5yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883687; x=1731488487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkHWyYIKfFDhAZ5vn6/ZhGd9wV02p4FQmn3m/eJ5Tsc=;
        b=wBFqsCRHbqn9KPUnzXk8jg7bT9zLVAXacOAUilBXUOvpWnPE0/kwoMeLn+uFDNQ+NY
         ycqJEjT2tHTlwSzoktdeGonR3UO/HPZRGgIGtvTOm08EqCa0NKdGHtHMDG1AR4Vy+cz0
         AUWChqApEUOlwXqyF6e+fA3cwXWkVZeivXXhNJySC8ZySSAJWByLaTbH42CCX14E38Gi
         S3zuXcbxIYpGlIanD6CYSAl8aYXRhALQkTwWSjKFpOmqYUq7JtWKF2xNUItkT0M0TL+O
         fAeLHUEHvr6pCTxlTMJe4mJfNwDKCPVlB4FAVY7vqSam79AMhhabSLwI5kJfJVNpPt9O
         jtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaR50+EFEBKbGKsbP5osgzkOxhrG9csMhNVXPL5uOWyReLNf+KG09FZEM+miYqM2dhZmUX2Ab5sFXB4+g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHWOdUKBA+YTB/ckXK7YiKAs1Hlsv0gyk6Sz14lDNLKgCJr2Gr
	wuUpzlEv3Y+ZV06ay6815S08CrYAHYl2WHI2mvIEMGcO8+3onp0XqiFyGA==
X-Google-Smtp-Source: AGHT+IHkffsRtd6EA2zoMDxncdUpDGCX04PghiP3RUmDMHfbnoPeC+5oXmEJ9X6fEookxlW1OKhnOg==
X-Received: by 2002:a17:902:db0f:b0:20c:9c09:8280 with SMTP id d9443c01a7336-210c6cc207amr494628845ad.54.1730883687187;
        Wed, 06 Nov 2024 01:01:27 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:26 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 06 Nov 2024 16:58:51 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
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
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
References: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
In-Reply-To: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=5069;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=nyuZFMsNp/CjM9UzYTg0cqEV/NdG/xPxUypZLXNSJj8=;
 b=Ze0ie0kcmnjxo/e5uJQYgqpRrMIjUT1WXgfcU6c8AqMXDe68EhULrw20/M9OKtdFRqbSHmuKZ
 nsLJsIq2guHAK5hSFXmN0DT4nM77oThw4ZITq853Oe8pam8MrMEQ4I0
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the GPIO linename of each PDB CPLD IO expander based on latest
CPLD firmware.

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


