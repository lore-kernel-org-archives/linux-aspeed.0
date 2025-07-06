Return-Path: <linux-aspeed+bounces-1650-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD65EC83F0A
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5Q3XqVz2yRD;
	Sun,  6 Jul 2025 14:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775866;
	cv=none; b=bv00w2/uHEM5peaVF3X0+0joCU8+LR0iwWzqYQeNs+etP4CW2wOHD99hW6AYR5tVVrocayMEVEkwb9k5loF+5Hbg0nZup+Svo9F1o3vh8EisOSWurn0CiFNkrPN6Uvvtw4esPKXOgX7d4CgSsHnOu1Q0wJoRf5Oqfixe728yPML/R8QcxejgSKq+jFQm6DDIM7lwsPttNGoH5mieSUT3RSQt236tKr938V/qTwWnCzl8ExK6SIQBoy6xcRk788KLGd7obGMAiINVpOCSioCkwPX1jrvWL0ViJRH0nv9GgEEm+XEcOVLCP6dZA1djAPWiji0fKa+W53DEtOXt2mPTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775866; c=relaxed/relaxed;
	bh=dfn1RaDZ/VoXGBlX+/NPIiA54a4d4cEOfZQVkuaZdk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAEQv1/B9XRb+nbJ6YCnzyzEBdPpQpOs7/xYIDfO6H/9BJ4TVoMLggn1Q7MwjeKkZzWY3pY5t8+gTxVwABkeFg/KUDI/Bi/Zi+g/udU12nkmvf14bdPAIF5IDSjiqOO69c6zy4xKK3vWfli0OnNU028f3qfKNYhFFIB/hhgUrzLkUN9XuNw8xAO5r6T05pGQfCmfSest+uzWmgCyLxHi0ejuQnXTw5dRoPi7A4hqTdfr0k2xdl6MzkxAzrk//d7v1XGFfa9bAwIxtPJe0TuwL/mHL4qB81cx2Ofg6qtT/zX7hsq1HawJgZbmkBcFL/NfT9awFb38TF+q3/qEQ6+0LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cn+cnIXO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cn+cnIXO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5P6WCqz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:25 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-73972a54919so1781532b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775864; x=1752380664; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfn1RaDZ/VoXGBlX+/NPIiA54a4d4cEOfZQVkuaZdk4=;
        b=cn+cnIXO93bZi6lJ+G9phoFWfWzirwXPmIeqwm3KVmTAs23uSMlqBEYSkJlxHZaSfk
         M9wHtTmmQRp7ruAl0OsfPeD3ACjMTeix1HzNPVCwbwuJv3ymPlsQdJLNuEzLwrHH9heK
         3AtT2+xZhzTqAlrZmCs5OwBH1jgCwcJ4JsSsdvgU1ZEpmTMhEVclbGD+mRwcCSiMUQAy
         jPYdZmt3t+KzSXCESNtvMYBH62BT+SjwWz0xzqR9nTRVfIfDRWJJzrjI9xV9T/sft9eh
         tB8uKQt2xXfy0y52ocTlEQYC5oeKcn8NMR0Kx4jcZjZjLBMZNxCWjsBEottW5aVpiIMS
         ZEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775864; x=1752380664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfn1RaDZ/VoXGBlX+/NPIiA54a4d4cEOfZQVkuaZdk4=;
        b=WjesfqJCZ/dV7WKkFL7g4VrvG/mhz+DHZPH/bTXjnJh34ZYbngsv1lrRrop9GahCxf
         UtRWBaa9ir9YPTKAomyDDjhBXnWJLRyKaRyr3nLWoC8Zp6Ju4IVr1uALRGwCssZW3r7L
         wcnMZlloNyQHv2s8tRQWSFyDvHSKsOBSGZuKxnKI8/VBDDF8+U0xC8afMAKUZvxYKlf+
         cS9347M9gwjJy5ngRHHGqvQHdwbA3s7c7TCGrkKM42VOF/WQw+ajpuVUMJ4OnvmFPKu0
         qzX5e38GRAlnlJKCp9nwVWDWRDDOPwgAFjdyQFoLdDpcNOeYTTwVNundSOJIX6MBSxtN
         GZUA==
X-Forwarded-Encrypted: i=1; AJvYcCWrByR0hEuIgTCc5Fuy72iAagGwOUuAqswN57CYzWTEd8FVlu8xQ2X6jLcAOkzV/lGdQdv1BkQzd/+1CbE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6aObCFkcqVPsvQYnb11Taod/SDoGC9jPMYrSvRbgQgk4YmjQ0
	vLkXTXW/a1b74bvRkIFMlcZ5pg/omXt7niZo2gaHEt6QT9MS08OLNZlY
X-Gm-Gg: ASbGncv+JehYPBRKfYWRu+8tc2R8tMxqUeovti4HQNma4aoY61/m5UaRN0i5oalnX6/
	lx4ZxeuAwxcPDIVb918JokD0uI/jiCXl5izhcRbrmu+Ji6eUV8pF6k8lhYZbiptPJKVQauSWg0S
	wBqCnQT/LTCYLBTpKV+hsC5xa/eRbp5DoLSpKlMZgFZIFzormIa+kUKCdmqyQtegBbc7WiLE6KG
	ewNRaXhdXHLG3Te7XHCF34rY+jdb3Bmq84fVMEbs5v460NXCsQhjjh/2K4sc/aFFkhI2f2uo+/n
	iMfxSN4iyTsdw+y6ncMboUb1RY6Vs9qF8OqnKzsMFEfHX56AE+O9fgNY2EQmfoKpVoAAHzq+M4p
	b2BY7/Pet0tY+WRYKTyDr6ucj9dYe3iY5Qgt6XMY=
X-Google-Smtp-Source: AGHT+IFLx/ecv0fzT4aq24Vp/6Qjs2Ymni61ExjnL6k5yrrhyuTQDQe/9YeSrYCfZz3y6aBbWrlwew==
X-Received: by 2002:a05:6a00:1493:b0:742:a02e:dd8d with SMTP id d2e1a72fcca58-74ce8acd787mr10488800b3a.20.1751775863981;
        Sat, 05 Jul 2025 21:24:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:23 -0700 (PDT)
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
Subject: [PATCH v2 9/9] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Sat,  5 Jul 2025 21:23:59 -0700
Message-ID: <20250706042404.138128-10-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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
Changes in v2:
  - Removed mac3 controller.
  - Fixed DTB warnings.

 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 78 +++++++++++++++++++
 2 files changed, 79 insertions(+)
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
index 000000000000..e2e71b1d02c4
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
@@ -0,0 +1,78 @@
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
+&fmc {
+	flash@0 {
+#include "facebook-bmc-flash-layout-128.dtsi"
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
2.47.1


