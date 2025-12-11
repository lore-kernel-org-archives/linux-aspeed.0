Return-Path: <linux-aspeed+bounces-3070-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA530D41C01
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRlXc1KyFz2xNk;
	Thu, 11 Dec 2025 19:06:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765440384;
	cv=none; b=dFZQEZ+RUjSWPel/WomFkSzCnuuKjg9VA1UyCVpUJli/MyhDwFEDDlg8DYu+qA7FVsFFFDLEBQNVrk4bFNuVVypURlbCSxHnWPaTPbcd4+7yDF4FSEMjotWJ3aE4x9O5v6qqS8cqrF8i6mRwUOAriso3SqLPCWe6KaEWDubzcSKlPY+kr+ounM1fBB/ILqiMLJgh90ALJLO2Zeyo22cREeiBXEPLIa4fsnmhDqfCbxlPZpEo5OTC7azFU3q9Ug1v2FtWGYj0hBFtwGD68TI4ahhpWQ/FUTdIr60bftpAeFhmm4tjC8rTIfXXMqZxqV0TcrrVpgW8hKg5LORu3wsn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765440384; c=relaxed/relaxed;
	bh=g3rLCxy8arP6w59VperOyYrrxNsr7wHMVWS7dXHm70Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFBMBHsHMpeB8xjSqEilKw6MIT53sCarIXWEmlfgrjaCwQ4S4O0/5X00nq27e27VViO+3grnsFr6nfL+R8b9auH/iLyaVM6fkrUdeS6WUM2p3+JGRiPE2p2iPTaXERJgDJUxwqR3bcXgdeO8fXTPII5f+Hj6yqdj+LVS3/k/YEfWIzIMUQhM8vYUMPCqsBaCYFN7iuBXiq9wC8vNpnV7+BEz4b1TPFJzEeYtukOJn9kka4g+pvNrGoM+UcQxzg7uqQ7Bj/sbKD7fWzp3ehsKPT3ZKQ9OL6GYsT2X1yXTAddEmJsx5ar9wLrIksqNs+TBeILKVhU4KdNfewSTMNmwZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fdbrFBDq; dkim-atps=neutral; spf=pass (client-ip=209.85.214.182; helo=mail-pl1-f182.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fdbrFBDq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.182; helo=mail-pl1-f182.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRlXZ33lFz2xHP
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 19:06:21 +1100 (AEDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2956d816c10so9017475ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765440318; x=1766045118; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3rLCxy8arP6w59VperOyYrrxNsr7wHMVWS7dXHm70Y=;
        b=fdbrFBDqJz7W0nVbIXI4LuCLye9bJMhtWvHiPmQDbFeBEUbQVTz4p+A4lF/27eiNe2
         YBPbnQfC3VjNkaGghBFcneQ+qRsjEf+jssjlzJsoflLACYAmeuGTqC93YRWsN+BeeSvl
         FlZFvoPwxe3jnItcqLdRqv+4LXQ7ava3n1hTCO9j/6LpuzkmxLlkcCxZzWdoeM0a5kyL
         x7MTfUkJq+dcp7tz95l7GAT6Olt2F54S6TlRwGasqzHAmnfFqWbVVGWgGNxwi9HYdGMO
         KagB2QNcyXODnXvc7DZAJMbWMKUVt1pZpIXvohUbg+DqCGfQhOiDYgG2QW66SSd0uivI
         M0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765440318; x=1766045118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3rLCxy8arP6w59VperOyYrrxNsr7wHMVWS7dXHm70Y=;
        b=iyWASggQhiYQFDBHgNUHgY/E9cfQnbGaOSSvcJzzq2k+wOzIMkHYnLvexRGFZF6U2A
         qskU9Ktka6PqiaLF5+WwEy1ke5qApTtcdll8sZy852Glza8dSWZtRM8UotJyKurMeye7
         fIHTBGrh4LgJ2Qh3StKBEIThNKNU+Itn6RTIbeKDVinQ7KBrqGiKlaoZiuJgt+50t3kJ
         G0SMWeqeSXPaWWHa2MhBPSFIDejgS+ldzvDxec/9xIL+mclM8CWVV78QdutpPFkKy7K8
         mzBYFmLc+jyKyCeteVHTZjIoTdpI8dZz3oHUSpFl1jFto7Wfk/vRSZyHzPbeDe8H5/By
         xAfA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ZJzfFSikKC7rfAZ+lfmuADANQi9jkB+hp5HVNp5Wyff74z7h2DA4NeR3jDLF3cmfkwaM+xBDN20pPpc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwX7Pi4Sg6n97QTCUjA1xmroqvrE3TF9OT7cscJAClJ7MTvKhV5
	X1Hxbi1OcVomB2vZflEKgLzYM/0CNOZTroEnQecVtQBa6XpDz5qdDaPa
X-Gm-Gg: AY/fxX4/Q33AogGjzDiWNNH915LWkoew+10tpywZNd9eQcFBixvXqcuUE8mjJ0V98Dk
	39VFhts4Tn0mNFjP2Be1XfDbpssWNFUWc/841gxmPO6vd+UXZtTbS4aOZUQTLmSqF8BJVh15Noo
	Tr+URQxbRNdOIxGbuPDVntxJn5lAeUK7ewVPdhoVafv0IqQkcnur7XbvgZuePriJeasmW11xZ8n
	sUp67REvpdnNTk47iEL86Pdo5LKsdVJWYun3AH3Opqsog5n+6qN5eVSi1qZcHO7kP9ReV25wIOA
	nxrbNKGQhFVwHbjDif6/n0h4OrNgcXVsLpRGUThvFfK2xCtoFce9f3rVaBN97HiPhDwYP4LnaWb
	kfep880H7ByfTTFiW2Ys1BoY45rqCwx9F9PfRQHNnTaI6YCzR0b8pCNcx2LkogPEXkz6MqTD1B/
	J9joHnxgACZ8NEw818gavhz/37V2zhNfYcrobIOSYkyUwz1ToEEmefCnhiebzXfX+Tzfh4m6Nub
	nFp7PquboKy/UY=
X-Google-Smtp-Source: AGHT+IFSb6qHiNb7jgJvSvyN5nw2vItlbOK8l/VjqDL3ZuhE2uUid0Tlm0CFY+T/pBTkwDJQrCPzZw==
X-Received: by 2002:a17:903:1666:b0:29e:9c82:a925 with SMTP id d9443c01a7336-29ec22ca944mr62447985ad.6.1765440318499;
        Thu, 11 Dec 2025 00:05:18 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b373d6sm16118945ad.13.2025.12.11.00.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:05:18 -0800 (PST)
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
Subject: [PATCH] ARM: dts: aspeed: bletchley: Fix dt-schema warnings
Date: Thu, 11 Dec 2025 16:03:11 +0800
Message-ID: <20251211080311.242771-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Update the device tree to fix dt-schema warnings:
- Use generic node names for SPI, LEDs, and GPIO keys.
- Update SPI GPIO properties to use the "-gpios" suffix.
- Remove unused address/size cells from pca9539 nodes.
- Use 'aspeed,int-vref-microvolt' in ADC nodes.
- Remove unused 'aspeed,hw-timeout-ms' from i2c13.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 100 ++++++++++--------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index abdb1562115a..7c27bf6bb51d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -34,14 +34,14 @@ iio-hwmon {
 			<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
 	};
 
-	spi1_gpio: spi1-gpio {
+	spi1_gpio: spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
@@ -54,7 +54,8 @@ tpm@0 {
 
 	front_gpio_leds {
 		compatible = "gpio-leds";
-		sys_log_id {
+		led-0 {
+			label = "sys_log_id";
 			default-state = "off";
 			gpios = <&front_leds 0 GPIO_ACTIVE_LOW>;
 		};
@@ -62,42 +63,50 @@ sys_log_id {
 
 	fan_gpio_leds {
 		compatible = "gpio-leds";
-		fan0_blue {
+		led-0 {
+			label = "fan0_blue";
 			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 8 GPIO_ACTIVE_HIGH>;
 		};
-		fan1_blue {
+		led-1 {
+			label = "fan1_blue";
 			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 9 GPIO_ACTIVE_HIGH>;
 		};
-		fan2_blue {
+		led-2 {
+			label = "fan2_blue";
 			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 10 GPIO_ACTIVE_HIGH>;
 		};
-		fan3_blue {
+		led-3 {
+			label = "fan3_blue";
 			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 11 GPIO_ACTIVE_HIGH>;
 		};
-		fan0_amber {
+		led-4 {
+			label = "fan0_amber";
 			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 12 GPIO_ACTIVE_HIGH>;
 		};
-		fan1_amber {
+		led-5 {
+			label = "fan1_amber";
 			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 13 GPIO_ACTIVE_HIGH>;
 		};
-		fan2_amber {
+		led-6 {
+			label = "fan2_amber";
 			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 14 GPIO_ACTIVE_HIGH>;
 		};
-		fan3_amber {
+		led-7 {
+			label = "fan3_amber";
 			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 15 GPIO_ACTIVE_HIGH>;
@@ -106,12 +115,14 @@ fan3_amber {
 
 	sled1_gpio_leds {
 		compatible = "gpio-leds";
-		sled1_amber {
+		led-0 {
+			label = "sled1_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled1_blue {
+		led-1 {
+			label = "sled1_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
@@ -120,12 +131,14 @@ sled1_blue {
 
 	sled2_gpio_leds {
 		compatible = "gpio-leds";
-		sled2_amber {
+		led-0 {
+			label = "sled2_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled2_blue {
+		led-1 {
+			label = "sled2_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
@@ -134,12 +147,14 @@ sled2_blue {
 
 	sled3_gpio_leds {
 		compatible = "gpio-leds";
-		sled3_amber {
+		led-0 {
+			label = "sled3_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled3_blue {
+		led-1 {
+			label = "sled3_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
@@ -148,12 +163,14 @@ sled3_blue {
 
 	sled4_gpio_leds {
 		compatible = "gpio-leds";
-		sled4_amber {
+		led-0 {
+			label = "sled4_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled4_blue {
+		led-1 {
+			label = "sled4_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
@@ -162,12 +179,14 @@ sled4_blue {
 
 	sled5_gpio_leds {
 		compatible = "gpio-leds";
-		sled5_amber {
+		led-0 {
+			label = "sled5_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled5_blue {
+		led-1 {
+			label = "sled5_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
@@ -176,12 +195,14 @@ sled5_blue {
 
 	sled6_gpio_leds {
 		compatible = "gpio-leds";
-		sled6_amber {
+		led-0 {
+			label = "sled6_amber";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled6_leds 0 GPIO_ACTIVE_LOW>;
 		};
-		sled6_blue {
+		led-1 {
+			label = "sled6_blue";
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
@@ -191,32 +212,32 @@ sled6_blue {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		presence-sled1 {
+		presence-sled1-switch {
 			label = "presence-sled1";
 			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 2)>;
 		};
-		presence-sled2 {
+		presence-sled2-switch {
 			label = "presence-sled2";
 			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 3)>;
 		};
-		presence-sled3 {
+		presence-sled3-switch {
 			label = "presence-sled3";
 			gpios = <&gpio0 ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 4)>;
 		};
-		presence-sled4 {
+		presence-sled4-switch {
 			label = "presence-sled4";
 			gpios = <&gpio0 ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 5)>;
 		};
-		presence-sled5 {
+		presence-sled5-switch {
 			label = "presence-sled5";
 			gpios = <&gpio0 ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 6)>;
 		};
-		presence-sled6 {
+		presence-sled6-switch {
 			label = "presence-sled6";
 			gpios = <&gpio0 ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 7)>;
@@ -352,8 +373,6 @@ sled1_ioexp41: pca9536@41 {
 	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -441,8 +460,6 @@ sled2_ioexp41: pca9536@41 {
 	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -530,8 +547,6 @@ sled3_ioexp41: pca9536@41 {
 	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -619,8 +634,6 @@ sled4_ioexp41: pca9536@41 {
 	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -708,8 +721,6 @@ sled5_ioexp41: pca9536@41 {
 	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -797,8 +808,6 @@ sled6_ioexp41: pca9536@41 {
 	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -953,7 +962,6 @@ fan_leds: pca9552@67 {
 
 &i2c13 {
 	multi-master;
-	aspeed,hw-timeout-ms = <1000>;
 	status = "okay";
 
 	//USB Debug Connector
@@ -1024,7 +1032,7 @@ &gpio0 {
 };
 
 &adc0 {
-	vref = <1800>;
+	aspeed,int-vref-microvolt = <2500000>;
 	status = "okay";
 
 	pinctrl-names = "default";
@@ -1035,7 +1043,7 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 };
 
 &adc1 {
-	vref = <2500>;
+	aspeed,int-vref-microvolt = <2500000>;
 	status = "okay";
 
 	pinctrl-names = "default";
-- 
2.43.0


