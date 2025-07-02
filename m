Return-Path: <linux-aspeed+bounces-1615-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADBAC83F05
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79c143lz30Qk;
	Wed,  2 Jul 2025 15:04:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432676;
	cv=none; b=gAfXn0tNPRTQbURk9pRdYspgxh4tapTsJ6yKJM/JqJjhP+SR3zeZhcJGfpIW7qTcMgaNS4Nu0a/DoaA0e8neYy+9sBTVW7Nbp6fIH7QVKlhI9V0OfG3IMmdJ6VQb/GuAOZrjNrnVqBeybVt6cE1+VYZDA9YL5dTXs0wlaQNzNV95kOPLOjuWQWYKOZLRl0oxHQ36Jiwj6rFz3+Whz6p555571M5eP7iTUvaaggCu6BB3msNQ20rU21RQpyqj/ODnuBPtpGb+2XrfxhcGtqZyRHxP7V42OWJegcsZv5wGh0inyJ8ABN/uvZ5Jb7zJXHKjx08Xa2MQ+lL+wDrmJzDaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432676; c=relaxed/relaxed;
	bh=YF+z+9UJtGb+XbPNA4vnSpzZQyRgL5kz75DPKXiDmdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdnQ4TEZ5o7cQ7hESSloHU2bxyVxQIKmsBzrRmud+dasn1hyZyjyfaQeVkU36Ay3ZcCeoIw1yu7U6L5Ksi1+hJqSM9MG7DXEVHvrASThx6aFU7qKfAllhCp1+ziLR59o4ZYUt5Sp1oVvqZdjJ+IyKNmIXonoxwgPLDEEWjgS7Ze35yvMFr5TV5O1sQOxhLFNExko7XreuwDE+OPDI5crfGkcAlh7pKK8LaqmwjxK1dq4fEhPOOD7Z0cAu6TWSrr0qFePwmtSD3A+eCNwYIgXWxQSf+GujWmCdsCqFXDprjyAemsShieTUxmHRY3Di3NeDKBeshVMifAo+WRUXvTVGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BzeG8APe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BzeG8APe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79b3Q9Yz305n
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:35 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso7451772a12.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432674; x=1752037474; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF+z+9UJtGb+XbPNA4vnSpzZQyRgL5kz75DPKXiDmdo=;
        b=BzeG8APexHjMO7B7727G/++yWaN5eS5DxreFNS19QKd3NwoB8lJpM1U9DTQ061amo+
         gGauThEfp6a0XvWgOOKMa7QkeNbccs4ulhJoAnm7y7sSE7UyhASxMZ35Bpj/lWgCR7uZ
         myC3HMi7nYfIRCMeKenWYIUFVE+GI6xm3CLVuGwRHa/bbX3jNJxi9zJR6pPoKYLsNO0v
         XLfU1+V6QRQYE3yz8tbwA5s0zDXaz08iAg4bUqX0DBljJLIRXaLnk/Y+G+KBCDcO6xJP
         WN1vFWQiiHqbKFnzEK1xYeMo2zsuC1WBRBOtZ5HCh4ZJJRDcTKw/sogkniUh9+JhWZ3D
         B15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432674; x=1752037474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF+z+9UJtGb+XbPNA4vnSpzZQyRgL5kz75DPKXiDmdo=;
        b=aVYdBtDzUYlaBTQeBEl+a+utWZIh8cKNowypLXd+YfrreIN0BmkrGVIDCd8tZFNpyk
         DxX7Zjm35PN+Watgm54bGSqMVvvFRRe9Zm11Zvyglou+CIC07SzygIDLCo3P+mCfRYzN
         he7l9n+nnPbdgwMn9kPp5NXvCV9coleED/GTuuER/BlyBAJtN0CLd638mxZj8mngqNV2
         Ks2AbxtmanSEUtQ1RoOlcd/UnPg+kLXIZL1rBrW4a2F+6TFE8KcgTobjP9BePFlgiRIu
         qTaTgcIPTcwUnyOR/OAaP7hpK9nfUj+hjUpwyJEz1/Pe5NPKtNDrafe68lQrYgxBur2Z
         W5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVoEpYz/bRlbeXqsoYBfaaE0VKWe5zCdEYHmKA1wi1fWDLs2wU9fT8CqtdDCFhLJWnginlODVhHW5/vMDk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqSX4gix0602CsI2NeU4g0PFsns2R1wJoXGAChPQ/vuyDvqXQz
	9JCa/p9D0ltaFhBk2qlSHP9SjYntKA/CxDwFFehFecxS0dgMopUVxBzW
X-Gm-Gg: ASbGncsLKf2MkksLllJnsWWwHTmC9EHX/RRwcGNcYaZ38YItVi8jno9ZiL81/GbMPoo
	eLJ0IrxwJPTYRVKQgqc8zpgnYFwro5/z8pdtx5JPFCWzK8bYqssKvzX+/VjDC/sfxotse3NgudP
	FOqfZHPbj/Ftya4vioyILvxhF21C04vtKBxK/feMcypfrP/RvUexz1rQF13QeIU1Vwj+NTnYf8H
	CBIxMEThVoSZehP5X1FsMQoz6xd5JgWOO3Xg8u/8zQBAqDktsrtHhxniMRmbuqAEVV960Rk8bXp
	pq5hCo6rv2TevwU9Ur7IWLmscNUuala5jSAjew9ySjkqn/IivBQc9o+JnYABOoEcu+Aq2rMf9/m
	kfSykP6viepuMf+P4Xod/q5Hw7sY+8ZTvKRvshYTx+wvR+t177g==
X-Google-Smtp-Source: AGHT+IFHbwDhMvbqCmis9Avzz0dITiewmawmhCdCrU+rThLZ332gFQVSpCI8zquGUjTRwmwtjMg8pA==
X-Received: by 2002:a17:90b:5183:b0:311:c1ec:7d05 with SMTP id 98e67ed59e1d1-31a90c1faf7mr2410967a91.35.1751432673558;
        Tue, 01 Jul 2025 22:04:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:33 -0700 (PDT)
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
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Tue,  1 Jul 2025 22:04:16 -0700
Message-ID: <20250702050421.13729-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702050421.13729-1-rentao.bupt@gmail.com>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
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
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073..debbfc0151f8 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-facebook-catalina.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-darwin.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
new file mode 100644
index 000000000000..f902230dada3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
@@ -0,0 +1,92 @@
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
+/*
+ * BMC's "mac3" controller is connected to BCM53134P's IMP_RGMII port
+ * directly (fixed link, no PHY in between).
+ * Note: BMC's "mdio0" controller is connected to BCM53134P's MDIO
+ * interface, and the MDIO channel will be enabled in dts later (when
+ * "bcm53xx" driver's probe failure is solved on the platform).
+ */
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
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
+	ref_voltage = <2500>;
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		     &pinctrl_adc2_default &pinctrl_adc3_default
+		     &pinctrl_adc4_default &pinctrl_adc5_default
+		     &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
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
2.47.1


