Return-Path: <linux-aspeed+bounces-3540-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81425EEC2AC
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:06:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKc1K6hWTz3cBN;
	Tue, 24 Feb 2026 10:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845479;
	cv=none; b=CppBV25LuQKqHGMZlViIskQOVYIvzOLYUMXD26h/8zzKlO0WatHzh6MDa4uvUjgJz6vRO0zLcYY2MF78oZ0VxiXsiy2tY8tKk/IyHj84NUuDkjK25kXsKqz6qUDqt45uQkYRPc0sErTiVNzshN6GpXuqBHh6FE4csc9uxPwclM5uTGnKSslA0B9y9kUWGTq2ZK8jWasiAebn3k1eGJRJkYvvbHh1zG2fFZzrrFmjWGdDeLA1HaxDvOjX05elkaitkg3eV55Vigo5bw1D4mQQFqthDNPEnM+PEtA884OiU3gp8TDIVc8SCREt6QgxU1nzyH0gPbtj3myisUzbpApPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845479; c=relaxed/relaxed;
	bh=D5vVMT1zbuATIKTYy3lzElq9T02DZlHlvtVffec21kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qis3YPjaTNqVQSUEm3C1FD0a8Ta+ozIUs0rPamCtKaB3C5rB6Qzn4Y9yMAoqVcT8Nlt5hRaRdtPu1132SYiaFnbEb+DLMaJkvLs5lHglR+3mlNqKhDIp3/Voe7hfg8wI9I1j1XdVnXGrI5zKUF5/gBKYSOzMO3zlELc9YJon1il3VH+BXk+8Fs0aaP+wpPtBEi0MoAXHrOFDUcmuM5p+P7o60yReDEulHGAn6WbC7r++GyGbOw+sY8hcs060+0v4jxol/Zg3RDSjekos9AZa5+PYm2lE9FgWi8TrFWJ4OI3RrHxJuYa/ga+4YnC2XC+hDdJ/3oLB4Yy7r8xlkaM9SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CTB4+fGw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CTB4+fGw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHV6yCKz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:17:58 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ab077e3f32so16885405ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845477; x=1772450277; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5vVMT1zbuATIKTYy3lzElq9T02DZlHlvtVffec21kE=;
        b=CTB4+fGweDvNKS5rQAb9W778ZNLMN6Odsn1aQ0YlMlxNHlOAG1PcxbZhkv/zX0cszK
         iavAXycPCuhZ1SCzR6/y0RK9MI4Tq/qhkfykCy8CFYtOrIbuXcwx+/8Wft7yRnsP8MoS
         P9FQh6qrb6muXFipO4lJ4idMJtV2xzpMMjvRpMeXymyR/JnWDJm+mI4SlCzxJxQdqAk1
         42kQmlrDWySpesH5ng9ID1ULk+h57jE1Ke+R1l71YolgXYsyIe1v4gYV8m0WrULTGnp1
         8umpxbjNzkEtcCFsh04bnmIRuB0rwtqF2pWX88mtvMPr+bRy+o/kcbvQik9g2TB6BsoE
         nPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845477; x=1772450277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D5vVMT1zbuATIKTYy3lzElq9T02DZlHlvtVffec21kE=;
        b=kGisMLjGCTmcmQQd6ndbr4afkkNW5+Vz519T4WGWiHbdUgVQtJ7sAnXsUfgaC2KZqQ
         2nI3ycMaAWEyCZZCmyu8ZGVSKIFCd7yNktJZB4z/2oNJMdm+A51yfeXb7uh+M26n/QG6
         7CjklWYtqv77ptBcqBEFYhRxlcMVYwslMbi8B9XvBzOTzMsrrdmsvAUFofQXW8zSJQRy
         0myMlj0xU605MRIZqMcgO3rWHs6IT7neCOV8AwASHzYkAwCvwUFEuPmhvU6EHremMq1F
         rAy1ChytBZDb4d9QKJjCcVyueERR5pcP05RBdJo/Yxd/aLcBywQrHx2+h3fLGZ+Mn2/J
         Ad0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmCJlpje9XcpfSl0JCF1NJldHCf7hk2GAry6Dm0qQydyitkqPevxdAUAW6zB28lzfJmuieIQhg+XcoDIk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHWkY1iiXfk8h4QtsPlNWqFHNkOZm1M7LKNjdVm2zY3ELpXVQY
	dkRIxXsVHvFs7/ckwPziw3uoYuW5uML5OTZ3D0RxGo3/jUm58CwkpBEBH33PRg==
