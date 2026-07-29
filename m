Return-Path: <linux-aspeed+bounces-4585-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E8C54F52
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 11:43:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Sk2n26z2yjg;
	Wed, 29 Jul 2026 21:43:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325398;
	cv=none; b=E8skLDip6yC8+5utCJr4E1K6qX02lbTl0rjF7dhSl1PI1oDnR6TaUG3imFXUxEbScntJtUPsts6SHWnD3Sucb5M58bdZwTK07yynyUtMBmN5y422SAP9mqUowPdGl/ralRjKVGmTUCdl8Os0l6/71uZyOefU/LGtIyz1jrYbVcuUHz3a++de9DtTWL49lAH517qOId7Do7HDmAQfF5YfzwcxGxva9ZFzzzLsu7BO60pHbWFi3RtHEMNmPEGz9ieqNLi/rAELeLha+SNcNoCJ3lHIz+xB2p/w8mZZrchvBvRsB052iE5ZwcYn6r1VV6BM2tVygP9RKNKFhifGmnWPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325398; c=relaxed/relaxed;
	bh=c/W1fqK7GrdRxdJRx517NJ0wj5HQ/50koQW2iNa5L7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn9gla9DJ29lEg7NbEL59A53W9tjrKVI/h4Hur5TvEp9U3rwdD2ftd8+pMuTDq+cQ9rPTPZ5zZ9fdm98MGev2lPE45wQr8z5k4Nh92tR7j5MOYH3vVLkGJBc1PTQiiqXvP8Vpzp9ZwnO/c/vlo0JLII2kWUdzRoE7a3hqTxaleu+kmHYfbwPYgoQ8v3zxVfMEsoG7l7kqXxkO49f85m5+bweF+oaqEJBgkXArd+6+cEjUAs6CPXxXIetupRA14f1h8uxdLrlZaQUfQMQqiLYyAmEfcOkkn9iDaAtt/RvScQIKMjeomvr+wjwy1moBaRtZQsOovT7zL6uRIiic+TUTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cyeIwXus; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cyeIwXus;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Sj4NWwz2xnp
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 21:43:17 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so897150b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325395; x=1785930195; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/W1fqK7GrdRxdJRx517NJ0wj5HQ/50koQW2iNa5L7Y=;
        b=cyeIwXussj534WycSH5jGBFx8KOCZRLGqMkbHlMcK0WTFkfMORxI5B1ahNWuJjUuZj
         WgzWFU71fUl/5LLrRh1liTuNIJZs8jdbv43Ma/S13WRiiMGSKC4fd7lVKbxEUoatebH0
         yB4eMsncRtaIfqHngFeTqSC9xsywXyRsW3ewqh6eYhUI+q014gDVA9NgPUIUaPANSi2P
         0HfV/CoGq2850x16WILXOCaifHdHjOwwnNaRjVUROnFAEXH3iOzKdJchyO5QK4uMudmO
         ik1fuMuBfcKelKZtiMiMnkuctv6q6GwQn2hsmCEdvA01shocg8opDHeoY/e8LGys/YG+
         P4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325395; x=1785930195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/W1fqK7GrdRxdJRx517NJ0wj5HQ/50koQW2iNa5L7Y=;
        b=U1n/u1ftlWtYIb7CcaCjflWCQ046eAkGQ/sW6MQymldmAxerA/6DcXOwWsQFnZBQdT
         wBE/t0CQ3n9jBgZGqI1X6gWEpmO7k/ZTTeKULElW+7+ySJylWHvxCt/Qymok0/S3/fRo
         6vVHnTpMsYcNbck7xXLOw1DjnOvXXRRNnroKZ9ROWVsQhoG4rQbCh41qBEPhuhw1RUiI
         jT1Za8QinH9L7Is/EP2oBszaa5jAr/bTl08phQXQcXDC6AkHSGSm5uqeSLiT3YpGpB7M
         +Xhu1rTyxFBrR8YTVIwyaxjf29m+wF1sLcTIc0eAA5QM1r0up8jUCWLQ8F8YAvu34HB+
         YiWA==
X-Forwarded-Encrypted: i=1; AHgh+Rofv538gWPhkFdbiFdd5WqCJMrP4j4JnnHp/8qXz0/heNT9kJvJc+NsvCBrg5fE5yhA5BJi+ITo9RO7S4Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymoSHvG/lVomqo2XQFOEGgXNBIFy04KwttBXcYmiSAlNnrppdE
	HqN4TQLKJiwYySGSRdfgg8V5J6eHxK/Qx6XL5PasUF/6wwM20UYaY5Ql
