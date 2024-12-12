Return-Path: <linux-aspeed+bounces-194-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AA7E77184
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D3P2xqyz30WB;
	Fri, 13 Dec 2024 00:34:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010481;
	cv=none; b=m+mwdq6WcGsvulUoftVjpHrPdsE4DzXc5CAitXGNrdo23NLXTU3xkBwTPpxDbMidLNLLR38yaxIohvhOeMZrHZRF2L1Bi9D/mC/WI3ftPSbWJ1sEMyNb+Ta1HpZGXzQG0on+z5bI95fNJwjyQ2UJT2CLvs091H+mloDr8j041IWbluC5v2fz5nwHJQQx3L3If5KbQfOMCE2Ts3EmD6QFXLK0h+a/yCGyovsvxMjgCes+ztRovUF5pwfc97MvGg/4ME4hUXdJJ3uLaBQRyMIAKG5hKbQNP3msyOAY67IATsUPm4mQtVmP5iB5CpYQZtRjcrhxDr5NUaMjjztptBk+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010481; c=relaxed/relaxed;
	bh=GeCo6voBzfvsd9B5AKf1XLFT78VWFwo447c6e8aMI7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHBTe9kEgLLR9eOPrqhmCOcQThJiYZA2eKxAdjwq2CpdqT9EvtWiBEumIRYyAvGN2PZd7rhwxVilmYJ4ZFfKt0YCp7uEffCSCA7XMm5eoCycc4oGmiRV+rcmYHf/V6frH+EKD3AqC8/2XnJBwOck1/LPQuM39w1DmWTqYUfS0MOXGcayXWKjOdlfuZMa2kQQqAVDgaSFQlAzhkd8sxp7+Aas5xFwJ0pmPu9YkZoqmXmyM6mwioWbs6zp6KNeXjz4yq3tiESl5539HcuGdky8F/QATPvuNc9ixC4kW4/lS5kGvt4pMi6SwZmMzlkbd3OP9bYeKc/n+Wbu3y/7yAKoRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ByN6TeIJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ByN6TeIJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D3N3d8yz30VL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:34:40 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21654fdd5daso5129805ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010478; x=1734615278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeCo6voBzfvsd9B5AKf1XLFT78VWFwo447c6e8aMI7g=;
        b=ByN6TeIJ5WSdeLYLxOLZksmU+W4Jw8mD8L3PZorTkTZZBKXdmaK9GMtXfw6NMwIYbY
         oz/FPuNxMvFRYY+uIg11ScKlhRxZzHJC8hiZQLAIAM4L5FnaJGeUAdRH4EsvzE4J5vX8
         BImsYy67UJOPIxHHxtqL/FPub0+ln7nrmeNSB8CxCzd6NuKtecJnXeQV8MW9Cg1QnLBq
         lbe3h5yWkf1AcE7T3tW7X/nzqiJ7dN4zXvOSFzXDcawYQ1nw7hPlbf8jNFBaP0yVFVNZ
         zJSclp0Y/nMWpMFo9tYH88RstGDtfDvN6X1uQxhz1kqFnUYmj4dJXvgXiPybz0fcamX+
         DQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010478; x=1734615278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeCo6voBzfvsd9B5AKf1XLFT78VWFwo447c6e8aMI7g=;
        b=aLEnWt66lEqhrkdz0YHkw+aefZ7esCqcbkrny35z1+WHWS3ZCxKn3ee5NJFVKXXjRC
         nYBsqNwC1EFKB3Yjbg+iEylzREysAReXHv5yqDqyX9njEnf/WOJIcY7wR/AyczjUvT3+
         DQh5XDe+VSjU84S7Ku6qJUc37KIcai1VxCWyWx3bG0ZkjO5dGwjnOq9PDNq6D9mVNkOU
         6yRo9gu7oQpuyqxGYPhLA3+kL7hVDxR0gPbgjFi70i30S71/LR89OKDgRLRYGRRH5fCW
         bDrxhG12FqPWGuqcNhxzZbP6TnSx4IDuMcHp+eJ/sJPaKjwvgnauBwEgqHA1h3lVz9Y9
         /cVg==
X-Forwarded-Encrypted: i=1; AJvYcCXAUgRtoXcS1bs/+cgAQrjsfU4qieGG4zMkAVZ0Rd6iW5WcDgYLIjqTohUYrD6Rad956qfQnMNhnf3HuW8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvYFwaxSKWW1biaWse4yIEgnT+vM1tjPlN9fLbHo31CiEtS/aA
	PWHd6dCn7rSwwpq5HFdn/wnEpb+tGFEGCAZvuYcBC+P9HLnBgjss
