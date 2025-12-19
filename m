Return-Path: <linux-aspeed+bounces-3182-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62213E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFXD0nMRz2yFY;
	Sat, 20 Dec 2025 17:55:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131870;
	cv=none; b=KDGI2RhJeKI+aRn7ZqKzwsEFFLt5DNVTkxH7rwQ4TfKpnaUpP4YMkrf7kJKOtQ9TC1bKcFSqZxkeN64CZ5itw4Wjn4E1jZfaKSNli+oYqwRVCm5b29CVrn2+SAHlvio3SdkSdRcjNimP3Zmv/pJYNyIvPj0OOOd4JxNHRq+1BFgD++8r2XfwM2xqPGJP7Y4Mr9v9zUaveqQH5OrZJue5IafJpWbLORPIXufCiaAFyj/Ky6kapXwpj5Xmj8WsKy64S8ZP8tiBPq1AD9q27miu2j3539hFMCyem28+DYXyOpr+uw6KSvRvuf5K24qoxxPaUL/pAi9+ilUsfDvDk/kxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131870; c=relaxed/relaxed;
	bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgMZfdPBOUdhy+ZMCxRZVTA2Zeirbe429IvZei76HI8u0Ux1fAuoOq5Bb3NEzgzRRXKRDaGYHvdetlPk1LTuISRn8Tz+ZRXrVMP17+JnjsdVp3Vrgtwx/mGzTPAzOguRYJFFlxme3YQIcaGQmDzByjnjUhj3sp/TmK7TrrSSVRWwWd/D6PppqOjJLXiYugnTYeytQJhk0DviJCacMorNMXkAgUr4uUuxf9/ZQ0vyH61C5ljwOBGqaP32lAkuWS4umeHNOlb1KGN1ThT0i/ntrcQMTwuO/BMbF7Wa7G1Z9ufCYZMVZiUs+y8ZzXw/OqceA8wm7dF1oliZnJcDa2064w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JsL67Ftq; dkim-atps=neutral; spf=pass (client-ip=209.85.210.177; helo=mail-pf1-f177.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JsL67Ftq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.177; helo=mail-pf1-f177.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGQ0QNXz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:10 +1100 (AEDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f1243792f2so1054128b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131808; x=1766736608; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
        b=JsL67FtqHuYZcedyGBSGCoAQbLZFpEBGexBTbQPpcs1lSyiTPMHqM2RexJbnA4xO3V
         TElhVTiAWMi6RNRf3reQihW5kVkdmGyuUVazg3pFCLs13bzUmfFhuJ1mr0Rd9x0WxXym
         oYo3mPh7/ld3hLs6l52MjZ+Ey9arZ00kJUFDDuy/MQ4caVT6yP9/YIdvJ6lIyhZYqHVT
         nsXXFEhbFyUT2QhpcRasuOzrRLolcEsAsDP4dgCEYPhEpSNQY0JeJNA+DiaGrZet9Vzw
         P/vAnWztY1iFKgrY+FuhUMQ1swjR/iRQIHGOGnIRAbWLaSasNpVKIQtJs59+Y6I334vI
         Q09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131808; x=1766736608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
        b=dI70jHqWReEk2cq3u4l1+oIjd2SwSb0VTNknEVeCoCcb0ealV4pYnWLbbje3Bjp2sF
         WyJEvBt2E3DwKYyiXvhCr+GWL2j7IkRh1yzSDoHgIhiXTXF/kDjQuEG56wK0RQsv77N8
         cUFEgA5o6Y3ka36SIFNgTJOduoz2RltoMlR1f9xObHprh0p3+xl4NJugot+GGqLCzxBv
         i3lm3od4pexDrvIxmw5yHfNgl5nm52Ztp4iiJtpTWqqH7unUvmaL07+ixAMLJRD1fX8+
         l1cT3Wx6BJCn3lGzerOUvYL0Jk3Ag7PIQlThcCk9NxMjcDs1DCrDnu6hSncsH+c0bp/3
         kuHg==
X-Forwarded-Encrypted: i=1; AJvYcCVAGQWf41Iw/veoG4zA6PicxQGQgWrJ+L0TLGYFuDu2JiVe5ozD66YJUfTtMTDhhF13y6w3qAsMQRhNdYo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnIYYdDSMQl6ueG2Flfrh3hRp0UIH72vQTnK3sussdcRVXRNv3
	1xRHBppZbHSEDF1QK63JlwIuRX2njobvNmabuVB9S5kIixDrNRy70MeR
X-Gm-Gg: AY/fxX6pVGjuWWewXTGQ6rGq8qN44ZwR/injUhKlEkLQtgay5OPkK9zqZFwZ8rnO/Y+
	CGkhZZUTEN1SrQnr4cVnoEnSZbS1c6ko1uVd2q/gkJhlESg4Lq5OFPzwIpfh0a67RudN2sibCRD
	k7LDvFxFGkUtsQdOneeWVBvlVcUco6MVvER85CfkqzkqfBFp8qBWmy3fHy0DRY/OtTjO2ehq1Uu
	HNemF43vE4a25hpWYQgpnUfDGYyTffDRVvFdUk8vG1R1Ljszzl6JdsPTh9aVS/1C/w62cy2nQ6r
	AYUlNl0T62UfL5n1yaWvDg+6suH5cUqxSiiH9im6RM2fvIA6jV4MXAYV38RdUvup62IEEt3Cp7J
	llJEOQPFfLgxXg381EhM6Upo969t1rmZPOXw1kgxVr5iS9sfJK8V1/rfuKCvkO40S1O8xB6JNxS
	+QYe3L/Aiad1QPmia40TWQQrpCRx+8KO/Ud6y+F+xrxz+8wCsoiveBbmBUbQH52irbbg0h9pqqP
	QtNqVnDf1q7Y+u855uegJa57WYynzCGb9129N6VNWvScjUOp0cNHFugG+YzwhWfeaC0ciCJQxS+
	uBln88/fbmg=
X-Google-Smtp-Source: AGHT+IH03b4+jSie1GtQ8+ubGota0N33xeJ3WXg3aVbp8UHxbGm9Xls37ao3K2cBu2+EzsJRbtyMVg==
X-Received: by 2002:a05:6a00:3409:b0:7e8:43f5:bd47 with SMTP id d2e1a72fcca58-7ff6725978fmr2012408b3a.51.1766131808131;
        Fri, 19 Dec 2025 00:10:08 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:10:07 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:09:56 +0800
Subject: [PATCH v3 3/5] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
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
Message-Id: <20251219-yv5_revise_dts-v3-3-ca1d5a382013@gmail.com>
References: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
In-Reply-To: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=1856;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=bf8xEERmNoQu6JKiJbQyzBDcSJlpDrQjBle4TDLj5zE=;
 b=8pOWULTXthC45NBzVPT2fNC0LDr1UhXhIrPRavW4GSG7+HeWQ1n1MkgrFLQ3L4agx/PncSGEF
 D1a1C0Hpo4vD8qtIs2BisigZk1w2BTXDMGc5g2JLrjPaXrKDbyVd0Dz
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add new SGPIO line names for user space monitoring and event logging.

Also rename PADDLE_BD_IOEXP_INT to ALERT_IRQ_PMBUS_PWR2_N to match
hardware naming. The original PADDLE_BD_IOEXP_INT is unused, so this
change does not affect current system functionality.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 31 ++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 45b8ac2e8c65a4f672e64571631b7f6944f26213..983aebc394d9159c7e3db2e7c39e963f7b64c855 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -978,7 +978,7 @@ &sgpiom0 {
 	"E1S_0_BD_IOEXP","",
 	"E1S_1_BD_IOEXP","",
 	/*bit88-bit95*/
-	"PADDLE_BD_IOEXP_INT","",
+	"ALERT_IRQ_PMBUS_PWR2_N","",
 	"FM_BOARD_REV_ID0","",
 	"FM_BOARD_REV_ID1","",
 	"FM_BOARD_REV_ID2","",
@@ -991,16 +991,37 @@ &sgpiom0 {
 	"PRSNT_BOOT_N_FF","",
 	"PRSNT_MCIO1A_N_FF","",
 	"NIC_PRSNT_N","",
-	"","",
+	"FM_CPU_BMC_RST_N","",
 	"","",
 	"","",
 	"","",
 	/*bit104-bit111*/
-	"","","","","","","","","","","","","","","","",
+	"MASTER_PWR_EN","",
+	"MASTER_PWR2_EN","",
+	"PRSNT_MCIO0A_E1S0_N","",
+	"","",
+	"PRSNT_MCIO0A_E1S1_N","",
+	"","",
+	"","",
+	"Fault","",
 	/*bit112-bit119*/
-	"","","","","","","","","","","","","","","","",
+	"FM_CPLD_RSVD_MCIO0A_SB1","",
+	"FM_CPLD_RSVD_MCIO0A_SB2","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
 	/*bit120-bit127*/
-	"","","","","","","","","","","","","","","","";
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","";
 	status = "okay";
 };
 

-- 
2.52.0


