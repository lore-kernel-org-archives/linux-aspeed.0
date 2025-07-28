Return-Path: <linux-aspeed+bounces-1850-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08734C87FCF
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75f5Rnqz30WY;
	Mon, 28 Jul 2025 15:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682198;
	cv=none; b=haTiAWYygTitPRG1B/F9gW2wh8EdPOnomdMT+1RZZTVYviTXiLI72RF+AIQWjl5zLa++4YiLMeBQP2ogFbNpvFhGTzzz8FmyaPSc5poYXgbZ1WhgwpW/p6RW8GvIgIyOU+aVWBhHtIjC6fJzDaiK6rtB+37/bzQ09D9RWiEWa1gYS4o/FSfzI5/7SgKBaBRP3+Hh+ye5Bw6DsY8Q3YOhpNNH7jAyzOZLf31K1lP3L98PC1nAzulE0XatNcuRjsVBL62gULld70yGgIcYYfeh7QbsMoKRLO5eqHK4jzzyhPL52QMYv/NhHtsMrDxtrbMC3IeVANoUHf0ff3Ciyf8lpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682198; c=relaxed/relaxed;
	bh=hts95YB/ZjUXh8JubeUkj5tnYbtjKOGgkAFrza9S0yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elj5cnzAyuMFzu+N8YvD2haxJZRtlImiTRgePwZE70gTLJ1967WneW+7mZBOEHeiABjqMZCmnU/pchzfCHdZcmeHVaJcwnUd+0NFTj79+s7Gs2k6oPfqAGIYZXzke7TGcPrnXKFZB9g1DkEvV8KLACprAw6aGbPe5zac2FvtOmtrkcqc65GyhthzY2MWmMJYzsVk63rtTwBELDVuJYHh0iXgb0i/jURS8MbnYskkdtscxieDLxuCTIApmwBJT+or7mjiQuClULS/Oi74xm13RnaKZpeh15YRhTvFnuHwz3agYpZ2b2UMle4TwRmlt8+OZCqy8iOqeiQJQVnBQVnIRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NxVlLqLo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NxVlLqLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75f05Ckz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:38 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2402bbb4bf3so6222385ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682196; x=1754286996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hts95YB/ZjUXh8JubeUkj5tnYbtjKOGgkAFrza9S0yg=;
        b=NxVlLqLoesjxTnAKOdiuKIU/46zXZ1WIukm1x3g7yX/Ylpn+fONnInjo0AggNj6b06
         TR8YLqg3JrGdGnCvRo6z44y+63mYRqz5ZgptkcURgqzGembmVOR4Rvqhse+1zFKf5Wsw
         zEq5WxV00l018Gl9HwQ7WVmWsEElcuBQRDLO1Ws39M3YqycaXrMXBo9cl/g0Dgf1VOjd
         DeCjIM/VgI7bJPiEQ/zr2hdC42GpRsJkm3QJewogxobDV4dmHXVzFCkQxudE3eC9o/3U
         IFky84W4YGtlUPUIUd6oNJ25yZdxPCGuXiq3WzocBvM1oHBpoBBzfkbawQFnv0PMZqd+
         KDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682196; x=1754286996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hts95YB/ZjUXh8JubeUkj5tnYbtjKOGgkAFrza9S0yg=;
        b=RExruvCCaTJokiZkRK5qtzwvt+foCWfLiii4JSvBHJ/dZn5KQAloMmDwOi3Zs84RbY
         VDiWIFSkWSdAWYQ6yFWwntmM+rvCsXtwy5/cuv0ysYYs8TdsZsj9BJQ6ms3914gbNsE9
         WjH98vs5HfEiRcVXvACWQG6W8iVNdszGtocHJ7np1Vcbu40Ss3gz7hwcwStGKbdr0CQx
         kSDAKuJv1l76EeBza/dMCPTsRVggGObJTyoWdX4mpqbsZRu+AxEedBPrEfH0dYS52n0m
         Ua8/bN6E6Rm8Mfug1HnHlmAmRDfKGyCLvO6jfwxzoDpXA8vxcuxETIjZNXSvTy73O0zu
         LeWg==
X-Forwarded-Encrypted: i=1; AJvYcCXWeoRUiA15RrFimae+EqeTcNz9yhPdO6kcz7X78Fynn79336aBqm34kwq3PQrX5MsUsQDNq3wwcVWlPW4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw45FHcGAHRyASo3L7+7lxi+j96ZjIbW2Lb9xvYsIqRXLfLIrvX
	HtzDL0ONmSWXozd+VAjyKx0P9z5jLQGYMUojBto4KsvA6zAjz2i6G8fU
X-Gm-Gg: ASbGncu0WWgh6IDm4gZC/0u19Pw9yTapi/9eW7obE07ikSuwKs8g3DHvtiEX1kfIl6v
	dBBrtuO2PfpCVSeWoWQd9QBZy4qA05R3vRU5w8Wejq8iZS66X3kPfQid+UKQI5aXLV+RcUrTkEq
	pNxU9Ass2H4ZXYkeG8qCjsPTsAao7FclAPJqwD4TiWGYk/D1NccdA9V9JKX60//aJtcPEa9Uug2
	ALmXifBNT0ZJLVapELr5wPKpQUUb+oDSToxuFGqEsXeVvN2Sz/ny/9FG/MQ/iOCAhbiqFYZrouX
	APnORK57cCZoG8xqqvX0VBc/EZyBw+pF7LlGeoFMdYqVSwJzRkPO8bBNkgxJyZK+6ID5kmG0IS/
	IuPwqIG11GwApe1Zd8Am/OIwNfPLG7RW8VwHklGN1jr72283tmpgMN9P1Vq+GJiLCzCGcuMj7mK
	Fn+qyFfEi77Q==
