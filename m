Return-Path: <linux-aspeed+bounces-193-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C58E77183
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:34:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D3M1zjCz30WR;
	Fri, 13 Dec 2024 00:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010479;
	cv=none; b=PRK3qeqY79BVuupImvbkT7Vxb96V/q2Rc2Fbm0pWqW+tc2y5/IZBkmWK8z0PSKDAQ2WtFL4TkzZsafo8YldhLEZybscr95eJaQXi50lQyhCoj87mZtE2RmLaz/QW6xbgccv1rx7vVN7tmjg+Rwi0rgRWvE7W8zxII6vTvQpsSGYR/Gk54fk/6FbyEcYfpKyh8MTcD2JK+gM11AyWCogXV9nee1HrEwGnswEGRWAd4v0Jmnbr1993jWt8Eb23X8c3piH8l3SZlWr5TE48b5nvSA+TTrXLr4RpGgOAJgY0HhCS47go082mBDF9l3G83pfOhTJ4i076SUC52rrukvOm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010479; c=relaxed/relaxed;
	bh=MWMAc4zmfYhsrt0DV+vmCYXKX/GHYBxniAba73eEZ6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Euga0Z3RTnp/ETna+DfR+zv7J88wr29hV77w3eV37jpvPQUuda7/OuN+jK2jNFBdkVz/nHzDqbZWvKGPfesvI/5HD1p7l+c3oToxt968W159y++I6JAjnF4uXl5AqtldlHG6GXY2bjOUxmYX88U2XsNgD8xeSdyWScifqIzJXyDLuOD0WWd/bxiKHLNzxVYCrMa2uT5DP3X9VFLRUdIXuAkYDCVZWjOf4W0CsNYV37F7wils8NOMZvUzo597543yI6w7z83WMqgKiPrlk1O30G2HtZM6fAkF1+dn4mRb/L337b660ON+aFYe2Wo1lmnsmcScQVG4J771j+Sj7XEw8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eyN2GS0g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eyN2GS0g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D3K3xGdz30WB
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:34:37 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-216634dd574so3975345ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010475; x=1734615275; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWMAc4zmfYhsrt0DV+vmCYXKX/GHYBxniAba73eEZ6c=;
        b=eyN2GS0gh9o0FxTBvuby+Xqo/ApDfY0g5d3ler27DYKxEm2lVLnFOV/WSG6LK0mnbv
         0gJCsTwjVSO1obMdoIESKOtQ8v1T4+sX+HHEiqcuBxl2BEDhWW8Ni/XsSbvu9za+gFwM
         TgHvRnOZvdfC01J5PdfMoc+MhVtIKwiAngZywHRMnZCpwiHG845rs8FEYBCiwDHtguTn
         M2a4zaccvBXe0AES27MGP18UoBnk4CwlJRw0fn/64VottvBjRsaI7rpBY0BPRuSE0ysl
         vG/s8rS/QfCA2OHePqFde2gCU27Dwol3iQMEort5//VZwp4xnIghgtuDrSECH7CDGwSA
         MaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010475; x=1734615275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWMAc4zmfYhsrt0DV+vmCYXKX/GHYBxniAba73eEZ6c=;
        b=ST/fmV33t/uDyzrMyaOvEZY6Szj6nPhaq/E2EVtD/AqmVNaD9RXaDP/1LuwRm1k51o
         CL5YhA8vRlfJGqefxWQVgRMEQGyE61MwQlLAwAM1w3n8GJnGO1/RHpP1lWTd4JWISuyt
         bbF6yKlc2FRC9yxu82SVcYPpg0geOMKCW4KUUhTPCW4CrpkVY7AhT1FsMschMK9J01bD
         KdRURQ75OphYDHNNkizA24XJAdQ5TnAE/xg3l7vVLIsAhkD7WmwVKdmA0nyMgcFsa+yc
         loMrmSc/ElmNzYNpQWpK+sluoSC+Aqeb+6ik1wi0QtAW3aRQXXn+no7fhUr4g22wc+lw
         BbMA==
