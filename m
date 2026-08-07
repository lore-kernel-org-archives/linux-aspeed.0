Return-Path: <linux-aspeed+bounces-4646-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E83C5AC82
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:31:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcnn5kPkz3byk;
	Fri, 07 Aug 2026 18:31:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091517;
	cv=none; b=m60XP0VYMUU8NakLLUSPvBJ+o6/V/aT8YnXPy3yUN6Yu+ZC2FIyY3lch/MOXbeT74Luf/xBRMQj6YlIB7tp5mTSTyJh7ltC4HjU2gPTs02Nlr2rWu8AJtY9I4KgknjZtaARWiedcbGrCnbIyaybFOIXsOJPpw4DgbuHkj4aJ5Sfynx8zrey/9Wc1ClAWj9BGkclQ9rMpWCr4gZ4k+G6bYJB1M4cdV3BztMw8Nu5+EsHelPUTw+GXP/t+aZdYwjoj8WmYZPUn5DM6uJ+7yZwdhZwt4fWQXb6blI8MHYBQBsgOyKpEK9kvxCYnSFZI7cqgYUW/xIzcgQNyspz9mLpxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091517; c=relaxed/relaxed;
	bh=CjG/L6vRX47pDzFHeJpXAhEEn3GJ7KDceCdHzawl8to=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbuZ5qQyN0R0z1abyVIbNCRvy0bVsWfFjxFW16jwUmRLp9Y4mUzyWpeXLt6hWvbTrp2CarpodbApDwBz5nhqJTFqifjN+kOLFofsFmawGrm8MQg2dpvUmMhQ1W71c/zmI9A+0GyE+IUGwo5/q2oY3ZwcN7wqvd/8rNFr7IZC+r2o5U5aTglE98KO+xGf2lN9ZnraAu6N1Mt8CsdEo8bfS38vje33RobhvWcoWc59hbzqp9kWrwFi4zfJQOsnx54OlGA4xocOvj8b+Z0/PBCOMxkAmvZGrZMNl+B0cw/mZwP41zRKsZvKpqCk6OoF/zaOw7ynL5sNEUzIs2faE4/frw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jDIcRhcl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jDIcRhcl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcnm6HBHz3c01
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:31:56 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2119943a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091514; x=1786696314; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CjG/L6vRX47pDzFHeJpXAhEEn3GJ7KDceCdHzawl8to=;
        b=jDIcRhclhj+Z1dXAbPjc6ACoDyAhAdWm4ZxIRbOykvaQsiSNUEHjquuinuzZ/CLayc
         nXiVc+1O3xE1eweD7xb4L+8WtsfvdK+yCQqM4kJqQNuQaxk3sXE6PrkfqSkxA8/n8tSO
         05L3DLu//Bm1lc9939OUlUuJzn2ZwKZvhJOCfhs+b7flUgbQU5qIJzBxgO14Hs7lHPQv
         N2YO1ahNUXjcahVE8nF+GcQgC7SxaaooKoK07y2cnHhZO1u8OzxHt5n5XuKLP9sEEOev
         Edtav37MamzWYz6KGq7t70/lestpbF7DewraZ3fQUxkQyTydGdaKB2q5BDCr8AvTVeLV
         EDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091514; x=1786696314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CjG/L6vRX47pDzFHeJpXAhEEn3GJ7KDceCdHzawl8to=;
        b=GUdjp0FSJlWpjJcQlRPE8o7xalw8QTTfGN7KUmfitsXsHBVfKkpdnzCVOfFzrQng3e
         9XVU1bppiTRPfgTMivOANXbSoWjVdGBjrqT4cbHeBQYFRQBbb8VoxZWnvGfMfsu+ElP0
         QFEsYmHk2HyhMyTj0VM2T9BJUU2oNB18qRqaaLugYqnwVTOLm2GIPyE9Nn3m+PnmPQRV
         chI2P4yx0ofWud/9yfSAGptPbeeEUyjYazpyJ6YRiqRt3XT+PF3SCZSCWxfYWP52v1xq
         dQHTYG4PzFbmEhmPIRNiG+5RHS7vX3ufD8MDQqIK11GWt5rfstf5I8liDwa+aK2LB/as
         F1fA==
