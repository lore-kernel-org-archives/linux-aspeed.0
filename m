Return-Path: <linux-aspeed+bounces-3642-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FFAFD0620
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Mar 2026 06:21:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW0yW628Dz3cBP;
	Wed, 11 Mar 2026 17:21:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773210115;
	cv=none; b=MyiA2qedCHXGrSdsw5ucoeBkkYUwPhPpxiFPyhUEB2dRY3QL9Q+A2XkBfqFnIR3pEgGTHsWZR7tw3ZNAiZfEKcTNncktLjjdUt4bsXiUSu3t8nXoiQCXMheq9al9iNBxMsttGZNYOohB5nSFh9n0xoGh6cqUjOFvf4r+aQD2ZbdrjvNY4PLnjVSayvyTKpOsWhB8ZeC59O/vgHODUABdABGSEdx1ouwBHpVxFP2Bfrk7t2Rx29eouYvgPT+BSxNKmZaBtUtjYXXrTbRTRiW1Zqh1rDxyWCfogdNhSHmOAbhX4cPhvgOKZHLClti1boe3AGk4XXLNppXsoA2VetM9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773210115; c=relaxed/relaxed;
	bh=4m//d/QtgzXH+6tzSwM2p/x+AAgXSJSFVFC+M90kcgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqXi5fCjZX7/bb9lFtMW0xX3O/+4EYBBjcN61lAKrg7/D3uVCrBSSTUUO7Uo8uxuHU0HWL3ZiYVLHjHGPUUudlru+xfes8N2rjFSnTnZ2jjkx2kNIiNE8ho1ccHpPA/CxGHdK56qn3/7f2Ug3GqRAyr4TNh8LhHp2LRQONsFmieCgwy0BFs9kWt96X4ElxbW3bH/Kv7ppEjC//GqMBzdRPDVjzB00LSxMA/nQWbq4tJYzt5RbUA3TCilJ3xeJupdN1d1VgKqxGiSA5e5EpvF8s8UbqnXYNrwD2n9T4/y1rrESr1oxiSOwqPcsYFORbaT012qf4UD1TEbEIK/RVZbqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hwQd7le9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hwQd7le9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW0yW0jt6z30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Mar 2026 17:21:55 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c73c990a9cdso417734a12.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773210113; x=1773814913; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m//d/QtgzXH+6tzSwM2p/x+AAgXSJSFVFC+M90kcgk=;
        b=hwQd7le9eCjwInDuzjnAmo+Pz79jZ6s4OXS/lRhXweRwAFfGEzznLm8zXULW0ZfVWR
         AMXDXJb/mDks7mGzX2cshxKh0zj7ePYe3f/M9+xKPqV2Q7IPpHh8y3N49uwqSvMj8eBd
         /tZnjvXB7ShMmx2gKjP20BgW3eEHwF+7ZH8tS/BlgeKeL4oK33c+yW78bC0+oRx6cmdQ
         SqAg00Jzyd1gnf9OitCt/88M7FQ6qlKhK1fUdB5comSTYPTM1d/WaqhW0AeliN4cWTRF
         f91xRNExSnOVIzC+RD16sK9qE1FsLxVby0cM8+tabMDbMl/fv6WzgUYM6poPoZj9ilrD
         GFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773210113; x=1773814913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4m//d/QtgzXH+6tzSwM2p/x+AAgXSJSFVFC+M90kcgk=;
        b=i1TY/oDkfFK0gKSnikFtpNL+vC9x+6kZAPgv1w+qIa79D64La+moVyP4hkbB6XKJ+D
         e8NjzwscYx/ZdyqYWwE5ypGGEk+9gehgUd3tBoOyngJcEfPGCWqwYCbE3fycavw3XYIb
         Z0fwZpZh53rlVZw/GqrE9hznQFVH9rrdGRMMprPb0xNCthoQMyc6oUt93omKB6qS8k4a
         /Dd1DilsBM4T7xbVvJvf/ifYwFn+Aa+0AdG7X0D37jHowNCe4Za7On18ULaOu9E7qYNA
         QnO+Djd7f5pfvm05KOCLHrClUg1MQssO4lLMjuJTQUqLXO6Qz8F5UlF1P+BSyJ4kuv5T
         vsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqt37BBFL0JUVkgr0qBm8Z3c0vquzYFTr2NwMbg7NdijtWQRSxyrTuddtKcQiBRPvqKhGKCiXERpSafRU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGZHPHWUoexwxWK8ME6BtAa2Ug7fxyhdV2+FIDyd7N43rFZN6m
	AeohpO2nTvLjWX7pE9jntK3b6eu4OLevlh0PB2Lsq0Np40ACMP+Kpg9r
