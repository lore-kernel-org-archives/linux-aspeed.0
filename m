Return-Path: <linux-aspeed+bounces-3863-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F067105D991
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2JB34Kyz2yd7;
	Wed, 08 Apr 2026 09:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775549882;
	cv=none; b=WCZmLumTeyL1pok1xKryRYF1HgwPIFDKMfL0kYCdKlak3lkGBjZ0SmsMwZQ6wlprOmYt9pBT4YIPFBHwTYp3Xx0COFXf7+NznaURQ76c7HGVgSePNm8bXiojAJLv9Y22k2xGCve6Yta+W5pvRkFyIGpxSiABsv5z1okwlvMup0I4/ayeZQLJtD4jS3x2aecOv1WbxK8CXWpnhT9dqW0MEzj+720m8UZ0iLyKM1S56FRDUmSeRRwpfeZPID6LtOXfjxQo8deWDGAAISadnQ+YpZCjIQJYjOLMH1wXrJjYc9BMgVIqspc9/7YstwhQHIOSykAx9pwr17qI3DJzr9yfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775549882; c=relaxed/relaxed;
	bh=1nNKJBXSs91tcpzoJ5f/BLeAo/JzakUZqetZvRFHBJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHBp5dzt1/S0JPLIajWskST3Q7er0gfH79W160qVHrYcmnG5xwcdXqnXT360H6dLqJgCamtt16ipjxbwCJFseDVexEUBArnl8MpDLYtz9kHxp0YhsqpG39CO89HWF0rbWMsSz+ImYqhP6oSjoijD7QFopq+CqhKHvbHmaeYgyTfzQLr6tNU7m/XPVfpBOR4MDo6SdtTuR3tTW2MUy/0GIWYvK1rxlPrTISA470rq05vk80fgMxd5JPQ3VzOCUL8uo7CRGYm71zLptW0fnDpM6Gh0g+HJ2oqYS1X1eB3q4+iInfzNwbjsXiZQ5rnq5Lb80LK5THggOVd3ugqMlClbtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YJF3kLQj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YJF3kLQj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqfG10Zhfz2yh4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 18:18:00 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3388587a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549879; x=1776154679; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nNKJBXSs91tcpzoJ5f/BLeAo/JzakUZqetZvRFHBJg=;
        b=YJF3kLQj1TXgO5kDufRpkNw28XiqYn+AULNRPeOIq4SrN+a3Oantyf5vk282oFnrIt
         jVh5CkONtUCj/+QJLLTK2PdN7hjb8uy+NbBvN3tWJu8le92hH7iFPrUbRpBOsmevTKd1
         zEh0orAcaK52ttuMcKR1r/PRhssGnQiImKS4pjKwehuv8l6bLSS0EaXdRfZmDDI9OSDa
         H/lxwiuaT//87QFuCOzVkb0oPA0KIV+rRr9Oi/mrvQaxoykZY8mpptQL74iwNGlUE+dD
         sp39AWwj/TkjvDGpK7y+cDbyrNfrQjLEw5NVsqRTsTR2NZXIxa5EHkVSRN0P0yp1Ts4o
         FX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549879; x=1776154679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nNKJBXSs91tcpzoJ5f/BLeAo/JzakUZqetZvRFHBJg=;
        b=awX5y9yP13wCjIPIKJU8zfug3Anau9K8JtnjJAeQMaz2iVtjoWBu37OWBcFTzjgTFL
         7bLbSDQsTXznuu8UNvifFwqgE+Tn85XOh9g7zHuT7YJm1QlVAmlEEu7DWcm1KLV/V89T
         pyLsbjMSmrwP/+MM5fKvynVWFZCKag/wkZQjo9Scr5QtkbWP55NkMgYnjSo2/EoR9G5R
         v2ye3TPwhCeLLzfXipujU9BDELcxbdMsUSN0rmYtreTCNXT68l46FhgcrADEyK0U7MwE
         c7b43yRwN7EQg6XsJY6NSi9dvqnHq7dzsAHqakv35knuLh4g8WkQNfv3U6wL7mhEAhT7
         HMug==