X-Gm-Gg: AR+sD12y/3fH8FwdYCDhxwwyKbI58nWgsrEI2TV7UFy2n9fXk78Hblic1HFZea3vKWR
	IF7iui0mYStXgIc6Tiq8dzzNAfzPhi2PzxIdEenx+ZEuXd3V67rI4G9FU/OPC54OBZHl+eXWqSH
	BIiVAhrr0m51YoED33d1xj1PQWDo2ZLjLSju2PaMcO3SlekKIKYiJJ4Nyc7RJelyT27MoktVxHA
	e3KEPYMJ8rNrGcsk+mCQxOZlfeqvmeB3WUBHXPi3UVE+2Ygctmq57iQylKv0mUzPuOiulDB2u8x
	WwtZEdOt16Q2jOVZaa2reeF4pNMPx6ZEUBg8aJ7QDO77E4KpDbbIkcHLeatkSfZ4w69sUx9fNuI
	Vj1nmJRuL0CMHvsmVxIubADsTK02eABBrSkBnXol6AAyep4SWXhw+J/ofEOZjZzKYslXtBNlK5z
	I2k4J7tTeMLCsvHGBDnSdV5eKaBCuF3aombf9GccpsVOkGUuE9wNddwmWhi4mAXkdockBvlaL25
	YriZhZQS+xl/rjydKwQ+jTnC5iWGH+Y6fQ=
X-Received: by 2002:a05:6a00:298b:b0:848:3f91:da82 with SMTP id d2e1a72fcca58-84e93258a6bmr6621278b3a.32.1785325395379;
        Wed, 29 Jul 2026 04:43:15 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03cbd1csm1263532b3a.53.2026.07.29.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:43:15 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 3/4] ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
Date: Wed, 29 Jul 2026 19:43:11 +0800
Message-ID: <20260729114312.3947300-4-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729114312.3947300-1-chou.cosmo@gmail.com>
References: <20260729114312.3947300-1-chou.cosmo@gmail.com>
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

Add alternative PCA9532 LED controllers at address 0x66 to support boards
populated with the PCA9532 instead of the primary PCA9552 at 0x67.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 422 ++++++++++++++++++
 1 file changed, 422 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index e1fa3a18ea5c..3da1cf9bbb99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/i2c/i2c.h>
 
@@ -86,6 +87,66 @@ led-7 {
 		};
 	};
 
+	fan_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 8 GPIO_ACTIVE_HIGH>;
+			label = "fan0_blue";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 9 GPIO_ACTIVE_HIGH>;
+			label = "fan1_blue";
+			retain-state-shutdown;
+		};
+
+		led-2 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 10 GPIO_ACTIVE_HIGH>;
+			label = "fan2_blue";
+			retain-state-shutdown;
+		};
+
+		led-3 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 11 GPIO_ACTIVE_HIGH>;
+			label = "fan3_blue";
+			retain-state-shutdown;
+		};
+
+		led-4 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 12 GPIO_ACTIVE_HIGH>;
+			label = "fan0_amber";
+			retain-state-shutdown;
+		};
+
+		led-5 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 13 GPIO_ACTIVE_HIGH>;
+			label = "fan1_amber";
+			retain-state-shutdown;
+		};
+
+		led-6 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 14 GPIO_ACTIVE_HIGH>;
+			label = "fan2_amber";
+			retain-state-shutdown;
+		};
+
+		led-7 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 15 GPIO_ACTIVE_HIGH>;
+			label = "fan3_amber";
+			retain-state-shutdown;
+		};
+	};
+
 	front_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -162,6 +223,24 @@ led-1 {
 		};
 	};
 
+	sled1_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled1_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled1_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled2_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -180,6 +259,24 @@ led-1 {
 		};
 	};
 
+	sled2_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled2_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled2_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled3_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -198,6 +295,24 @@ led-1 {
 		};
 	};
 
+	sled3_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled3_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled3_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled4_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -216,6 +331,24 @@ led-1 {
 		};
 	};
 
+	sled4_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled4_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled4_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled5_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -234,6 +367,24 @@ led-1 {
 		};
 	};
 
+	sled5_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled5_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled5_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled6_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -252,6 +403,24 @@ led-1 {
 		};
 	};
 
+	sled6_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled6_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled6_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
@@ -430,6 +599,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled1_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled1_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -520,6 +718,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled2_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled2_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -610,6 +837,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled3_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled3_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -700,6 +956,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled4_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled4_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -790,6 +1075,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled5_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled5_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -880,6 +1194,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled6_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled6_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -993,6 +1336,85 @@ tmp421@4d {
 		reg = <0x4d>;
 	};
 
+	fan_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"presence-fan0","presence-fan1",
+		"presence-fan2","presence-fan3",
+		"power-fan0-good","power-fan1-good",
+		"power-fan2-good","power-fan3-good",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-4 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-5 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-6 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-7 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-8 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-9 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-10 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-11 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-12 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-13 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-14 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-15 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	fan_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
-- 
2.43.0


