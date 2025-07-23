Return-Path: <linux-aspeed+bounces-1800-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3BCC87FC5
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjx1hm6z3bh0;
	Thu, 24 Jul 2025 09:30:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313429;
	cv=none; b=NrRAkSnDCxa7ioSjSA99b83LhobvYaySMdeBc33/vEXiqKALiiWlMmENl+xNvU47mzdlvsF+G0+QxZ5enu9LMDA2cO79cT5xDozi2Lh94Z7KfnWIXrB2Kh1PPSFwy4V+tyrS4GVpa46/clb/giIEWBunil95FN6YgPZWK25XDksez/YLMsZDC4F5RVyAOnP8zkMVlfJhe/sRffR1mQalnz92em+ZR01jYC1Jxh6sI+jLE51Lw5bUDPdkhEKoDfQJYv1SJgERdWTb6vJXHSNTF41RngRnGTEfCr/bdWiGMmIsucgku7w/nwRbvv69A1JRgqPuQ/jPTcucxpTqDITk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313429; c=relaxed/relaxed;
	bh=RkVzo5NE0GNCbJSinTR7TyExPK/C8GmZwMd+EFgVEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI9ikjimaep3E5PDo9gtz2HAb/WcpCEJj38XWoDoh+sM11xlgSsA2klvs6Lvz7j+nqcfXIOSn4kIxqjuOVm93TorywOaGKK6pluh9fIsxxqFk3xHctSaW5heu5ry8E4kP76dgQJeZfHhkQrhcMtfTdToaaR/EJhfo3sYg1d2ZdTX4AYjiiClFCDGwGW/CAXAUCBEeyYvq+VTKgtOTnkmqjizDNgjjZa069WxC0wQBdv7s6YsRvE2d35e6yFiCiK/lejcN9bn69HjzOsHyZ3F0t8iC/ZuM+hT/O1HnZjfgkSsuxhdNZiQNYZTTb1OMbknC/OG30TFJMkRov3yJ43zMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YtfhxHXm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YtfhxHXm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjw3rspz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:28 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso510817a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313426; x=1753918226; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkVzo5NE0GNCbJSinTR7TyExPK/C8GmZwMd+EFgVEoM=;
        b=YtfhxHXmWJHgBvtsn2SwgK0XLMjej4iJHlKXNxBqQKL2Ik1D7Bt6nRACdjVieyPBLO
         kXzTPYfr/GoivxP+hIeu4wb5mmRWRsPXaS2puU65NBccgO5lacWxgez0/XTLehAyVC6M
         gPhH4l+J2GdH0uK4SB6+7Mev0UQS8UNrJPRdNX9zzhNE82cggU2lWD1guDPwIm9GrMuq
         btAXYoMTCAXoF6YGgVn6SQMkr3w+c3TYwbk6Pa3OCWxiUlacrsktdXtFY2a/ZysKWYw1
         tUN0yp7gYOcx2r/e3pPg7kUtEYvTl0qap/XyuSjX68HEHvJHma4Zhn1ipVAEyhEjepJZ
         138g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313426; x=1753918226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkVzo5NE0GNCbJSinTR7TyExPK/C8GmZwMd+EFgVEoM=;
        b=JOm7ht2nwTYQeUSe5a+pLJvo9ZtK47z0v/esPa320GicjyiFitbR+owAgQ++ou6/zL
         RT6AHGWddIwDzbkVCetqKySepRt1LJcD92UmoP9njjaPiQpIgnnY7G7JcHNZinRRwAiT
         uFfKEP4pLVsw8EqclAWO/C9T0eGZFqegpZd2N6vhvGTXBDqDIkZPx/2hp8xoQtwCD7B3
         GYcEEek10YxgpN9fdiuCVa4OKNKe4a7UEQUX743sa2tB5GLDDCmuHaBEMIMiN0rzY3dZ
         LNYFTqxCmtYGTYbxfGBQznj+JCTGbm6IVEffBB60wlWzGlInLr4r4yK4cc4KRJE84U+a
         ssLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOo1b/ELCWnRH1IcUF6jTVHnrIgyFMeryj6yiBYhjs/l0+W6gTCfBXRTBLptgY+3am+VAb2aOnHsGnLWs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVuEmomuRFINfMo35bG0ncMWthmb4PYqtQ2nqSiKq8+htg1wk9
	hXlyDiF+90E0XFwWK7fuR9nfZ8y5n5S1jnVbhjmHAqUJIOvQqTrHHgMD
X-Gm-Gg: ASbGncvAtC4tb3BxRBOE+cC0w9qArPEd5O95OE2XZ0/vKIIhSsV6YA9/brqD4YksMLM
	smvwHtfVdVnNBJPaADwKZjSuH4VVBwp20q9nrhXL/1Ahe7B34NmndAee5lCex5oTGdJfG17MBME
	0ei3s+HeEir9rv+dAvvoB4JrMKG52ZUQzusrs5aM4d7AQvWpvJ0Zk6NjVZsqyvshregxTOXJ4rR
	EOdT2fbtGjtYEfSJOMLttxjSwClWN9mHdvoGsGvBJhgAKTxtZdNmB168aOJ+tmfG0d+W6LV5jbf
	tHtQPTYVfJpIq63Krp+cqc/tyI29B30+rFr1nZ2JiW6r9TAHeFPtVCwMNFDowMu5SjwAw42dzw1
	RmH2lvGXlkebIJ2iGsP+0GBAMBBFIyqup8uR+RLj4sgysdpEJicZ2cTl9fNNBkKtxoVX+WUVFeA
	E=
X-Google-Smtp-Source: AGHT+IHzWqipQFV1rlMjfGMj2ZYctdbfed8wRJ1YF4iYb6xdbsKUiD0L697jJ9ynyQV7v99kSM5TEg==
X-Received: by 2002:a17:903:2b03:b0:234:c549:da10 with SMTP id d9443c01a7336-23f981d2e75mr67924515ad.47.1753313426507;
        Wed, 23 Jul 2025 16:30:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:26 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 04/13] ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
Date: Wed, 23 Jul 2025 16:30:00 -0700
Message-ID: <20250723233013.142337-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Move eMMC entries from ast2600-facebook-netbmc-common.dtsi to each
platform because eMMC is removed from future Meta/Facebook AST2600
Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - The 3 emmc-related patches in v1 are squashed into this patch.

 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..ff1009ea1c49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -201,3 +201,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 840d19d6b1d4..d0331980d082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1243,3 +1243,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 208cf6567ed4..0ef225acddfc 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -156,18 +156,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.3


