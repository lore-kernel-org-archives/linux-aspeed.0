Return-Path: <linux-aspeed+bounces-4584-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963AC53200
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 11:43:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Sh1gHnz2ygW;
	Wed, 29 Jul 2026 21:43:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325396;
	cv=none; b=HmyE81/IoaKhsLqc/jIYUUNOgr8Oc88FF/VpZEeo/exljgbAoUNVfHfiNPJIueO9pnkaXckQgQIH/3wYWO3MjxjL1tjCKZULSnax2hgf3mrPZb6LdF5YZbxi7DVJdfXU1CImR1kN7LfIxOAUD5rTts7+ijOEZ/IoWtUCGHjSbeDYiC8erLa5N4NbxYsDgZJid0LYggnqVZ06dvR0Xd1P6e7uuEr65RcMs6aWotwUNnkll2YRCWqoHGWE2AJ7IwBC13VT8lYLp4RFueItCdCG9Db/ZTGoCW5saaw0HDo0tkMD6VIR2AOfXPUgNmWhWMU/W0SYlobSGbD4EKCv8uIVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325396; c=relaxed/relaxed;
	bh=gvCS92adBOMqcSwKtopSqRFpX+KFLdA+oInUug96Q/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8252yAnNP2FNGEcwKeHLKBXZxryzdktvkSMWtwWvsP/0kLbMtHHej2EeW9ZESVxruKiMRi7WoWhB0YCsXam1dCrimUnOfjZ9kYsMR1cs/O6lp0Wj9jAam57Ca2RBE+1YmZBVRrKJi0uPXwXL48yKQ1/oAI93Xl18pp/Ah+GCWD4Lo3V94DhWPvMYDfITTKfMnmhaJ2PfahWYDcfn1ZgmXxX4PrGsnwmEgl6AvGjClLK0YHLrfku9/qu5G+pIjcrYCyxYHHliCL7u/72aCi/56Oo4U2F1SQ9cBd3w2CKIf171WM7ICPVnh56ArJMD8GM8jSeuEB3esQCoxr1aEXmSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GavCCHPs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GavCCHPs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Sf51Klz2xnp
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 21:43:14 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-848593533cbso438934b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325393; x=1785930193; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvCS92adBOMqcSwKtopSqRFpX+KFLdA+oInUug96Q/4=;
        b=GavCCHPsu1pqmva2H6kRvSjLP4Mnwh8YN3a98l+tTXviCaadL+Fgk3ZQZ94hg2HM/O
         5EH8lqgC00NyUoV2k9qoWRlclUFjwFLWxm0E/EDf4D19CbReKY8b2HNTTvGuaHaJ+F8n
         jDDF74xZMOTwczH1v2U2+EI3xmKQXdgR6mJh4iHOXFiA7WckDNB499ha26AfCLxPQu1I
         XRGP30RMNwvoKgXHx1qk1cLofMXfgvqRU+9menBZ3vn57291YU0WvfAVBi/YVQUjE8O3
         D81s27zEbDjc3o+TQHmNQPcPCz7tJdCkriLKRzfoJioCifvMbE/rNg1KB10Vw9q0A/H9
         DunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325393; x=1785930193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvCS92adBOMqcSwKtopSqRFpX+KFLdA+oInUug96Q/4=;
        b=GMpU+D0b+XR2mvP6MPxUCp9E+WJohNlTTRGXwnv3d+8+nhT7sWz5hQ4oDN8HQ66fbt
         8dCEL5HhseMrJ+VpNCmrfFYxYKVsopPOVAnuTBYRyqa5zKspnoW3ar93LJG8Xkv9WUtL
         MYm4OQJmPHaXEgujnnggAQ6i1oID2nYfm8LfeHJFhulWENoiKBGlqBp4EbZ8wkwVcR2c
         o8mxQp7nsBs7XOUbvDAMR9P4MC8TmJDo+Ld/QEkYBSBlzy8mbITJkFEWvU1guFEw6gJQ
         0YocoulJRmsacwFgFqY+jvQy9kNyx4U+gmMIb9XbRlOjQeRf7uOgG0IqSTcrKfJkI8ti
         O49g==
