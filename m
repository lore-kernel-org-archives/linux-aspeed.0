Return-Path: <linux-aspeed+bounces-157-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50E7D75BA2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qV2Mfbz2yl1;
	Thu, 21 Nov 2024 13:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157622;
	cv=none; b=aiktYPPQsvACeEsR0ENGaHNObTmpRfXd1vf44murIMfzchl//3mlw1ra2ungLFewE3WD0WqMcXcMzas0xEZQ484hjwouc5YeqMNBlJKSkRaB//IHq94XnYGFM+rPgVXl9iy4+l31v660w/yKdIQMVZRZUyKVlzAl5Zrf3E+ca1VoMoYQXbd0iW7vOO13DljAgB2HdKAMxGiaLJtnNfx3UHplueNGZjiPnk3y9n8iclzrel702awtBTeonbEdydLaR+oi5PQfTxTndUi001yrb+aCb5kyqfJ9zijfetBTsvh3ikaA7nxhs3RpM4xP0sArdkSzbH+lzM2V6ziIuxLTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157622; c=relaxed/relaxed;
	bh=7hFpMGE8s7psUHx3+Wdj8euFlIX9fVjcGzp1EwkK8LE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eW3fdp1lcJFK1/HwBmteLLYrAPC3A3gNVDrysstRBQkzw6ppFfeBr4sUIhnjkOOsDcLDdcrJm6TxtFR90jmKaEXDz+K4xEKQH1nzrhdUXGzxKCZGIONVTJpUvRuDnv64BjBkuRmIQOL+cKUUjy78d2E/noUQHFiwQ+885ntJn1VdSrTWzzBhQFztym6oBm4F7eZJ3xWehYfYAWTVPWWEuCOJD49fgLJ111/g4x4U/OmbXe80LiOVGGZRo6AbMMNvPMRJhDJ86EPZvk7hfxkTfgf/Clvd96Jgdi4WcCtfZ0VOKxBPFDT2C4C6VGJVnnZoztzyNadn1JDcnuAfYjbxEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QIJUT33x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QIJUT33x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qT2NRtz2yD6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:41 +1100 (AEDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-71811707775so195916a34.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157618; x=1732762418; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hFpMGE8s7psUHx3+Wdj8euFlIX9fVjcGzp1EwkK8LE=;
        b=QIJUT33xiQb/QoxjfqQLqwvaX4ekqFwdhxUgBJp+hzXO9ojLA/kZfyzKXwh9FRglNu
         Ve5zh3CbeQj8gHg1jrmaNXz4zdQQF3DD926GF4JJtmntAsT05aILFyTSFoq6zqPGalXn
         uzLrHjS65lYUS3f/Sn/QDYoqZyZ2SO4/t49t3STCTu/ZpPv5W200OAFRcJxB8Q08R9sC
         Som1TdAXyL+/71otZeubKgkDJh70V/F3gBtegA+XNwg6DTiUk2EQz/OZp66uKjW1sgBC
         gp+FAwGCrmKIeW+CgjWJrHbHza5o8VSNfy8KkIbG6xkMok2JgG01hhcVqkFpSTTSc96M
         PjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157618; x=1732762418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hFpMGE8s7psUHx3+Wdj8euFlIX9fVjcGzp1EwkK8LE=;
        b=Rhg3975Ur/0Zo3i15uX5QcZ5SVFyZzByqZh5WiU8t12lAtcUcL7C8zKkRmFnYE7lsq
         CIbmjYVGhVPx7zV/1I1CeE3VOqT2CvBCTYGB2z+w1YOBe6dWboSJLeCl6H2utGCSdy3e
         jaN1LovBeI2oTywsG/3mSTVuLAqIW0mF1iAjQguoBHgNt5Vdn+AqkaR+UaBJ0eMz2cWt
         Aeib3Oz42UEv54dbtlfH1hoAddiOgZ+0K9z0VXkPDR0Ag88/S1PCgTSLpZp3hX41g4of
         Gtzao0+g4d2Efx71k8mCPLboajdPtKfmiQUj1zGOz6T8efYcwA1IhruPbVVoJin0SwhD
         XGZg==
X-Forwarded-Encrypted: i=1; AJvYcCVaakAaCeUH1kAHWXyJscOGfqUzhGpZpCmAqvuVKbDiN4iVWH9A7BS2idAtiKpaHQxan55CbyPvDLn4GJs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6L7Cm7JY5Ka8MJHnlycMPMY0nquKhruzo4m7Bso8qRFPILDYd
	/tlMu3CbXOylbx7vSkc6mokQhxqWLucJUL+lJnS3dnc+khWXNo84
X-Google-Smtp-Source: AGHT+IFinVzwidv3KxbK4poEFtxDXiNYFFKy7ns+/JV5m2BWBfiQ/ywhmjk5vggcq044ZI8cYP3oKQ==
X-Received: by 2002:a05:6830:6e99:b0:71a:6cbf:7e96 with SMTP id 46e09a7af769-71ab30ed2c8mr6011687a34.9.1732157617978;
        Wed, 20 Nov 2024 18:53:37 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:37 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Harma: Revise GPIO line name
Date: Thu, 21 Nov 2024 10:53:20 +0800
Message-Id: <20241121025323.1403409-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add:
"ac-power-button",              // AC power button input signal
"asic0-card-type-detection0-n", // ASIC0 detection signal 0
"asic0-card-type-detection1-n", // ASIC0 detection signal 1
"asic0-card-type-detection2-n", // ASIC0 detection signal 2

"cpu0-prochot-alert",           // CPU 0 processor hot alert signal
"cpu0-thermtrip-alert",         // CPU 0 thermal trip alert signal

"irq-uv-detect-alert",          // IRQ for undervoltage detection alert
"irq-hsc-alert",                // IRQ for hot-swap controller alert

"uart-switch-button",           // Button to switch UART interfaces
"uart-switch-lsb",              // UART switch signal, least significant bit
"uart-switch-msb",              // UART switch signal, most significant bit

"leakage-detect-alert",         // Leakage detection alert signal

"power-card-enable",            // Power card enable signal
"power-fault-n",                // Power fault signal
"power-hsc-good",               // Hot-swap controller power good signal
"power-chassis-good",           // Chassis power good signal
"presence-post-card",           // Presence for debug card
"presence-cmm",                 // Presence for chassis manager
"pvdd11-ocp-alert",             // PVDD11 overcurrent protection alert signal

"reset-control-cmos-clear",     // Reset control signal for clearing CMOS
"reset-cause-pcie",             // Reset cause indication for PCIe
"reset-cause-platrst",          // Reset cause indication for platform reset

"P0_I3C_APML_ALERT_L",          // APML alert signal

Rename:
// Rename the power signal to match PSM defined
"power-cpu-good" to "host0-ready",
"host-ready-n" to "post-end-n

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 58 ++++++++++++-------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index fd85d5e34a55..ce1731bdc1af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -416,12 +416,6 @@ gpio@31 {
 		reg = <0x31>;
 		gpio-controller;
 		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"","","","",
-		"","","presence-cmm","",
-		"","","","",
-		"","","","";
 	};
 
 	// Aegis FRU
@@ -559,7 +553,8 @@ &gpio0 {
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"","","","",
 			"bmc-spi-mux-select-0","led-identify","","",
-	/*C0-C7*/	"","","","","","","","",
+	/*C0-C7*/	"reset-cause-platrst","","","","",
+			"power-hsc-good","power-chassis-good","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -568,7 +563,8 @@ &gpio0 {
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","",
+			"leakage-detect-alert","","","",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"led-postcode-0","led-postcode-1",
 			"led-postcode-2","led-postcode-3",
@@ -577,18 +573,29 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
+	/*Q0-Q7*/
+			"","","","",
+			"","power-chassis-control","","uart-switch-button",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
 			"rtc-battery-voltage-read-enable","",
-			"power-chassis-good","",
+			"","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"","","","","","","","";
+	/*Z0-Z7*/	"","","","","","","presence-post-card","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "ac-power-button","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","","","","","";
 };
 
 &sgpiom0 {
@@ -636,10 +643,10 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"power-cpu-good","reset-control-smb-e1s-0",
+	"host0-ready","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
-	"host-ready-n","reset-control-srst",
+	"post-end-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
 	/*E4-E7 line 72-79*/
@@ -656,7 +663,7 @@ &sgpiom0 {
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
 	"","uart-control-buffer-select",
-	"","ac-control-n",
+	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
 	"FM_CPU_CORETYPE1","",
@@ -668,7 +675,7 @@ &sgpiom0 {
 	"FM_BOARD_REV_ID2","",
 	"FM_BOARD_REV_ID1","",
 	/*H0-H3 line 112-119*/
-	"FM_BOARD_REV_ID0","",
+	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
 	"","","","","","",
 	/*H4-H7 line 120-127*/
 	"","",
@@ -683,22 +690,31 @@ &sgpiom0 {
 	/*I4-I7 line 136-143*/
 	"","","","","","","","",
 	/*J0-J3 line 144-151*/
-	"","","","","","","","",
+	"","","power-card-enable","","","","","",
 	/*J4-J7 line 152-159*/
 	"SLOT_ID_BCB_0","",
 	"SLOT_ID_BCB_1","",
 	"SLOT_ID_BCB_2","",
 	"SLOT_ID_BCB_3","",
 	/*K0-K3 line 160-167*/
-	"","","","","","","","",
+	"","","","","","","P0_I3C_APML_ALERT_L","",
 	/*K4-K7 line 168-175*/
-	"","","","","","","","",
+	"","","","","","","irq-uv-detect-alert","",
 	/*L0-L3 line 176-183*/
-	"","","","","","","","",
+	"irq-hsc-alert","",
+	"cpu0-prochot-alert","",
+	"cpu0-thermtrip-alert","",
+	"reset-cause-pcie","",
 	/*L4-L7 line 184-191*/
-	"","","","","","","","",
+	"pvdd11-ocp-alert","",
+	"power-fault-n","",
+	"asic0-card-type-detection0-n","",
+	"asic0-card-type-detection1-n","",
 	/*M0-M3 line 192-199*/
-	"","","","","","","","",
+	"asic0-card-type-detection2-n","",
+	"uart-switch-lsb","",
+	"uart-switch-msb","",
+	"","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
-- 
2.25.1


