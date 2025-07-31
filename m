Return-Path: <linux-aspeed+bounces-1871-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B28C87FD3
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcb073Pz30MY;
	Fri,  1 Aug 2025 08:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999966;
	cv=none; b=JR093YtKnZVot3U/o1W41OpxhClFTfcY+Hj1Nv3UXq0i2TAfGBOykMFpWrQOdcscb+8ypI+kNo0GMVycNgim0ssjF1ZLdYEOdH2DNpp8xqT/xxPM7LWcPU03lcma8XvBXHONmdme+B9St6t9sXhm5jpLki3nLszeRZVYd4FGckatdYTRmLaigOinY7mqRapp/3sHKtTPqAs7PwrVV6wWUxYtsvatvWIqAr7Yc1t+vtQjCqVxMhOVMvjtRTSuXEcM7DRrh0i55e8X0iLiDKL/utgHlm/q6eiYac3HKT/nLl7G4r3HIh6ZIMlXfWqYJEwpfYVmYhGCB3PBytB1wea2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999966; c=relaxed/relaxed;
	bh=IqTotNiAOWcLbU9JFvPO9h9wcM3uvNLK5yQIugKJtOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqWjXWvIUTS9+YH95RQVWlZ7leragi3H2pC5KXSM7NeTQycAOoS/FOREfQSj3hzQkVQndhT4EzIOEVQL4SHV9E3f0V2mzrv5y0U8cbWNK/E8J+sS2iLCDxTVdzVSnN6MytMl8eFqym68DdAJGEEG1RaM+C59V8W0o7JBEbq053DtnFEQlnHmDQxlZQoJ6IDvdxxr7hB42HgYG/te01ZQ1ID9IKMvFAy4tZs7b7yL977jLE82Ph1AWOu8IYrSRKY7d/WrXycXYFaCvpsAw7MZyPbLjt6EwXv2kO0xWIy9LbeaygzS7R9CH9aFh8oLDjUudDPOz+VC1DBoXfCEAw+LMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g35nxxeU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g35nxxeU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcY1Htbz2xRs;
	Fri,  1 Aug 2025 08:12:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BA9DF61135;
	Thu, 31 Jul 2025 22:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F7C4CEF4;
	Thu, 31 Jul 2025 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999962;
	bh=tdDkXmNUX4O3VWO9zUljpRGtZvcgIcgJ0oBAw1ujc0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g35nxxeUbz4f/mQmvW8Q5iBzd6861+826jXm8MYGFoj1apAVSoWQCnKon2dnihV44
	 lj10o/xd8zFe7SyTPXXwnm+1m3cXx8nOf+yOXNE8GQulwcpVymZTTnrs+PMch7p4EJ
	 pslA2XsT3ik9C1pZU/kju+bPppN2G3sad396d38wo3yqZsFrtYyY1jBmobbRt9mGHI
	 r23bvPynjzG/Y6Fuo6nuTsNtEpePsji9uRj51gVF8YEKilo7U3S0rYPEu/wGxvbsjh
	 W7JlyjmEaacyN+qJtBzQsx2EAGAcgYXLAEKZig6a5omNNzZ3E+S5vKI487twBQtf6n
	 b05zlMAaGn8lA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:20 -0500
Subject: [PATCH 3/6] ARM: dts: aspeed: Add missing "ibm,spi-fsi"
 compatibles
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
Message-Id: <20250731-dt-fsi-cleanups-v1-3-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

The "ibm,spi-fsi" compatible is missing or incorrect in various nodes.
The incorrect cases used the "ibm,fsi2spi" compatible by mistake which
is the parent node of the actual SPI controller nodes.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 24 ++++++++++++++--------
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 12 +++++++----
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 12 +++++++----
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 9961508ee872..52a044b1e454 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2808,6 +2808,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam4_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2824,6 +2825,7 @@ eeprom@0 {
 			};
 
 			cfam4_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2840,8 +2842,8 @@ eeprom@0 {
 			};
 
 			cfam4_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -2857,8 +2859,8 @@ eeprom@0 {
 			};
 
 			cfam4_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3181,6 +3183,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam5_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3197,6 +3200,7 @@ eeprom@0 {
 			};
 
 			cfam5_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3213,8 +3217,8 @@ eeprom@0 {
 			};
 
 			cfam5_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3230,8 +3234,8 @@ eeprom@0 {
 			};
 
 			cfam5_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3554,6 +3558,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam6_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3570,6 +3575,7 @@ eeprom@0 {
 			};
 
 			cfam6_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3586,8 +3592,8 @@ eeprom@0 {
 			};
 
 			cfam6_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3603,8 +3609,8 @@ eeprom@0 {
 			};
 
 			cfam6_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3927,6 +3933,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam7_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3943,6 +3950,7 @@ eeprom@0 {
 			};
 
 			cfam7_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3959,8 +3967,8 @@ eeprom@0 {
 			};
 
 			cfam7_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3976,8 +3984,8 @@ eeprom@0 {
 			};
 
 			cfam7_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
index 07ce3b2bc62a..06fac236773f 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
@@ -82,6 +82,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam0_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -98,6 +99,7 @@ eeprom@0 {
 			};
 
 			cfam0_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -114,8 +116,8 @@ eeprom@0 {
 			};
 
 			cfam0_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -131,8 +133,8 @@ eeprom@0 {
 			};
 
 			cfam0_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -249,6 +251,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam1_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -265,6 +268,7 @@ eeprom@0 {
 			};
 
 			cfam1_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -281,8 +285,8 @@ eeprom@0 {
 			};
 
 			cfam1_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -298,8 +302,8 @@ eeprom@0 {
 			};
 
 			cfam1_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
index 57494c744b5d..9501f66d0030 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
@@ -733,6 +733,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam2_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -749,6 +750,7 @@ eeprom@0 {
 			};
 
 			cfam2_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -765,8 +767,8 @@ eeprom@0 {
 			};
 
 			cfam2_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -782,8 +784,8 @@ eeprom@0 {
 			};
 
 			cfam2_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1106,6 +1108,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam3_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1122,6 +1125,7 @@ eeprom@0 {
 			};
 
 			cfam3_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1138,8 +1142,8 @@ eeprom@0 {
 			};
 
 			cfam3_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1155,8 +1159,8 @@ eeprom@0 {
 			};
 
 			cfam3_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.2


