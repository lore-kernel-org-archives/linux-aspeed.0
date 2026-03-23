Return-Path: <linux-aspeed+bounces-3742-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628ABFC72DA
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffXsc0jrSz2yYq;
	Mon, 23 Mar 2026 23:43:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774269828;
	cv=none; b=eTa7gJ043FAWcXGSmiCvug67Fdw6LaST3VrJHuXN4FrH9QZeiMSkpwpK+8nq1GUvYa1e1BWJI8yu56OnLnD2nfFBPmLVV+ykjtdeuNhU1D2dtMQC8oeROCEYVWQIUKQuQS4SPzG22vNJOLz7kSHdtiW6NaJO/kukQwIhZkPMWC+ThkX58D15/SdOzLCd/O8A1HaW58X30VR5M4EFxZbWRnY4ODIlmnRMJWIKvOh/+RgT6AQpzbLkVBdyA9hQUasYw8WHo+FFi+aR10hoDXJb6zKBq0k+OHZN4evX5kGbllPkMhB2q53EQvXVlRYBvi471sXcIsKEGBbYTxP1CiUI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774269828; c=relaxed/relaxed;
	bh=W4RJYPNKRsW04fFe/7orD4Bx35IeFe5O5l7ivepyrbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt/Z1t8hawNg+YXJhdpO4ZDZUGZnSvqFRbP2iEkaUXTWYDx1bukqt9ve/f/BhC7NT36ZQJeWNA9w9lM3Q4i0zy91OyLEh0aHuqK2CYbU4E10Ns4+XY6RQ1mvOAD6lA2ikkAULOZlUeHNq+C3j4L37o31YMEdgjsEU20pwZ+0woo//sdSfhnm2f6Z9Djuyg6CKEfpCBGR9E/kF/54sneQxsZX0Qv+aO5UChgPiP/H5Er0XllwtOsxrabw9+rGSSjrJ6mMLbfzixY2eSK+ouSujA00kF+9W6/mQfYHMKi30mmO1ZIdnNrX4EZG7vM3AkJFhlOK8f1CUDppB4onrQRssg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ws6k/FAs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ws6k/FAs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffXsb01tTz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 23:43:46 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c6e2355739dso27555a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269825; x=1774874625; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4RJYPNKRsW04fFe/7orD4Bx35IeFe5O5l7ivepyrbE=;
        b=Ws6k/FAsxwWiILSIDbZ3NUnDUgZt/2MbTFaI2oMCTLfsZt4QIEtDLVtAruZLEWGLeB
         Go4RvxzE3UWn9wMh+epNuUsyUnHhswg8MMZqy4/K2aGeCdYHYy7/il/otT+7JuK5GHnF
         3yYg0ZC2hmkqskqX00XOGVC2WfKg4LTuVY/2imT46yDT72AewbbBHuh1dHiMTmKAOlor
         206Ui5F2I8SLz7jW51K/cxeN11VpBOdPmHZS1qlrQqk75pVaI9/aUvoTMZJRT4EhGMKe
         XXAdyEu4i5vfcHuh5ivMsuenF64tEbzk89zMAYC9pc3XlSDR8rNSMAs3OPgiUMYrqg/6
         4POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269825; x=1774874625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W4RJYPNKRsW04fFe/7orD4Bx35IeFe5O5l7ivepyrbE=;
        b=BOXHLU9B9G+S05tzrbG9tZpdeNdI4RbdPK6TS0ymLWltM6vyDfIET005oSLSUAMUkk
         +uLHE7e2AMOXO0/k/U0z8nuSpGUdFrd/xvnxhSaPM2t/PWPEWqINda73dtp/4ZUJPJgJ
         6AjqBlFa+uNJcegpd8l8dU8yVpperfUYJ73o6FSojrAETy9g3S1y1VZaTT0LUjRKe20q
         76WYsa04YtJJVuyEdNtfUl1tE7uK36wGpYAuhQr0dM9tM9S5N8xnRKGsQdD3IMK8EEvT
         /noVWc2aAWvTJZyBi2vwjryDk4y7Bx6KltHhbV2ztVoLwbQUz/4Dj8GxD/+X50tbEQci
         8Uiw==