X-Gm-Gg: ATEYQzx5i6Xrw5vJ0zn1rjfhQ4WGfnyd/9zwjvBvlxNbjsyuSJfBul7THbFip9YdrC1
	aZF/0sEWDlPc6P5aBJsddjWNWA+67mcqADFIrTTJAFD+7FIQcWYH3uaDHMWzIp985KerQ098fZc
	qFvixvStUprBJVqgbKjWpIxffpTvNc/TFgOKxc7uLXNiux37Tq+ab3ITOXC3Ocf873R6UwzVi2z
	hCl7GjXQVY5UBa/eBlFm8sWrp3ubU+uhV+ZeT/hsPYL9JTbzXQXkYsOzA3oUQ9iSik8Pgu4OcRF
	cU5eVBYDj+/GYfnXmB03MYfsud6V8qPKfTv7qjzoMHvZ+CoAuQpjj5Gtgph2nRS1XLn5INAyGjP
	jjb0BBE4KHQ07f4TiMV0X2JxdDaVAqLKAGoXJH/nPCBidvJZ+TL0i6IsLTHH/kqQPYnPVeBYc5P
	gXwtg5TSH3MvyGuKxitfvaFpMJyCj/kKCJzV0vSJjukGizCmkWbv5r9JYMZnLpmJGkO2/ocCWA1
	/w=
X-Received: by 2002:a05:6a21:7a43:b0:398:c0ba:9cfd with SMTP id adf61e73a8af0-398c5e60474mr1421893637.1.1773210113101;
        Tue, 10 Mar 2026 23:21:53 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdfa9acbsm1008019a12.32.2026.03.10.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:21:52 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 11 Mar 2026 14:19:29 +0800
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add Meta SanMiguel BMC
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
Message-Id: <20260311-sanmiguel_init_dts-v3-2-2b4d1ab7a8a1@gmail.com>
References: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
In-Reply-To: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773210105; l=15900;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=q2NRqpVJP1M7zeObGc3g3LI1idjKjJhkG4+CSErc/rE=;
 b=IZxHj7agXO+VHPKH6whlWf9tAlfqkgW23CzQMLQwLArPDN/qedOp+4Vu770B98sXlaecyBDGq
 L562rQc0tiKB0OvlfcF0/wtyIKScU/fOi82KhyX9DAOigPB1ywYwd07
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add linux device tree entry for Meta (Facebook) SanMiguel compute-tray
BMC using AT2620 SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 634 +++++++++++++++++++++
 2 files changed, 635 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 9adf9278dc94..ab2effc29f6f 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-harma.dtb \
 	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
+	aspeed-bmc-facebook-sanmiguel.dtb \
 	aspeed-bmc-facebook-santabarbara.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
