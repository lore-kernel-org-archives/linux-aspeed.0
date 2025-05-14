Return-Path: <linux-aspeed+bounces-1216-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603F6C3ABCC
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 May 2025 12:01:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyBkx4KLVz2yr6;
	Wed, 14 May 2025 22:01:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747205152;
	cv=none; b=g9pf6t1deJQ5QzWzbMONwxu4XshTS9DictXitOam+hWGdPySyfDwuzRzjrDDlPWWbp6X6NJ4ojNtJvmGwxlVQHZNzf3I45KGx6Nks/+eACo8IoX1msDi5Kyn89R4CliEFjS9Az5qxTqkimjd/rhKf4/npZx0X8bzmnJ/wpwK7hDALJvnc5cP9DylUEWdEc8Ys4EzFZHv7E2+6/leUjlSJmRSPOL50X6MTQVnyNCxW+ROGlbytKLRKzq2JkC1ktPAmkcSFAObt0bRLUsLUfzpMDbCCB38QB55B/n2SYPEzGoN4x9SmXAgoIo+WVn6ekXDkrHnO6ic0KAHvaLVkT2GVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747205152; c=relaxed/relaxed;
	bh=d6Qd8otaSNCUQIKbKS8SWfStRi4tWnNqFDSjPKR0dWo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=betXTt30TlAVRwKdJQgSn7i8mw2FRiB7SFg1I+smZBhL9GvgzDnK+ro0iJeBItF2zh4rUPP2DF+mL4q/t9LEUvK4h/V060y6rUJ3lJ/3PgBqWu+wonSOC4KtOhokWgBtVHhv6uEyob3dJT+2N6u6Mo3gV8vQ298corxHGZujCng/Zm10msAdP6xucVUVd3Opgg4P3eoaiDvcHSryYWSqpWPVpTExgoqn+OJEwRirJKOFQkG6ysQWeijZjkzYDaP5LyrnPf3G+eRJkjZTTML4SfnZGLxbMNnJR8+Cv6Tz9KVZMPatEEKY4//c81m7XjErKoKmxFtJtGHalS0lTITGVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UkqW/hHG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UkqW/hHG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zy3l32Bbwz2x9N
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 16:45:50 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2302d90c7f7so39473815ad.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747205149; x=1747809949; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6Qd8otaSNCUQIKbKS8SWfStRi4tWnNqFDSjPKR0dWo=;
        b=UkqW/hHGjbXD3THrEMD8QLjcwjotT3EtO7GM7wioeSlISQozoBBChI3j/oLRVFN5tf
         yH1m5HYHYOz5i+d0Lr2LeFAS0Gcsx4qcgmLpcCMTabBUVcnys8+ulfJmX2IBgL/hes8g
         OLhf0+wp0U7Ccm6R/l9kTBBJHWRQ0R0imLrJnosAb0luH7hgv5T9dYT2YiYf7w4alvbQ
         4pwLEt4eZZPbF7G5W3OR9vHpXWyt0JDF9bZTOcKCI/AsPgCEK8AcqXe3VyhzhaM/gn8g
         ZBCEIgP+6z9mGvvOgEjWoW90MCzPaEfPi6rVeoU530BgchhGA0HzJ6/NFr+4D+f5iIxp
         d5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205149; x=1747809949;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d6Qd8otaSNCUQIKbKS8SWfStRi4tWnNqFDSjPKR0dWo=;
        b=V0tTBGy2dJ+7kO1KU/9OmcxOuvSEeOPAI7OKP4ZGE+YtparyjUzSNg79TImrYp4M/d
         nrGjaaEa+N4fJ1nZ908U5H2o9RP/Ei4gYwhKy/te0WnJxpqF/eCOLptgpo+dG0DPhVbs
         T2HO56RHArOPuzQ2etkgXAa5g2L+hetIyQjeBTbq+uABCPgpoVlyhmq2jMVoXU9GnH23
         zMhpnG6jxWD5NbVkMmKqBmusMBJRlJCNqFc7pyI+4gz4hs31SbJKYVIb+KczHL2Kf+V0
         j51kP7mbbkPpeUC0Y5bsZVMYpT352uVBRuI5mz0OxJvFV8j8NK8C+6V3NDCIZONZaDIo
         630g==
