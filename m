Return-Path: <linux-aspeed+bounces-5086-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58306CA5FBA
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 11:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvsxl0ymjz2xmh;
	Wed, 30 Sep 2026 21:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790767147;
	cv=none; b=Q+t5Purf/IVpujcBraj7Pn/0H3aJidebLHHoQuIR3ztVhgFyIUzJZDMQsDi/8Igt89ndcd6MsNb/QeUh0G/rMHi4kEI6ZoBOfaHDdavGJhYY1VczSoVuLONIz9AHWN/8uKcyqjGS76wsQ29DMfX1lCbquTQnILf41L5uUWoH5TH0Tmb173kEWeUMLJdRYORocbbkfFXEtN6bZ26WGuOpTiX9EMS8YlbCH+gIUMZKYZwxrPJleIhjvo/3jSFnbrNHBzAjrNifo7g5IEcFkI0PObONywsX879gTOYBai7KjD/bRvAl8LVnnyn692jXYlvFeNyJ7Bsvzo6oBqQl6r7KAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790767147; c=relaxed/relaxed;
	bh=rCnLVLhWtVLLmpN3x9fjuaEAEUhiKYtsxACEAQQZJ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcoQBC5/VQtaoZyC8gL54rkh5N/vpFVUdP0PGvDIoxf9PXJbiuWY6W6fuROZLwcwCQYTnb5u1lfM7f9WWInJVY20VU2b0TqXjD2Yo4+vgQiqC3bTmxTkG7VRnCo4jsE6H18F85R3CXb07tJW909j6zUvU8n5sSabXP4LzIS21K1iAd4iCDh4zQUtS4BQiFkA12cgLaZS2SQ9JgULZlu14sdNKsG7sCB+dJuEqF+fvMgql6XclSMxR61/A+/oNcnEs3fOkua6pWMmI9jrqkv7BZPqLfn1+YRXpuPcV9Il59BW0RlrYZjE+5Xlao6qyaGwL8ViQekMaVPrM4Ruonjm0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTQ4+2jR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTQ4+2jR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvsxj494Wz2yjN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 21:19:05 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8686f46e4adso3342943b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 04:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767144; x=1791371944; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCnLVLhWtVLLmpN3x9fjuaEAEUhiKYtsxACEAQQZJ0o=;
        b=DTQ4+2jRMKWOzLdsJsXj9htPQmj6Z9mQ15xnV4gDzGPSIfNUZlq46bhNcQ7dEVWAJ5
         0k6Or+jpdu6+Cd5VeRPn+/O9O4IAfqnCtOK9oMn/c061+z0FbaWpbwKyIpzrc8bn+siS
         h5ZBPHV3BQ7BeA6zOKVwUfI8+fQIl2qaJrg8JXC/w/ZkdSlhYOztu8gZZK8WTKU8BULX
         FC7XxOzALe3C2c3GbRVWAL3aiQxqxu7HpFWp2hJGOcTzrB7O03+9hqXyRZca028SbeEs
         odCAh1AXNfLRu1Xp9VaDcvtfD2acbtWKwOTx2J+lEibOrQL/aN4kWGmeRkj+wCx4xJjr
         vbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767144; x=1791371944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rCnLVLhWtVLLmpN3x9fjuaEAEUhiKYtsxACEAQQZJ0o=;
        b=tykMO7K8ClOaG3eC7LFM9fq5Nv8S9alJuKK2cZ93C9HGMkxyQnEnwS4xK3648qpVKN
         j8nfiTQ267gaCSv5Wy5AKFk5FXCBdBhgV8YtUXIF6w1BgbUyFEXGXOpX/8/ktyryAxM1
         4QH9ivYvDDYuqIABPtFZNJVA/mA74i1FQqgeT+4Vl6Y5BmXZ9DQDPWqFT20OyypLX3CU
         BaJ1g/woy1ZZ4hyoCTMYOS3WBLNw3GabwqVPFJhxLwXCpeLx9piK35Zu7V4dCk334RP7
         R5E5kiKs3Aav2ZxAwZyCaCr498Hc0ZAIH7xUkWZoeSojQDT7l5zmNLOxqPLe0OZyDN8W
         d+dA==