new file mode 100644
index 000000000000..e29a79560c5b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2025 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Facebook SanMiguel BMC";
+	compatible = "facebook,sanmiguel-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		i2c16	= &imux16;
+		i2c17	= &imux17;
+		i2c18	= &imux18;
+		i2c19	= &imux19;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>;
+	};
+
+	spi2_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+
+	standby_power_regulator: standby-power-regulator {
+		status = "okay";
+		compatible = "regulator-fixed";
+		regulator-name = "standby_power";
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	scm-leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	fio-leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "power_blue";
+			gpios = <&fio_ioexp 4 GPIO_ACTIVE_HIGH>;
+		};
+		led-1 {
+			label = "power_amber";
+			gpios = <&fio_ioexp 5 GPIO_ACTIVE_LOW>;
+		};
+		led-2 {
+			label = "id_blue";
+			gpios = <&fio_ioexp 6 GPIO_ACTIVE_HIGH>;
+		};
+		led-3 {
+			label = "id_amber";
+			gpios = <&fio_ioexp 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&mdio0 {
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+&adc0 {
+	aspeed,int-vref-microvolt = <2500000>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default>;
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	hpm0_ioexp_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+
+		gpio-line-names =
+			"B0_M0_SHDN_FORCE_L-O",
+			"B0_M0_STBY_POWER_PG-I",
+			"B0_M0_THERM_OVERT_L-I",
+			"B0_M0_THERM_WARN_L-I",
+			"B0_M0_GLOBAL_WP-O",
+			"B0_M0_USB_HUB0_RST_L-O",
+			"B0_M0_PRE_SYS_RST_L-O",
+			"B0_M0_LEAK_DETECT_ALERT_L-I",
+			"B0_M0_RUN_POWER_EN-O",
+			"B0_M0_RUN_POWER_PG-I",
+			"B0_M0_CPU_CHIPTHROT_L-O",
+			"B0_M0_SHDN_REQ_L-O",
+			"B0_M0_CPU_SHDN_OK_L-I",
+			"B0_M0_CPLD_READY-I",
+			"B0_M0_PWR_BRAKE_L-O",
+			"B0_M0_PWR_BRAKE_STATUS_L-I";
+	};
+
+	hpm0_ioexp_21: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+
+		gpio-line-names =
+			"B0_M0_I2C_BUS_MUX_RESET_L-O",
+			"B0_M0_HPM_MCU_OK-I",
+			"B0_M0_CPU_L0_RST_IND_L-O",
+			"B0_M0_C0_SOCAMM_DAC_SEL0-O",
+			"B0_M0_C1_SOCAMM_DAC_SEL1-O",
+			"B0_M0_C0_SOCAMM_I2C_SEL_R-O",
+			"B0_M0_C1_SOCAMM_I2C_SEL_R-O",
+			"B0_M0_EEPROM_POWER_DISABLE-O",
+			"B0_M0_L0L1_RST_L-I",
+			"B0_M0_L2_RST_L-I",
+			"B0_M0_BRD_ID_0-I",
+			"B0_M0_BRD_ID_1-I",
+			"B0_M0_BMC_LEAK_TEST_L-O",
+			"B0_M0_MCU_BMC_ALERT_L-I",
+			"B0_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B0_M0_BMC_TO_GPU_MCU_I2C_EN-O";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	smm_ioexp_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+			"HMC_RST_R_L-O", "HMC_RECOVERY_R-O",
+			"HMC_SPI_MUX_R_SEL-O", "GLOBAL_WP-O",
+			"HMC_READY-I", "HMC_PRSNT_R-I",
+			"BMC_SELF_PWR_CYCLE-O", "EEDO_LED2-O",
+			"PWR_LED_L-O", "PWR_BTN_L-I",
+			"UID_LED_L-O", "UID_BTN_L-I",
+			"FAULT_LED_L-O", "USB2_HUB_RST_L-O",
+			"USB2_BMC_HUB2_RST_L-O", "WARN_LED_L-O";
+	};
+
+	smm_ioexp_21: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+			"BMC_HMC_MUX_SEL-O", "BMC_TPM_MUX_SEL-O",
+			"BMC_USB2_MUX_SEL-O", "HMC_PGOOD_3V3-I",
+			"", "HDR_SPI_PRSNT_L-I",
+			"SW_NRESET_R_L-O", "MUX_I2C_ESPI_SEL-O",
+			"I2C_BUS_MUX_RESET_L-O", "USB_MUX_EN-O",
+			"PDB_TRAY_RST-O", "USB_PWR_EN-O",
+			"RTC_CLR_L-O", "I2C_RTC_ALERT_L-I",
+			"X86_TPM_RST_SEL_L-O", "BMC_MUX_PI3DP_SEL-O";
+	};
+
+	smm_temp: temperature-sensor@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	smm_fru: eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	hmc_ioexp: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"", "", "HMC_EROT_FATAL_ERROR_L-I", "",
+			"", "HMC_EROT_RECOVERY_L-O", "HMC_EROT_RESET_L-O", "";
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	hpm1_ioexp_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+
+		gpio-line-names =
+			"B1_M0_SHDN_FORCE_L-O",
+			"B1_M0_STBY_POWER_PG-I",
+			"B1_M0_THERM_OVERT_L-I",
+			"B1_M0_THERM_WARN_L-I",
+			"B1_M0_GLOBAL_WP-O",
+			"B1_M0_USB_HUB0_RST_L-O",
+			"B1_M0_PRE_SYS_RST_L-O",
+			"B1_M0_LEAK_DETECT_ALERT_L-I",
+			"B1_M0_RUN_POWER_EN-O",
+			"B1_M0_RUN_POWER_PG-I",
+			"B1_M0_CPU_CHIPTHROT_L-O",
+			"B1_M0_SHDN_REQ_L-O",
+			"B1_M0_CPU_SHDN_OK_L-I",
+			"B1_M0_CPLD_READY-I",
+			"B1_M0_PWR_BRAKE_L-O",
+			"B1_M0_PWR_BRAKE_STATUS_L-I";
+	};
+
+	hpm1_ioexp_21: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+
+		gpio-line-names =
+			"B1_M0_I2C_BUS_MUX_RESET_L-O",
+			"B1_M0_HPM_MCU_OK-I",
+			"B1_M0_CPU_L0_RST_IND_L-O",
+			"B1_M0_C0_SOCAMM_DAC_SEL0-O",
+			"B1_M0_C1_SOCAMM_DAC_SEL1-O",
+			"B1_M0_C0_SOCAMM_I2C_SEL_R-O",
+			"B1_M0_C1_SOCAMM_I2C_SEL_R-O",
+			"B1_M0_EEPROM_POWER_DISABLE-O",
+			"B1_M0_L0L1_RST_L-I",
+			"B1_M0_L2_RST_L-I",
+			"B1_M0_BRD_ID_0-I",
+			"B1_M0_BRD_ID_1-I",
+			"B1_M0_BMC_LEAK_TEST_L-O",
+			"B1_M0_MCU_BMC_ALERT_L-I",
+			"B1_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B1_M0_BMC_TO_GPU_MCU_I2C_EN-O";
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+	pdb_mps_hsc1: power-monitor@10 {
+		compatible = "mps,mp5926";
+		reg = <0x10>;
+	};
+
+	pdb_ti_hsc1: power-monitor@11 {
+		compatible = "ti,lm5066i";
+		reg = <0x11>;
+		shunt-resistor-micro-ohms = <763>;
+	};
+
+	pdb_mps_hsc2: power-monitor@12 {
+		compatible = "mps,mp5926";
+		reg = <0x12>;
+	};
+
+	pdb_ti_hsc2: power-monitor@13 {
+		compatible = "ti,lm5066i";
+		reg = <0x13>;
+		shunt-resistor-micro-ohms = <294>;
+	};
+
+	pdb_mps_hsc3: power-monitor@14 {
+		compatible = "mps,mp5926";
+		reg = <0x14>;
+	};
+
+	pdb_ti_hsc3: power-monitor@15 {
+		compatible = "ti,lm5066i";
+		reg = <0x15>;
+		shunt-resistor-micro-ohms = <294>;
+	};
+
+	pdb_mps_hsc4: power-monitor@16 {
+		compatible = "mps,mp5926";
+		reg = <0x16>;
+	};
+
+	pdb_ti_hsc4: power-monitor@17 {
+		compatible = "ti,lm5066i";
+		reg = <0x17>;
+		shunt-resistor-micro-ohms = <381>;
+	};
+
+	pdb_temp: temperature-sensor@4e {
+		compatible = "national,lm75";
+		reg = <0x4e>;
+	};
+
+	pdb_fru: eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	pdb_ioexp_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+			"PDB_STRAP-I", "STBY_POWER_EN-O", "STBY_PWR_OK-I", "",
+			"", "MAIN_PWR_EN-O", "MAIN_PWR_OK-I", "GLOBAL_WP-O",
+			"PDB_PWR_BRK_L-I", "FAN_PRSNT-I", "", "",
+			"", "", "", "";
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	scm_temp: temperature-sensor@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	scm_fru: eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	sw_config: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	smm_ext_ioexp: gpio@38 {
+		compatible = "nxp,pca9554";
+		reg = <0x38>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SSD0_PRSNT_L-I", "E1S_PWR_EN-O",
+			"SSD0_PWRDIS-O", "I2C_PDB_ALERT_L-I",
+			"BMC_SSD0_RST_L-O", "GLOBAL_WP_E1S-O",
+			"12V_SSD0_PGD-I", "SSD0_LED-O";
+	};
+
+	smm_ext_fru: eeprom@55 {
+		compatible = "atmel,24c128";
+		reg = <0x55>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	fio_ioexp: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+			"", "", "", "",
+			"PWR_LED_BLUE", "PWR_LED_AMBER_R_N",
+			"BEEP_ID_LED_BLUE", "BEEP_ID_LED_AMBER_R_N",
+			"", "", "", "",
+			"FM_MAIN_PWREN_RMC_ISO_EN_N", "LEAK_DETECT_RMC_N",
+			"PWRGD_RMC_N", "SMALL_LEAK_RMC_N";
+
+		pwrgd-rmc-hog {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_LOW>;
+			output-low;
+		};
+	};
+
+	fio_fru: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"", "", "", "", "", "", "", "",
+	/*B0-B7*/	"", "", "", "", "", "", "", "",
+	/*C0-C7*/	"", "", "", "", "", "", "", "",
+	/*D0-D7*/	"", "", "", "", "", "FPGA_PEX_RST_L", "", "",
+	/*E0-E7*/	"RTL8221_PHY_RST_L-O", "RTL8211_PHY_INT_L-I", "", "",
+			"", "", "", "MUX_SGPIO_SEL-O",
+	/*F0-F7*/	"", "", "", "", "", "", "", "",
+	/*G0-G7*/	"", "", "", "", "", "", "", "",
+	/*H0-H7*/	"", "", "", "", "", "", "", "",
+	/*I0-I7*/	"", "", "", "",
+			"", "QSPI2_RST_L-O",
+			"GLOBAL_WP_BMC-I", "BMC_DDR4_TEN-O",
+	/*J0-J7*/	"", "", "", "", "", "", "", "",
+	/*K0-K7*/	"", "", "", "", "", "", "", "",
+	/*L0-L7*/	"", "", "", "", "", "", "", "",
+	/*M0-M7*/	"USB_HUB_RST_N-O", "BMC_FRU_WP-O",
+			"", "HMC_STBY_POWER_EN-O",
+			"STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
+	/*N0-N7*/	"", "", "", "", "", "", "", "",
+	/*O0-O7*/	"", "", "", "", "", "", "", "",
+	/*P0-P7*/	"", "", "", "", "", "", "", "",
+	/*Q0-Q7*/	"", "", "", "", "", "", "", "",
+	/*R0-R7*/	"", "SP0_AP_INTR_N-I", "", "", "", "", "", "",
+	/*S0-S7*/	"", "", "", "", "", "", "", "",
+	/*T0-T7*/	"", "", "", "", "", "", "", "",
+	/*U0-U7*/	"", "", "", "", "", "", "", "",
+	/*V0-V7*/	"", "", "", "", "", "PCB_TEMP_ALERT-I",	"", "",
+	/*W0-W7*/	"", "", "", "", "", "", "", "CPU_RST_L-I",
+	/*X0-X7*/	"", "", "", "", "", "", "", "",
+	/*Y0-Y7*/	"", "", "", "EMMC_RST-O", "", "", "", "",
+	/*Z0-Z7*/	"HMC_EROT_SPI_INT_L-I", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	/* 36 1.8V GPIOs */
+	gpio-line-names =
+	/*A0-A7*/	"", "", "", "", "", "", "", "",
+	/*B0-B7*/	"", "", "", "",
+			"AP_EROT_REQ-O", "EROT_AP_GNT-I",
+			"IO_EXPANDER_INT_L-I", "",
+	/*C0-C7*/	"", "", "", "", "", "", "", "",
+	/*D0-D7*/	"", "", "", "", "", "", "", "I2C_SSIF_ALERT_L-I",
+	/*E0-E7*/	"", "", "", "", "", "", "", "";
+};

-- 
2.31.1


