Return-Path: <linux-aspeed+bounces-3455-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CAFD172AA
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V80PNQz2xjQ;
	Mon, 02 Feb 2026 09:41:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761235;
	cv=none; b=Xpoqv2B4EucUHYQGDMbY19oPNic10kUyVVQEvgvCUpxJgeL/QWTrujUlAtKmmRxGBfOdMZ8hFYFWeVNE2Sw8l1RP4ZoMAIGR68tqrXCQ2aWxDXaw4S536uHy8xKxkAyCOD+9DNSw38GcNbTxPvsihN31xVWXRIhQ36hhru00jPNGeG9NpKMoLPzXsFhCIStOia4G31Xu5afOuW3eGiuw7bXo0GrqJkfm5y4ylr4hLNJ7cM5OGkr2t8S1kX9psbZMm9mFmoJCyAx+/bej86vk5nXpuNt4FhbSKXMo3OTDXg6fhihQyx2QSIBMb225gj/iZXpNLFgkV1nNcqaN3ON9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761235; c=relaxed/relaxed;
	bh=iYbUGVE7c7id+MiIunPPyopC/JujGSCKOd5+ZEtgyBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXI6+ljut5k8VFQE/1N1Td1IlbBzYVw5PpCVkqraIG3BXPIVYZSXVXFFsXEUGz3JEiVzqFB0RVAigt0lbKPmCg8GlefKbM1PHSugDw4DykPG2k46hUiih8sK82zfhT9o8qrkGhhZMa8qcJYwnrJvSUBduUK0lSiEGpbMznKNp7yEv9kbhOuVsxks0/Xw62RvqBIFVWQ+DEDu6ViXscjm4ZylFnlpD84nekobVmFBEG1g9J8MKfVW715FaR2cE3AdHyerbaiAzvT2HI3HJkmgw1YSuO5cvpIIryeoe2wD3Pol9Bn1dX0raxkc+ls8+BSQU9euzXHbUlTGKDJ1ilbA3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MjFKLWsG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MjFKLWsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTv0w8Wz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:35 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1019854b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761233; x=1770366033; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYbUGVE7c7id+MiIunPPyopC/JujGSCKOd5+ZEtgyBw=;
        b=MjFKLWsGxg+D8h1dV/Vj0UKcyRAMBlQIqmVrUrD90nr4mHjPizxZ3GQA7GsdAsAlBd
         pK5WpTsbq7BcEIF3QNzJYJd5cthGEL/5O4seGiU5+CpPrVyZdrXNZg41Fbz4XoCUcOEQ
         L1HdoX69hVY3x8J2dsUlg5VyLfEJdvIgwLCS6yJEyWeZFG93Ka8+wZmHfJgNuXF2Nvcf
         /UaDAXzprqvQJjaXiZ/M9UYK3RUGS3A7MGRemNGHxj+ILlD7gLgJ7D0ODjBonvnYAWGf
         Hf1UPtIMDhHM1Te4dRO3f3NL589kDtI7gW32PKpwRFWbTaIpFqoYGbtYk/5kTBoANCxG
         xLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761233; x=1770366033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYbUGVE7c7id+MiIunPPyopC/JujGSCKOd5+ZEtgyBw=;
        b=FUSI3ZAuGVD+Vc7ZbCURIyyqYklOuE54c67d22MMFPmdKu/EeFCtj8akKpGBOj/gv9
         iC6YqxK4jRQINwEf+0E6Xp1MXgWnP5GVgUY1q0pgcOegTPbdHoMsciOuZReUTG/eCTaj
         OsQoPB+FlNUAsUL5vOYzHsvSQ4p1271BNFQSppo2vUizCjfjbMY5+Zrl43y8JCBayQ8C
         7PpgYL4z+lKU1lZKn8YDsnJ9/76kzbkSnSzJadXU+PLCab2O0TJ3G0srmWOYPtw/98eN
         syQvCE3HJqT4eieCc4J6ZU2HtaLjwoRG6O280NDEhpEK93gn5sS/pbWKNyowZUkEg63y
         xR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVMdhxRnWl/yyiZ8ULGDn8lLbBLZC/d22j97B1+E1lhTXKfbNG6iOygrJwCiAcNKSsPCEIVnyC4/4SAqyY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKpgmkRt10bM7CxIJATs8iFR+/Nn1jU9T9X08a2XfHsARAlHvd
	8CWQT6/tfWwtKxfxaOkuqy3om2PqdLxjgtTIf3KMHA+olwnzVoIbcr5Z
