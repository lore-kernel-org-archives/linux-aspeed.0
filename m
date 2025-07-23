Return-Path: <linux-aspeed+bounces-1809-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83760C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVkD1pF1z3bmY;
	Thu, 24 Jul 2025 09:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313444;
	cv=none; b=YkHo9xlrKhdRvmjdym2M2flLSnj7UROP6SA9e0s4dsAlBpVfGgZdowB69y85qNk7+sMBwMk3uv2jasPAP0K4u+WSG5E3zYngOufEzFa2pI7KSWTL+zHED16VudG4tEGhI+L3dfHK9lAdVounxm4PZOoHbDjqpieWwtoQFjS+8UB8rVFkGZNtxFGF+lZn8IYxcfz5OEOYotBmxEcOpCLszVGny6j5eaMobKYoELaovDrYXotRsB+ROgH/w6YHNBuXf/MywAFPRD6zsmY9nmMWzN+qQxAVqSkuv44aoGEgx1y77Oq7AOcSxCgBrrhjNhfVqUR8nGdJFKQzXwjvuQ0a0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313444; c=relaxed/relaxed;
	bh=wWNqqAntiLueNlOOvISn5Xu4T7d1LNy1Kt3fgDDvAVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0Ev0LQu4BJKwIE9IkFg0lZCNbvD2GY+fnJPIdXsZxtxSppzNPzCbmC66Pgv5gcWVgdWIdQOC2f9dH/ntV4RAVM+VfNSQQQ/CfjOlW6u2sjnrmUtscH+j0PR/f54hD2yjFAWhg5FXt7zhofVXtBjdLIixOzL7ioEZKZUKWbVOctqjgAlf2l1pwlin8PWTKyFUtK6ze/BjwC6s1fFnj7mMMw2rG45r1JzjIDkgzggxBt1B+ElBrz7S3U0a4K3GMaWMasBC5n7K7AlS64v3X0wsFEkldYGpfmL9FdKOm2do8jNfh7vnNF8PIvMLvgO7RJXr4I8inTCGxEgW5DIXgUeHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fLIKrO56; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fLIKrO56;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVkC3L0Mz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:43 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-234b9dfb842so2990865ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313442; x=1753918242; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWNqqAntiLueNlOOvISn5Xu4T7d1LNy1Kt3fgDDvAVM=;
        b=fLIKrO56VyhFuLCYStAUt7XD4SHe5zj2N4SqTHJEBJZ+6v3i0GfG+URa3IxbbU3M3u
         a8PwPS1v78Od/wbNyG94bOO1g5mhp9Gx27K+52X2ilJpHt7mYzldpBq+7tXDt9+TH5xa
         oe17xoSz9MOzG5ND8BAniiBIT7xHVxS3brs7XyFuAz5K4MlvgJQGazOhd1DNFA8P5yxp
         aD9xKFRlQPu8h35bdlaUVIfcdQryiaXVmgvzoky7OovCzbzfohzXLaBiK4NinvZhm7l9
         SrUTo+yCkXMdJPdLozB1oDMVKMvHHTz57eXRoh8SkRpaHAgKMBm/N0x5B7IzgZhzHNCv
         cwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313442; x=1753918242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWNqqAntiLueNlOOvISn5Xu4T7d1LNy1Kt3fgDDvAVM=;
        b=Sx6WI1N3fqsRByLM9bAqVrH13UrLPlVrTe/XSht2XFtS93ahl+Cbj/cYnQodf5jjyy
         JCzuAXXpA7GK2plaqn/NaAORHPtOTIJWOQASQPJlMHEkB++pDDY8CwdAp/nrrIWBKJ7K
         UXTjYfESuzMmdoKEt7AuH/RK1zr/l9hJM/TzkM9JQBrkjSLb6DGM/j+/D7RRMLdxXt7u
         pjsjclpMV6xbRTn68jaPBLDyHSN8wAmx2Qk301Gj//eDf0WKVQeVHE7Xx0KiifVnQhYF
         u0TZFzkmURG6nkdpfG2KNsUixj1dchJhSu7fzPSlgVZXJM9B/qNwuo6014JhaygwCT/u
         LCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0AsOe+UqEM2/1m7o+J8Xi3zAcaWA72PE91AHGtFSBfoGbun3V61ShZYpartRcbUeXXBVRKbsx6IU5ADc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyP1+LKdrjDIXiPqs0/ZKRrxjtBfYOe22LO04ZDaFgnFS9gIyJn
	EO7j6R9uRPgy4Qt+Om0vSk1KJZaKvoDXHkGRc9inrdE3OtF6OcBZCOJj
X-Gm-Gg: ASbGnctCW43GCx8WBiSGC/U+h72NJ8Cdl6ElYkRGmWGsPZJiBNoCkJNcaV2EniHxyHJ
	AXSQelKHzFfeErI/JlmvnBOLMZD0Zm7u/FuStTe1zXEKwzKCJUsaAELdYUQBFCOH1L0296ZvAjg
	mmG7LiFS/Ytk6y29kIBUDvY49/v0KBWpr2CbFCmRyHIgsz/bjwonSXcBAAamMOUNeyUxVvZmCO7
	goK3jDcWggpbnPGuNAv4sbe4wKTkti/E4Tmd/h9CDD9BKj8ymWZRDIhFLYXpQ4xp68eKRKwB+8T
	ivgtZDVfZSvCVBv+AHjYCPvB3K9i5mF19loBD6gpSoIoOdAJiZZD+EayacdLuST1b/DJEkk/AjO
	vulliDwTEInkW5r+EaxRNzDbd0OcS7LxQmheVJeXJPr2BtLW+GBerZ0nBLnEN1bZhSab1S25Mb/
	w=
X-Google-Smtp-Source: AGHT+IGMpmU9/y8jlws7TyyqNLtoPH3duLJVbY+xZiyyDKkZpeNxiVfJuwOA88XEZKJDN/jVR3l4cw==
X-Received: by 2002:a17:903:1aa6:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23f9814eb24mr64705765ad.18.1753313441648;
        Wed, 23 Jul 2025 16:30:41 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:41 -0700 (PDT)
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
Subject: [PATCH v3 13/13] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Wed, 23 Jul 2025 16:30:09 -0700
Message-ID: <20250723233013.142337-14-rentao.bupt@gmail.com>
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

Add initial device tree for the Meta (Facebook) Darwin AST2600 BMC.

Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
health monitoring purpose.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - Removed flash layout (use the "default" in common.dtsi).
Changes in v2:
  - Removed mac3 controller.
  - Fixed DTB warnings.

 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index f6e714b7db2d..dce32ee0ace7 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-facebook-catalina.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-darwin.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji-data64.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
new file mode 100644
index 000000000000..58c107a1b6cf
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Facebook Inc.
+
+/dts-v1/;
+
+#include "ast2600-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Darwin BMC";
+	compatible = "facebook,darwin-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	spi_gpio: spi {
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c0 {
+	eeprom@50 {
+		compatible = "atmel,24c512";
+		reg = <0x50>;
+	};
+};
+
+&adc0 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		     &pinctrl_adc2_default &pinctrl_adc3_default
+		     &pinctrl_adc4_default &pinctrl_adc5_default
+		     &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		     &pinctrl_adc10_default &pinctrl_adc11_default
+		     &pinctrl_adc12_default &pinctrl_adc13_default
+		     &pinctrl_adc14_default &pinctrl_adc15_default>;
+};
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
-- 
2.47.3


