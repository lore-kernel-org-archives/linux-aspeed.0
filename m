Return-Path: <linux-aspeed+bounces-3938-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C26F8FA74
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 13:03:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0MxQ0bKbz2ySW;
	Tue, 21 Apr 2026 23:03:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776776634;
	cv=none; b=TPKQloN3LT7KJwFQbhyicNowwPYeEPWcrBFbCU+23dxCl39P1ekyH1tLXH1auNJLW6tjiCIBl8uJwqg4ioZl/gHEfDoeScYft2EXnwaz0zhFBdFfhfLgZFUpT4cOn2aDy2RC4gtePb7ExUfo+6j/VG618QasRr4mk/vXqrzJy5PHWQKpOyKxdylR2OM9L4Z4UCcOTJkWZdWLDjfj0Fw9PcLmMH76WCn7aPnESmeGPKwl9d1Iuj7Hyyafdizpmgr2IXhDezXT39aGgqo1iM4VET9x9WX+m0VgvqpNFQt+UhOxMGqnIe3YTEGLRm4UqKKygGOxasAQmuXuXVKMIn9efA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776776634; c=relaxed/relaxed;
	bh=maE5jQDJwsycLww5UnLtB8sLxR1IdmgJ/9+EbDBJAp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/Wo+TPZMsUxpz4/dkcA3rC8Oz9DLDDuewNC7fA7wmZSRvUuFx6GRawKqVasbY9KfQ3IV7zbjo3kWC2UtkY1WoRTkUpM5LltWBjCz2+UW0kYHOyvvDrH/Ua0TmWCpCBI3R+7CE3OQjeBonVPO/1yfQKBMjRViMovXRCkDKuBNwBRxmtTdy2EhhL5FDOIWOYdDjwt5n15vYimQt4qj8b3iDHmZOHCnwSV3by2jlj0dNRIYXIgTxF1FkArIYCWbeAWg4sTxvl7waa1mMmULNX6R15nbuFi6OSjaEwkRNZn+cBtwGjTsAXtRvueRpi19iVvHLM+31sRiik7iLSkUqKcBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h54UGOtj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h54UGOtj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0MxP2CwTz2xQB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Apr 2026 23:03:53 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c795f096fa5so1689567a12.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Apr 2026 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776631; x=1777381431; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maE5jQDJwsycLww5UnLtB8sLxR1IdmgJ/9+EbDBJAp4=;
        b=h54UGOtjwLe8b1Qj0PMPb94fk1MNDaR+RyY/7+I9erz29YCBsXyPLG5g8BaQlfxYzs
         bQDIunKHVVS0O5DXsxJIxKYktNsbjwub6rAlMGXLYUuRaRXADa9Q0fi2wtdjPR00uN2k
         pF2BRJtOTpT3SeJU6uJeInGvgbjeFLMrJZyNCYewCDqvFpl4UpXaKQ8TKHd5YrxcSV6g
         iK37IfutSxRn4UcVq8jrZuZ664CHMEt9fzVZ+vE2HRqPG1jx0UwMQ8thUAHjTkCXFSsq
         B/6npOXMYBx8pI2FOaGzAi9kvEfi++CczVqmhk4EtdHnSEkMlWptxxIZ0+t4Qde/Mn/j
         g0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776631; x=1777381431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maE5jQDJwsycLww5UnLtB8sLxR1IdmgJ/9+EbDBJAp4=;
        b=iu/FX9idttaCDxfb7sFq1GaOLvMlmSHgbPZ+vDbsMUmoJ/OuvyZNWwz1gK4VZC0TS5
         KPiWg9dHLGxmGMcZT0x0Dsz9QQcqOsivUqedOp/cRHADZ301ZxSQ0GMUseNIIh6Vo78I
         XJ/xmMUuZOV8Mro6a0eFj4BB9D82wOHXD4/2ABS8lDh6YRKOykuPP1XiS5mmbh+p1ARe
         Blxbw2M1D2+LSaEESiWZJolMhVbSM+y0SJrH/5Co5kHA1ZOLl/MPweZfmWdj6KEIcDmh
         dvFjYTUbPsAzAv1625VC4iNKKNfGDqg3Ef+4ly409OmI9cmlmZeXtvCuaOXRSYPxIKig
         GyMw==
X-Forwarded-Encrypted: i=1; AFNElJ/N/kHdy/diUKYWIYpxkj1XBw5UgYFOeBNx69MnZWkiveOUYa6uV8OY6J3df9vClK058p4c8ea3rLkJdX0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWhdb7ThQqxC55uVCBMdCMiZ2pAMo/ftYhqaJkeSAyipEIkm5F
	WkWVKTbu+GjdLsIed1R0ZihG78OvAtwmNwTRNFixEni5BSxkW+r3PSiu
X-Gm-Gg: AeBDietkyFIciFpPAKehLlzJqXQvoUr2Hcz11Ms6zbZmfsO3qrr+4Lnnszkp5Iqxj1I
	xltZuN4pW+Bo7Vv/3D6SMBE/IeFOT7nmpZuPD+FL7V5Vo7es0Y56DxBjkUhBlvEvgSR6EUs/ARK
	pqkXOLpEGC7TRl7QmH8K1vvnBJpE0vmePsIxS5lWZ+Jdi2BXFmm0yFXad/i5B3dHIu4Yj4TeXiJ
	yMiBQvtU3hkJfo2/kjcWbmpyOUwynSywes3gH4RqhSKiaq8IT9Q/I4k750DSMzkbn1X/WQrEj1F
	2uHk6ZUn8tNpoi4dxMOrG8iaVHUw1pSoAJPqsRbFE4mGJ89XUVRp5WHaV4zDpoy0GAd7APN228n
	NZDvOzLk08fjNeDCnIXezHE/bWe4qQrJDWyPEDh8PSJRPjSxY3lHEVqF/OZIUl4Z1FNnDvOXNCP
	LWjdPVAg7XG99l/W9COSkybrgrz1pQgIz7wo2cNgwW3FZDJPM+w9IAy9t8BVGFOzd8seEpBsP4D
	UwhPcHWbhnXJX3QsYtz++8=
X-Received: by 2002:a05:6a20:9146:b0:3a2:dbaa:82ee with SMTP id adf61e73a8af0-3a2dbaa8538mr5955384637.9.1776776631018;
        Tue, 21 Apr 2026 06:03:51 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14456484b3a.3.2026.04.21.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:03:50 -0700 (PDT)
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
Subject: [PATCH v2 1/1] ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs
Date: Tue, 21 Apr 2026 21:03:41 +0800
Message-ID: <20260421130344.2751662-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421130344.2751662-1-fredchen.openbmc@gmail.com>
References: <20260421130344.2751662-1-fredchen.openbmc@gmail.com>
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

Add several GPIO expanders to the Santabarbara platform, with ioexp0
(0x20) configured to aggregate interrupt signals from downstream
expanders to optimize sideband pin usage.

The new GPIO nodes provide support for:
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


