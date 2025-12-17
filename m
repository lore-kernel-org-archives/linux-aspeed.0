Return-Path: <linux-aspeed+bounces-3126-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6F2D6406E
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ563wtcz2ySY;
	Wed, 17 Dec 2025 13:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939402;
	cv=none; b=Cu1vG4CsNzbl1Q2qHPthEhPpj9hmjDz3CPHTOQmV4vaGr4IVvFS9i6zyYvGPzEy5hyqNVRZFjNq7fL/SqH1Xs9+umLbqJzlxnIN4F18mLTR2xJ+YuGq9E8TdvBnPmRUnyMO0hqFcR8IsvofIaZVuhMHIBCjTYrQcj/AVk7f6ivKU58F5Fgx51QLaSNjxi+NH6ndnF9ER2IR15TKiXdX7B/24MjZp/ER1yt6MFfFT9wWK/uef0C9dHwmOb6FAjeMBs+xiGGvkqpwh2Ij+3jOfgDrFC4G+B4OWmRSaiFH1rlej7FHnfGmjlW6Fpl7snrB/vHoVgTpITIZbBrpaFLTV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939402; c=relaxed/relaxed;
	bh=g+r102hR9zDuFntSAOHLz1qhcLIKv7rvOLb1bWkWV94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUFv95NiYzL09f6pAfu7QDcdwXJT2VGgpdDadJtet9dNZ6AhFe1K/esY2V0ylmKP7BdP3U7w02gRAkRlrgYfczK2jEk0EajCbbQNfIcheGDwmXAsbUyym81gm9Twx45pspdhkshX1blbC+pE/dCugU+uj4eWHmav9DMw3dvbFhXuyiBDRWmqIZ4FpninW0Td7QskwaNmeI6Tk/lKWmsur8VsNnGnwd2IW7pDDl9coEr1e8IilXQjFhgFGdNb7+M68p/hjm2zCC91dNgfsnvjFhMapRLY5JLOeEgUDGl7DkAmMVlsrOIjsW2nOEj8jnA6LDC61fPEpdqPXS+FgAb7bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eHn6S2L9; dkim-atps=neutral; spf=pass (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eHn6S2L9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ555JsQz2ySB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:21 +1100 (AEDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4300564b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939340; x=1766544140; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+r102hR9zDuFntSAOHLz1qhcLIKv7rvOLb1bWkWV94=;
        b=eHn6S2L9HOnXQxCwTesCoKSFCd1iVEjQIJY5GF0mQ/8tyPXTHfNYy4U+C4qxaD4KTs
         f2Q4U/772u9ImulvRVok0Jreq0MoUfbzJOPYf+GkksJfRkl1BqXh312tyTNpI0DJYye8
         bwpQbmO9gMlnTUqnO2gDeS8XFsh+K7BinDZJWmAoIWthRbKAcvRM9q/fICv6ieuszSwc
         preidpKB3xBygxqHnVEL11zm0vcRqyWGIykiIqT/JCwAZ770q1RHAb0+B8ZEzFsNV53K
         Ggy5lLUNblBVgGxEL8raupd013/QHXi8dkPfIECK/vo750IgBavFyO7R9lnUTNUrUWW9
         Djmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939340; x=1766544140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g+r102hR9zDuFntSAOHLz1qhcLIKv7rvOLb1bWkWV94=;
        b=wUlaDNZkTwAnijwiRFdyIVeKP/WrXWLWv9d3PvHGKMBSvrQPqQuOI9N0H1eBYoZS65
         xaVOFdLGvJn6DXKf2W0n/bGyRPTuyAmFclgvpwspUE82aOXyBCJWgsD+AmGg0dqdrNWO
         DC0R99Mc2geMYLGxhbRO83VNPLBlbFMosBF+gLEZu0hKaJbpf4kDB34/z8g8uRN8hi5H
         6ne7w5t4pC55ky+jvkrj4nQiQh4sN65Va993SlkbjzF9NBIMd/KdkyzQDyge+Md3zbN1
         +d6DoMmQ5uS09jzJYNNbk69KmxJeJhlPodoWJ/hxxS6u411UMaukg2+tEKLUO4zKtijk
         wKlA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jK2EJu1fMfDm99p7M3bWik/B+AVvF1sNvi5DUeMbespzjBsyevVOtbCcMwXuvWsE9A209S33tzMYAgY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywd2D4G577x4cVj2pj/u5xtBdStS+2LNU7Z02MdeQy+gQly2keJ
	p+GMQ+YAqGqNOUD689O4nHAQI3oNKdwlTxqLwfA5BQtVvVWLz6DGrB0B
X-Gm-Gg: AY/fxX7f8vYa1eyUSccKO0/S4nYC5Sv4VgSU/63XqfaCbpXsHlnDfNSZnPJIcj1ohBl
	6zEsO7pPHs7gry5qX5Tp7TYNGpP2ZzHFnSNPr91H02bHj56REhoEKMXwa8Hkzj3mTfcG2QcClBc
	iqZVsviqke43w0TH0K+pXZZwQhdBXZcYREe80f9kbfBCqw1uMDVuwQhzWuww5V/ivroVRMfbJoL
	Nku6kuSZeTBa/YEiWWY9FRprFc7yyAXVVpVbQfG4VtbbsLISt1BmCPd7CWucy26s9nB1oXzifoy
	bgrwBVT1fk9KYsDv438EyBw7kS9XToY1ckHkiNISjwpTauk+WkH4cp4UgzSMvK2mjM0QJvKVvs2
	9d2IftK7kO+qyoY2X0AwQUB3rG1zgNBLH17ePey6CNK85bHK1NQlnH60vRYYs2EKHZD3ncmGq2D
	WfDg/uJb4XC6UMRWRKDsIzAu5zb5nfkWV9NAoCzn3CQb6W7J4Mk3vbNYs5HSi3sOZI2eSoM4Lnh
	x/O/JOOG8oWtNuCITx5Y8PWgQ==
X-Google-Smtp-Source: AGHT+IGzXtV/pP5X31xR86Zl+foQoI5ZOx0o6hr3iWfkE+akqdst4RveLg7C30cUfY07vcJgFJiDIQ==
X-Received: by 2002:a05:6a00:6c95:b0:7e8:43f5:bd3f with SMTP id d2e1a72fcca58-7f6692aadf6mr15691763b3a.43.1765939339626;
        Tue, 16 Dec 2025 18:42:19 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:19 -0800 (PST)
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
Subject: [PATCH v2 1/5] ARM: dts: aspeed: bletchley: Use generic node names
Date: Wed, 17 Dec 2025 10:39:34 +0800
Message-ID: <20251217023938.445721-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
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

Use generic node names to fix dt-schema warnings:
- spi1_gpio: rename to generic "spi" node name
- LED nodes: rename to led-N and move names to label properties
- GPIO key nodes: add "-switch" suffix to node names

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 77 ++++++++++++-------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index abdb1562115a..9cb01381e482 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -34,7 +34,7 @@ iio-hwmon {
 			<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
 	};
 
-	spi1_gpio: spi1-gpio {
+	spi1_gpio: spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
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
-- 
2.43.0


