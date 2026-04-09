Return-Path: <linux-aspeed+bounces-3892-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1745EF45A18
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyq215gPz2yTK;
	Sat, 11 Apr 2026 12:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775734844;
	cv=none; b=bQzJft7LVpVXb/da9xqrbuy5LdwjoaiKfySYab8ppvVDbHS5C2NgksOK0V2HREZ5iW8cL9VH1xRYabiWsj3Z14vrGPKIzZppjgBECXarTUfPiFpvdBCEYqoSVm+/Pz9In3JiNc9fsnUb6MSQfKqr8HsIp3gx28DQXaVl5qDZsi5+jiVyvVOMogymDMJ4TnGrJEZQesBDs/P5iQYH97gD7x52wsaTFkq8nFOCIBtozCNawOad3On3xVuwIROwoGSuFz86m2RFNnrpgGpQ7Nlw5fNp+wir22hqq7AsI7q3IN6lIxHilLeGVqPzyENa19B91wbl5MxAGyPgYNqbTryJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775734844; c=relaxed/relaxed;
	bh=bO+J8t2Ql5lOD38MZOpMmNhFcDI6DNivx80x0UZkAiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbWQG07vfNcAxgfV8vTSX3taMzOORHa6SJWp7NhH6hS6unWO+gnToy9gZ9yKieF7JGyrwSUBm+GtJcCLrKuK/8aL7NWImM7cQN9P11dxbbxpZXm5Dd1r+0LEhfxNIAHFaJcp2kF24EKVtCQ11u20j5HfsM+k2KEUDF5oWSIhFipyqLueQClcvA36ybYVMXbARog8MCiIs3QmIJgD29r4a9h9je9vITrT5378ApysLez1C/9NqQ0WZdWB5u3KE3HFpL2PBCW+kVC5VD6bM4X0YhRp1cii5L0UvteJeCNulik9no3uYlD7Ff1YwqwFyFG3Cv/wt768uGprJ7/3zEAcJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/9T95zc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/9T95zc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fryfy41m2z2ygf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 21:40:42 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so336690a12.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734840; x=1776339640; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO+J8t2Ql5lOD38MZOpMmNhFcDI6DNivx80x0UZkAiw=;
        b=G/9T95zc9h6ztxpeHw+g0Uao6B9Mw6fLmnuo8qM11ezTbzg1XHj1fpmXlflKnjp5eF
         Q9XoHHuDG9X7f2Yh2BaMslxeGBJAgfYVEFLFaSgsfOptCDKNFI/ExneWLQYs3rMpfmyo
         Eyp/xj8878ZKA2Urxfi3wc1NZKvLgFVG7N+mG+uN5722VT2LZpAtNYaobo8jRO3l7aKb
         8VexK3LkcO9EDawzAK2fmLTx6bsBZ4l+JZls2NxMHzv4zY/XQeyqViAXOX23FiR57ZhK
         XE3vLVwhAk+qTqFBQtvvhkYuKS8OryDIEoiS0MEFDL7shaW9US5TiWT/hRiHIAiFh/+L
         jY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734840; x=1776339640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bO+J8t2Ql5lOD38MZOpMmNhFcDI6DNivx80x0UZkAiw=;
        b=dFJekfgiXeiOoxxtlhMeOoxP8tEO2kwXScB0OmljuJvAdKrre45dWY9Fs+TrSmfl7R
         UpjCg5Iw4SvGcLE8G5QVDRA1ytLXuUMLVSj/8yhUOE1iUB5YQ2c+hFCgAjrRSAuADX5H
         Ogx3Z/j8mr+WBun3dQHTZNA1D8Ol26+9FKUAi09w2siv+xD9f3EKGlJRqi70AOim8wVs
         LWNT/bt66d2by1s+DLQm9/sQi61OdukY75FGFF+LybbChOmNAlljTa+eXK0NWSKPOXIh
         a32bDuvajmNy4uI4BcciX4ge/qi7E6tX4qottWRAIWSrTbveY5G5Z3uyUrD4b3qOk+sl
         pQLg==
X-Forwarded-Encrypted: i=1; AJvYcCXky5C0KgFI6odCP9snhzWHwzo4EuxEXhxzg7R0hZwlZ9K3aucudfRWo+THRVQ+ZFwtZ+6V9R4YFU1s/ss=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIv09Q10CVrVcHEMwr5WWvphgGcW6nLW1mUOuAOoMwDFaLI+Nt
	HfzDGVUGj8hSmFGRBR7IuzCAuykxTeLGkVKamJiUSyBxNpsigeSB8g4G