X-Gm-Gg: ASbGncvO59PhgD3dj3sq+5S81wOcn1BW3OOXkPE/CRqb8Z8s+BkLtxLHijIgknYltrI
	l/LEAu2X803q85wKB8LnMYu10yay0716Mx58kLtu+fnSdKqb/SpjnvVNCAUdEMUUJmh+XH4s16n
	oKAklbMQHfh6l7eH9Q8PQpT+6qrWw1v5IgN47cyC3to5gpDSQcaPTYnGpaJyOWAZIXQ9q+EKZFx
	qE/8MY7nkGfZp7jxHMuBYS3md1/jn9gGSXnqe1RSZsixvp74GX6wXVE5iikMVN+iKcbiuXKolI9
	qPC9s8hd/ddneBwcAgQ67ZQ/z2n/eEaTZLmPw5NmeiT0H1BoN+lSFJEjMOD/vA0/JscNTicjPkz
	skGPF
X-Google-Smtp-Source: AGHT+IEz+JRhCfmuLuRPQjfAY6LvHPw+8lus0bkpzmOra75yYYsCHcZ2q2Oh1JNu4NCSZCdVZ0hghg==
X-Received: by 2002:a17:902:c947:b0:215:b75f:a1cb with SMTP id d9443c01a7336-2178ae4d3c3mr55231155ad.9.1734010476166;
        Thu, 12 Dec 2024 05:34:36 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:35 -0800 (PST)
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
Subject: [PATCH v1 2/4] ARM: dts: aspeed: minerva: add i/o expanders on each FCB
Date: Thu, 12 Dec 2024 21:32:24 +0800
Message-Id: <20241212133226.342937-3-yangchen.openbmc@gmail.com>
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

Add four I/O expanders on each i2c of fan control board (FCB), assign the
GPIO line name to each GPIO in use, and specify the interrupt GPIO number
for each FCB's i/o expander.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 456 ++++++++++++++++++
 1 file changed, 456 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 426e249c3326..9cd225ae96cb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -342,6 +342,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN1_PWRGD_R", "P48V_FAN2_PWRGD_R",