X-Gm-Gg: AZuq6aJmDRyzmhXsFY4hD/w277v9hk3CSDqoep/tc6LkwkuCn0D94ANNMWO1MbEOi7b
	//vkdf9kH/fXri/7mu4RXpzREZfdKc59WQcHrX2j1lu1QcnCMycIcu93fginKlS8k1zz7/SAVlu
	t9h+UvbNAfZW8YBV+kB5iuYGa0saZbHSd4PLYRv6kCT5kh1UMQyUgr5leXg88Ga1NedUre+b0zz
	UF8BUKpAXloHwetlonTOpxbnERLWyCD1JZQ8JYo3M33Tdbc41PnlxkmO9P8sPLvMITRHy+qV2BF
	JJMmEDLv0SFx6vfVr3rKH7qSaoVx8L82Sd0V8U3JCpMB/wCCy7HhL7DbaOwftazd150i2w7IC3I
	ZE4BFbmgt9/+2499F1DDvghb48Hceh9VWXL4hjZNbIAqV++07oFL7aUTxkSU3+CPDiBqiP+T/aL
	kpCKijIjaCmGDhckia7c1S/dWLiZHGsBOAXg+sCjDZsPurPPKpJxwgj2G0OOG5+YGr/w3d6jsfZ
	AOhOSAkJET5X13qGjTZjEgAqAjm0V/LFkR9utRRtUxH3sZ6Ix9PWeSSZHuMMJqTWGxRtFAtrR6A
	Nt/yRubvETq9
X-Received: by 2002:a05:6a00:b47:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-823ab670e70mr2255776b3a.23.1769761233312;
        Fri, 30 Jan 2026 00:20:33 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:33 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:20:14 +0800
Subject: [PATCH v4 6/7] ARM: dts: aspeed: yosemite5: Add PDB IO expander
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
Message-Id: <20260130-yv5_revise_dts-v4-6-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
In-Reply-To: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=1824;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=NTGKevMUAPMV9E4g5zl0RMUalv3BlRNqGivNE3JH5S0=;
 b=EKe0E7xkKfIl93ATKKmxvOzRrcqGGBGFkA7Oq65hguM7RoXuXfiS4HXbDRBXhjCRF+7YLemSg
 uyF0pu4T5YwA9uz4uT6b+JFmyHCfLYHWs+2IlAaz+l2+H7EOwjbtrtb
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

The new hardware design adds an IO expander on the PDB to support
fan presence detection and HSC fault monitoring. So Add the PDB
IO expander device node to the DTS.

The IO expander interrupt is connected to SGPIO92, which was
previously named ALERT_PADDLE2_SMB_N and not used by the system.
This pin is now repurposed and renamed to FM_IOE_ALT_N to reflect
its function as the PDB IO expander interrupt.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts    | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 524597a81365ef10cd03b67d35eeb88a965cbe0a..48f864b52d1a22b12f8a39ba9703a90349ed930d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -389,6 +389,25 @@ adc@1d {
 		ti,mode = /bits/ 8 <1>;
 	};
 
+	/* PDB IOEXP */
+	gpio-expander@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <92 IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"FM_P52V_AUX_FLT_N", "FM_P12V_AUX_PWRGD",
+			"FM_SLOTX_HSC_FAULT_N_FF", "",
+			"","",
+			"","",
+			"PRSNT_FAN0","PRSNT_FAN1",
+			"PRSNT_FAN2","PRSNT_FAN3",
+			"","",
+			"","";
+	};
+
 	power-sensor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
@@ -937,7 +956,7 @@ &sgpiom0 {
 	"ALERT_OC_PADDLE2_N","",
 	"ALERT_OC_PWR2_N","",
 	"ALERT_OC_PWR11_N","",
-	"ALERT_PADDLE2_SMB_N","",
+	"FM_IOE_ALT_N","",
 	"ALERT_PWR14_SB2_LEAK_DETECT_N","",
 	/*bit48-bit55*/
 	"ALERT_PWR14_SB3_LEAK_DETECT_N","",

-- 
2.52.0