X-Forwarded-Encrypted: i=1; AKwUvBx8oTBO6++SPMfORCksTH6jW/PNiGh2W3zwqJDkZBn2iVExAtHx75JTci4iZ/Me3GDzNObr+1f2W/Wak0c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nUEXsxlS+v4CD2Er9fr3Y5RiqllzJNvzbYascrB2MDjkzqD9g4
	9H/iD/dedjrTkI9BuT8fmZGrbVaYSHDaNYVA3r4YlZTBjEL7Wu/O9j/w8Tz8WQ==
X-Gm-Gg: AYBFou3oAaPbPzrYYU1La3ivEFSFXcepyQQy4hbwo/3wxUETpaqFeeza/4RyD7X8ET3
	Mpz7Qxz0/MdL7Lm9cH/ayjA/GsYh8UmT6dXwGUw7eq0TItLBGNVn05vit1OIPi34Oh7ixX1m25d
	+6CyKs5LqT+B3Wd/077hJbFkXY360bzAesplH2GKkwnMMotW0u0frtqMRM/C3Wk9rCNOW4HjGy/
	1RnDoOGfEOAEPRje4nH42WLNOyWobjVoQdwxZZKjEbGYQGwX3a+geOWCoCYvd9ptIGiDbW6lMp9
	RjfePoD72SiYWacE++wjvBsVonMP0MHDVWbCUXTp5OkeMzl5B/k7lJaiX/ZGVHrT8i173VLKvMp
	oVIHrO2ConLhbemp2AqAIn1lIPfznYspd/9tInV+RKab/77jsYkpwSTNbfM+2LM4J2TVj9S0Kgb
	XTIhJUKWqv6v3qIo0u7Tfh/yTlr2sQnIkT38TkQ8RW6aDMDjPdfRWwclRrK8HBWW3GNBRvTGea+
	FeHnYeNZlA16Ou8tRlXQdukbTP/xaH/ENklH30ia738u0gd9GJ5ucw=
X-Received: by 2002:a05:6a00:4390:b0:880:fe7b:bc56 with SMTP id d2e1a72fcca58-8874e53ec84mr760256b3a.50.1790767143558;
        Wed, 30 Sep 2026 04:19:03 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887253992a9sm650257b3a.17.2026.09.30.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:19:03 -0700 (PDT)
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
Subject: [PATCH v3 1/4] ARM: dts: aspeed: bletchley: Sort i2c device nodes by address
Date: Wed, 30 Sep 2026 19:18:10 +0800
Message-ID: <20260930111813.52396-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930111813.52396-1-chou.cosmo@gmail.com>
References: <20260930111813.52396-1-chou.cosmo@gmail.com>
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