X-Forwarded-Encrypted: i=1; AHgh+RppJJ3jkHCiJHzo+sSGTm4giKPVboMZprNbegqyaxNei1kDlPMInguZmZ5AIMV0Mo7WtFseDcfD8frRFRM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypmjwzJPRp0M3cBbEDy17ZaOa0wLJgd/wjTWxsHb5+vW0qoKJv
	TDp+KollB75TbttFEkd5KkfcHZAw8Tsa58jpBAxmcuSpfEOShukCY6cg
X-Gm-Gg: AR+sD13D4Lwz5am3gD4uTqmi3GQJXQHnpK6/x8oafqL37sHDNpNrIpXjZ6QNmmsDDk9
	Bmh3gDEGxRXUGmvK8QHQbqzLTHg8YeazLElf5BmL4Y7+SgThNEUzg6xBXDk5LJ9CQq0acP6jvNn
	0W/F3Uh3ptfQSh3K4/jFXQTAdoaZb22FGADxfE/NkiTgC62+g+bBwni3OVtA6ZsrSTBGDXoKqRM
	cd2oL9xpBI/xDKjV+IcQqysIb8LFlzg5GOQvHE0ZafOnd06XEnGSpvWfu+dY7oLpvbfm8mUXDI1
	/hRP6Es73vohd65RJ0aXGzDvwfQXVGV+aKdmqcsnZ20fWTU0v/AY0J4KLhUWPvwEkJ7zzFsphH3
	iMGM40SQrRuRJxNIDyJB9QeBXwtl8pQFitR5jdKjSyWsZY/Vkd8fmAxZc7E2VTY8h8h9b/hZZ+p
	/l8VX3GxdgEj/nNSl9oDWqzmYKuZyJfJ+ImHCGWcIFnJ2sVlYHKCVrW3Urg43P4DbsavWixI9v4
	fVsAkuj4kaMHnXgFmWTd+zwPqTL0MQBPYR/0eIyI5bB5MXmdQ==
X-Received: by 2002:a05:6a00:a1f:b0:847:83bd:6671 with SMTP id d2e1a72fcca58-84f2e04a630mr22800889b3a.19.1786091514166;
        Fri, 07 Aug 2026 01:31:54 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:31:53 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs
Date: Fri,  7 Aug 2026 16:34:04 +0800
Message-ID: <20260807083415.672008-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
References: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
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

Add several GPIO expanders on the switch board for NIC, PEX, and cable
presence monitoring. Due to a design change, ioexp0 (0x20) now
aggregates interrupts from the downstream expanders (0x21-0x27) onto a
single sgpiom0 line, reducing the number of sideband interrupt pins
required.