X-Forwarded-Encrypted: i=1; AJvYcCXEfvZW3YYfpladwhJh2GAn/rZ59IGvl89UkDvFD91nVGG18+/7+2NetQOb09qHgMoNZqrtdGV0x4yDP9k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyrml+Of2nu3OG4FjqHcrTeoWkwsDrdWK3efIzreoeI6tc+7e4b
	jDZwm3gHGFUDA8p6AHnos2aRTdFL0v/ylVYjDIkzBrnYzdtRAJOx9TF2
X-Gm-Gg: AeBDietTtQUV8h9OX2W8Li//1wf3Be75V2lbLn9clyJiejKZVw/5qywqDMr+qynjX2/
	TeOOPh3Ysi4h42TaM6wSZbO26R84lke8OzpS07LmWSdPulq3v2ghCjD80Lb18S3Ok9lxaRrvmSj
	9VMa8mgj76UPUEZEF7WIIvYtSMrRvZnuQYAeFAJKkKfHjWmqQelf+3Gg/PLdKCa5kqxhiK6D9iQ
	3CPvbshkNnZGrJCtCwZnCiS/8UQJNol+teJN+R6wRH/bUMkP/DQfRHqBvXI4SKSPlLdXbs9S/UL
	P8BMWqrOo0zLDcGJZ4IxbOR4AlTRq+1urIhrwwHCJUfFlWpBQnnhSOy5Usk3yoUQzzo7EUBrcFp
	19xaCQvZKFfF4lfqJNqPU3lkw81Qv1jLIfwoSlV9ptUPzq0H/vceKKMgdKj/Z/qGzSMv3GT1nPl
	tWAF1E0jecoK/6O6F///mTGRKaGD5X4ZoRztJ0AFwHYz/Wn9d637yjTOpWWntMEDneoR7ih8PHP
	RDn/CeVthH2o43+Sp46Kek=
X-Received: by 2002:a17:90a:e710:b0:35d:9bb3:2a31 with SMTP id 98e67ed59e1d1-35de69a6055mr14398111a91.25.1775549878933;
        Tue, 07 Apr 2026 01:17:58 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de6a2325bsm4592889a91.12.2026.04.07.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:58 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Jason-Hsu@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v13 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
Date: Tue,  7 Apr 2026 16:17:00 +0800
Message-ID: <20260407081700.2658011-3-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407081700.2658011-1-pkleequanta@gmail.com>
References: <20260407081700.2658011-1-pkleequanta@gmail.com>
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

Add Linux device tree related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1636 +++++++++++++++++
 2 files changed, 1637 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b707654..f5ac72d5933c 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-santabarbara.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-ventura.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
 	aspeed-bmc-facebook-wedge400-data64.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