X-Gm-Gg: AeBDies73c0x4uIDm77+FeJg7dp6oM3msPeDterihtpeLzZd6Q+q2EmtI41t7+gk1Ba
	mJ3nbm47dq0YvJdQWLWnznY/y7Hiq5Ur1I29/TPybAl6QdLI/TSaWF2qbWMc2QVVXPv3yZfl6s6
	1KrGNtM71DYGTgvWpi4BqkjiQIkOrqVO9A4tWi7qiSFsMU+/LUfifvV7UFDZOw5jhA/UB2obguG
	O5RwR0bJyam0ABWqN4MmaIQqsRuMACf6fPijsvl/rsCosgmMm16g1RAtK/u+kzsrCaojVmSJ81k
	gIUnM12JKzMm/Y6Fd6G6MujBYNGwzkucbheVPjDMMSP3H9lyyQFqrwK2cDFTn7sN6LDrABwDzEA
	LSwavLtORSFglHSumiOMGUpwG6hQRsgfGX55LB1M7GXx336aySjcKUuAB7h85qjvxKQJLGIty6y
	9BgaYIzWMecvIwQDOjZW8=
X-Received: by 2002:a05:6a21:6e92:b0:39f:be2d:aed9 with SMTP id adf61e73a8af0-39fbe2e3fb0mr6233093637.19.1775734840141;
        Thu, 09 Apr 2026 04:40:40 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm22438545a12.29.2026.04.09.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:40:39 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 09 Apr 2026 19:40:27 +0800
Subject: [PATCH v2 2/3] ARM: dts: aspeed: anacapa: add EVT1 devicetree and
 point wrapper to it
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
Message-Id: <20260409-anacapa-devlop-phase-devicetree-v2-2-68f328671653@gmail.com>
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
In-Reply-To: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775734833; l=46337;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=vsiAwBhKGeIEL8aDpcAFGcbmD7z25k2Jihgu4HBgVOs=;
 b=S6teLBScBUlOqXoJHUV4ZTzLaw8u+Uj79lm4oaTTNSy9GLSGJ5vV8LkqB+Toqjx58cFY/alhr
 eSbJqspVFhiDo/TYyienYNiaFvIcp0HaJFDHBUdS2wPPEGki+ATIXBe
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

This change introduces a development-phase devicetree for the
Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa
wrapper DTS to reference it.

A dedicated EVT1 DTS is added for revision-specific hardware while
keeping a single, Anacapa entrypoint used by the build and deployment
flow. The top-level aspeed-bmc-facebook-anacapa.dts

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1067 ++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1064 +------------------
 2 files changed, 1068 insertions(+), 1063 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