X-Forwarded-Encrypted: i=1; AJvYcCUMZzzRp/PgBiQYCPBOIh89enPvndugx8TB9o6uMrdrldJKElYYtDaA9yW43PsSQv2Qovrpi90vrTBdRHU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkNrysULwHq7SSCslJE2XThamkt8xBd/rNDKnTB7Rc+/FPwk1R
	t2wTLoL8zmqZp22vHr98pEKOabwcrQTq96P2NIq9I54uCpdjDSJ2
X-Gm-Gg: ASbGncs7KGaEFsImxJsIxVpE86Oh/ZCKz/0ySkkRUhk9MY1nHWOKPqlSuTMGoPLD2U/
	YyQFf0/3iaFcQEsEqiHmt588p/4rthUBjN0VD92z04Nhh96VsGzgyTQQHyCIp3Yxnqp1f+Ln9ha
	65/UP3weL+LX5zRTtwN0Xk+bSgcMx/qhEKVIdxsTmW/ZkdAPajZLGfl5zrto6rBwaHdm7QkEn+W
	+j1VoMNrBPiIQJs7urBTxcy2lNf9IuOgKLwyQELMzYNBh7G5oqryp/zdVvHaRbNJmbghVBssqUj
	SpbbwU8D74+383+v5WZfw+Jc2CbHGygFgwgnKGaUG+zAqROc3K96aSg/zvCbpXHvmK0noUGD
X-Google-Smtp-Source: AGHT+IFQMwGhw64XF2mEB03hwEUiXq47S35DZTihPa7U8h6/MLMvkkG8x7qV6ITlMd7VZY17O9pAew==
X-Received: by 2002:a17:903:3c44:b0:22e:7c7e:2b7d with SMTP id d9443c01a7336-2319813d414mr30571305ad.20.1747205148725;
        Tue, 13 May 2025 23:45:48 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82900afsm90729375ad.199.2025.05.13.23.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:45:48 -0700 (PDT)
Message-ID: <68243c1c.170a0220.301af4.eeec@mx.google.com>
X-Google-Original-Message-ID: <20250514064532.284595-1-LeoWang>
From: leo.jt.wang@gmail.com
X-Google-Original-From: LeoWang
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	george.kw.lee@fii-foxconn.com,
	leo.jt.wang@fii-foxconn.com