X-Forwarded-Encrypted: i=1; AHgh+RpGEIUB/ZhASZGlyot6NFONyAze0L5b/pHitIg/8NbkCXHVhHmP/C0seuR39ktgUNp7TvezW6WRCCeC7tc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyg6/J/1trTLbOcYmyR7I5cdtX1e0UwRVzNRWGtp/dXSt5vTj89
	G1mqmNBVb0QzW3OVvFawEYcpcwBH7ogb8v566qQ5pR1G2/Zxp6oLeCMJ
X-Gm-Gg: AR+sD13QhJfdlWo/7vi4Vl3K0TyzqHyfFkCGQOMzhIvqKDt9vLkYFuWOUM1qG4lyDhc
	wZNa0kmxVGcvi+gb+gSYdj7vi426Uryb4h8ozEC7f8kB4Cdy52KALKnkoSSQe622UdpKDRxINa9
	KAAppBlMavsezWKBrwN+izJzn8Dvnw0aZgNKHjnbK/dazZFr6k00m4ZuCIjsKcKdlj9UK0XmW3V
	bNbz6pY31518pbgVW9som7e4x/KLxyJFpfVkBeI6Myyask4MxldEqLFFX/EIlSC6B2Mu2hcYS4Q
	MTP8AzF8/fr5l0uHx3aMmcqyXTZxU2mlEIb+r4onFnO+0oLQOzaqiiAHeQUYqxGaV/ZBucwnfW8
	Xse70xhf6fM/RWU7bS2jKuJyJsdfrHsvrRR7iRDZlISxXpQ6uAEUNp3EsWv8aVX3b/evpGGB4+l
	zv3+U6fTqqRVPANOKPWMEN0b8xiBohQFu9Xccr3xyqp67ZqZd4nRRJWQaxHvT2aP2O6N0FupUQQ
	bri5GGecGUbbilW8TizMeHsY2bM/l5Tub7QAX+T7wNojZg=
X-Received: by 2002:a05:6a00:9a3:b0:842:5b63:6112 with SMTP id d2e1a72fcca58-84e93252b23mr6496795b3a.32.1785325392498;
        Wed, 29 Jul 2026 04:43:12 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03cbd1csm1263532b3a.53.2026.07.29.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:43:12 -0700 (PDT)
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
Subject: [PATCH v2 2/4] ARM: dts: aspeed: bletchley: Fix style warnings
Date: Wed, 29 Jul 2026 19:43:10 +0800
Message-ID: <20260729114312.3947300-3-chou.cosmo@gmail.com>
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

Refactor the device tree to resolve all strict mode warnings reported
by scripts/dtc/dt-check-style.

Changes include:
- Sorting properties into their canonical order.
- Reordering child nodes alphabetically.
- Aligning multi-line continuation strings.
- Inserting required blank lines before child nodes and status
  properties.
- Removing unused node labels to resolve unused-labels warnings.
- Wrap lines exceeding 80 columns.