X-Gm-Gg: ATEYQzw1/gChctgyDgIIH+ItSzhc3dXKihubhRAnotln66bpEZZMCG5rzj8oqLRjmfX
	9F6uqfn/n7fKKChkdzi2/AbK21qiZrjal0p6eyHAM2QDn7NMXULYDMzNrDS31COL/Lfbn+BKkwK
	edxxr24AME5QzdhgznYcNlluJinLRruYwz/R8WqCKdc7dye4DUqgEax5dxVJmj/meguxPByC0OT
	mpur6AdpopTMDVLcLl9DWTYY5jMCQ7XNjJgJAjIrynsMkuyexGVRa59xojYGQhJDGkXFyEsAO3T
	5AdM1qaeOrLbQ/riPTvxetEnZYFUoBHYKUcpfMXVzdqntXcESa6UAUyVCofeo6Da5WJGvlAmE/V
	41TfXL+z6Jc9xGfQ0CGKosTjrEARPMyzeWxhjqrrT8fYhoXXmvc5WzTeRnI2g7y+3iWVLui7btk
	7QSbJMxZsqUjpGMm95AeFXTooaIYTrDI52anczUL4alinfeFy7H5Fu5sC5SCgUxPXsd5sUqxhkC
	s37v3QWvyLQ2jOSxaMgU/kPwLivM9N3MFQ7WMySUfH6aMW7Ycoqj0t3MXmntJZauOdwPNIgzbxH
	wm4LeWjl/LMh+gcgY0tc
X-Received: by 2002:a17:903:1904:b0:295:5132:1a99 with SMTP id d9443c01a7336-2ad74579492mr68714575ad.44.1771845477264;
        Mon, 23 Feb 2026 03:17:57 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:17:57 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:38 +0800
Subject: [PATCH v5 6/8] ARM: dts: aspeed: yosemite5: Add power distribution
 board IO expanders
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
Message-Id: <20260223-yv5_revise_dts-v5-6-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
In-Reply-To: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=2527;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=XhvT0QVqfubc2SFF6jrDcroi321rW0noJl73B6I6iXc=;
 b=O9OnQ/chzEMf/fvHPQWK4maR7cBtWJhmUprWi2xvvAQHfu7EDK1fmcNdRzjOSF3QVoZVZK+QC
 WQ/rCXtpalDBcJGTTwGoiS/y0QJ81L4P9kiJl4xJ4N7dW2ctbdTUDCP
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add device tree nodes for the two IO expanders on the power
distribution board (PDB) in Yosemite5.

The updated hardware design introduces these IO expanders to support
fan presence detection, hot swap controller (HSC) fault monitoring,
and PDB CPLD update status monitoring.

Connect the IO expander interrupt to SGPIO92. This pin was previously
named ALERT_PADDLE2_SMB_N and was unused by the system. Repurpose and
rename it to FM_IOE_ALT_N to reflect its function as the PDB IO
expander interrupt.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 524597a81365ef10cd03b67d35eeb88a965cbe0a..30fb41fdaeb7a2276cdfe98654696a16cf1de5fc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -389,6 +389,46 @@ adc@1d {
 		ti,mode = /bits/ 8 <1>;
 	};
 
+	/* PDB IOEXP0 */
+	pdb_io_expander0: gpio-expander@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <92 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"FM_P52V_AUX_FLT_N","FM_P12V_AUX_ALERT_N",
+			"FM_SLOT1_HSC_FAULT","FM_SLOT2_HSC_FAULT",
+			"FM_SLOT3_HSC_FAULT","FM_SLOT4_HSC_FAULT",
+			"FM_SLOT5_HSC_FAULT","FM_SLOT6_HSC_FAULT",
+			"PRSNT_FAN0","PRSNT_FAN1",
+			"PRSNT_FAN2","PRSNT_FAN3",
+			"","",
+			"","INT_SLOT";
+	};
+
+	/* PDB IOEXP1 */
+	gpio-expander@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		interrupt-parent = <&pdb_io_expander0>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"SLOT1_CM_UPDATE","SLOT2_CM_UPDATE",
+			"SLOT3_CM_UPDATE","SLOT4_CM_UPDATE",
+			"SLOT5_CM_UPDATE","SLOT6_CM_UPDATE",
+			"","",
+			"","",
+			"","",
+			"","",
+			"","";
+	};
+
 	power-sensor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
@@ -937,7 +977,7 @@ &sgpiom0 {
 	"ALERT_OC_PADDLE2_N","",
 	"ALERT_OC_PWR2_N","",
 	"ALERT_OC_PWR11_N","",
-	"ALERT_PADDLE2_SMB_N","",
+	"FM_IOE_ALT_N","",
 	"ALERT_PWR14_SB2_LEAK_DETECT_N","",
 	/*bit48-bit55*/
 	"ALERT_PWR14_SB3_LEAK_DETECT_N","",

-- 
2.53.0