+				"P48V_FAN3_PWRGD_R", "P48V_FAN4_PWRGD_R",
+				"FCB_1_P48V_ZONE0_PWRGD_R", "FCB_1_P48V_ZONE1_PWRGD_R",
+				"FCB_1_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN1_ALERT_N", "INA238_FAN2_ALERT_N",
+				"INA238_FAN3_ALERT_N", "INA238_FAN4_ALERT_N",
+				"FCB_1_TMP75_ALERT_N", "",
+				"", "",
+				"FAN1_PRSNT", "FAN2_PRSNT",
+				"FAN3_PRSNT", "FAN4_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN1_IL_TACH_ALERT", "FAN1_OL_TACH_ALERT",
+				"FAN2_IL_TACH_ALERT", "FAN2_OL_TACH_ALERT",
+				"FAN3_IL_TACH_ALERT", "FAN3_OL_TACH_ALERT",
+				"FAN4_IL_TACH_ALERT", "FAN4_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_1_P1V0_POWER_FAIL", "FCB_1_P1V8_POWER_FAIL",
+				"FCB_1_P48V_ZONE0_POWER_FAIL", "FAN1_POWER_FAIL",
+				"FAN2_POWER_FAIL", "FAN3_POWER_FAIL",
+				"FAN4_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 2
 		imux17: i2c@0 {
@@ -389,6 +465,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN5_PWRGD_R", "P48V_FAN6_PWRGD_R",
+				"P48V_FAN7_PWRGD_R", "P48V_FAN8_PWRGD_R",
+				"FCB_2_P48V_ZONE0_PWRGD_R", "FCB_2_P48V_ZONE1_PWRGD_R",
+				"FCB_2_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN5_ALERT_N", "INA238_FAN6_ALERT_N",
+				"INA238_FAN7_ALERT_N", "INA238_FAN8_ALERT_N",
+				"FCB_2_TMP75_ALERT_N", "",
+				"", "",
+				"FAN5_PRSNT", "FAN6_PRSNT",
+				"FAN7_PRSNT", "FAN8_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN5_IL_TACH_ALERT", "FAN5_OL_TACH_ALERT",
+				"FAN6_IL_TACH_ALERT", "FAN6_OL_TACH_ALERT",
+				"FAN7_IL_TACH_ALERT", "FAN7_OL_TACH_ALERT",
+				"FAN8_IL_TACH_ALERT", "FAN8_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_2_P1V0_POWER_FAIL", "FCB_2_P1V8_POWER_FAIL",
+				"FCB_2_P48V_ZONE0_POWER_FAIL", "FAN5_POWER_FAIL",
+				"FAN6_POWER_FAIL", "FAN7_POWER_FAIL",
+				"FAN8_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 3
 		imux18: i2c@3 {
@@ -436,6 +588,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN9_PWRGD_R", "P48V_FAN10_PWRGD_R",
+				"P48V_FAN11_PWRGD_R", "P48V_FAN12_PWRGD_R",
+				"FCB_3_P48V_ZONE0_PWRGD_R", "FCB_3_P48V_ZONE1_PWRGD_R",
+				"FCB_3_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN9_ALERT_N", "INA238_FAN10_ALERT_N",
+				"INA238_FAN11_ALERT_N", "INA238_FAN12_ALERT_N",
+				"FCB_3_TMP75_ALERT_N", "",
+				"", "",
+				"FAN9_PRSNT", "FAN10_PRSNT",
+				"FAN11_PRSNT", "FAN12_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN9_IL_TACH_ALERT", "FAN9_OL_TACH_ALERT",
+				"FAN10_IL_TACH_ALERT", "FAN10_OL_TACH_ALERT",
+				"FAN11_IL_TACH_ALERT", "FAN11_OL_TACH_ALERT",
+				"FAN12_IL_TACH_ALERT", "FAN12_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_3_P1V0_POWER_FAIL", "FCB_3_P1V8_POWER_FAIL",
+				"FCB_3_P48V_ZONE0_POWER_FAIL", "FAN9_POWER_FAIL",
+				"FAN10_POWER_FAIL", "FAN11_POWER_FAIL",
+				"FAN12_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 4
 		imux19: i2c@2 {
@@ -483,6 +711,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN13_PWRGD_R", "P48V_FAN14_PWRGD_R",
+				"P48V_FAN15_PWRGD_R", "P48V_FAN16_PWRGD_R",
+				"FCB_4_P48V_ZONE0_PWRGD_R", "FCB_4_P48V_ZONE1_PWRGD_R",
+				"FCB_4_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN13_ALERT_N", "INA238_FAN14_ALERT_N",
+				"INA238_FAN15_ALERT_N", "INA238_FAN16_ALERT_N",
+				"FCB_4_TMP75_ALERT_N", "",
+				"", "",
+				"FAN13_PRSNT", "FAN14_PRSNT",
+				"FAN15_PRSNT", "FAN16_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN13_IL_TACH_ALERT", "FAN13_OL_TACH_ALERT",
+				"FAN14_IL_TACH_ALERT", "FAN14_OL_TACH_ALERT",
+				"FAN15_IL_TACH_ALERT", "FAN15_OL_TACH_ALERT",
+				"FAN16_IL_TACH_ALERT", "FAN16_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_4_P1V0_POWER_FAIL", "FCB_4_P1V8_POWER_FAIL",
+				"FCB_4_P48V_ZONE0_POWER_FAIL", "FAN13_POWER_FAIL",
+				"FAN14_POWER_FAIL", "FAN15_POWER_FAIL",
+				"FAN16_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 5
 		imux20: i2c@4 {
@@ -529,6 +833,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN20_PWRGD_R", "P48V_FAN19_PWRGD_R",
+				"P48V_FAN18_PWRGD_R", "P48V_FAN17_PWRGD_R",
+				"FCB_5_P48V_ZONE0_PWRGD_R", "FCB_5_P48V_ZONE1_PWRGD_R",
+				"FCB_5_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN20_ALERT_N", "INA238_FAN19_ALERT_N",
+				"INA238_FAN18_ALERT_N", "INA238_FAN17_ALERT_N",
+				"FCB_5_TMP75_ALERT_N", "",
+				"", "",
+				"FAN20_PRSNT", "FAN19_PRSNT",
+				"FAN18_PRSNT", "FAN17_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN20_IL_TACH_ALERT", "FAN20_OL_TACH_ALERT",
+				"FAN19_IL_TACH_ALERT", "FAN19_OL_TACH_ALERT",
+				"FAN18_IL_TACH_ALERT", "FAN18_OL_TACH_ALERT",
+				"FAN17_IL_TACH_ALERT", "FAN17_OL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_5_P1V0_POWER_FAIL", "FCB_5_P1V8_POWER_FAIL",
+				"FCB_5_P48V_ZONE0_POWER_FAIL", "FAN20_POWER_FAIL",
+				"FAN19_POWER_FAIL", "FAN18_POWER_FAIL",
+				"FAN17_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 6
 		imux21: i2c@5 {
@@ -575,6 +955,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN24_PWRGD_R", "P48V_FAN23_PWRGD_R",
+				"P48V_FAN22_PWRGD_R", "P48V_FAN21_PWRGD_R",
+				"FCB_6_P48V_ZONE0_PWRGD_R", "FCB_6_P48V_ZONE1_PWRGD_R",
+				"FCB_6_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN24_ALERT_N", "INA238_FAN23_ALERT_N",
+				"INA238_FAN22_ALERT_N", "INA238_FAN21_ALERT_N",
+				"FCB_6_TMP75_ALERT_N", "",
+				"", "",
+				"FAN24_PRSNT", "FAN23_PRSNT",
+				"FAN22_PRSNT", "FAN21_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN24_IL_TACH_ALERT", "FAN24_OL_TACH_ALERT",
+				"FAN23_IL_TACH_ALERT", "FAN23_OL_TACH_ALERT",
+				"FAN22_IL_TACH_ALERT", "FAN22_OL_TACH_ALERT",
+				"FAN21_IL_TACH_ALERT", "FAN21_OL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_6_P1V0_POWER_FAIL", "FCB_6_P1V8_POWER_FAIL",
+				"FCB_6_P48V_ZONE0_POWER_FAIL", "FAN24_POWER_FAIL",
+				"FAN23_POWER_FAIL", "FAN22_POWER_FAIL",
+				"FAN21_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 
 		imux22: i2c@6 {
-- 
2.34.1


