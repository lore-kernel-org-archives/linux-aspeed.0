Return-Path: <linux-aspeed+bounces-1998-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E9CCA0EE6
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Aug 2025 13:17:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5qrd4kh6z3d4D;
	Tue, 19 Aug 2025 23:17:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755609473;
	cv=none; b=anrXoOLyM9unJlp94JdW4JHnhyAaya2h6ubQH357w2ftBphyF45fWe26KggYptklhEzZb6ZAIS4kTiOwoA02BdAMW0C95EgdRlvfLmgsANj58s7k4WzTqM48DbagwSYyQYq1NhKosjsp3jI6qmxYVbZirydhVzBblCQffS1OXe0Sp1iJlLRqPEp9U5N27JjPjj3mTpvXwLSSHd6p4JcxJsxXZK4WEFARiVm8LVLQt6K+dTAKGMRVeASBTndmlRZ+1kGKOOBEn3M6mz/y/2MzhO8sOKuNjzOHj1lAHUYel1uJhb891OIZPLs40pl7R0+wEcK5hOdlVMzu/WyfqtAVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755609473; c=relaxed/relaxed;
	bh=yX8jqUNVoaT/pP/QBlusgZO8WrcJpEh11O3LQ2VZcys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bB04At66JqDyyrGj0KgTJ0hdCdwxpFXB8+WXvskGEd9/FDBIqliZTkpsVGwHi8Pty+T5qCL4Z2YzjC0incFnHnlxtcjADNi8jZ5FPE4zV7X3m84PjjXSCJRWLqI/vzttc293w+7piAq9S+kznYptkZ70936pRixRbLdBmbuGnqPYhPrnBWcAkhot0kJ+jF7aQyRYjafBxoOv+C29bcTn/X0ylcBOfajxYKWSJBgxNyB0KgOnNeoo1kMLrevrelPVThiRoYEbcSnMCR1AOgYhEVy59eFzE+Bjf/YfzTUhjAj6hf7/IdN65zH0vcIhQQ+VOj/gWVQIswiOC1ssqb/7zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PcQmdMBP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PcQmdMBP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5qrc5Ngnz3d3M
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Aug 2025 23:17:52 +1000 (AEST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-afcb7a41b78so71853566b.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Aug 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609470; x=1756214270; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yX8jqUNVoaT/pP/QBlusgZO8WrcJpEh11O3LQ2VZcys=;
        b=PcQmdMBPrgEQ+4gokYKNGemC0Lam7SFtwhk28zSJVneOTXcw49wGhaAYOs8Bajhxti
         7CSfZNs3LAazXRtacbu20epMgTxCkGayRSnshiBDDKWmjlbsLNNb5eMI7cZK5iFFfWj3
         I6DSntmHfqpS7AfWQ/bsuR0eD4PvYiMmbRpOoTZzXcmMRiIAahLVp5eEJ1yi4dpbDGMb
         LzurLggwRaQIspbo1kNA/CuryFp92lJ0DDj5ExvKWCaf/9fn8EgQuRqjlgEBeL2b1pya
         kGIue+RUiEKBp45iU6R5HQrHJ7pCc2LO2Lh6rlDw3s7exBOsMbnPl4FT7PGxhwGfCFVm
         kaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609470; x=1756214270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yX8jqUNVoaT/pP/QBlusgZO8WrcJpEh11O3LQ2VZcys=;
        b=Ye8y72UhmWIclFoLWWm/m3nXeW9bcHeE0iQ+uwSaVY7SKOtVxGi/EYsMb/TEiak8SX
         yW9//tpoBwfLPkbBhFZdKJjwSossRfHSK/JJe4l5SdEzAbmyfOWmOuclN+vBDUG4YQgg
         u6Rclw9WC1MCJ37OS3yZzA81jTSdn6UTBLAUEbIqAcLuTjisoUeT23LMZAAWPFNdBB1D
         wMGgMZ2BglHN1nARbG5dliCTVT4eXIRw4iMkrJNh6W0uECnFotijW+CPFWmNrAxFRd8y
         P7MHSnTle4a3FHhnOpFxmIm+ElEh8JBoRM43vo6sQsBeNH1mQsZ+lCGDCTe7RWrLMj3E
         Qh0w==
X-Forwarded-Encrypted: i=1; AJvYcCXkdQyipb7xg/jIdL8Qk0iOar1ExV08vun4QElhqBra4xwGM9T9tAF3U8N8S4Kt2j4P0BJeaupe1Hl6Nkw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzcWJvM61DM8NtI4zMsHoCGfZW8jpuXO7/WPnrbW1j/93Niy38Q
	5hYyjgDmrsUKz+jBOtnMXoosDvDOnKLgH/vvHEsOZmpegY0NrixV2aHMYoDdBfiE8kQ=
X-Gm-Gg: ASbGncvK0NjfMJSsYaWaw2T1IFslzLDC/7DKDHedWGlJ+uSWW0Oiujr8bS+T/2AHGZD
	AaOyRd7KKdAgysk73DJCkuDRu9AjL6mrJ5eXgV9vzkkG5TD42Se2Bqh0aaKGNcIWR6NSj1GFuI9
	AwUQLXkC/hhWP6ZhAgwDPB6uA2ZDmjynkrxuanc4MEBHVPTduaPeVnlaKlNvuGwhMUBl6ZQGiPU
	xYYBM2NOgfT7tJtDgKRpq69j5IJ4/06OU3OJoPlSAdUqgfbqKRxNyhX6RAzRaf76TV3hUK/jtdG
	fF+fjueB7cqwjbko8j1ztmRAoEzjTTUf/tQodi3kKBYptRHJ1D9Kkkrb6tty2MvrILpwB8vosq9
	f6m8IEx3/l1pleYwU7QaqANjRyhlRqznMxaS+TjWmlxQp
X-Google-Smtp-Source: AGHT+IHRYPCS3CIXpz9ep32Qtx6spFR8eE7gvHlEe/afYX4onbStKp+kGa6meEY3YtnW6Pv8oWVyMQ==
X-Received: by 2002:a17:907:968a:b0:ad8:a2b3:66fb with SMTP id a640c23a62f3a-afddcbadb07mr124772066b.3.1755609469701;
        Tue, 19 Aug 2025 06:17:49 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f49sm1007251066b.7.2025.08.19.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: aspeed: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:44 +0200
Message-ID: <20250819131743.86905-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9010; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=J/hsPKtt4JbGzEI1pCl4hW7h1QPoxR3/5npoimUrZNQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHl3mN1BKV6PxXk7jlrwxP7edMkWFv03fc9Q3
 tA7yxN2kDqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5dwAKCRDBN2bmhouD
 12wrEACF0czF4yiRZj5xxAq/TmjYthxtMYW9SNh1wmjiPXvf5M2AiAzTIli8cRpczKhhvWN3qEJ
 qH3aARLi0lTJXzcnGDcI+CpxdRvuLpLG+UlM0C0TEMzIXZJLf1bKy+R8zpmdKCZI1cb1iOieubr
 65DQZUfVUCVwfIy36b/tG35fgcBgf59x5kisxw5jKNj98ZqTK95UrSGkmwMY8BztU8USV8TABG4
 WtZeGUwdrbgZjBfDv7OqrCaR04NUCHpZB51V6MtiRYTAecUGg40DtQSWwLIIN7oL4AcyEEwdlIX
 v/ZBmJ3OdXAfkVWlg5GVlQzHUEZeuFa4y+kIT//k/Vuna/VObLIs5tg60vINmhq14AE030krBKG
 hYZpeiA3Y3wRJYlmEdIY7/SUuhqQ6rGh4KRpjtQHufKF/NPJOlduxebYKS1ZtesZSs5Dj4EpApI
 RgnH47VCBru9xdUvn6CWk+ZpTbzz+Rub3K+7+8TdT8sK1ZVXKr+OZTwaf53JAsbWXN+xGLk3Cdu
 7Uhnu/dxC2YW4tu/urgD2b01L4SyvhXHHXBcTtsxWInt4Bs2Qe+YLx5FKy6kuBsBt9Erf5x/zBw
 6B3ujHdYTjMA1xcncq9EuwQQEv/UW2PyYxmswjbb6eO2VQjo6sBvr+1AbMYmCP56E+nYkmka0uy Bno9k6UHwpW/itg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts     |  2 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts |  4 ++--
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts    |  4 ++--
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts  | 12 ++++++------
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  |  2 +-
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts     | 12 ++++++------
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts  |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts     |  8 ++++----
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts   |  2 +-
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts    |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts    |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi      |  2 +-
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
index c435359a4bd9..53b4372f1a08 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
@@ -243,7 +243,7 @@ temperature-sensor@49 {
 				compatible = "ti,tmp75";
 				reg = <0x49>;
 			};
-			temperature-sensor@4a{
+			temperature-sensor@4a {
 				compatible = "ti,tmp75";
 				reg = <0x4a>;
 			};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 8d786510167f..14dd0ab64130 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -526,11 +526,11 @@ fan-3 {
 					tach-ch = /bits/ 8 <0x03>;
 				};
 			};
-			fanctl0: fan-controller@21{
+			fanctl0: fan-controller@21 {
 				compatible = "maxim,max31790";
 				reg = <0x21>;
 			};
-			fanctl1: fan-controller@27{
+			fanctl1: fan-controller@27 {
 				compatible = "maxim,max31790";
 				reg = <0x27>;
 			};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..59249e5f2fce 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -183,7 +183,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	pwm@5e{
+	pwm@5e {
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -257,7 +257,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	pwm@5e{
+	pwm@5e {
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ef96b17becb2..399e244bcd79 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -312,7 +312,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
@@ -435,7 +435,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
@@ -558,7 +558,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
@@ -681,7 +681,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
@@ -804,7 +804,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
@@ -926,7 +926,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 
-			pwm@5e{
+			pwm@5e {
 				compatible = "max31790";
 				reg = <0x5e>;
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ee93a971c500..72c84f31bdf6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -233,7 +233,7 @@ gpio@20 {
 			"FM_NIC_PPS_IN_S0_R","FM_NIC_PPS_IN_S1_R";
 	};
 
-	fan-controller@21{
+	fan-controller@21 {
 		compatible = "maxim,max31790";
 		reg = <0x21>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index aae789854c52..60b98d602e80 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1186,19 +1186,19 @@ adc@1f {
 				ti,mode = /bits/ 8 <1>;
 			};
 
-			pwm@20{
+			pwm@20 {
 				compatible = "maxim,max31790";
 				reg = <0x20>;
 			};
 
-			gpio@22{
+			gpio@22 {
 				compatible = "ti,tca6424";
 				reg = <0x22>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
 
-			pwm@2f{
+			pwm@2f {
 				compatible = "maxim,max31790";
 				reg = <0x2f>;
 			};
@@ -1234,19 +1234,19 @@ adc@1f {
 				ti,mode = /bits/ 8 <1>;
 			};
 
-			pwm@20{
+			pwm@20 {
 				compatible = "maxim,max31790";
 				reg = <0x20>;
 			};
 
-			gpio@22{
+			gpio@22 {
 				compatible = "ti,tca6424";
 				reg = <0x22>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
 
-			pwm@2f{
+			pwm@2f {
 				compatible = "maxim,max31790";
 				reg = <0x2f>;
 			};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 757421bc3605..c5fb5d410001 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -263,7 +263,7 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	tca_pres1: tca9554@20{
+	tca_pres1: tca9554@20 {
 		compatible = "ti,tca9554";
 		reg = <0x20>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
index 8d98be3d5f2e..dbadba8eb698 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
@@ -3778,10 +3778,10 @@ smb_svc_pex_rssd01_16: pinctrl@20 {
 			pinctrl-0 = <&U65200_pins>;
 			pinctrl-names = "default";
 			U65200_pins: cfg-pins {
-				pins =  "gp60", "gp61", "gp62",
-				"gp63", "gp64", "gp65", "gp66",
-				"gp67", "gp70", "gp71", "gp72",
-				"gp73", "gp74", "gp75", "gp76", "gp77";
+				pins = "gp60", "gp61", "gp62", "gp63", "gp64",
+				       "gp65", "gp66", "gp67", "gp70", "gp71",
+				       "gp72", "gp73", "gp74", "gp75", "gp76",
+				       "gp77";
 				function = "gpio";
 				input-enable;
 				bias-pull-up;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
index de61eac54585..c63f0b43090e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
@@ -151,7 +151,7 @@ &mac1 {
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
 
-&adc{
+&adc {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc0_default
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 72dafebc080d..4de38613b0ea 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -282,7 +282,7 @@ &uhci {
 };
 
 &sgpiom0 {
-	status="okay";
+	status = "okay";
 	ngpios = <128>;
 	gpio-line-names =
 		"","",
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
index 627c91f178e6..af3a9d39d277 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
@@ -64,7 +64,7 @@ event-checkstop {
 			linux,code = <ASPEED_GPIO(F, 7)>;
 		};
 
-		event-pcie-e2b-present{
+		event-pcie-e2b-present {
 			label = "pcie-e2b-present";
 			gpios = <&gpio ASPEED_GPIO(E, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(E, 7)>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
index 16815eede710..8c953e3a1d41 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
@@ -30,7 +30,7 @@ video_engine_memory: jpegbuffer {
 			reusable;
 		};
 
-		ramoops@9eff0000{
+		ramoops@9eff0000 {
 			compatible = "ramoops";
 			reg = <0x9eff0000 0x10000>;
 			record-size = <0x2000>;
-- 
2.48.1