new file mode 100644
index 000000000000..6ce6201f7755
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
@@ -0,0 +1,1636 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2023 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook ventura RMC";
+	compatible = "facebook,ventura-rmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		i2c16 = &i2c3mux0ch3;
+		i2c17 = &i2c3mux0ch4;
+		i2c18 = &i2c3mux0ch5;
+		i2c19 = &i2c3mux0ch6;
+		i2c20 = &i2c3mux0ch0;
+		i2c21 = &i2c3mux0ch1;
+		i2c22 = &i2c3mux0ch2;
+		i2c23 = &i2c3mux0ch7;
+		i2c24 = &i2c0mux0ch0;
+		i2c25 = &i2c0mux0ch1;
+		i2c26 = &i2c0mux0ch2;
+		i2c27 = &i2c0mux0ch3;
+		i2c28 = &i2c0mux0ch4;
+		i2c29 = &i2c0mux0ch5;
+		i2c30 = &i2c0mux0ch6;
+		i2c31 = &i2c0mux0ch7;
+		i2c32 = &i2c1mux0ch0;
+		i2c33 = &i2c1mux0ch1;
+		i2c34 = &i2c1mux0ch2;
+		i2c35 = &i2c1mux0ch3;
+		i2c36 = &i2c1mux0ch4;
+		i2c37 = &i2c1mux0ch5;
+		i2c38 = &i2c1mux0ch6;
+		i2c39 = &i2c1mux0ch7;
+		i2c40 = &i2c2mux0ch0;
+		i2c41 = &i2c2mux0ch1;
+		i2c42 = &i2c2mux0ch2;
+		i2c43 = &i2c2mux0ch3;
+		i2c44 = &i2c2mux0ch4;
+		i2c45 = &i2c2mux0ch5;
+		i2c46 = &i2c2mux0ch6;
+		i2c47 = &i2c2mux0ch7;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			<&adc1 2>;
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
+			default-state = "on";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+
+		led-3 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "compute1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g5_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			label = "compute1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			label = "compute1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			label = "compute2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			label = "compute2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			label = "compute2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-10 {
+			label = "compute3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-11 {
+			label = "compute3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-12 {
+			label = "compute3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-13 {
+			label = "compute4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-14 {
+			label = "compute4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-15 {
+			label = "compute4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-16 {
+			label = "compute5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-17 {
+			label = "compute5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-18 {
+			label = "compute5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-19 {
+			label = "compute6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-20 {
+			label = "compute6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-21 {
+			label = "compute6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-22 {
+			label = "compute7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-23 {
+			label = "compute7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-24 {
+			label = "compute7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-25 {
+			label = "compute8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-26 {
+			label = "compute8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-27 {
+			label = "compute8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-28 {
+			label = "nvs1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-29 {
+			label = "nvs1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-30 {
+			label = "nvs1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-31 {
+			label = "nvs2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-32 {
+			label = "nvs2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-33 {
+			label = "nvs2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-34 {
+			label = "nvs3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-35 {
+			label = "nvs3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-36 {
+			label = "nvs3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-37 {
+			label = "nvs4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-38 {
+			label = "nvs4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-39 {
+			label = "nvs4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-40 {
+			label = "nvs5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-41 {
+			label = "nvs5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-42 {
+			label = "nvs5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-43 {
+			label = "nvs6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-44 {
+			label = "nvs6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-45 {
+			label = "nvs6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-46 {
+			label = "nvs7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-47 {
+			label = "nvs7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-48 {
+			label = "nvs7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-49 {
+			label = "nvs8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-50 {
+			label = "nvs8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-51 {
+			label = "nvs8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-52 {
+			label = "nvs9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-53 {
+			label = "nvs9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-54 {
+			label = "nvs9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-55 {
+			label = "compute9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-56 {
+			label = "compute9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-57 {
+			label = "compute9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-58 {
+			label = "compute10_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-59 {
+			label = "compute10_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-60 {
+			label = "compute10_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-61 {
+			label = "compute11_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-62 {
+			label = "compute11_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-63 {
+			label = "compute11_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-64 {
+			label = "compute12_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-65 {
+			label = "compute12_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-66 {
+			label = "compute12_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-67 {
+			label = "compute13_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-68 {
+			label = "compute13_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-69 {
+			label = "compute13_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-70 {
+			label = "compute14_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-71 {
+			label = "compute14_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-72 {
+			label = "compute14_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-73 {
+			label = "compute15_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-74 {
+			label = "compute15_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-75 {
+			label = "compute15_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-76 {
+			label = "compute16_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-77 {
+			label = "compute16_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-78 {
+			label = "compute16_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-79 {
+			label = "compute17_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-80 {
+			label = "compute17_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-81 {
+			label = "compute17_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-82 {
+			label = "compute18_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-83 {
+			label = "compute18_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-84 {
+			label = "compute18_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-85 {
+			label = "fan0_ledd1_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-86 {
+			label = "fan0_ledd2_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-87 {
+			label = "fan0_ledd1_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-88 {
+			label = "fan0_ledd2_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-89 {
+			label = "fan1_ledd1_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-90 {
+			label = "fan1_ledd2_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-91 {
+			label = "fan1_ledd1_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-92 {
+			label = "fan1_ledd2_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
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
+&ehci1 {
+	status = "okay";
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
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"BATTERY_DETECT","","","BMC_READY","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","USBDBG_IPMI_EN_L",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","FM_MDIO_SW_SEL","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c0mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c0mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c0mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c0mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c0mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c0mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c0mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c0mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c1mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c1mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c1mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c1mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c1mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c1mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c1mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c1mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c2mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c2mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c2mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c2mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c2mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c2mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c2mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c2mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c3mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c3mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c3mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c3mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			fan_leds_g1_gpio: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+				"", "",
+				"", "",
+				"", "",
+				"", "",
+				"FAN0_PRSNT", "FAN1_PRSNT",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+
+			// Fan Board 0 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			fan_leds_g2_gpio: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+				"", "",
+				"", "",
+				"", "",
+				"", "",
+				"FAN2_PRSNT", "FAN3_PRSNT",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+
+			// Fan Board 1 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pwm@20 {
+				compatible = "maxim,max31790";
+				reg = <0x20>;
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
+
+			hwmon: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				//fan 0 IL
+				fan-0 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				//fan 0 OL
+				fan-1 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x0B>;
+				};
+
+				//fan 1 IL
+				fan-2 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0A>;
+				};
+
+				//fan 1 OL
+				fan-3 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0D>;
+				};
+
+				//fan 2 IL
+				fan-4 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x0F>;
+				};
+
+				//fan 2 OL
+				fan-5 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				//fan 3 IL
+				fan-6 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				//fan 3 OL
+				fan-7 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+		};
+
+		i2c3mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			// REAR-IO Board FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	// VR TEMP U399
+	temperature-sensor@4c {
+		compatible = "ti,tmp75";
+		reg = <0x4c>;
+	};
+
+	// VR TEMP U397
+	temperature-sensor@4d {
+		compatible = "ti,tmp75";
+		reg = <0x4d>;
+	};
+
+	// BRICK TEMP U398
+	temperature-sensor@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	// RMC FRU
+	eeprom@54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <100000>;
+	multi-master;
+	i2c-scl-clk-low-timeout-us = <31744>;
+
+	//USB Debug Connector
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	// SCM TEMP SENSOR
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	// SCM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c128";
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
+	gpio@10 {
+		compatible = "nxp,pca9555";
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"IT_STOP_PUMP_SPARE_2", "IT_STOP_PUMP_2",
+		"IT_STOP_PUMP_SPARE", "IT_STOP_PUMP",
+		"", "RPU_2_READY_PLD_R",
+		"RPU_READY_SPARE_PLD_R", "",
+		"wPWRGD_P12V_SCM_R", "wPWRGD_P12V_AUX_R",
+		"wPWRGD_P24V_AUX_R", "wPWRGD_P52V_HSC_PWROK_R",
+		"wSMB_TMC75_TEMP_ALERT_N_R", "wP48V_HSC_ALERT_N",
+		"wP24V_AUX_INA230_ALERT_N_R", "wP24V_SM_INA230_ALERT_N_R";
+	};
+
+	gpio@11 {
+		compatible = "nxp,pca9555";
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "wPWRGD_P24V_SMPWROK",
+		"wPWRGD_P1V05_AUX_R", "wPWRGD_P1V5_AUX_R",
+		"wPWRGD_P3V3_AUX_R", "wPWRGD_P5V_AUX_R",
+		"", "",
+		"", "",
+		"", "",
+		"", "";
+	};
+
+	power-monitor@14 {
+		compatible = "infineon,xdp710";
+		reg = <0x14>;
+	};
+
+	gpio@16 {
+		compatible = "nxp,pca9555";
+		reg = <0x16>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"PWREN_COMPUTE_BLADE2_EN_R", "PWREN_COMPUTE_BLADE1_EN_R",
+		"", "",
+		"", "",
+		"", "",
+		"PWREN_NVS_BLADE2_EN_L_R", "PWREN_NVS_BLADE1_EN_L_R",
+		"PWREN_COMPUTE_BLADE8_EN_R", "PWREN_COMPUTE_BLADE7_EN_R",
+		"PWREN_COMPUTE_BLADE6_EN_R", "PWREN_COMPUTE_BLADE5_EN_R",
+		"PWREN_COMPUTE_BLADE4_EN_R", "PWREN_COMPUTE_BLADE3_EN_R";
+	};
+
+	gpio@17 {
+		compatible = "nxp,pca9555";
+		reg = <0x17>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"PWREN_COMPUTE_BLADE18_EN_R", "PWREN_COMPUTE_BLADE17_EN_R",
+		"PWREN_COMPUTE_BLADE16_EN_R", "PWREN_COMPUTE_BLADE15_EN_R",
+		"PWREN_COMPUTE_BLADE14_EN_R", "PWREN_COMPUTE_BLADE13_EN_R",
+		"PWREN_COMPUTE_BLADE12_EN_R", "PWREN_COMPUTE_BLADE11_EN_R",
+		"PWREN_COMPUTE_BLADE9_EN_R", "PWREN_NVS_BLADE9_EN_L_R",
+		"PWREN_NVS_BLADE8_EN_L_R", "PWREN_NVS_BLADE7_EN_L_R",
+		"PWREN_NVS_BLADE6_EN_L_R", "PWREN_NVS_BLADE5_EN_L_R",
+		"PWREN_NVS_BLADE4_EN_L_R", "PWREN_NVS_BLADE3_EN_L_R";
+	};
+
+	gpio@19 {
+		compatible = "nxp,pca9555";
+		reg = <0x19>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"wIT_GEAR_RPU_2_LINK_PRSNT_SPARE_N_R", "wIT_GEAR_RPU_2_LINK_PRSNT_N_R",
+		"wIT_GEAR_RPU_LINK_PRSNT_SPARE_N_R", "wIT_GEAR_RPU_LINK_PRSNT_N_R",
+		"", "",
+		"", "";
+	};
+
+	gpio@1a {
+		compatible = "nxp,pca9555";
+		reg = <0x1a>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"wPRSNT_LEAK1_SENSOR_R_PLD_N", "wPRSNT_LEAK0_SENSOR_R_PLD_N",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "wPRSNT_LEAK2_SENSOR_R_PLD_N";
+	};
+
+	gpio@1b {
+		compatible = "nxp,pca9555";
+		reg = <0x1b>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "wPRSNT_LEAK4_SENSOR_R_PLD_N",
+		"wPRSNT_LEAK3_SENSOR_R_PLD_N", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "PWREN_COMPUTE_BLADE10_EN_R";
+	};
+
+	power-monitor@44 {
+		compatible = "lltc,ltc4286";
+		reg = <0x44>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+
+	tray_leds_g1_gpio: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g2_gpio: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g3_gpio: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g4_gpio: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g5_gpio: gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g6_gpio: gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// LED Board FRU
+	eeprom@56 {
+		compatible = "atmel,24c128";
+		reg = <0x56>;
+	};
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+
+	/* Connected to Marvell 88E6393X CPU port in unmanaged mode */
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+};
+
+&mdio0 {
+	status = "okay";
+	/* * Intentionally left empty.
+	 * Enabled to allow user-space tools (e.g., mdio)
+	 * to access the unmanaged Marvell switch registers.
+	 */
+};
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+
+	gpio-line-names =
+	/*"input pin","output pin"*/
+	/*A0 - A7*/
+	"power-chassis-good","power-chassis-control",
+	"IOEXP1_INT_N","WATER_VALVE_CLOSED_N",
+	"wPRSNT_RETURN_PLD_R_N","FM_MDIO_SW_SEL_PLD",
+	"wPRSNT_SUPPLY_PLD_R_N","FM_88E6393X_BIN_UPDATE_EN_N",
+	"LEAK3_DETECT","",
+	"LEAK4_DETECT","",
+	"RETURN_CNTL_FB_D_R","",
+	"SUPPLY_CNTL_FB_D_R","",
+	/*B0 - B7*/
+	"IOEXP0_INT_N","",
+	"IOEXP11_INT_N","",
+	"IOEXP10_INT_N","",
+	"IOEXP9_INT_N","",
+	"RPU_2_READY_SPARE_PLD_R","",
+	"IOEXP7_INT_N","",
+	"IOEXP6_INT_N","",
+	"RPU_READY_PLD_R","",
+	/*C0 - C7*/
+	"wAALC_RPU_READY","",
+	"LEAK0_DETECT","",
+	"LEAK1_DETECT","",
+	"LEAK2_DETECT","",
+	"PRSNT_COMPUTE_TRAY1_N","",
+	"PRSNT_COMPUTE_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY3_N","",
+	"PRSNT_COMPUTE_TRAY4_N","",
+	/*D0 - D7*/
+	"PRSNT_COMPUTE_TRAY5_N","",
+	"PRSNT_COMPUTE_TRAY6_N","",
+	"PRSNT_COMPUTE_TRAY7_N","",
+	"PRSNT_COMPUTE_TRAY8_N","",
+	"PRSNT_NVS_TRAY1_N","",
+	"PRSNT_NVS_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY11_N","",
+	"PRSNT_COMPUTE_TRAY12_N","",
+	/*E0 - E7*/
+	"PRSNT_COMPUTE_TRAY13_N","",
+	"PRSNT_COMPUTE_TRAY14_N","",
+	"PRSNT_COMPUTE_TRAY15_N","",
+	"PRSNT_COMPUTE_TRAY16_N","",
+	"PRSNT_COMPUTE_TRAY17_N","",
+	"PRSNT_COMPUTE_TRAY18_N","",
+	"PRSNT_NVS_TRAY3_N","",
+	"PRSNT_NVS_TRAY4_N","",
+	/*F0 - F7*/
+	"PRSNT_NVS_TRAY5_N","",
+	"PRSNT_NVS_TRAY6_N","",
+	"PRSNT_NVS_TRAY7_N","",
+	"PRSNT_NVS_TRAY8_N","",
+	"PRSNT_NVS_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY10_N","",
+	"SMALL_LEAK_COMPUTE_TRAY1_N","",
+	/*G0 - G7*/
+	"SMALL_LEAK_COMPUTE_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY3_N","",
+	"SMALL_LEAK_COMPUTE_TRAY4_N","",
+	"SMALL_LEAK_COMPUTE_TRAY5_N","",
+	"SMALL_LEAK_COMPUTE_TRAY6_N","",
+	"SMALL_LEAK_COMPUTE_TRAY7_N","",
+	"SMALL_LEAK_COMPUTE_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY1_N","",
+	/*H0 - H7*/
+	"SMALL_LEAK_NVS_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY11_N","",
+	"SMALL_LEAK_COMPUTE_TRAY12_N","",
+	"SMALL_LEAK_COMPUTE_TRAY13_N","",
+	"SMALL_LEAK_COMPUTE_TRAY14_N","",
+	"SMALL_LEAK_COMPUTE_TRAY15_N","",
+	"SMALL_LEAK_COMPUTE_TRAY16_N","",
+	"SMALL_LEAK_COMPUTE_TRAY17_N","",
+	/*I0 - I7*/
+	"SMALL_LEAK_COMPUTE_TRAY18_N","",
+	"SMALL_LEAK_NVS_TRAY3_N","",
+	"SMALL_LEAK_NVS_TRAY4_N","",
+	"SMALL_LEAK_NVS_TRAY5_N","",
+	"SMALL_LEAK_NVS_TRAY6_N","",
+	"SMALL_LEAK_NVS_TRAY7_N","",
+	"SMALL_LEAK_NVS_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY9_N","",
+	/*J0 - J7*/
+	"SMALL_LEAK_COMPUTE_TRAY9_N","",
+	"SMALL_LEAK_COMPUTE_TRAY10_N","",
+	"PWRGD_COMPUTE_TRAY1_N","",
+	"PWRGD_COMPUTE_TRAY2_N","",
+	"PWRGD_COMPUTE_TRAY3_N","",
+	"PWRGD_COMPUTE_TRAY4_N","",
+	"PWRGD_COMPUTE_TRAY5_N","",
+	"PWRGD_COMPUTE_TRAY6_N","",
+	/*K0 - K7*/
+	"PWRGD_COMPUTE_TRAY7_N","",
+	"PWRGD_COMPUTE_TRAY8_N","",
+	"PWRGD_NVS_TRAY1_PWROK_N","",
+	"PWRGD_NVS_TRAY2_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY11_N","",
+	"PWRGD_COMPUTE_TRAY12_N","",
+	"PWRGD_COMPUTE_TRAY13_N","",
+	"PWRGD_COMPUTE_TRAY14_N","",
+	/*L0 - L7*/
+	"PWRGD_COMPUTE_TRAY15_N","",
+	"PWRGD_COMPUTE_TRAY16_N","",
+	"PWRGD_COMPUTE_TRAY17_N","",
+	"PWRGD_COMPUTE_TRAY18_N","",
+	"PWRGD_NVS_TRAY3_PWROK_N","",
+	"PWRGD_NVS_TRAY4_PWROK_N","",
+	"PWRGD_NVS_TRAY5_PWROK_N","",
+	"PWRGD_NVS_TRAY6_PWROK_N","",
+	/*M0 - M7*/
+	"PWRGD_NVS_TRAY7_PWROK_N","",
+	"PWRGD_NVS_TRAY8_PWROK_N","",
+	"PWRGD_NVS_TRAY9_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY9_N","",
+	"PWRGD_COMPUTE_TRAY10_N","",
+	"LEAK_DETECT_COMPUTE_TRAY1_N","",
+	"LEAK_DETECT_COMPUTE_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY3_N","",
+	/*N0 - N7*/
+	"LEAK_DETECT_COMPUTE_TRAY4_N","",
+	"LEAK_DETECT_COMPUTE_TRAY5_N","",
+	"LEAK_DETECT_COMPUTE_TRAY6_N","",
+	"LEAK_DETECT_COMPUTE_TRAY7_N","",
+	"LEAK_DETECT_COMPUTE_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY1_N","",
+	"LEAK_DETECT_NVS_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY11_N","",
+	/*O0 - O7*/
+	"LEAK_DETECT_COMPUTE_TRAY12_N","",
+	"LEAK_DETECT_COMPUTE_TRAY13_N","",
+	"LEAK_DETECT_COMPUTE_TRAY14_N","",
+	"LEAK_DETECT_COMPUTE_TRAY15_N","",
+	"LEAK_DETECT_COMPUTE_TRAY16_N","",
+	"LEAK_DETECT_COMPUTE_TRAY17_N","",
+	"LEAK_DETECT_COMPUTE_TRAY18_N","",
+	"LEAK_DETECT_NVS_TRAY3_N","",
+	/*P0 - P7*/
+	"LEAK_DETECT_NVS_TRAY4_N","",
+	"LEAK_DETECT_NVS_TRAY5_N","",
+	"LEAK_DETECT_NVS_TRAY6_N","",
+	"LEAK_DETECT_NVS_TRAY7_N","",
+	"LEAK_DETECT_NVS_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY10_N","";
+};
+
+&uhci {
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
-- 
2.43.0


