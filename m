Return-Path: <linux-aspeed+bounces-1855-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0971C87FD1
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75q3DjWz30WS;
	Mon, 28 Jul 2025 15:56:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682207;
	cv=none; b=G9qzHFFcDsvjnzR38+EWYOFxxaTyRpMf9PUTYFR/uLN9zTunK0G3aEzXtjpHVU0FKRhMy5+sjTA5v58ZwPmdY/roP28T/bMGr9D7Sa9jTIfWjzkj9PXYzQIhaSy6zv4uSKRyfYhJATAlQp75BlBUPOTmFCh0fWKNiZ3ySMVy6BsVsxev6STfP+bePf/+m0cknUn0aIvpSa4nKrjbt3O4l8Y0K+/+oU3sB5wnTZrBgfSq0ON+200z56E5IbAuc4Bw0erShWwlHlnKtPYt462pvPIFqpijKWquVLbBUAPLA5hKOHPg6sejC183mkSSiENG1v1a4f3vuFhPIH/B0pxRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682207; c=relaxed/relaxed;
	bh=h+hROFZIJ4zafnbkZoU/ntEvBJYn2g7xzj4eJTsFhmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/sJhJfsSw4KtSnkcco4F+9XeKxpP8y4KC4NHf25iWonh+w0HHitzOe/Zb0vMXj/2ZBA98Go6xPLJhFJIJu07n1ZaniDjVk4439wOhrj/o5/hYJFFMXFNkyCfLQiG0O/D3PcS1eLYvBJxzuKQozVfBGhrz+3NOiBtyG5IOvjbIwuaxrYi9wQ5xR2wuV2EPNyq8fHMuwc/9MLi+R95h3sBcIKlQ1soUEWDkJrQcL/Xds8k5h4N8RE/f5cCfP1iJH9pYTQahnynaChtOxe6h0oA5UletVhNgrFYWFrTxoVwnNVK2x0MlYrsdAJJluF1iDWTgowwhcmBpHLJnuUt9hh9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qwg5HmHi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qwg5HmHi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75p4gGfz30Lt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:46 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so9242455ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682204; x=1754287004; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+hROFZIJ4zafnbkZoU/ntEvBJYn2g7xzj4eJTsFhmI=;
        b=Qwg5HmHiKB94ucHcH+UPpuDRlnrvrqhT3SXaaNDa55pD2xZvxaApApMAUwtErod1Kj
         CwDaDWFn6t7pyaxFKgQPUDeWCfVYLrcbq0Gj+O5LeFpjJPSqz4DALGy5PdTVxkexENv3
         8tVgxFYNSkrgTHbGDSR6rkIN3ZAPA1hx2oCGboYfHsC2ivLm1Ygp1dBmYSNzMEsNPA/s
         3y4xsjmG0p6kn7jtWM/adG9ip0lLlQ4v8FMlvOFFoFlUZfipxJpE35fpNNZms8N2Kk7Q
         oKYJE2dWYb5+IZrYbo337/ssDnOcxAzoCT7lMXG1xtG+HbtIoJtemSl5T2ce+K7hkdKW
         2+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682204; x=1754287004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+hROFZIJ4zafnbkZoU/ntEvBJYn2g7xzj4eJTsFhmI=;
        b=qciMV9P/XLjlaAeWty7ZI0fzN5czswpEtTk+WV5bRVHQpWq7j0zgxoopYnDJ4A0/lG
         vomLxJBVQLN1h5iNu0pY/qMslTAuEqvJ9LR2xxF1apRnd/sTwin6m1heQMQHO+eZfbXC
         GR7UzcJR1T+VoLjdzA8oHPWQHgBhgbSxkQiIhnz6L4uxprkUTvCSqA8+Ynj3TzhGlKUt
         xXu1RL0fqN+Vsw6x4Jfu3r67um7DWWrSbe0j0QdBzQ65/A3gvD9ZYh2sReJdWAAPpb4J
         0hcRDHQM3/4yv4Ya58eVFyij6ePirvPDgGnGkx1YGDcvdATNqRH3q0kuAaI0lEyVqrp8
         R9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvFfh1jx5+U4LhJdxUQRatJ6UUo0GRpwi539kvC0WJZuB7fb7Bmvn/eHJsHsHW7cpyfPRJ21P6ePsnK3Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6gJdHThb0PDeU0uXC1wzpGnRinTdJrpv0wWUCusZIKVli0MQn
	xBqsa8P92qFmXjh8pl8b73YX+dDmGyk14X/TmRBvqJMNzCpNmvapIRZA
X-Gm-Gg: ASbGncumbRxU8YzQJvJv5m+7pGA4mug2vkg7MBIH/UdkGQLmJyp4mvJKbCdQZkS7qnY
	eAXNvMJ1EYJ9UN4ifdFhVaPLfYSAmoufe19d8iwvCiZLd1PjyzW9sL/8rFIAHdDUwesyfyQ8u69
	BtoHWu6qwowGcrlmwlzMTYRuNJB2PPGcUBmYAEPAycMX8om+X5i1n73QIas5sjQ/ldKhMpf4tnk
	0HF5Q7WDQQfXH0x3pEuZmJJ1U3/v14Wcn+IYu+96d3NVE216+xZ1/WPUGR8QIM9ewxqoo1+cA1s
	yV0/rsT2mQuBoe3Umcvqza7Gp4hLwgSLS1gFySy2ca9KK8WMsNHS7sgPeQvhWvO7ftQbS4ih9Bu
	5/Qk980A7pxUUJ2MJHrgX6QRwfsdaBpZC+e58p/4kqu0C4O6zlV6wm4A++58fPlZV30sUdg9BZy
	k=
X-Google-Smtp-Source: AGHT+IESYMV9/aCSq8+ZkMIq1xghfGxILNOdIuRhEeldG3+nYfcr3Y2QDDogE793q0IX8dW9AYzfjA==
X-Received: by 2002:a17:902:c409:b0:234:f4da:7eeb with SMTP id d9443c01a7336-23fb3051350mr152238685ad.7.1753682204352;
        Sun, 27 Jul 2025 22:56:44 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:43 -0700 (PDT)
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
Subject: [PATCH v4 13/13] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Sun, 27 Jul 2025 22:56:15 -0700
Message-ID: <20250728055618.61616-14-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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
Changes in v4:
  - None.
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