No functional changes.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 540 ++++++++++--------
 1 file changed, 298 insertions(+), 242 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index b022bdd02c1e..e1fa3a18ea5c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -10,8 +10,8 @@
 #include <dt-bindings/i2c/i2c.h>
 
 / {
-	model = "Facebook Bletchley BMC";
 	compatible = "facebook,bletchley-bmc", "aspeed,ast2600";
+	model = "Facebook Bletchley BMC";
 
 	aliases {
 		serial4 = &uart5;
@@ -22,329 +22,361 @@ chosen {
 	};
 
 	memory@80000000 {
-		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
-	};
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
-			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-			<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
-			<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
-	};
-
-	spi1_gpio: spi {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
-		num-chipselects = <1>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
-
-	front_gpio_leds {
-		compatible = "gpio-leds";
-		led-0 {
-			label = "sys_log_id";
-			default-state = "off";
-			gpios = <&front_leds 0 GPIO_ACTIVE_LOW>;
-		};
+		device_type = "memory";
 	};
 
 	fan_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "fan0_blue";
-			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 8 GPIO_ACTIVE_HIGH>;
+			label = "fan0_blue";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "fan1_blue";
-			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 9 GPIO_ACTIVE_HIGH>;
+			label = "fan1_blue";
+			retain-state-shutdown;
 		};
+
 		led-2 {
-			label = "fan2_blue";
-			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 10 GPIO_ACTIVE_HIGH>;
+			label = "fan2_blue";
+			retain-state-shutdown;
 		};
+
 		led-3 {
-			label = "fan3_blue";
-			retain-state-shutdown;
 			default-state = "on";
 			gpios = <&fan_leds 11 GPIO_ACTIVE_HIGH>;
+			label = "fan3_blue";
+			retain-state-shutdown;
 		};
+
 		led-4 {
-			label = "fan0_amber";
-			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 12 GPIO_ACTIVE_HIGH>;
+			label = "fan0_amber";
+			retain-state-shutdown;
 		};
+
 		led-5 {
-			label = "fan1_amber";
-			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 13 GPIO_ACTIVE_HIGH>;
+			label = "fan1_amber";
+			retain-state-shutdown;
 		};
+
 		led-6 {
-			label = "fan2_amber";
-			retain-state-shutdown;
 			default-state = "off";
 			gpios = <&fan_leds 14 GPIO_ACTIVE_HIGH>;
+			label = "fan2_amber";
+			retain-state-shutdown;
 		};
+
 		led-7 {
+			default-state = "off";
+			gpios = <&fan_leds 15 GPIO_ACTIVE_HIGH>;
 			label = "fan3_amber";
 			retain-state-shutdown;
+		};
+	};
+
+	front_gpio_leds {
+		compatible = "gpio-leds";
+
+		led-0 {
 			default-state = "off";
-			gpios = <&fan_leds 15 GPIO_ACTIVE_HIGH>;
+			gpios = <&front_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sys_log_id";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		presence-sled1-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+			label = "presence-sled1";
+			linux,code = <ASPEED_GPIO(H, 2)>;
+		};
+
+		presence-sled2-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+			label = "presence-sled2";
+			linux,code = <ASPEED_GPIO(H, 3)>;
+		};
+
+		presence-sled3-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			label = "presence-sled3";
+			linux,code = <ASPEED_GPIO(H, 4)>;
+		};
+
+		presence-sled4-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
+			label = "presence-sled4";
+			linux,code = <ASPEED_GPIO(H, 5)>;
+		};
+
+		presence-sled5-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			label = "presence-sled5";
+			linux,code = <ASPEED_GPIO(H, 6)>;
+		};
+
+		presence-sled6-switch {
+			gpios = <&gpio0 ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+			label = "presence-sled6";
+			linux,code = <ASPEED_GPIO(H, 7)>;
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
 	sled1_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled1_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled1_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled1_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled1_blue";
+			retain-state-shutdown;
 		};
 	};
 
 	sled2_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled2_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled2_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled2_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled2_blue";
+			retain-state-shutdown;
 		};
 	};
 
 	sled3_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled3_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled3_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled3_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled3_blue";
+			retain-state-shutdown;
 		};
 	};
 
 	sled4_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled4_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled4_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled4_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled4_blue";
+			retain-state-shutdown;
 		};
 	};
 
 	sled5_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled5_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled5_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled5_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled5_blue";
