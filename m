Return-Path: <linux-aspeed+bounces-87-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514AAD29FB3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 09:01:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xjzhs73kqz2yyR;
	Wed,  6 Nov 2024 20:01:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730883693;
	cv=none; b=lz9JMNPh6e2jklXnQxh8S1j3yIFUncQ05jbYEtC9MpCF7hjV768GkHje6ty0xokGcUZfWbg4/VM9NmQJC1i/EsO1nkCd8lmEfILJK3cxrb8tydIHCheZJvH3zMcLC1JPEaIz0U+2PT/UzfMQNMM5NDKSjepSTsapY7xE9e9Zrs/AxkNfSXuig7jtkPYn0BxRXtOXaREeEGeVC8ZRrbTEO2hr/i/Jes3/I78ntD7KYo3aBn2T0BxMGLf6+TPKlYyRyhPE5QhoESd/vSMHWOI3F2+SCqRzciAnC3z6WB9+xuja8AAXHQYuOA1QO0jhvroueonY0bLbHVl5FFiC/56pow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730883693; c=relaxed/relaxed;
	bh=sGC6TPqRGXu1mF5aeFEhak+3rB765Th2HjWB1mjw0KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOhhM9NGzIQgPVuHRjXXWILl54QAoQLEUNaiK6RzBW0rJ3eKHajGpkwHFpICRePX7qZO8ApQUq2B49Akeet2hJJ7WUWc9TOUVamKy3Z4ROR9HOOOzbWKpe04dOaPdHNjJQ4WRh9Hxf1T6lypN4yn4nIa7vS6ERt48RpBWkMA7nvs5kkXmy6O8Z/lgHT8J3tFfXuAw+/JhvDX2YKZxCgBNCwj5M1r8ekNnvrR97fAv0ADfm2nl5JW3x+vJ3TrCWdKTZmI0cj4ooVbcGGL1AULtSML8Z08qzjzJRojujVjMCKg4T0LPZyUNIkDGEr/3ZITfctVfHOlqDMk4v07EnQRXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IFewanih; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IFewanih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xjzhs0jLNz2yRD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 20:01:32 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20bb39d97d1so61933145ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 06 Nov 2024 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883690; x=1731488490; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGC6TPqRGXu1mF5aeFEhak+3rB765Th2HjWB1mjw0KQ=;
        b=IFewanihrrT1TgGPd8cdInUlQKTcMcIWBuBrO+3B6kIhEtWLUWv4BlGxl8pi7ZvyWX
         xtJKXH8LlpnYHAXYy2LVY2dHNdGw3R58hoqv3JU0zym3Bm+x6bTDkUdNBq+lycyXNC9M
         RZRlDL0R50NuUY6s6GJQ3l9OtxM7KrcqkFLmSsDQ7erj9p5Bq2s2GPEIPKFTFL/g48UM
         +XhH635raBxPKDYXe7Pdxqpgle9kGTbN21OYZpmLREwj9sQ0t+Qg0z7VC/qIHnPCglrr
         Fo0CvwLJTopIhLcRl9umHvVg/GjZMj35nmE5TWGiTCEwT7bKKbJ5+dNTpugJXvmCym7q
         EUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883690; x=1731488490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGC6TPqRGXu1mF5aeFEhak+3rB765Th2HjWB1mjw0KQ=;
        b=nzSywTTTGV62Z5GpfDjrv6lm/yevp1j/F37sNrgJys0Pw0WoSxrPjRBHf0dc9JXaeO
         MXJ61a76hG6uBVL2f4DDZ18WAYIw4gr62IHpDu820ckJEfvkMIvn/5Pap+VdxPEiQgn5
         kwuz5ydO4befw/mdpjpJGyImlyb1g5lHhjWrzzXMt16iWYTYYZG8yKBV/ICp/sge6K/h
         GMi5BhIJB282HpF4wu1vcEiVgYCNbAR77/ApBkCLWvFcfFMiQicLp4atPKAjqq7icESm
         HAjjXscyO4Grc/HqSedEsc+3YpG2L8Y5JDu6euwK2VIzLx8wK3KqiLmoJ5mOtGx6lZcU
         WNVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQOAJ3HpKw1aNb2+CBKaOsHabZMelX8ZD3pEMmw6vNCYXi0ljIlwbRiQcpdD24Yy8/Fz8q4veQ7LPfTic=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+vRbMMM56qr68pSld0EBtcj2cYW8GIZZtlpgKGsyfp2vsJOZa
	sI1VQwYMae70lAcLd7Jns9JeDzV2w5GoUfZluxQAYle64H1iGmFpzX7uWA==