new file mode 100644
index 000000000000..81ad065e114c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -0,0 +1,1067 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Anacapa BMC";
+	compatible = "facebook,anacapa-bmc-evt1", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		i2c16 = &i2c0mux0ch0;
+		i2c17 = &i2c0mux0ch1;
+		i2c18 = &i2c0mux0ch2;
+		i2c19 = &i2c0mux0ch3;
+		i2c20 = &i2c1mux0ch0;
+		i2c21 = &i2c1mux0ch1;
+		i2c22 = &i2c1mux0ch2;
+		i2c23 = &i2c1mux0ch3;
+		i2c24 = &i2c4mux0ch0;
+		i2c25 = &i2c4mux0ch1;
+		i2c26 = &i2c4mux0ch2;
+		i2c27 = &i2c4mux0ch3;
+		i2c28 = &i2c4mux0ch4;
+		i2c29 = &i2c4mux0ch5;
+		i2c30 = &i2c4mux0ch6;
+		i2c31 = &i2c4mux0ch7;
+		i2c32 = &i2c8mux0ch0;
+		i2c33 = &i2c8mux0ch1;
+		i2c34 = &i2c8mux0ch2;
+		i2c35 = &i2c8mux0ch3;
+		i2c36 = &i2c10mux0ch0;
+		i2c37 = &i2c10mux0ch1;
+		i2c38 = &i2c10mux0ch2;
+		i2c39 = &i2c10mux0ch3;
+		i2c40 = &i2c10mux0ch4;
+		i2c41 = &i2c10mux0ch5;
+		i2c42 = &i2c10mux0ch6;
+		i2c43 = &i2c10mux0ch7;
+		i2c44 = &i2c11mux0ch0;
+		i2c45 = &i2c11mux0ch1;
+		i2c46 = &i2c11mux0ch2;
+		i2c47 = &i2c11mux0ch3;
+		i2c48 = &i2c11mux0ch4;
+		i2c49 = &i2c11mux0ch5;
+		i2c50 = &i2c11mux0ch6;
+		i2c51 = &i2c11mux0ch7;
+		i2c52 = &i2c13mux0ch0;
+		i2c53 = &i2c13mux0ch1;
+		i2c54 = &i2c13mux0ch2;
+		i2c55 = &i2c13mux0ch3;
+		i2c56 = &i2c13mux0ch4;
+		i2c57 = &i2c13mux0ch5;
+		i2c58 = &i2c13mux0ch6;
+		i2c59 = &i2c13mux0ch7;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				  <&adc1 2>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size = <0x02c00000>;
+			alignment = <0x00100000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p3v3_bmc_aux";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	spi_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+		status = "okay";
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&adc0 {
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+	status = "okay";
+};
+
+&adc1 {
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&gpio0 {
+	gpio-line-names =
+
+	/*A0-A7*/
+	"","","","","","","","",
+
+	/*B0-B7*/
+	"BATTERY_DETECT", "", "", "BMC_READY",
+	"", "FM_ID_LED", "", "",
+
+	/*C0-C7*/
+	"","","","","","","","",
+
+	/*D0-D7*/
+	"","","","","","","","",
+
+	/*E0-E7*/
+	"","","","","","","","",
+
+	/*F0-F7*/
+	"","","","","","","","",
+
+	/*G0-G7*/
+	"FM_MUX1_SEL", "", "", "",
+	"", "", "FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
+
+	/*H0-H7*/
+	"","","","","","","","",
+
+	/*I0-I7*/
+	"", "", "", "",
+	"", "FLASH_WP_STATUS", "BMC_JTAG_MUX_SEL", "",
+
+	/*J0-J7*/
+	"","","","","","","","",
+
+	/*K0-K7*/
+	"","","","","","","","",
+
+	/*L0-L7*/
+	"","","","","","","","",
+
+	/*M0-M7*/
+	"", "BMC_FRU_WP", "", "",
+	"", "", "", "",
+
+	/*N0-N7*/
+	"LED_POSTCODE_0", "LED_POSTCODE_1", "LED_POSTCODE_2", "LED_POSTCODE_3",
+	"LED_POSTCODE_4", "LED_POSTCODE_5", "LED_POSTCODE_6", "LED_POSTCODE_7",
+
+	/*O0-O7*/
+	"","","","","","","","",
+
+	/*P0-P7*/
+	"PWR_BTN_BMC_BUF_N", "", "ID_RST_BTN_BMC_N", "",
+	"PWR_LED", "", "", "BMC_HEARTBEAT_N",
+
+	/*Q0-Q7*/
+	"","","","","","","","",
+
+	/*R0-R7*/
+	"","","","","","","","",
+
+	/*S0-S7*/
+	"", "", "SYS_BMC_PWRBTN_N", "",
+	"", "", "", "RUN_POWER_FAULT",
+
+	/*T0-T7*/
+	"","","","","","","","",
+
+	/*U0-U7*/
+	"","","","","","","","",
+
+	/*V0-V7*/
+	"","","","","","","","",
+
+	/*W0-W7*/
+	"","","","","","","","",
+
+	/*X0-X7*/
+	"","","","","","","","",
+
+	/*Y0-Y7*/
+	"","","","","","","","",
+
+	/*Z0-Z7*/
+	"SPI_BMC_TPM_CS2_N", "", "", "SPI_BMC_TPM_CLK",
+	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/
+	"","","","","","","","",
+
+	/*18B0-18B7*/
+	"","","","",
+	"FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV_ID1",
+	"FM_BOARD_BMC_REV_ID2", "",
+
+	/*18C0-18C7*/
+	"","","","","","","","",
+
+	/*18D0-18D7*/
+	"","","","","","","","",
+
+	/*18E0-18E3*/
+	"FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_N", "", "";
+};
+
+// L Bridge Board
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c0mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c0mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c0mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// R Bridge Board
+&i2c1 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c1mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c1mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c1mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c1mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// MB - E1.S
+&i2c4 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c4mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// AMC
+&i2c5 {
+	status = "okay";
+};
+
+// MB
+&i2c6 {
+	status = "okay";
+
+	// HPM FRU
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+// SCM
+&i2c7 {
+	status = "okay";
+
+
+};
+
+// MB - PDB
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
+					"RPDB_FAN_CT_FAN_FAIL_R_N", "",
+					"", "",
+					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
+					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
+					"RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
+					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
+					"RPDB_PGD_P3V3_STBY_PWRGD_R",
+					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9555";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN1_R2_PG", "RPDB_P50V_FAN2_R2_PG",
+					"RPDB_P50V_FAN3_R2_PG", "RPDB_P50V_FAN4_R2_PG",
+					"", "RPDB_FAN1_PRSNT_N_R",
+					"", "RPDB_FAN2_PRSNT_N_R",
+					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
+					"", "";
+			};
+
+			// R-PDB FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+		i2c8mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
+					"LPDB_FAN_CT_FAN_FAIL_R_N","",
+					"","",
+					"LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
+					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
+					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
+					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9555";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
+					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
+					"LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
+					"LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
+					"LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
+			};
+
+			// L-PDB FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+		i2c8mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c8mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// SCM
+&i2c9 {
+	status = "okay";
+
+	// SCM FRU
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	// BSM FRU
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+// R Bridge Board
+&i2c10 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"","",
+					"","RBB_CPLD_REFRESH_IN_PRGRS_R_L",
+					"RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
+					"RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
+					"RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
+					"RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
+					"RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
+					"","";
+			};
+
+			// R Bridge Board FRU
+			eeprom@52 {
+				compatible = "atmel,24c256";
+				reg = <0x52>;
+			};
+		};
+		i2c10mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c10mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c11mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"","",
+					"","LBB_CPLD_REFRESH_IN_PRGRS_R_L",
+					"LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
+					"LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
+					"LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
+					"LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
+					"LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
+					"","";
+			};
+
+			// L Bridge Board FRU
+			eeprom@52 {
+				compatible = "atmel,24c256";
+				reg = <0x52>;
+			};
+		};
+		i2c11mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c11mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// Debug Card
+&i2c12 {
+	status = "okay";
+};
+
+// MB
+&i2c13 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c13mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c13mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c13mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c13mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+		};
+		i2c13mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			// HPM BRD ID FRU
+			eeprom@51 {
+				compatible = "atmel,24c256";
+				reg = <0x51>;
+			};
+		};
+		i2c13mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c13mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c13mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			nfc@28 {
+				compatible = "nxp,nxp-nci-i2c";
+				reg = <0x28>;
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
+
+				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
+			};
+		};
+	};
+};
+
+// SCM
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	use-ncsi;
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/* A0-A7 line 0-15 */
+	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
+	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
+	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
+	"", "", "", "",
+
+	/* B0-B7 line 16-31 */
+	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage_Manifold2", "",
+	"Channel5_leakage_EAM1", "",
+	"Channel6_leakage_CPU_DIMM", "",
+	"Channel7_leakage_EAM2", "",
+
+	/* C0-C7 line 32-47 */
+	"RSVD_RMC_GPIO3", "", "", "",
+	"", "", "", "",
+	"LEAK_DETECT_RMC_N", "", "", "",
+	"", "", "", "",
+
+	/* D0-D7 line 48-63 */
+	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
+	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
+	"", "", "", "",
+
+	/* E0-E7 line 64-79 */
+	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
+	"", "", "", "",
+	"", "", "", "",
+
+	/* F0-F7 line 80-95 */
+	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
+	"PWRGD_PVDDCR_CPU0_P0", "",
+	"", "", "", "",
+	"", "", "", "",
+
+	/* G0-G7 line 96-111 */
+	"PWRGD_PVDDCR_SOC_P0", "",
+	"PWRGD_PVDDIO_P0", "",
+	"PWRGD_PVDDIO_MEM_S3_P0", "",
+	"PWRGD_CHMP_CPU0_FPGA", "",
+	"PWRGD_CHIL_CPU0_FPGA", "",
+	"PWRGD_CHEH_CPU0_FPGA", "",
+	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
+	"", "",
+
+	/* H0-H7 line 112-127 */
+	"PWRGD_P3V3", "",
+	"P12V_DDR_IP_PWRGD_R", "",
+	"P12V_DDR_AH_PWRGD_R", "",
+	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
+	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
+	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
+	"PWRGD_PVDD18_S5_P0_PG", "",
+	"PWRGD_PVDD33_S5_P0_PG", "",
+
+	/* I0-I7 line 128-143 */
+	"EAM0_BRD_PRSNT_R_L", "",
+	"EAM1_BRD_PRSNT_R_L", "",
+	"EAM2_BRD_PRSNT_R_L", "",
+	"EAM3_BRD_PRSNT_R_L", "",
+	"EAM0_CPU_MOD_PWR_GD_R", "",
+	"EAM1_CPU_MOD_PWR_GD_R", "",
+	"EAM2_CPU_MOD_PWR_GD_R", "",
+	"EAM3_CPU_MOD_PWR_GD_R", "",
+
+	/* J0-J7 line 144-159 */
+	"PRSNT_L_BIRDGE_R", "",
+	"PRSNT_R_BIRDGE_R", "",
+	"BRIDGE_L_MAIN_PG_R", "",
+	"BRIDGE_R_MAIN_PG_R", "",
+	"BRIDGE_L_STBY_PG_R", "",
+	"BRIDGE_R_STBY_PG_R", "",
+	"", "", "", "",
+
+	/* K0-K7 line 160-175 */
+	"ADC_I2C_ALERT_N", "",
+	"TEMP_I2C_ALERT_R_L", "",
+	"CPU0_VR_SMB_ALERT_CPLD_N", "",
+	"COVER_INTRUDER_R_N", "",
+	"HANDLE_INTRUDER_CPLD_N", "",
+	"IRQ_MCIO_CPLD_WAKE_R_N", "",
+	"APML_CPU0_ALERT_R_N", "",
+	"PDB_ALERT_R_N", "",
+
+	/* L0-L7 line 176-191 */
+	"CPU0_SP7R1", "", "CPU0_SP7R2", "",
+	"CPU0_SP7R3", "", "CPU0_SP7R4", "",
+	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
+	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
+
+	/* M0-M7 line 192-207 */
+	"EAM0_SMERR_CPLD_R_L", "",
+	"EAM1_SMERR_CPLD_R_L", "",
+	"EAM2_SMERR_CPLD_R_L", "",
+	"EAM3_SMERR_CPLD_R_L", "",
+	"CPU0_SMERR_N_R", "",
+	"CPU0_NV_SAVE_N_R", "",
+	"PDB_PWR_LOSS_CPLD_N", "",
+	"IRQ_BMC_SMI_ACTIVE_R_N", "",
+
+	/* N0-N7 line 208-223 */
+	"AMCROT_BMC_S5_RDY_R", "",
+	"AMC_RDY_R", "",
+	"AMC_STBY_PGOOD_R", "",
+	"CPU_AMC_SLP_S5_R_L", "",
+	"AMC_CPU_EAMPG_R", "",
+	"", "", "", "",
+
+	/* O0-O7 line 224-239 */
+	"HPM_PWR_FAIL", "Port80_b0",
+	"FM_DIMM_IP_FAIL", "Port80_b1",
+	"FM_DIMM_AH_FAIL", "Port80_b2",
+	"HPM_AMC_THERMTRIP_R_L", "Port80_b3",
+	"FM_CPU0_THERMTRIP_N", "Port80_b4",
+	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
+	"CPLD_SGPIO_RDY", "Port80_b6",
+	"", "Port80_b7",
+
+	/* P0-P7 line 240-255 */
+	"CPU0_SLP_S5_N_R", "NFC_VEN",
+	"CPU0_SLP_S3_N_R", "",
+	"FM_CPU0_PWRGD", "",
+	"PWRGD_RMC", "",
+	"FM_RST_CPU0_RESET_N", "",
+	"FM_PWRGD_CPU0_PWROK", "",
+	"wS5_PWR_Ready", "",
+	"wS0_ON_N", "PWRGD_P1V0_AUX";
+	status = "okay";
+};
+
+// BIOS Flash
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+	status = "okay";
+	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		label = "pnor";
+		spi-max-frequency = <12000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+		status = "okay";
+	};
+};
+
+// HOST BIOS Debug
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+// BMC Debug Console
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+	pinctrl-names = "default";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
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
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..980628af80b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,1067 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 /dts-v1/;
-#include "aspeed-g6.dtsi"
-#include <dt-bindings/gpio/aspeed-gpio.h>
-#include <dt-bindings/i2c/i2c.h>
+#include "aspeed-bmc-facebook-anacapa-evt1.dts"
 