X-Forwarded-Encrypted: i=1; AJvYcCWISFtLYFOGeD2OO9ss2qDtkw4Kqrro35rL5PQlhkxULrhRJuZ5KEF+EkLT6P8eePuOBpEEtPRyDbhPdqE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4GsDek7T1h47Myzoes2iDClOmvA9PalneLiFjXGm4mki/2qEs
	NWlqWRs4vt/OREBQXUedDG6r20LXEnTiWXIVTlxeOT9Fx04mF8jE
X-Gm-Gg: ASbGnctHyYIS3Ya8isBLz1Uq2d4S6OhIrwdMbHNYiG48zUlXEhU2w/pctePVaMnXLuq
	XulyeoDNxsnrjs5BT6+JO+OcGeXhMAs6CUL2AeB4VcpAlE3K3lmJ7/wxUpiOqVdQBSd51zwZiFS
	sk9xDTZgjvkYPfC/2oasx4a3S9lBsoR/7VMCLTWsCuaweDNPNmlXO9ezGa5B8UV7kMP3jHbUlNc
	a1yPd4N1trzUh1S61hIhqnTjKpqBfnVCQT7Cxmlkwoc4jpGZlmS7jYotQ08IQCrw2s53kqHnl98
	mOSB/RFIPPKXqL+2aBvCWyMUKnr4Dshz0pY5HP80a9fcScbAmi/NzBnBx0h/1j88/1if1/GZvfA
	tOJkU
X-Google-Smtp-Source: AGHT+IEkAjpA5aepVMZDNkc8vUvUYOwLibC5GFvwj+RJ/gySt8BuEg8jjIp5XHCBFQBsOmxVfSqR1g==
X-Received: by 2002:a17:902:ce86:b0:215:7cde:7fa3 with SMTP id d9443c01a7336-21778509fa3mr108167325ad.25.1734010473524;
        Thu, 12 Dec 2024 05:34:33 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:33 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 1/4] ARM: dts: aspeed: minerva: add i/o expanders on bus 0
Date: Thu, 12 Dec 2024 21:32:23 +0800
Message-Id: <20241212133226.342937-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
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

Add three I/O expanders on i2c bus 0, assign the GPIO line name to each
GPIO in use, and specify the interrupt GPIO that has been used on it and
give the interrupt gpio number.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 468a33f50ef2..426e249c3326 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -208,6 +208,63 @@ leds_gpio: gpio@19 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	gpio@11 {
+		compatible = "nxp,pca9555";
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <238 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"PWRGD_P24V_SMPWROK", "P1V5_PWROK",
+		"P3V3_PWROK", "P5V_PWROK",
+		"P12V_SCM_PWROK", "P12V_PWROK",
+		"P24V_PWROK", "P48V_HSC_PWROK",
+		"ERR_GPIO_IRQ", "TMP75_ALERT_N",
+		"BMC_PWROK", "P12V_INA230_ALERT_N",
+		"P24V_INA230_ALERT_N","",
+		"P48V_HSC_ALERT_N", "P1V05_PWROK";
+	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <240 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"P1V05_PWR_FAIL", "P1V5_PWR_FAIL",
+		"P24V_PWR_FAIL", "P24V_SM_PWR_FAIL",
+		"IRQ_NW0/1/2_N", "IRQ_NW3/4/5_N",
+		"RTC_INT_N_R", "ERR_GPIO_IRQ",
+		"", "",
+		"", "",
+		"", "",
+		"", "";
+	};
+
+	gpio@13 {
+		compatible = "nxp,pca9555";
+		reg = <0x13>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <242 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"RACKMON_A_1", "RACKMON_A_2",
+		"RACKMON_B_1", "RACKMON_B_2",
+		"", "",
+		"", "";
+	};
 };
 
 &i2c1 {
-- 
2.34.1


