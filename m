Return-Path: <linux-aspeed+bounces-4163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8ECD6E5D
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:52:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVSL13ghyz2ytj;
	Wed, 03 Jun 2026 09:52:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780406712;
	cv=none; b=U3l2AWnytd2W+vM4oIRcrdU8MgLSk0yKOgGjFGvjrRVuOZAgeoFVyjmt9jErW+G6fkWjrHxbt5xPJ1GKDb5jeR7lL04ZVSkxztBILPjb0PJxJt0KHGHRZWSvC4cQ5BO8lLfm3yllibm+buF0kbDZAWiZ0zOouo+/CB2nDGIdJUYbwM/3NTb531UXNFF+BC3rBLqFGHEr2NDZjmKg0AFqodiodVKQL7eARbdrqaYb5mvpiaY0Z2yoVYuOcib9suuPWBTVQeGC563JygWyf5SlOEKFa8Ph6yxWMaKgMlbHeopazR2r/1e1BDyvilEmsAMCsMUnTWXuZiAWEo9F4oyPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780406712; c=relaxed/relaxed;
	bh=jQED88Vy62af70/e/Yo+SKKTpHIWPlP36uYG4ItaDbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjLaxuHvG5L99hQ/5z7o/vuvWMsLTcX0phQw7/SXxyTl/DsP1a0mPfGoe5kvSnMPgxnFh6vCTuBjaEBcZk0yMJqgYHHcC4/J2lLwnp1ZvvMvbOSDCzYT5egVsM35eWfeKdLC5QPa/kAgYFD/JM22yGRPueS9bsM/rMRALTfgLqqMqlaJyyPa5qoYTi6d8nAElzHwZFn5Bam3AgZUhZX6ygqOZ4V+VnPljHiBjwnhsFnVULhEgsRoOysreMwcUhHNwHhyVB2tbs4jBkcOyKSxTJNhAjY/nUYshXL3WviO2E77cipKm5fY1sY2Y8z6b3NlXU33A69Xcpz7OfqeuulepA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=auBI5Yap; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=auBI5Yap;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVBQZ6xjBz2yv0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 23:25:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 37CF044608;
	Tue,  2 Jun 2026 13:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1072BC2BD05;
	Tue,  2 Jun 2026 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780406705;
	bh=oRZu3eePph574LLYQBblinNrMaZQAY/xVnLsaIDWonU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=auBI5YapL5RRPxAszptq9runs2dn6/qEFl+Syjykq3zlU5/H0nkQS2luD1KYCCOK/
	 TA/FiJruchto84fIV7PSQED1nNe0qjVyhQDrTh1PC/QtHf0mQLRyRW39xSnNwB2N4I
	 lzQycfY7Je1Ped7LB9mxotyyTkwMwvyFEzd3POSqKwRad5G/Wr3LzsJoZCXtN8V65n
	 iDHCo7tKqDFD5L75+HZROOL9sC5Bo3g/tz7wIBIp+iOAFSjVlonaYiGOOPZdGY+kuY
	 YN4HhxF+1GlVsLhokr0AeRVCQhkYIZTlB6RqIkK9tA1mxJ1X8YSIxly4eX9fUiziUC
	 bexwePYD/OqQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A5CD6E60;
	Tue,  2 Jun 2026 13:25:05 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 02 Jun 2026 21:25:03 +0800
Subject: [PATCH v3 8/9] ARM: dts: aspeed: anacapa: Enable MCTP and FRU for
 NIC
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-anacapa-devlop-phase-devicetree-v3-8-7c93c5df8d9b@gmail.com>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780406700; l=4631;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=kVrgdeyIILumAIqglDCa0K5zOenzetqMl+AfMwM1Ya4=;
 b=vrx/Pv6lGMAarGPzLbHcM8iiWG3M3J5vKfNJ0+D4MQZWFHQZINR/1+6BAtKn2yCa8ugglxR5B
 dMWPYeQuf6yAu2zzDv2bdnu7d5rigjtSBpDw8z17Olys/2mY07WFakF
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU and reorder the I2C virtual bus
index accroding to the system silkscreen index.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 98 ++++++++++++++++++----
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index 29df10697613..5b6ce3c556fe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -35,22 +35,22 @@ aliases {
 		i2c33 = &i2c8mux0ch1;
 		i2c34 = &i2c8mux0ch2;
 		i2c35 = &i2c8mux0ch3;
-		i2c36 = &i2c10mux0ch0;
-		i2c37 = &i2c10mux0ch1;
-		i2c38 = &i2c10mux0ch2;
-		i2c39 = &i2c10mux0ch3;
-		i2c40 = &i2c10mux0ch4;
-		i2c41 = &i2c10mux0ch5;
-		i2c42 = &i2c10mux0ch6;
-		i2c43 = &i2c10mux0ch7;
-		i2c44 = &i2c11mux0ch0;
-		i2c45 = &i2c11mux0ch1;
-		i2c46 = &i2c11mux0ch2;
-		i2c47 = &i2c11mux0ch3;
-		i2c48 = &i2c11mux0ch4;
-		i2c49 = &i2c11mux0ch5;
-		i2c50 = &i2c11mux0ch6;
-		i2c51 = &i2c11mux0ch7;
+		i2c36 = &i2c11mux0ch5;
+		i2c37 = &i2c11mux0ch6;
+		i2c38 = &i2c11mux0ch7;
+		i2c39 = &i2c11mux0ch0;
+		i2c40 = &i2c11mux0ch1;
+		i2c41 = &i2c11mux0ch2;
+		i2c42 = &i2c11mux0ch3;
+		i2c43 = &i2c11mux0ch4;
+		i2c44 = &i2c10mux0ch1;
+		i2c45 = &i2c10mux0ch2;
+		i2c46 = &i2c10mux0ch3;
+		i2c47 = &i2c10mux0ch4;
+		i2c48 = &i2c10mux0ch5;
+		i2c49 = &i2c10mux0ch6;
+		i2c50 = &i2c10mux0ch7;
+		i2c51 = &i2c10mux0ch0;
 		i2c52 = &i2c13mux0ch0;
 		i2c53 = &i2c13mux0ch1;
 		i2c54 = &i2c13mux0ch2;
@@ -617,13 +617,17 @@ eeprom@56 {
 // R Bridge Board
 &i2c10 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c10mux0ch0: i2c@0 {
 			reg = <0>;
@@ -634,21 +638,45 @@ i2c10mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch5: i2c@5 {
 			reg = <5>;
@@ -694,38 +722,72 @@ i2c10mux0ch7: i2c@7 {
 // L Bridge Board
 &i2c11 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c11mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// FE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch5: i2c@5 {
 			reg = <5>;

-- 
2.34.1