-/ {
-	model = "Facebook Anacapa BMC";
-	compatible = "facebook,anacapa-bmc", "aspeed,ast2600";
-
-	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-		i2c16 = &i2c0mux0ch0;
-		i2c17 = &i2c0mux0ch1;
-		i2c18 = &i2c0mux0ch2;
-		i2c19 = &i2c0mux0ch3;
-		i2c20 = &i2c1mux0ch0;
-		i2c21 = &i2c1mux0ch1;
-		i2c22 = &i2c1mux0ch2;
-		i2c23 = &i2c1mux0ch3;
-		i2c24 = &i2c4mux0ch0;
-		i2c25 = &i2c4mux0ch1;
-		i2c26 = &i2c4mux0ch2;
-		i2c27 = &i2c4mux0ch3;
-		i2c28 = &i2c4mux0ch4;
-		i2c29 = &i2c4mux0ch5;
-		i2c30 = &i2c4mux0ch6;
-		i2c31 = &i2c4mux0ch7;
-		i2c32 = &i2c8mux0ch0;
-		i2c33 = &i2c8mux0ch1;
-		i2c34 = &i2c8mux0ch2;
-		i2c35 = &i2c8mux0ch3;
-		i2c36 = &i2c10mux0ch0;
-		i2c37 = &i2c10mux0ch1;
-		i2c38 = &i2c10mux0ch2;
-		i2c39 = &i2c10mux0ch3;
-		i2c40 = &i2c10mux0ch4;
-		i2c41 = &i2c10mux0ch5;
-		i2c42 = &i2c10mux0ch6;
-		i2c43 = &i2c10mux0ch7;
-		i2c44 = &i2c11mux0ch0;
-		i2c45 = &i2c11mux0ch1;
-		i2c46 = &i2c11mux0ch2;
-		i2c47 = &i2c11mux0ch3;
-		i2c48 = &i2c11mux0ch4;
-		i2c49 = &i2c11mux0ch5;
-		i2c50 = &i2c11mux0ch6;
-		i2c51 = &i2c11mux0ch7;
-		i2c52 = &i2c13mux0ch0;
-		i2c53 = &i2c13mux0ch1;
-		i2c54 = &i2c13mux0ch2;
-		i2c55 = &i2c13mux0ch3;
-		i2c56 = &i2c13mux0ch4;
-		i2c57 = &i2c13mux0ch5;
-		i2c58 = &i2c13mux0ch6;
-		i2c59 = &i2c13mux0ch7;
-	};
-
-	chosen {
-		stdout-path = "serial4:57600n8";
-	};
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
-				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				  <&adc1 2>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "bmc_heartbeat_amber";
-			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		led-1 {
-			label = "fp_id_amber";
-			default-state = "off";
-			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
-	};
-
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		video_engine_memory: video {
-			size = <0x02c00000>;
-			alignment = <0x00100000>;
-			compatible = "shared-dma-pool";
-			reusable;
-		};
-
-		gfx_memory: framebuffer {
-			size = <0x01000000>;
-			alignment = <0x01000000>;
-			compatible = "shared-dma-pool";
-			reusable;
-		};
-	};
-
-	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
-		compatible = "regulator-fixed";
-		regulator-name = "p3v3_bmc_aux";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	spi_gpio: spi {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
-		num-chipselects = <1>;
-		status = "okay";
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
-};
-
-&adc0 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-		&pinctrl_adc2_default &pinctrl_adc3_default
-		&pinctrl_adc4_default &pinctrl_adc5_default
-		&pinctrl_adc6_default &pinctrl_adc7_default>;
-	status = "okay";
-};
-
-&adc1 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc10_default>;
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&fmc {
-	status = "okay";
-
-	flash@0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-128.dtsi"
-	};
-
-	flash@1 {
-		status = "okay";
-		m25p,fast-read;
-		label = "alt-bmc";
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&gfx {
-	status = "okay";
-	memory-region = <&gfx_memory>;
-};
-
-&gpio0 {
-	gpio-line-names =
-
-	/*A0-A7*/
-	"","","","","","","","",
-
-	/*B0-B7*/
-	"BATTERY_DETECT", "", "", "BMC_READY",
-	"", "FM_ID_LED", "", "",
-
-	/*C0-C7*/
-	"","","","","","","","",
-
-	/*D0-D7*/
-	"","","","","","","","",
-
-	/*E0-E7*/
-	"","","","","","","","",
-
-	/*F0-F7*/
-	"","","","","","","","",
-
-	/*G0-G7*/
-	"FM_MUX1_SEL", "", "", "",
-	"", "", "FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
-
-	/*H0-H7*/
-	"","","","","","","","",
-
-	/*I0-I7*/
-	"", "", "", "",
-	"", "FLASH_WP_STATUS", "BMC_JTAG_MUX_SEL", "",
-
-	/*J0-J7*/
-	"","","","","","","","",
-
-	/*K0-K7*/
-	"","","","","","","","",
-
-	/*L0-L7*/
-	"","","","","","","","",
-
-	/*M0-M7*/
-	"", "BMC_FRU_WP", "", "",
-	"", "", "", "",
-
-	/*N0-N7*/
-	"LED_POSTCODE_0", "LED_POSTCODE_1", "LED_POSTCODE_2", "LED_POSTCODE_3",
-	"LED_POSTCODE_4", "LED_POSTCODE_5", "LED_POSTCODE_6", "LED_POSTCODE_7",
-
-	/*O0-O7*/
-	"","","","","","","","",
-
-	/*P0-P7*/
-	"PWR_BTN_BMC_BUF_N", "", "ID_RST_BTN_BMC_N", "",
-	"PWR_LED", "", "", "BMC_HEARTBEAT_N",
-
-	/*Q0-Q7*/
-	"","","","","","","","",
-
-	/*R0-R7*/
-	"","","","","","","","",
-
-	/*S0-S7*/
-	"", "", "SYS_BMC_PWRBTN_N", "",
-	"", "", "", "RUN_POWER_FAULT",
-
-	/*T0-T7*/
-	"","","","","","","","",
-
-	/*U0-U7*/
-	"","","","","","","","",
-
-	/*V0-V7*/
-	"","","","","","","","",
-
-	/*W0-W7*/
-	"","","","","","","","",
-
-	/*X0-X7*/
-	"","","","","","","","",
-
-	/*Y0-Y7*/
-	"","","","","","","","",
-
-	/*Z0-Z7*/
-	"SPI_BMC_TPM_CS2_N", "", "", "SPI_BMC_TPM_CLK",
-	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO", "", "";
-};
-
-&gpio1 {
-	gpio-line-names =
-	/*18A0-18A7*/
-	"","","","","","","","",
-
-	/*18B0-18B7*/
-	"","","","",
-	"FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV_ID1",
-	"FM_BOARD_BMC_REV_ID2", "",
-
-	/*18C0-18C7*/
-	"","","","","","","","",
-
-	/*18D0-18D7*/
-	"","","","","","","","",
-
-	/*18E0-18E3*/
-	"FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_N", "", "";
-};
-
-// L Bridge Board
-&i2c0 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c2048";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c0mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// R Bridge Board
-&i2c1 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c2048";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c1mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// MB - E1.S
-&i2c4 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c4mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// AMC
-&i2c5 {
-	status = "okay";
-};
-
-// MB
-&i2c6 {
-	status = "okay";
-
-	// HPM FRU
-	eeprom@50 {
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-	};
-};
-
-// SCM
-&i2c7 {
-	status = "okay";
-
-
-};
-
-// MB - PDB
-&i2c8 {
-	status = "okay";
-
-	i2c-mux@72 {
-		compatible = "nxp,pca9546";
-		reg = <0x72>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c8mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			adc@1f {
-				compatible = "ti,adc128d818";
-				reg = <0x1f>;
-				ti,mode = /bits/ 8 <1>;
-			};
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
-					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
-					"RPDB_FAN_CT_FAN_FAIL_R_N", "",
-					"", "",
-					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
-					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
-					"RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
-					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
-					"RPDB_PGD_P3V3_STBY_PWRGD_R",
-					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
-			};
-
-			gpio@24 {
-				compatible = "nxp,pca9555";
-				reg = <0x24>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
-					"RPDB_PWRGD_P50V_HSC4_SYS_R",
-					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
-					"RPDB_P50V_FAN1_R2_PG", "RPDB_P50V_FAN2_R2_PG",
-					"RPDB_P50V_FAN3_R2_PG", "RPDB_P50V_FAN4_R2_PG",
-					"", "RPDB_FAN1_PRSNT_N_R",
-					"", "RPDB_FAN2_PRSNT_N_R",
-					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
-					"", "";
-			};
-
-			// R-PDB FRU
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-		};
-		i2c8mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
-					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
-					"LPDB_FAN_CT_FAN_FAIL_R_N","",
-					"","",
-					"LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
-					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
-					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
-					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
-			};
-
-			gpio@24 {
-				compatible = "nxp,pca9555";
-				reg = <0x24>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
-					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
-					"LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
-					"LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
-					"LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
-					"","",
-					"","",
-					"","";
-			};
-
-			// L-PDB FRU
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-		};
-		i2c8mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c8mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// SCM
-&i2c9 {
-	status = "okay";
-
-	// SCM FRU
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
-
-	// BSM FRU
-	eeprom@56 {
-		compatible = "atmel,24c64";
-		reg = <0x56>;
-	};
-};
-
-// R Bridge Board
-&i2c10 {
-	status = "okay";
-
-	i2c-mux@71 {
-		compatible = "nxp,pca9548";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c10mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"","",
-					"","RBB_CPLD_REFRESH_IN_PRGRS_R_L",
-					"RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
-					"RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
-					"RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
-					"RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
-					"RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
-					"","";
-			};
-
-			// R Bridge Board FRU
-			eeprom@52 {
-				compatible = "atmel,24c256";
-				reg = <0x52>;
-			};
-		};
-		i2c10mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// L Bridge Board
-&i2c11 {
-	status = "okay";
-
-	i2c-mux@71 {
-		compatible = "nxp,pca9548";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c11mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"","",
-					"","LBB_CPLD_REFRESH_IN_PRGRS_R_L",
-					"LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
-					"LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
-					"LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
-					"LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
-					"LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
-					"","";
-			};
-
-			// L Bridge Board FRU
-			eeprom@52 {
-				compatible = "atmel,24c256";
-				reg = <0x52>;
-			};
-		};
-		i2c11mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// Debug Card
-&i2c12 {
-	status = "okay";
-};
-
-// MB
-&i2c13 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c13mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			adc@1f {
-				compatible = "ti,adc128d818";
-				reg = <0x1f>;
-				ti,mode = /bits/ 8 <1>;
-			};
-		};
-		i2c13mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			// HPM BRD ID FRU
-			eeprom@51 {
-				compatible = "atmel,24c256";
-				reg = <0x51>;
-			};
-		};
-		i2c13mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			nfc@28 {
-				compatible = "nxp,nxp-nci-i2c";
-				reg = <0x28>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
-
-				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
-			};
-		};
-	};
-};
-
-// SCM
-&i2c14 {
-	status = "okay";
-};
-
-&i2c15 {
-	status = "okay";
-};
-
-&kcs2 {
-	aspeed,lpc-io-reg = <0xca8>;
-	status = "okay";
-};
-
-&kcs3 {
-	aspeed,lpc-io-reg = <0xca2>;
-	status = "okay";
-};
-
-&lpc_ctrl {
-	status = "okay";
-};
-
-&mac2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ncsi3_default>;
-	use-ncsi;
-};
-
-&sgpiom0 {
-	ngpios = <128>;
-	bus-frequency = <2000000>;
-	gpio-line-names =
-	/*in - out - in - out */
-	/* A0-A7 line 0-15 */
-	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
-	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
-	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
-	"", "", "", "",
-
-	/* B0-B7 line 16-31 */
-	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
-	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
-	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
-	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "",
-	"Channel5_leakage_EAM1", "",
-	"Channel6_leakage_CPU_DIMM", "",
-	"Channel7_leakage_EAM2", "",
-
-	/* C0-C7 line 32-47 */
-	"RSVD_RMC_GPIO3", "", "", "",
-	"", "", "", "",
-	"LEAK_DETECT_RMC_N", "", "", "",
-	"", "", "", "",
-
-	/* D0-D7 line 48-63 */
-	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
-	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
-	"", "", "", "",
-
-	/* E0-E7 line 64-79 */
-	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
-	"", "", "", "",
-	"", "", "", "",
-
-	/* F0-F7 line 80-95 */
-	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
-	"PWRGD_PVDDCR_CPU0_P0", "",
-	"", "", "", "",
-	"", "", "", "",
-
-	/* G0-G7 line 96-111 */
-	"PWRGD_PVDDCR_SOC_P0", "",
-	"PWRGD_PVDDIO_P0", "",
-	"PWRGD_PVDDIO_MEM_S3_P0", "",
-	"PWRGD_CHMP_CPU0_FPGA", "",
-	"PWRGD_CHIL_CPU0_FPGA", "",
-	"PWRGD_CHEH_CPU0_FPGA", "",
-	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
-	"", "",
-
-	/* H0-H7 line 112-127 */
-	"PWRGD_P3V3", "",
-	"P12V_DDR_IP_PWRGD_R", "",
-	"P12V_DDR_AH_PWRGD_R", "",
-	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
-	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
-	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
-	"PWRGD_PVDD18_S5_P0_PG", "",
-	"PWRGD_PVDD33_S5_P0_PG", "",
-
-	/* I0-I7 line 128-143 */
-	"EAM0_BRD_PRSNT_R_L", "",
-	"EAM1_BRD_PRSNT_R_L", "",
-	"EAM2_BRD_PRSNT_R_L", "",
-	"EAM3_BRD_PRSNT_R_L", "",
-	"EAM0_CPU_MOD_PWR_GD_R", "",
-	"EAM1_CPU_MOD_PWR_GD_R", "",
-	"EAM2_CPU_MOD_PWR_GD_R", "",
-	"EAM3_CPU_MOD_PWR_GD_R", "",
-
-	/* J0-J7 line 144-159 */
-	"PRSNT_L_BIRDGE_R", "",
-	"PRSNT_R_BIRDGE_R", "",
-	"BRIDGE_L_MAIN_PG_R", "",
-	"BRIDGE_R_MAIN_PG_R", "",
-	"BRIDGE_L_STBY_PG_R", "",
-	"BRIDGE_R_STBY_PG_R", "",
-	"", "", "", "",
-
-	/* K0-K7 line 160-175 */
-	"ADC_I2C_ALERT_N", "",
-	"TEMP_I2C_ALERT_R_L", "",
-	"CPU0_VR_SMB_ALERT_CPLD_N", "",
-	"COVER_INTRUDER_R_N", "",
-	"HANDLE_INTRUDER_CPLD_N", "",
-	"IRQ_MCIO_CPLD_WAKE_R_N", "",
-	"APML_CPU0_ALERT_R_N", "",
-	"PDB_ALERT_R_N", "",
-
-	/* L0-L7 line 176-191 */
-	"CPU0_SP7R1", "", "CPU0_SP7R2", "",
-	"CPU0_SP7R3", "", "CPU0_SP7R4", "",
-	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
-	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
-
-	/* M0-M7 line 192-207 */
-	"EAM0_SMERR_CPLD_R_L", "",
-	"EAM1_SMERR_CPLD_R_L", "",
-	"EAM2_SMERR_CPLD_R_L", "",
-	"EAM3_SMERR_CPLD_R_L", "",
-	"CPU0_SMERR_N_R", "",
-	"CPU0_NV_SAVE_N_R", "",
-	"PDB_PWR_LOSS_CPLD_N", "",
-	"IRQ_BMC_SMI_ACTIVE_R_N", "",
-
-	/* N0-N7 line 208-223 */
-	"AMCROT_BMC_S5_RDY_R", "",
-	"AMC_RDY_R", "",
-	"AMC_STBY_PGOOD_R", "",
-	"CPU_AMC_SLP_S5_R_L", "",
-	"AMC_CPU_EAMPG_R", "",
-	"", "", "", "",
-
-	/* O0-O7 line 224-239 */
-	"HPM_PWR_FAIL", "Port80_b0",
-	"FM_DIMM_IP_FAIL", "Port80_b1",
-	"FM_DIMM_AH_FAIL", "Port80_b2",
-	"HPM_AMC_THERMTRIP_R_L", "Port80_b3",
-	"FM_CPU0_THERMTRIP_N", "Port80_b4",
-	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
-	"CPLD_SGPIO_RDY", "Port80_b6",
-	"", "Port80_b7",
-
-	/* P0-P7 line 240-255 */
-	"CPU0_SLP_S5_N_R", "NFC_VEN",
-	"CPU0_SLP_S3_N_R", "",
-	"FM_CPU0_PWRGD", "",
-	"PWRGD_RMC", "",
-	"FM_RST_CPU0_RESET_N", "",
-	"FM_PWRGD_CPU0_PWROK", "",
-	"wS5_PWR_Ready", "",
-	"wS0_ON_N", "PWRGD_P1V0_AUX";
-	status = "okay";
-};
-
-// BIOS Flash
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
-	status = "okay";
-	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		label = "pnor";
-		spi-max-frequency = <12000000>;
-		spi-tx-bus-width = <2>;
-		spi-rx-bus-width = <2>;
-		status = "okay";
-	};
-};
-
-// HOST BIOS Debug
-&uart1 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-// BMC Debug Console
-&uart5 {
-	status = "okay";
-};
-
-&uart_routing {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
-&vhub {
-	status = "okay";
-	pinctrl-names = "default";
-};
-
-&video {
-	status = "okay";
-	memory-region = <&video_engine_memory>;
-};
-
-&wdt1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdtrst1_default>;
-	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
-	aspeed,ext-active-high;
-	aspeed,ext-pulse-duration = <256>;
-	status = "okay";
-};

-- 
2.34.1


