Return-Path: <linux-aspeed+bounces-1983-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97683CA0ED1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 23:09:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3d8b0mHnz3ckP;
	Sat, 16 Aug 2025 09:09:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755299343;
	cv=none; b=OmccCWArctV9QPnf3D+p2NJhYC7YpVYboWUeS9xBbbpX+Ml8qSE915/GroUXKlGF580awIsxb9GsrRa/t9nW63xx1luJmZS7bwFa3jdPC0ajPmkmXaBGYay52v2N2kmFxzqLydSXQNCMLIEZBJurSOq722EI0zAB+3GN7ZaO11+XKKcqh6nWnTJ8q7vNRvWkLXQ1LrucYLxXJRGWDQd2NTatBs87A7FMUgTWE3txgwdn2JzIOz3ulV8VUN9ah4mva7bN1yXBpmqKEHUGKBS0HQdp2zi6RElJg0pb4yzofLE3SW0gFeWmP2164OK3Tlds6mjRVkJe7QIo5MfJuAMxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755299343; c=relaxed/relaxed;
	bh=9LqQdg9cwv1Tg513oOuRFKMGs0wqbpyblutdYH31Dco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEBKuBOV52nzLNlfVviz5ZSQXKiWf1XVmbYVftLstV4jWFgkVg2TkTaUkkLhkNSDDQyDMWzwUk6bWcxXN8syq8NLlXU5G3gquWN375IGBHIPZqwTvZam+9fYbRUJfd4ppNd6ApKNChfRZE2+CVRMSiX6X+0UJ+hyoGh27Wj0Z4C2bXdda8zst3mqM0Lbopd//5qcVC/pKjGsLiVa865btR69dmxeUiciCWEYI0rt9Mh/9qCzlAPMUjLCEvqNHpbDz92w6icESE6c9m6CqbFVL/ACUt2pGhjoH7oI8U8fZMJzIPNm2IMpvJwGrPfaZIBQnLiPZgXUkZ2TrqHvL9495A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mc8zaiJd; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mc8zaiJd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3d8Z2VCjz3cht
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 09:09:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F1D6B5C59C3;
	Fri, 15 Aug 2025 23:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E631C4CEEB;
	Fri, 15 Aug 2025 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755299338;
	bh=2GRJzTk+BtY2YrnH++wopzOmkdTjrCsNi98W9z6N620=;
	h=From:To:Cc:Subject:Date:From;
	b=Mc8zaiJdlfbcfAlsWKhmAZAKFanuVxseD1OxvsAfJtKF7081GIZmX+rbRA7HOZ0at
	 4aBO7StfsaIXLTw7l7sFhi3gdMg8qqrZ3Rn3h+Xm0crT/GalDBjITPv5knK18QSHEs
	 NL4wqvH7d3FEhs6o/cXm+QqjY4eV1N6DASn8B6aJSoi9xOrX3xX0DNt/C9nZPeWF9X
	 ihvvW/H7NFXJWPaVyKXqjDysZhkgQy1q1Q87/ahn/0QOmZG8m+hKS10HibR0+Kn2aI
	 9SV6KOU1i44Od3IXVIwHVMHVU4sjzSBQlFKAHiA5IDE1wJIPTZdBtctncTx93eJiTR
	 /g3fu1jJJP71A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Fix/add I2C device vendor prefixes
Date: Fri, 15 Aug 2025 18:08:39 -0500
Message-ID: <20250815230841.3487764-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
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

The ASpeed DTS files have various I2C devices with missing or incorrect
vendor prefixes in their compatible strings. This hasn't really mattered
and doesn't impact ABI compatibility as I2C devices get matched with their
vendor prefix stripped.

With this, the "maxim,max31790" nodes now validate and have some
warnings. Remove the spurious "#address-cells" and "#size-cells"
properties to fix the warnings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../aspeed-bmc-arm-stardragon4800-rep2.dts    |  2 +-
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  |  8 ++-----
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 24 +++++--------------
 .../aspeed/aspeed-bmc-facebook-tiogapass.dts  |  2 +-
 .../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |  2 +-
 .../dts/aspeed/aspeed-bmc-opp-palmetto.dts    |  2 +-
 .../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |  4 ++--
 7 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
index 9605ccade155..b550a48f48f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -171,7 +171,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 			dps650ab@58 {
-				compatible = "dps650ab";
+				compatible = "delta,dps650ab";
 				reg = <0x58>;
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..1aae3645cc8c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -184,10 +184,8 @@ &i2c0 {
 	status = "okay";
 
 	pwm@5e{
-		compatible = "max31790";
+		compatible = "maxim,max31790";
 		reg = <0x5e>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	power-sensor@40 {
@@ -258,10 +256,8 @@ &i2c2 {
 	status = "okay";
 
 	pwm@5e{
-		compatible = "max31790";
+		compatible = "maxim,max31790";
 		reg = <0x5e>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	power-sensor@40 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ef96b17becb2..4584d3b536b4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -313,10 +313,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
@@ -436,10 +434,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
@@ -559,10 +555,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
@@ -682,10 +676,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
@@ -805,10 +797,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
@@ -927,10 +917,8 @@ eeprom@50 {
 			};
 
 			pwm@5e{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x5e>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			power-sensor@40 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts
index 704ee684e0fb..5d4c7d979f1e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-tiogapass.dts
@@ -508,7 +508,7 @@ &i2c7 {
 	status = "okay";
 	//HSC, AirMax Conn A
 	adm1278@45 {
-		compatible = "adm1275";
+		compatible = "adi,adm1275";
 		reg = <0x45>;
 		shunt-resistor-micro-ohms = <250>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
index de61eac54585..adc598cca50c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
@@ -211,7 +211,7 @@ &i2c1 {
 	status = "okay";
 	bus-frequency = <90000>;
 	HotSwap@10 {
-		compatible = "adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
index 123da82c04d5..e6f33d7cfc45 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
@@ -151,7 +151,7 @@ eeprom@50 {
 	};
 
 	rtc@68 {
-		compatible = "dallas,ds3231";
+		compatible = "maxim,ds3231";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
index fd361cf073c2..86451227847b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
@@ -509,7 +509,7 @@ U197_PCA9546_CH1: i2c@1 {
 			reg = <1>;
 
 			cpu0_pvccin@60 {
-				compatible = "isil,raa229004";
+				compatible = "renesas,raa229004";
 				reg = <0x60>;
 			};
 
@@ -530,7 +530,7 @@ U197_PCA9546_CH2: i2c@2 {
 			reg = <2>;
 
 			cpu1_pvccin@72 {
-				compatible = "isil,raa229004";
+				compatible = "renesas,raa229004";
 				reg = <0x72>;
 			};
 
-- 
2.50.1