X-Forwarded-Encrypted: i=1; AJvYcCVeyDMv0H8+nXxCP1Mmwx3z6O8jmpr4k6tscLCHg6aeREYEXsOshMpcsdXc22RnBkStLDQQTd1xksOSMog=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJgyyFWyr1xBfPLuS8YjNy70V2mHXXTN1R2SMpBu5WO0qmIrBR
	EbzVdzxLgQRcFNCIJh8RHxhtnMdovYT6rjHXjeq2xwXr0/ZnB8NC4WJ9
X-Gm-Gg: ATEYQzy4vj2I7YGkLfhIs6J35DsRu7xv7rmXBvX8yeOTMZQjh9fEeHu/H2GauFe9TAS
	VQFIgdR0XtTj1vLY/qpomFTK7oAwYPnKM7xOrvKTQ1Upr9OUKY8DLFEANO3OG2zL7k7rb0TbDkM
	La8A21MyZnH0EOQqe5IFidO+oHkrkKqhCVKurQ5fhy9dUwacbxjfZ5f3GlavdWkMbQvoDbsPhJG
	yNQuthVl4NWS2yBTtnWsFmBRKIT09SKPngOW5mz/GJAzz4oKhyXZz28RYOzeDPkU1R4LcqYudDL
	a7Ik0b7QN/yS6uTt88Qg0Nk7WnDGp9lKzEn00I3HFNI8Mq6ow7hmdtLYnaZZYGHl1Tr1R84ZoI8
	vG3pCVn8DFxlGdLyCq4j6udyFdgiCFg5OVaQo4ISAkJlh6704/VHSwVbqX4/30E3VvU6Gfoy9Uh
	D/2K3UCLvMNYRHMr1xgFU6jaUWTNyP9i0sliuXhIA8y1NMAmpMyZa3d6baO5VUWKDUK/Yds0F9z
	ZW4bwHajqCvOg==
X-Received: by 2002:a17:902:f60d:b0:2ae:829d:3c33 with SMTP id d9443c01a7336-2b0826c3d65mr115629365ad.8.1774269824766;
        Mon, 23 Mar 2026 05:43:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ae1sm103668865ad.13.2026.03.23.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:43:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 23 Mar 2026 20:41:06 +0800
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Add Meta SanMiguel BMC
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
Message-Id: <20260323-sanmiguel_init_dts-v4-2-caaa48a7f7be@gmail.com>
References: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
In-Reply-To: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774269813; l=16612;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=isyU77yx1k+Ka4GCoeq6I+By7hEOzPLWlrP4A8pRYiM=;
 b=UGboLhWc+uj/DgQpY4+CypKj1NxaXHtOrzrV3So2Wl0VFTCrJxD7zvv6n6xg/4rq5Ppwwxuyd
 fEE8uXcol1eCTacVzG2HJwG52MG5btJsG4H747EMRdMcV0+kyXGzuOX
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add linux device tree entry for Meta (Facebook) SanMiguel compute-tray
BMC using AT2620 SoC.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 668 +++++++++++++++++++++
 2 files changed, 669 insertions(+)

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
index 000000000000..74c8c1772109
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2025 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/usb/pd.h>
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
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>;
+	};
+
+	leds-fio {
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
+
+	leds-smm {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
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
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "standby_power";
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+
+		status = "okay";
+	};
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default>;
+	aspeed,int-vref-microvolt = <2500000>;
+
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
+#include "openbmc-flash-layout-128-alt.dtsi"
+	};
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiom4_unbiased_default
+		     &pinctrl_gpiom5_unbiased_default
+		     &pinctrl_gpiov4_unbiased_default
+		     &pinctrl_gpiov7_unbiased_default>;
+
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
+	/*V0-V7*/	"", "", "", "", "PCB_TEMP_ALERT-I", "",	"", "",
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
+			"HSC4_S5_OR_S0_N-O", "", "", "";
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
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl_gpiom4_unbiased_default: gpiom4 {
+		pins = "B12";
+		bias-disable;
+	};
+	pinctrl_gpiom5_unbiased_default: gpiom5 {
+		pins = "C12";
+		bias-disable;
+	};
+	pinctrl_gpiov4_unbiased_default: gpiov4 {
+		pins = "AE15";
+		bias-disable;
+	};
+	pinctrl_gpiov7_unbiased_default: gpiov7 {
+		pins = "AF15";
+		bias-disable;
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
+&wdt1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+
+	status = "okay";
+};

-- 
2.31.1