Subject: [PATCH V2 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
Date: Wed, 14 May 2025 14:45:31 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6822b851.050a0220.27a24d.d071@mx.google.com>
References: <6822b851.050a0220.27a24d.d071@mx.google.com>
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

From: Leo Wang <leo.jt.wang@fii-foxconn.com>

Add linux device tree entry for Meta Clemente compute-tray
BMC using AST2600 SoC.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-clemente.dts   | 1252 +++++++++++++++++
 2 files changed, 1253 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index b3170fdd3096..9d0a465cbb36 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-facebook-catalina.dtb \
+	aspeed-bmc-facebook-clemente.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
new file mode 100644
index 000000000000..543d6cac7de7
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -0,0 +1,1252 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Clemente BMC";
+	compatible = "facebook,clemente-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		i2c16 = &i2c1mux0ch0;
+		i2c17 = &i2c1mux0ch1;
+		i2c18 = &i2c1mux0ch2;
+		i2c19 = &i2c1mux0ch3;
+		i2c20 = &i2c1mux0ch4;
+		i2c21 = &i2c1mux0ch5;
+		i2c22 = &i2c1mux0ch6;
+		i2c23 = &i2c1mux0ch7;
+		i2c24 = &i2c0mux0ch0;
+		i2c25 = &i2c0mux0ch1;
+		i2c26 = &i2c0mux0ch2;
+		i2c27 = &i2c0mux0ch3;
+		i2c28 = &i2c0mux1ch0;
+		i2c29 = &i2c0mux1ch1;
+		i2c30 = &i2c0mux1ch2;
+		i2c31 = &i2c0mux1ch3;
+		i2c32 = &i2c0mux2ch0;
+		i2c33 = &i2c0mux2ch1;
+		i2c34 = &i2c0mux2ch2;
+		i2c35 = &i2c0mux2ch3;
+		i2c36 = &i2c0mux3ch0;
+		i2c37 = &i2c0mux3ch1;
+		i2c38 = &i2c0mux3ch2;
+		i2c39 = &i2c0mux3ch3;
+		i2c40 = &i2c0mux4ch0;
+		i2c41 = &i2c0mux4ch1;
+		i2c42 = &i2c0mux4ch2;
+		i2c43 = &i2c0mux4ch3;
+		i2c44 = &i2c0mux5ch0;
+		i2c45 = &i2c0mux5ch1;
+		i2c46 = &i2c0mux5ch2;
+		i2c47 = &i2c0mux5ch3;
+		i2c48 = &i2c5mux0ch0;
+		i2c49 = &i2c5mux0ch1;
+		i2c50 = &i2c5mux0ch2;
+		i2c51 = &i2c5mux0ch3;
+		i2c52 = &i2c5mux0ch4;
+		i2c53 = &i2c5mux0ch5;
+		i2c54 = &i2c5mux0ch6;
+		i2c55 = &i2c5mux0ch7;
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
+				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				  <&adc1 2>;
+	};
+
+	spi1_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
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
+
+		led-2 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+
+		led-3 {
+			label = "bmc_ready_cpld_noled";
+			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+	};
+
+	p1v8_bmc_aux: regulator-p1v8-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	p2v5_bmc_aux: regulator-p2v5-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p2v5_bmc_aux";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops@b3e00000 {
+			compatible = "ramoops";
+			reg = <0xbb000000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>;
+		};
+	};
+
+};
+
+&udma {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	compatible = "aspeed,ast2600-uart";
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	use-ncsi;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-package = <1>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncsi4_default>;
+	use-ncsi;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-package = <2>;
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
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+		i2c0mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c0mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+		i2c0mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux1ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c0mux1ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			// IO Mezz 0 IOEXP
+			io_expander7: gpio@21 {
+				compatible = "nxp,pca9535";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// IO Mezz 0 FRU EEPROM
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+		i2c0mux1ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c0mux1ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9546";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux2ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c0mux2ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c0mux2ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c0mux2ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9546";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux3ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+		i2c0mux3ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c0mux3ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+		i2c0mux3ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9546";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux4ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c0mux4ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			// IO Mezz 1 IOEXP
+			io_expander8: gpio@21 {
+				compatible = "nxp,pca9535";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// IO Mezz 1 FRU EEPROM
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+		i2c0mux4ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c0mux4ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0mux5ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c0mux5ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c0mux5ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c0mux5ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	// HSC
+	power-monitor@12 {
+		compatible = "ti,lm5066i";
+		reg = <0x12>;
+	};
+
+	// HSC
+	power-monitor@14 {
+		compatible = "ti,lm5066i";
+		reg = <0x14>;
+	};
+
+	// HSC TEMP SENSOR
+	temperature-sensor@4a {
+		compatible = "ti,tmp461";
+		reg = <0x4a>;
+	};
+
+	// HSC FRU EEPROM
+	eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+	};
+
+    // CPU0 Leak sensor MAX1363
+	Leak-sensor@34 {
+		compatible = "maxim,max1363";
+		reg = <0x34>;
+	};
+
+    // CPU1 Leak sensor MAX1363
+	Leak-sensor@35 {
+		compatible = "maxim,max1363";
+		reg = <0x35>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		i2c1mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
+		};
+		i2c1mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+		i2c1mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			fanctl0: fan-controller@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					reg = <2>;
+					sensor-type = "TACH";
+				};
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
+			};
+			fanctl1: fan-controller@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					reg = <2>;
+					sensor-type = "TACH";
+				};
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
+			};
+		};
+		i2c1mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+		i2c1mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+		i2c1mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+
+			// PDB FRU EEPROM
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			// PDB TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
+		};
+		i2c1mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+
+			// PDB IOEXP
+			io_expander5: gpio@27 {
+				compatible = "nxp,pca9554";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// OSFP IOEXP
+			io_expander6: gpio@25 {
+				compatible = "nxp,pca9555";
+				reg = <0x25>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			// OSFP FRU EEPROM
+			eeprom@51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+		i2c1mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+
+			// FIO FRU EEPROM
+			eeprom@51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+
+			// FIO TEMP SENSOR
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	// Module 0, Expander @0x20
+	io_expander0: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// Module 1, Expander @0x21
+	io_expander1: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HMC Expander @0x27
+	io_expander2: gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HMC Expander @0x74
+	io_expander3: gpio@74 {
+		compatible = "nxp,pca9555";
+		reg = <0x74>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// Module 0 Aux EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// Module 1 Aux EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+
+	// Interposer board EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <100000>;
+	multi-master;
+	aspeed,hw-timeout-ms = <1000>;
+
+	//USB Debug Connector
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
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
+	// SCM CPLD IOEXP
+	io_expander4: gpio@4f {
+		compatible = "nxp,pca9555";
+		reg = <0x4f>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// SCM TEMP SENSOR BOARD
+	temperature-sensor@4b {
+		compatible = "national,lm75b";
+		reg = <0x4b>;
+	};
+
+	// SCM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// BSM FRU EEPROM
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	// OCP NIC0 TEMP
+	temperature-sensor@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+
+	// OCP NIC0 FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+		alert-gpios = <&gpio0 ASPEED_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+		timeout-ms = <5000>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	multi-master;
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c5mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c5mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c5mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+		i2c5mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		i2c5mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+		i2c5mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			// HDD FRU EEPROM
+			eeprom@56 {
+				compatible = "atmel,24c64";
+				reg = <0x56>;
+			};
+		};
+		i2c5mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			power-sensor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@49 {
+				compatible = "ti,ina230";
+				reg = <0x49>;
+				shunt-resistor = <2000>;
+			};
+		};
+	};
+};
+
+&i2c13 {
+	status = "okay";
+	multi-master;
+
+	// HPM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+	// CBC 0 FRU
+	eeprom@54 {
+		compatible = "atmel,24c02";
+		reg = <0x54>;
+	};
+	// CBC 1 FRU
+	eeprom@55 {
+		compatible = "atmel,24c02";
+		reg = <0x55>;
+	};
+	// CBC 2 FRU
+	eeprom@56 {
+		compatible = "atmel,24c02";
+		reg = <0x56>;
+	};
+	// CBC 3 FRU
+	eeprom@58 {
+		compatible = "atmel,24c02";
+		reg = <0x58>;
+	};
+	// HMC FRU EEPROM
+	eeprom@57 {
+		compatible = "atmel,24c02";
+		reg = <0x57>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	// PDB CPLD IOEXP 0x10
+	io_expander9: gpio@10 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x11
+	io_expander10: gpio@11 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x12
+	io_expander11: gpio@12 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x13
+	io_expander12: gpio@13 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x13>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x14
+	io_expander13: gpio@14 {
+		compatible = "nxp,pca9555";
+		reg = <0x14>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	// OCP NIC1 TEMP
+	temperature-sensor@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+
+	// OCP NIC1 FRU EEPROM
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+};
+
+&adc0 {
+	vref-supply = <&p1v8_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref-supply = <&p2v5_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+};
+
+&ehci0 {
+	status = "okay";
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
+&pinctrl {
+	pinctrl_ncsi3_default: ncsi3_default {
+		function = "RMII3";
+		groups = "NCSI3";
+	};
+
+	pinctrl_ncsi4_default: ncsi4_default {
+		function = "RMII4";
+		groups = "NCSI4";
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"BATTERY_DETECT","PRSNT1_HPM_SCM_N",
+			"BMC_I2C1_FPGA_ALERT_L","BMC_READY",
+			"IOEXP_INT_L","FM_ID_LED",
+			"","",
+	/*C0-C7*/	"BMC_GPIOC0","","","",
+			"PMBUS_REQ_N","PSU_FW_UPDATE_REQ_N",
+			"","BMC_I2C_SSIF_ALERT_L",
+	/*D0-D7*/	"","","","","BMC_GPIOD4","","","",
+	/*E0-E7*/	"BMC_GPIOE0","BMC_GPIOE1","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","",
+			"FM_DEBUG_PORT_PRSNT_N","FM_BMC_DBP_PRESENT_N",
+	/*H0-H7*/	"PWR_BRAKE_L","RUN_POWER_EN",
+			"SHDN_FORCE_L","SHDN_REQ_L",
+			"","","","",
+	/*I0-I7*/	"","","","",
+			"","FLASH_WP_STATUS",
+			"FM_PDB_HEALTH_N","RUN_POWER_PG",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"PCIE_EP_RST_EN","BMC_FRU_WP",
+			"SCM_HPM_STBY_RST_N","SCM_HPM_STBY_EN",
+			"STBY_POWER_PG_3V3","TH500_SHDN_OK_L","","",
+	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
+			"LED_POSTCODE_2","LED_POSTCODE_3",
+			"LED_POSTCODE_4","LED_POSTCODE_5",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
+	/*O0-O7*/	"HMC_I2C3_FPGA_ALERT_L","FPGA_READY_HMC",
+			"CHASSIS_AC_LOSS_L","BSM_PRSNT_R_N",
+			"PSU_SMB_ALERT_L","FM_TPM_PRSNT_0_N",
+			"","USBDBG_IPMI_EN_L",
+	/*P0-P7*/	"PWR_BTN_BMC_N","IPEX_CABLE_PRSNT_L",
+			"ID_RST_BTN_BMC_N","RST_BMC_RSTBTN_OUT_N",
+			"host0-ready","BMC_READY_CPLD","BMC_GPIOP6","BMC_HEARTBEAT_N",
+	/*Q0-Q7*/	"IRQ_PCH_TPM_SPI_N","USB_OC0_REAR_R_N",
+			"UART_MUX_SEL","I2C_MUX_RESET_L",
+			"RSVD_NV_PLT_DETECT","SPI_TPM_INT_L",
+			"CPU_JTAG_MUX_SELECT","THERM_BB_OVERT_L",
+	/*R0-R7*/	"THERM_BB_WARN_L","SPI_BMC_FPGA_INT_L",
+			"CPU_BOOT_DONE","PMBUS_GNT_L",
+			"CHASSIS_PWR_BRK_L","PCIE_WAKE_L",
+			"PDB_THERM_OVERT_L","HMC_I2C2_FPGA_ALERT_L",
+	/*S0-S7*/	"","","SYS_BMC_PWRBTN_R_N","FM_TPM_PRSNT_1_N",
+			"FM_BMC_DEBUG_SW_N","UID_LED_N",
+			"SYS_FAULT_LED_N","RUN_POWER_FAULT_L",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"L2_RST_REQ_OUT_L","L0L1_RST_REQ_OUT_L",
+			"BMC_ID_BEEP_SEL","BMC_I2C0_FPGA_ALERT_L",
+			"SMB_BMC_TMP_ALERT","PWR_LED_N",
+			"SYS_RST_OUT_L","IRQ_TPM_SPI_N",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","RST_BMC_SELF_HW",
+			"FM_FLASH_LATCH_N","BMC_EMMC_RST_N",
+			"BMC_GPIOY4","BMC_GPIOY5","","",
+	/*Z0-Z7*/	"","","","","","","BMC_GPIOZ6","BMC_GPIOZ7";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/	"","","","","","","","",
+	/*18B0-18B3*/	"","","","",
+	/*18B4-18B7*/	"FM_BOARD_BMC_REV_ID0","FM_BOARD_BMC_REV_ID1","FM_BOARD_BMC_REV_ID2","",
+	/*18C0-18C7*/	"","","PI_BMC_BIOS_ROM_IRQ0_N","","","","","",
+	/*18D0-18D7*/	"","","","","","","","",
+	/*18E0-18E3*/	"","","","AC_PWR_BMC_BTN_N","","","","";
+};
+
+&io_expander0 {
+	gpio-line-names =
+		"FPGA_THERM_OVERT_L-I",
+		"FPGA_READY_BMC-I",
+		"HMC_BMC_DETECT-O",
+		"HMC_PGOOD-O",
+		"",
+		"BMC_STBY_CYCLE-O",
+		"FPGA_EROT_FATAL_ERROR_L-I",
+		"WP_HW_EXT_CTRL_L-O",
+		"EROT_FPGA_RST_L-O",
+		"FPGA_EROT_RECOVERY_L-O",
+		"BMC_EROT_FPGA_SPI_MUX_SEL-O",
+		"USB2_HUB_RST_L-O",
+		"",
+		"SGPIO_EN_L-O",
+		"B2B_IOEXP_INT_L-I",
+		"I2C_BUS_MUX_RESET_L-O";
+};
+
+&io_expander1 {
+	gpio-line-names =
+		"USB_MUX_SEL_N-O",
+		"",
+		"MCIO_PCIE_DISABLE_L-O",
+		"USB_PCIE_DISABLE_L-O",
+		"PEX_SW_PCIE_DISABLE_L-O",
+		"HSC_CARD_PRSNT_N-I",
+		"TPM_MUX_3V3_SEL_OUT_N-O",
+		"USB2_HUB4_RST_L-O",
+		"PCI_MUX_SEL-O",
+		"TPM_MUX_SEL-O",
+		"IOEXP_BMC_PHY_RST_N-O",
+		"IOEXP_RTC_CLR_L-O",
+		"BMC_12V_CTRL-O",
+		"PS_RUN_IO0_PG-I",
+		"",
+		"";
+};
+
+&io_expander2 {
+	gpio-line-names =
+		"HMC_PRSNT_L-I",
+		"HMC_READY-I",
+		"HMC_EROT_FATAL_ERROR_L-I",
+		"I2C_MUX_SEL-O",
+		"HMC_EROT_SPI_MUX_SEL-O",
+		"HMC_EROT_RECOVERY_L-O",
+		"HMC_EROT_RST_L-O",
+		"GLOBAL_WP_HMC-O",
+		"FPGA_RST_L-O",
+		"USB2_HUB_RST-O",
+		"CPU_UART_MUX_SEL-O",
+		"",
+		"",
+		"",
+		"",
+		"";
+};
+
+&io_expander3 {
+	gpio-line-names =
+		"IOB_PRSNT_L",
+		"IOB_DP_HPD",
+		"IOX_BMC_RESET",
+		"IOB_IOEXP_INT_L",
+		"IOB_UID_LED_L",
+		"IOB_UID_BTN_L",
+		"IOB_SYS_RST_BTN_L",
+		"IOB_PWR_LED_L",
+		"IOB_PWR_BTN_L",
+		"IOB_PHY_RST",
+		"CPLD_JTAG_MUX_SEL",
+		"",
+		"",
+		"",
+		"",
+		"";
+};
+
+&io_expander4 {
+	gpio-line-names =
+		"stby_power_en_cpld","stby_power_gd_cpld","","",
+		"","","","",
+		"","","","",
+		"","","","";
+};
+
+&io_expander5 {
+	gpio-line-names =
+		"JTAG_MUX_SEL","IOX_BMC_RESET","RTC_CLR_L","RTC_U77_ALRT_N",
+		"","PSU_ALERT_N","","RST_P12V_STBY_N";
+};
+
+&io_expander6 {
+	gpio-line-names =
+		"OSFP_PHASE_ID0","OSFP_PHASE_ID1",
+		"OSFP_PHASE_ID2","OSFP_PHASE_ID3",
+		"","","","",
+		"OSFP_BOARD_ID0","OSFP_BOARD_ID1",
+		"OSFP_BOARD_ID2","PWRGD_P3V3_N1",
+		"PWRGD_P3V3_N2","","","";
+};
+
+&io_expander7 {
+	gpio-line-names =
+		"RST_CX7_0","RST_CX7_1",
+		"CX0_SSD0_PRSNT_L","CX1_SSD1_PRSNT_L",
+		"CX_BOOT_CMPLT_CX0","CX_BOOT_CMPLT_CX1",
+		"CX_TWARN_CX0_L","CX_TWARN_CX1_L",
+		"CX_OVT_SHDN_CX0","CX_OVT_SHDN_CX1",
+		"FNP_L_CX0","FNP_L_CX1",
+		"","MCU_GPIO","MCU_RST_N","MCU_RECOVERY_N";
+};
+
+&io_expander8 {
+	gpio-line-names =
+		"SEC_RST_CX7_0","SEC_RST_CX7_1",
+		"SEC_CX0_SSD0_PRSNT_L","SEC_CX1_SSD1_PRSNT_L",
+		"SEC_CX_BOOT_CMPLT_CX0","SEC_CX_BOOT_CMPLT_CX1",
+		"SEC_CX_TWARN_CX0_L","SEC_CX_TWARN_CX1_L",
+		"SEC_CX_OVT_SHDN_CX0","SEC_CX_OVT_SHDN_CX1",
+		"SEC_FNP_L_CX0","SEC_FNP_L_CX1",
+		"","SEC_MCU_GPIO","SEC_MCU_RST_N","SEC_MCU_RECOVERY_N";
+};
+
+&io_expander9 {
+	gpio-line-names =
+		"wSequence_Latch_State_N","wP12V_N1N2_RUNTIME_FLT_N",
+		"wP12V_FAN_RUNTIME_FLT_N","wP12V_AUX_RUNTIME_FLT_N",
+		"wHost_PERST_SEQPWR_FLT_N","wP12V_N1N2_SEQPWR_FLT_N",
+		"wP12V_FAN_SEQPWR_FLT_N","wP12V_AUX_SEQPWR_FLT_N",
+		"wP12V_RUNTIME_FLT_NIC1_N","wAUX_RUNTIME_FLT_NIC1_N",
+		"wP12V_SEQPWR_FLT_NIC1_N","wAUX_SEQPWR_FLT_NIC1_N",
+		"wP12V_RUNTIME_FLT_NIC0_N","wAUX_RUNTIME_FLT_NIC0_N",
+		"wP12V_SEQPWR_FLT_NIC0_N","wAUX_SEQPWR_FLT_NIC0_N";
+};
+
+&io_expander10 {
+	gpio-line-names =
+		"FM_P12V_NIC1_FLTB_R_N","FM_P3V3_NIC1_FAULT_R_N",
+		"FM_P12V_NIC0_FLTB_R_N","FM_P3V3_NIC0_FAULT_R_N",
+		"P48V_HS2_FAULT_N_PLD","P48V_HS1_FAULT_N_PLD",
+		"P12V_AUX_FAN_OC_PLD_N","P12V_AUX_FAN_FAULT_PLD_N",
+		"","",
+		"","",
+		"","FM_SYS_THROTTLE_N",
+		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
+		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N";
+};
+
+&io_expander11 {
+	gpio-line-names =
+		"P12V_AUX_PSU_SMB_ALERT_R_L","P12V_SCM_SENSE_ALERT_R_N",
+		"P12V_AUX_NIC1_SENSE_ALERT_R_N","P12V_AUX_NIC0_SENSE_ALERT_R_N",
+		"NODEB_PSU_SMB_ALERT_R_L","NODEA_PSU_SMB_ALERT_R_L",
+		"P12V_AUX_FAN_ALERT_PLD_N","P52V_SENSE_ALERT_PLD_N",
+		"PRSNT_RJ45_FIO_N_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
+		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS2_LEAK_Q_N_PLD",
+		"CHASSIS1_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
+		"","SMB_RJ45_FIO_TMP_ALERT";
+};
+
+&io_expander12 {
+	gpio-line-names =
+		"FAN_7_PRESENT_N","FAN_6_PRESENT_N",
+		"FAN_5_PRESENT_N","FAN_4_PRESENT_N",
+		"FAN_3_PRESENT_N","FAN_2_PRESENT_N",
+		"FAN_1_PRESENT_N","FAN_0_PRESENT_N",
+		"HP_LVC3_OCP_V3_2_PRSNT2_PLD_N","HP_LVC3_OCP_V3_1_PRSNT2_PLD_N",
+		"PRSNT_HDDBD_POWER_CABLE_N","PRSNT_OSFP0_POWER_CABLE_N",
+		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS2_LEAK_CABLE_R_N",
+		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
+};
+
+&io_expander13 {
+	gpio-line-names =
+		"rmc_en_dc_pwr_on","",
+		"","",
+		"","",
+		"","",
+		"leak_config_0","leak_config_1",
+		"leak_config_2","leak_config_3",
+		"mfg_led_test_mode_l","small_leak_err_inj",
+		"large_leak_err_inj","";
+};
+
-- 
2.43.0