The new nodes provide:
- NIC1-4 power good monitoring, reset control, and fault detection
- Switch PEX power good signals and hardware SKU/Revision IDs
- Cable presence detection and selection for four SPI flashes
- System power fault alert via SGPIO and E1S GPIO expander interrupt

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 125 +++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 0a3e2e241063..2a822e38f091 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -616,6 +616,8 @@ gpio@74 {
 				reg = <0x74>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <146 IRQ_TYPE_LEVEL_LOW>;
 				gpio-line-names =
 					"P12V_E1S_ADC_ALERT","BUFF0_100M_LOSB_PLD",
 					"E1S_BP_SKU_ID0","E1S_BP_SKU_ID1",
@@ -1335,6 +1337,112 @@ eeprom@50 {
 &i2c12 {
 	status = "okay";
 
+	ioexp0: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <148 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"IOEXP_21h_INT_N","IOEXP_22h_INT_N",
+			"IOEXP_23h_INT_N","IOEXP_24h_INT_N",
+			"IOEXP_25h_INT_N","IOEXP_26h_INT_N",
+			"IOEXP_27h_INT_N","SWB_PWR_FAULT_N",
+			"","","","",
+			"","","","";
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PDB_PRSNT_J1_N","PDB_PRSNT_J2_N",
+			"PRSNT_NIC1_N","PRSNT_NIC2_N",
+			"PRSNT_NIC3_N","PRSNT_NIC4_N",
+			"","",
+			"CBL_PRSNT_MCIO_0_N","CBL_PRSNT_MCIO_1_N",
+			"CBL_PRSNT_MCIO_2_N","CBL_PRSNT_MCIO_3_N",
+			"","","","";
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"SWB_PWRGD_P3V3_AUX","SWB_PWRGD_P1V8_PEX",
+			"SWB_PWRGD_P1V8_AUX","SWB_PWRGD_P5V",
+			"SWB_PWRGD_P1V5_PEX","SWB_PWRGD_P1V2_PEX",
+			"SWB_PWRGD_P0V895_PEX","SWB_PWRGD_P0V81_PEX_0",
+			"SWB_PWRGD_P0V81_PEX_1","SWB_PWRGD_P0V81_REFCLK",
+			"SWB_PWRGD_MODULE","",
+			"","","","";
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"RST_PERST_NIC1_N","RST_PERST_NIC2_N",
+			"RST_PERST_NIC3_N","RST_PERST_NIC4_N",
+			"RST_PERST_MCIO_0_N","RST_PERST_MCIO_1_N",
+			"RST_PERST_MCIO_2_N","RST_PERST_MCIO_3_N",
+			"FM_P3V3_NIC1_FAULT_N","FM_P3V3_NIC2_FAULT_N",
+			"FM_P3V3_NIC3_FAULT_N","FM_P3V3_NIC4_FAULT_N",
+			"PWRGD_P12V_NIC1","PWRGD_P12V_NIC2",
+			"PWRGD_P12V_NIC3","PWRGD_P12V_NIC4";
+	};
+
+	gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"NIC1_MAIN_R_PWR_EN","NIC2_MAIN_R_PWR_EN",
+			"NIC3_MAIN_R_PWR_EN","NIC4_MAIN_R_PWR_EN",
+			"FM_PLD_NIC1_AUX_PWR_EN","FM_PLD_NIC2_AUX_PWR_EN",
+			"FM_PLD_NIC3_AUX_PWR_EN","FM_PLD_NIC4_AUX_PWR_EN",
+			"PWRGD_NIC1","PWRGD_NIC2",
+			"PWRGD_NIC3","PWRGD_NIC4",
+			"PWRGD_P3V3_NIC1","PWRGD_P3V3_NIC2",
+			"PWRGD_P3V3_NIC3","PWRGD_P3V3_NIC4";
+	};
+
+	gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"SWB_SKU_ID_0","SWB_SKU_ID_1",
+			"SWB_SKU_ID_2","SWB_SKU_ID_3",
+			"SWB_REV_ID_0","SWB_REV_ID_1",
+			"SWB_REV_ID_2","",
+			"RST_PLD_PEX_PERST_N","CPLD_MB_PWR_EN",
+			"RST_PERST_SWB_R_N","SWB_LEAK_DETECT",
+			"PEX_SYS_ERR_FPGA","PRSNT_SWB_LEAK_CABLE_N",
+			"","";
+	};
+
 	gpio@27 {
 		compatible = "nxp,pca9555";
 		reg = <0x27>;
@@ -1349,6 +1457,21 @@ gpio@27 {
 			"SPI_MUX_SEL","","","";
 	};
 
+	gpio@28 {
+		compatible = "nxp,pca9555";
+		reg = <0x28>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"SCO_UART_MUX_SEL0","SCO_UART_MUX_SEL1",
+			"SPI_PROG_PL12_SEL","SPI_PROG_PL34_SEL",
+			"","","","",
+			"I3C_HUB_3_MUX_SEL_PLD","",
+			"SPI_PROG_PL12_EN_N","SPI_PROG_PL34_EN_N",
+			"SCO1_SPI_SEL","SCO2_SPI_SEL",
+			"SCO3_SPI_SEL","SCO4_SPI_SEL";
+	};
+
 	// SWB FRU
 	eeprom@52 {
 		compatible = "atmel,24c64";
@@ -1776,7 +1899,7 @@ &sgpiom0 {
 	"MB_SKU_ID_1","PASSWORD_CLEAR",
 	"MB_SKU_ID_2","",
 	"MB_SKU_ID_3","",
-	"","BIOS_DEBUG_MODE",
+	"SYS_PWR_FAULT_ALERT","BIOS_DEBUG_MODE",
 	/*H0-H3 line 112-119*/
 	"FM_IOEXP_U538_INT_N","",
 	"FM_IOEXP_U539_INT_N","FM_MODULE_PWR_EN_N_1B",
-- 
2.52.0