X-Google-Smtp-Source: AGHT+IEERyee8yuMkqt0ER6m9QzckotlvCf7D5ZemQxV4YVnYPTWKduYZ7ohuFoSiKwCKIa+Cet3hw==
X-Received: by 2002:a17:902:dace:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-210f76d6870mr381219045ad.41.1730883689798;
        Wed, 06 Nov 2024 01:01:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:29 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 06 Nov 2024 16:58:52 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: add hdd board cpld ioexp
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
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-2-3437bcfcb608@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=2784;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Ma7zHm/VTawO0uhZBJJdi+x5g2IFHZE6w9ObR9Dz8mM=;
 b=9Mfn75WH2EHATjpkT8yHXktIYSE/oom0no6vIbpn29BER7AETsF/1yGpaSr1mOLp8P1Z7Jnx7
 BC/PFZV9qOlBWzy0AXX0GZ8TtazizPmWZFVoFLekpIsrhZ5YsIhjCBL
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add HDD board CPLD IO expender based on latest CPLD firmware support.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 10a9fca1b803..102d71234932 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -632,6 +632,36 @@ eeprom@51 {
 
 &i2c3 {
 	status = "okay";
+
+	// HDD CPLD IOEXP 0x10
+	io_expander13: gpio@10 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x11
+	io_expander14: gpio@11 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x12
+	io_expander15: gpio@12 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c4 {
@@ -1067,3 +1097,38 @@ &io_expander12 {
 		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
 };
 
+&io_expander13 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD0","wP12V_RUNTIME_FLT_HDD0",
+		"wP3V3_AUX_RUNTIME_FLT_HDD0","",
+		"Host_PERST_SEQPWR_FLT_HDD0","wP3V3_SEQPWR_FLT_HDD0",
+		"wP12V_SEQPWR_FLT_HDD0","wP3V3_AUX_SEQPWR_FLT_HDD0",
+		"wP3V3_RUNTIME_FLT_HDD1","wP12V_RUNTIME_FLT_HDD1",
+		"wP3V3_AUX_RUNTIME_FLT_HDD1","",
+		"Host_PERST_SEQPWR_FLT_HDD1","wP3V3_SEQPWR_FLT_HDD1",
+		"wP12V_SEQPWR_FLT_HDD1","wP3V3_AUX_SEQPWR_FLT_HDD1";
+};
+
+&io_expander14 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD2","wP12V_RUNTIME_FLT_HDD2",
+		"wP3V3_AUX_RUNTIME_FLT_HDD2","",
+		"Host_PERST_SEQPWR_FLT_HDD2","wP3V3_SEQPWR_FLT_HDD2",
+		"wP12V_SEQPWR_FLT_HDD2","wP3V3_AUX_SEQPWR_FLT_HDD2",
+		"wP3V3_RUNTIME_FLT_HDD3","wP12V_RUNTIME_FLT_HDD3",
+		"wP3V3_AUX_RUNTIME_FLT_HDD3","",
+		"Host_PERST_SEQPWR_FLT_HDD3","wP3V3_SEQPWR_FLT_HDD3",
+		"wP12V_SEQPWR_FLT_HDD3","wP3V3_AUX_SEQPWR_FLT_HDD3";
+};
+
+&io_expander15 {
+	gpio-line-names =
+		"P3V3_HDD3_FAULT_R","P3V3_HDD2_FAULT_R",
+		"P3V3_HDD1_FAULT_R","P3V3_HDD0_FAULT_R",
+		"P12V_HDD3_FLT_L","P12V_HDD2_FLT_L",
+		"P12V_HDD1_FLT_L","P12V_HDD0_FLT_L",
+		"HDD_23_PWRBRK_N_R","HDD_01_PWRBRK_N_R",
+		"","",
+		"HDD3_PRSNT_N_R","HDD2_PRSNT_N_R",
+		"HDD1_PRSNT_N_R","HDD0_PRSNT_N_R";
+};

-- 
2.31.1