X-Google-Smtp-Source: AGHT+IFP3tnIg6vILNX/jRsWfTC+IcuFHWpZZn8f55XY/hi2+oG+I/rcgv+3s7XDjIJi+OO27u1y4A==
X-Received: by 2002:a17:903:1a45:b0:235:f18f:2924 with SMTP id d9443c01a7336-23fb30caa26mr157779795ad.15.1753682195966;
        Sun, 27 Jul 2025 22:56:35 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:35 -0700 (PDT)
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
Subject: [PATCH v4 08/13] ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
Date: Sun, 27 Jul 2025 22:56:10 -0700
Message-ID: <20250728055618.61616-9-rentao.bupt@gmail.com>
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

Include "wedge400-data64.dts" in wedge400 dts to avoid duplicated code.

Wedge400-data64 and Wedge400 are identical except the BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 .../aspeed/aspeed-bmc-facebook-wedge400.dts   | 366 +-----------------
 1 file changed, 2 insertions(+), 364 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 3e4d30f0884d..ef0cfc51cda4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -1,376 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright (c) 2019 Facebook Inc.
-/dts-v1/;
 
-#include <dt-bindings/gpio/aspeed-gpio.h>
-#include "ast2500-facebook-netbmc-common.dtsi"
+#include "aspeed-bmc-facebook-wedge400-data64.dts"
 
 / {
 	model = "Facebook Wedge 400 BMC";
 	compatible = "facebook,wedge400-bmc", "aspeed,ast2500";
-
-	aliases {
-		/*
-		 * PCA9548 (2-0070) provides 8 channels connecting to
-		 * SCM (System Controller Module).
-		 */
-		i2c16 = &imux16;
-		i2c17 = &imux17;
-		i2c18 = &imux18;
-		i2c19 = &imux19;
-		i2c20 = &imux20;
-		i2c21 = &imux21;
-		i2c22 = &imux22;
-		i2c23 = &imux23;
-
-		/*
-		 * PCA9548 (8-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
-		i2c28 = &imux28;
-		i2c29 = &imux29;
-		i2c30 = &imux30;
-		i2c31 = &imux31;
-
-		/*
-		 * PCA9548 (11-0076) provides 8 channels connecting to
-		 * FCM (Fan Controller Module).
-		 */
-		i2c32 = &imux32;
-		i2c33 = &imux33;
-		i2c34 = &imux34;
-		i2c35 = &imux35;
-		i2c36 = &imux36;
-		i2c37 = &imux37;
-		i2c38 = &imux38;
-		i2c39 = &imux39;
-
-		spi2 = &spi_gpio;
-	};
-
-	chosen {
-		stdout-path = &uart1;
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
-	};
-
-	ast-adc-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
-			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
-	};
-
-	/*
-	 * GPIO-based SPI Master is required to access SPI TPM, because
-	 * full-duplex SPI transactions are not supported by ASPEED SPI
-	 * Controllers.
-	 */
-	spi_gpio: spi {
-		status = "okay";
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
-		num-chipselects = <1>;
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
 };
 
-/*
- * Both firmware flashes are 128MB on Wedge400 BMC.
- */
 &fmc_flash0 {
+	/delete-node/partitions;
 #include "facebook-bmc-flash-layout-128.dtsi"
 };
-
-&fmc_flash1 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		flash1@0 {
-			reg = <0x0 0x8000000>;
-			label = "flash1";
-		};
-	};
-};
-
-&uart2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd2_default
-		     &pinctrl_rxd2_default>;
-};
-
-&uart4 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
-};
-
-/*
- * I2C bus #0 is multi-master environment dedicated for BMC and Bridge IC
- * communication.
- */
-&i2c0 {
-	status = "okay";
-	multi-master;
-	bus-frequency = <1000000>;
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux16: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux17: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux18: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux19: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux20: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux21: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux22: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux23: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-};
-
-&i2c7 {
-	status = "okay";
-};
-
-&i2c8 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux28: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux29: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux30: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux31: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c9 {
-	status = "okay";
-};
-
-&i2c10 {
-	status = "okay";
-};
-
-&i2c11 {
-	status = "okay";
-
-	i2c-mux@76 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x76>;
-		i2c-mux-idle-disconnect;
-
-		imux32: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux33: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux34: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux35: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux36: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux37: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux38: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux39: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c12 {
-	status = "okay";
-};
-
-&i2c13 {
-	status = "okay";
-};
-
-&adc {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
-&sdhci1 {
-	max-frequency = <25000000>;
-	/*
-	 * DMA mode needs to be disabled to avoid conflicts with UHCI
-	 * Controller in AST2500 SoC.
-	 */
-	sdhci-caps-mask = <0x0 0x580000>;
-};
-- 
2.47.3