+			retain-state-shutdown;
 		};
 	};
 
 	sled6_gpio_leds {
 		compatible = "gpio-leds";
+
 		led-0 {
-			label = "sled6_amber";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled6_leds 0 GPIO_ACTIVE_LOW>;
+			label = "sled6_amber";
+			retain-state-shutdown;
 		};
+
 		led-1 {
-			label = "sled6_blue";
-			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
+			label = "sled6_blue";
+			retain-state-shutdown;
 		};
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		#size-cells = <0>;
 
-		presence-sled1-switch {
-			label = "presence-sled1";
-			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 2)>;
-		};
-		presence-sled2-switch {
-			label = "presence-sled2";
-			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 3)>;
-		};
-		presence-sled3-switch {
-			label = "presence-sled3";
-			gpios = <&gpio0 ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 4)>;
-		};
-		presence-sled4-switch {
-			label = "presence-sled4";
-			gpios = <&gpio0 ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 5)>;
-		};
-		presence-sled5-switch {
-			label = "presence-sled5";
-			gpios = <&gpio0 ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 6)>;
-		};
-		presence-sled6-switch {
-			label = "presence-sled6";
-			gpios = <&gpio0 ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
-			linux,code = <ASPEED_GPIO(H, 7)>;
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			reg = <0>;
+			spi-max-frequency = <33000000>;
 		};
 	};
 
 	vbus_sled1: vbus_sled1 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled1";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled1_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled1_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled1";
 	};
 
 	vbus_sled2: vbus_sled2 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled2";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled2_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled2_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled2";
 	};
 
 	vbus_sled3: vbus_sled3 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled3";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled3_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled3_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled3";
 	};
 
 	vbus_sled4: vbus_sled4 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled4";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled4_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled4_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled4";
 	};
 
 	vbus_sled5: vbus_sled5 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled5";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled5_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled5_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled5";
 	};
 
 	vbus_sled6: vbus_sled6 {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus_sled6";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&sled6_ioexp 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		gpio = <&sled6_ioexp 1 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vbus_sled6";
 	};
 };
 
 &mac2 {
-	status = "okay";
 	phy-mode = "rgmii";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
 
 	fixed-link {
-		speed = <1000>;
 		full-duplex;
+		speed = <1000>;
 	};
 };
 
 &fmc {
 	status = "okay";
+
 	flash@0 {
-		status = "okay";
-		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
 #include "openbmc-flash-layout-128.dtsi"
 	};
+
 	flash@1 {
-		status = "okay";
-		m25p,fast-read;
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
 	};
 };
 
 &spi2 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
 
 	flash@0 {
-		status = "okay";
-		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
 	};
 };
 
 &i2c0 {
 	status = "okay";
 
-	sled1_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -354,13 +386,15 @@ sled1_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -369,11 +403,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled1_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED1_SWD_MUX", "SLED1_XRES_SWD_N",
@@ -400,38 +434,39 @@ sled1_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
 		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
 		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
 		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
 &i2c1 {
 	status = "okay";
 
-	sled2_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -441,13 +476,15 @@ sled2_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -456,11 +493,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled2_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED2_SWD_MUX", "SLED2_XRES_SWD_N",
@@ -487,38 +524,39 @@ sled2_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
 		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
 		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
 		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
 &i2c2 {
 	status = "okay";
 
-	sled3_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -528,13 +566,15 @@ sled3_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -543,11 +583,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled3_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED3_SWD_MUX", "SLED3_XRES_SWD_N",
@@ -574,38 +614,39 @@ sled3_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
 		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
 		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
 		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
 &i2c3 {
 	status = "okay";
 
-	sled4_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -615,13 +656,15 @@ sled4_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -630,11 +673,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled4_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED4_SWD_MUX", "SLED4_XRES_SWD_N",
@@ -661,38 +704,39 @@ sled4_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
 		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
 		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
 		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
 &i2c4 {
 	status = "okay";
 
-	sled5_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -702,13 +746,15 @@ sled5_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -717,11 +763,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled5_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED5_SWD_MUX", "SLED5_XRES_SWD_N",
@@ -748,38 +794,39 @@ sled5_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
 		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
 		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
 		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
 &i2c5 {
 	status = "okay";
 
-	sled6_fusb302: typec-portc@22 {
+	typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -789,13 +836,15 @@ sled6_fusb302: typec-portc@22 {
 
 		connector {
 			compatible = "usb-c-connector";
+			data-role = "dual";
 			label = "USB-C";
+			op-sink-microwatt = <10000000>;
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			op-sink-microwatt = <10000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 		};
 	};
 
@@ -804,11 +853,11 @@ mp5023@40 {
 		reg = <0x40>;
 	};
 
-	sled6_ioexp41: pca9536@41 {
+	pca9536@41 {
 		compatible = "nxp,pca9536";
 		reg = <0x41>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED6_SWD_MUX", "SLED6_XRES_SWD_N",
@@ -835,31 +884,32 @@ sled6_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 
 	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		gpio-controller;
 		#gpio-cells = <2>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
 
 		gpio-line-names =
 		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
 		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
 		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
 		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -908,9 +958,8 @@ front_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"led-fault-identify","power-p5v-stby-good",
@@ -918,6 +967,8 @@ front_leds: pca9552@67 {
 		"","","","",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 };
 
@@ -928,8 +979,8 @@ adm1278@11 {
 		compatible = "adi,adm1278";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <300>;
-		adi,volt-curr-sample-average = <128>;
 		adi,power-sample-average = <128>;
+		adi,volt-curr-sample-average = <128>;
 	};
 
 	tmp421@4c {
@@ -946,9 +997,8 @@ fan_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-controller;
 
 		gpio-line-names =
 		"presence-fan0","presence-fan1",
@@ -957,11 +1007,14 @@ fan_leds: pca9552@67 {
 		"power-fan2-good","power-fan3-good",
 		"","","","",
 		"","","","";
+
+		#size-cells = <0>;
 	};
 };
 
 &i2c13 {
 	multi-master;
+
 	status = "okay";
 
 	//USB Debug Connector
@@ -973,9 +1026,6 @@ ipmb13@10 {
 };
 
 &gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpiov2_unbiased_default>;
-
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"FUSB302_SLED1_INT_N","FUSB302_SLED2_INT_N",
@@ -1029,28 +1079,33 @@ &gpio0 {
 			"BSM_FLASH_LATCH_N","FUSB302_SLED5_INT_N",
 			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
+
+	pinctrl-0 = <&pinctrl_gpiov2_unbiased_default>;
+	pinctrl-names = "default";
 };
 
 &adc0 {
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		    &pinctrl_adc2_default &pinctrl_adc3_default
+		    &pinctrl_adc4_default &pinctrl_adc5_default
+		    &pinctrl_adc6_default &pinctrl_adc7_default>;
+	pinctrl-names = "default";
+
 	aspeed,int-vref-microvolt = <2500000>;
-	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-		&pinctrl_adc2_default &pinctrl_adc3_default
-		&pinctrl_adc4_default &pinctrl_adc5_default
-		&pinctrl_adc6_default &pinctrl_adc7_default>;
+	status = "okay";
 };
 
 &adc1 {
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		    &pinctrl_adc10_default &pinctrl_adc11_default
+		    &pinctrl_adc12_default &pinctrl_adc13_default
+		    &pinctrl_adc14_default &pinctrl_adc15_default>;
+	pinctrl-names = "default";
+
 	aspeed,int-vref-microvolt = <2500000>;
-	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
-		&pinctrl_adc10_default &pinctrl_adc11_default
-		&pinctrl_adc12_default &pinctrl_adc13_default
-		&pinctrl_adc14_default &pinctrl_adc15_default>;
+	status = "okay";
 };
 
 &mdio0 {
@@ -1081,12 +1136,13 @@ &emmc {
 
 &pinctrl {
 	pinctrl_gpiov2_unbiased_default: gpiov2 {
-		pins = "AD14";
 		bias-disable;
+		pins = "AD14";
 	};
 };
 
 &wdt1 {
-	status = "okay";
 	aspeed,reset-type = "soc";
+
+	status = "okay";
 };
-- 
2.43.0


