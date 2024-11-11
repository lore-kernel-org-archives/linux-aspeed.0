Return-Path: <linux-aspeed+bounces-112-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A56D2E9CD
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4Rv5kK4z2yY1;
	Mon, 11 Nov 2024 20:46:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318363;
	cv=none; b=UuFe7US+TRcGTEnZbwFV/bH2OnDWuvWMHnfc860xx4ku2J/SdoEC4UyP/4MZn+gO1oEw2F0cTrVZJAPf9kRN0TZQG9jVEIhEf0hds8TyAi3R3zMLeOdagW4RQN7V5KZ7SxESIVTqcJXiNMDmFHcK1uwCy0TAHv3nrltl+U3Q25Xqq3eMZycBJvUagGKIW+tXSiVUb3ih2qYNIK/yQNOOyySPVPcX4RhqoMbziemfrNY4gwn3RpXxIZzL2r1m+VNdLnzgWcNiaeSYNtzmBF5OxezSzGnibNl+wh/wzHWlVclyaFQu0U5Zhn/EVABShuVIrkR9qXhYl4fbmIApoiA58w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318363; c=relaxed/relaxed;
	bh=hnd0dMgn8pF5mC6ybOYdJ6wVojOcLARfVRQ6oD52meo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLoj6Ge4eTmwZ1Fg2AP4Zv4spnd4nMbD4XSGX7exZnLkNIQdgCPFzvQXUlgKPt2eJZmC/8bAlC2O6Ajif4/4n+KCFeLGmXU9K16ThUMqnkuSWm9WCd1RRh9qo9OgZQRukjIUCIGGe2l0Rrmr2T5KV0V2ws8pXONxiZBjZ62fEO1JZv+1uS+gDq0geomUWUrHIFRdmkO52/knPg+r1oyKCUaiHAQe2tbM4lcC6yvlCm/qbAo0Rwe8Oh5spny+wrsSVYUPA7DR6JQJEBgh51pSLPgSSaIj0dus7jA00f1CvMd1/rTptMykmZ20rRouCCAU/HuzUaD541dUF2f97YEY+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LDAn1C76; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LDAn1C76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rt6JGJz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:46:02 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-20ce5e3b116so38638535ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318361; x=1731923161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnd0dMgn8pF5mC6ybOYdJ6wVojOcLARfVRQ6oD52meo=;
        b=LDAn1C76909T4OfHeqxC6U+FfwaCF+RiW+sLz4W/hL0pCLDuSEiGp1CsZK/Qj0TYrH
         kdgjYxOACSRH7nhl+sofOFl4puOvjb2VxB7Eyfz3Fhmsqr9XviO6ckqo6/0m/kHmSXkA
         W0qprgePjjDIiuMqFV/PFHHdAyDsNKlR10BXlK8j9xt6Uruxzhu+Kgnzd0tQPuiMhTxr
         xpt+fASG0oXedqdI+lzmLGb7MGiEVeSEnPpWlDSpFr4H2iAmNDsBnLHymOATlPvQdfnE
         uFTpSSNhJqDqydgFbKsoYn4hVLX3PKDt1ZQYuWkFBzVFcPvSUC8txG9Sm6I9eet5vvbH
         Nciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318361; x=1731923161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnd0dMgn8pF5mC6ybOYdJ6wVojOcLARfVRQ6oD52meo=;
        b=cG7mKrmaU79L+tz6NB9cC1DXx7G7u6ryNP/e3xwS/yOOAPe1WjBVGgyvXwt4zJec5V
         JounVPROgu2v2sK2Hq//d7EYWpQTW+P4lu4MzxUgpO4rGWZwOupXR/s285zamJHlO7Oo
         KdAG1xbMj13i9sHEEroFCtPgCed42wHsz/vR1YqphLUw29KHZRsRhQoySrtSB2goUP/b
         OnlKG1rsyW3++X31qyR/JhtTcDrHzLHAd1PjYE4+uqQckgO99G1VVe1TN61flkl/owhY
         qXD1VDY+KSoC5RK/Dk23QpbLqmbnlk0SAVtcyH96I12nK8VvCGz99YVCj0ThTSmUtL1m
         QtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs74dQjkdPm6TJEQBESSMgipIfN2j5bRzG6CR+XEbyV94tiI9XxXV6xg1MbuUPCQAXSZ4D/VCeFZTN/kQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxH7SApQzvl0bYP+afB0cVXTzRG9drBlt2MBZ0cAwDwJ7G6wOqN
	MaxQ7kCMdMi3v/yzvrrzfPWSFUF7Ur3B1/GNHc7/GnP+7NHIfbkMhtTdIA==
X-Google-Smtp-Source: AGHT+IHJPX81v+bCNaryh8mrbkn4Vw2k+4EN2NzDFSUrUCEELhKBfLTnc5EyUfjXpNmdcZ3GqJq0Xw==
X-Received: by 2002:a17:903:2347:b0:20b:b455:eb4f with SMTP id d9443c01a7336-21183d6eff4mr178322555ad.25.1731318360826;
        Mon, 11 Nov 2024 01:46:00 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:00 -0800 (PST)
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
Subject: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
Date: Mon, 11 Nov 2024 17:43:47 +0800
Message-Id: <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
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
    "ac-power-button",
    "asic0-card-type-detection0-n"
    "asic0-card-type-detection1-n"
    "asic0-card-type-detection2-n"

    "cpu0-prochot-alert",
    "cpu0-thermtrip-alert",

    "irq-uv-detect-alert",
    "irq-hsc-alert",

    "uart-switch-button"
    "uart-switch-lsb"
    "uart-switch-msb"

    "leakage-detect-alert",

    "power-card-enable",
    "power-fault-n",
    "power-hsc-good",
    "power-chassis-good"
    "presence-post-card",
    "presence-cmm"
    "pvdd11-ocp-alert"

    "reset-control-cmos-clear"
    "reset-cause-pcie",
    "reset-cause-platrst",

    "P0_I3C_APML_ALERT_L",

  Rename:
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