Reorder child nodes in i2c0-i2c6 to follow ascending unit address
ordering as required by scripts/dtc/dt-check-style. No functional
changes.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 430 +++++++++---------
 1 file changed, 218 insertions(+), 212 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index d1a04b63df9e..b022bdd02c1e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -343,10 +343,25 @@ flash@0 {
 
 &i2c0 {
 	status = "okay";
-	ina230@45 {
-		compatible = "ti,ina230";
-		reg = <0x45>;
-		shunt-resistor = <2000>;
+
+	sled1_fusb302: typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 0) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled1>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
+		};
 	};
 
 	mp5023@40 {
@@ -354,11 +369,6 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	tmp421@4f {
-		compatible = "ti,tmp421";
-		reg = <0x4f>;
-	};
-
 	sled1_ioexp41: pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
@@ -370,20 +380,20 @@ sled1_ioexp41: pca9536@41 {
 		"SLED1_CLKREQ_N", "SLED1_PCIE_PWR_EN";
 	};
 
-	sled1_ioexp: pca9539@76 {
-		compatible = "nxp,pca9539";
-		reg = <0x76>;
-		gpio-controller;
-		#gpio-cells = <2>;
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
 
-		gpio-line-names =
-		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
-		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
-		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
-		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
 	};
 
 	sled1_leds: pca9552@67 {
@@ -401,13 +411,33 @@ sled1_leds: pca9552@67 {
 		"","","","";
 	};
 
-	sled1_fusb302: typec-portc@22 {
+	sled1_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	sled2_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 0) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled1>;
+		interrupts = <ASPEED_GPIO(B, 1) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled2>;
 
 		connector {
 			compatible = "usb-c-connector";
@@ -421,39 +451,51 @@ connector {
 		};
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
+	mp5023@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	sled2_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED2_SWD_MUX", "SLED2_XRES_SWD_N",
+		"SLED2_CLKREQ_N", "SLED2_PCIE_PWR_EN";
 	};
-};
 
-&i2c1 {
-	status = "okay";
 	ina230@45 {
 		compatible = "ti,ina230";
 		reg = <0x45>;
 		shunt-resistor = <2000>;
 	};
 
-	mp5023@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
-	};
-
 	tmp421@4f {
 		compatible = "ti,tmp421";
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp41: pca9536@41 {
-		compatible = "nxp,pca9536";
-		reg = <0x41>;
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	sled2_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED2_SWD_MUX", "SLED2_XRES_SWD_N",
-		"SLED2_CLKREQ_N", "SLED2_PCIE_PWR_EN";
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
 	};
 
 	sled2_ioexp: pca9539@76 {
@@ -471,29 +513,18 @@ sled2_ioexp: pca9539@76 {
 		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
 		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
 	};
+};
 
-	sled2_leds: pca9552@67 {
-		compatible = "nxp,pca9552";
-		reg = <0x67>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
-		"","","","",
-		"","","","",
-		"","","","";
-	};
+&i2c2 {
+	status = "okay";
 
-	sled2_fusb302: typec-portc@22 {
+	sled3_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 1) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled2>;
+		interrupts = <ASPEED_GPIO(B, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled3>;
 
 		connector {
 			compatible = "usb-c-connector";
@@ -507,39 +538,51 @@ connector {
 		};
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
+	mp5023@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	sled3_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED3_SWD_MUX", "SLED3_XRES_SWD_N",
+		"SLED3_CLKREQ_N", "SLED3_PCIE_PWR_EN";
 	};
-};
 
-&i2c2 {
-	status = "okay";
 	ina230@45 {
 		compatible = "ti,ina230";
 		reg = <0x45>;
 		shunt-resistor = <2000>;
 	};
 
-	mp5023@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
-	};
-
 	tmp421@4f {
 		compatible = "ti,tmp421";
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp41: pca9536@41 {
-		compatible = "nxp,pca9536";
-		reg = <0x41>;
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	sled3_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED3_SWD_MUX", "SLED3_XRES_SWD_N",
-		"SLED3_CLKREQ_N", "SLED3_PCIE_PWR_EN";
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
 	};
 
 	sled3_ioexp: pca9539@76 {
@@ -557,29 +600,18 @@ sled3_ioexp: pca9539@76 {
 		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
 		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
 	};
+};
 
-	sled3_leds: pca9552@67 {
-		compatible = "nxp,pca9552";
-		reg = <0x67>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
-		"","","","",
-		"","","","",
-		"","","","";
-	};
+&i2c3 {
+	status = "okay";
 
-	sled3_fusb302: typec-portc@22 {
+	sled4_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 7) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled3>;
+		interrupts = <ASPEED_GPIO(S, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled4>;
 
 		connector {
 			compatible = "usb-c-connector";
@@ -593,39 +625,51 @@ connector {
 		};
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
+	mp5023@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	sled4_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED4_SWD_MUX", "SLED4_XRES_SWD_N",
+		"SLED4_CLKREQ_N", "SLED4_PCIE_PWR_EN";
 	};
-};
 
-&i2c3 {
-	status = "okay";
 	ina230@45 {
 		compatible = "ti,ina230";
 		reg = <0x45>;
 		shunt-resistor = <2000>;
 	};
 
-	mp5023@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
-	};
-
 	tmp421@4f {
 		compatible = "ti,tmp421";
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp41: pca9536@41 {
-		compatible = "nxp,pca9536";
-		reg = <0x41>;
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	sled4_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED4_SWD_MUX", "SLED4_XRES_SWD_N",
-		"SLED4_CLKREQ_N", "SLED4_PCIE_PWR_EN";
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
 	};
 
 	sled4_ioexp: pca9539@76 {
@@ -643,29 +687,18 @@ sled4_ioexp: pca9539@76 {
 		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
 		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
 	};
+};
 
-	sled4_leds: pca9552@67 {
-		compatible = "nxp,pca9552";
-		reg = <0x67>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
-		"","","","",
-		"","","","",
-		"","","","";
-	};
+&i2c4 {
+	status = "okay";
 
-	sled4_fusb302: typec-portc@22 {
+	sled5_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(S, 7) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled4>;
+		interrupts = <ASPEED_GPIO(Y, 3) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled5>;
 
 		connector {
 			compatible = "usb-c-connector";
@@ -679,39 +712,51 @@ connector {
 		};
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
+	mp5023@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	sled5_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED5_SWD_MUX", "SLED5_XRES_SWD_N",
+		"SLED5_CLKREQ_N", "SLED5_PCIE_PWR_EN";
 	};
-};
 
-&i2c4 {
-	status = "okay";
 	ina230@45 {
 		compatible = "ti,ina230";
 		reg = <0x45>;
 		shunt-resistor = <2000>;
 	};
 
-	mp5023@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
-	};
-
 	tmp421@4f {
 		compatible = "ti,tmp421";
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp41: pca9536@41 {
-		compatible = "nxp,pca9536";
-		reg = <0x41>;
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	sled5_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED5_SWD_MUX", "SLED5_XRES_SWD_N",
-		"SLED5_CLKREQ_N", "SLED5_PCIE_PWR_EN";
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
 	};
 
 	sled5_ioexp: pca9539@76 {
@@ -729,29 +774,18 @@ sled5_ioexp: pca9539@76 {
 		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
 		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
 	};
+};
 
-	sled5_leds: pca9552@67 {
-		compatible = "nxp,pca9552";
-		reg = <0x67>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
-		"","","","",
-		"","","","",
-		"","","","";
-	};
+&i2c5 {
+	status = "okay";
 
-	sled5_fusb302: typec-portc@22 {
+	sled6_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(Y, 3) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled5>;
+		interrupts = <ASPEED_GPIO(I, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled6>;
 
 		connector {
 			compatible = "usb-c-connector";
@@ -765,30 +799,11 @@ connector {
 		};
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
-};
-
-&i2c5 {
-	status = "okay";
-	ina230@45 {
-		compatible = "ti,ina230";
-		reg = <0x45>;
-		shunt-resistor = <2000>;
-	};
-
 	mp5023@40 {
 		compatible = "mps,mp5023";
 		reg = <0x40>;
 	};
 
-	tmp421@4f {
-		compatible = "ti,tmp421";
-		reg = <0x4f>;
-	};
-
 	sled6_ioexp41: pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
@@ -800,20 +815,20 @@ sled6_ioexp41: pca9536@41 {
 		"SLED6_CLKREQ_N", "SLED6_PCIE_PWR_EN";
 	};
 
-	sled6_ioexp: pca9539@76 {
-		compatible = "nxp,pca9539";
-		reg = <0x76>;
-		gpio-controller;
-		#gpio-cells = <2>;
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
 
-		gpio-line-names =
-		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
-		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
-		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
-		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
 	};
 
 	sled6_leds: pca9552@67 {
@@ -831,45 +846,36 @@ sled6_leds: pca9552@67 {
 		"","","","";
 	};
 
-	sled6_fusb302: typec-portc@22 {
-		compatible = "fcs,fusb302";
-		reg = <0x22>;
+	sled6_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		gpio-controller;
+		#gpio-cells = <2>;
 
 		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(I, 7) IRQ_TYPE_LEVEL_LOW>;
-		vbus-supply = <&vbus_sled6>;
-
-		connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
-			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
-		};
-	};
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
+		gpio-line-names =
+		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
+		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
+		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
+		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
 	};
 };
 
 &i2c6 {
 	status = "okay";
 
-	eeprom@56 {
-		compatible = "atmel,24c64";
-		reg = <0x56>;
-	};
-
 	rtc@51 {
 		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
+
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
 };
 
 &i2c7 {
-- 
2.43.0


