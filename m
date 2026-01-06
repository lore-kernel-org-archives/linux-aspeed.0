Return-Path: <linux-aspeed+bounces-3249-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2B0CEFD11
	for <linux-aspeed@archiver.kernel.org>; Tue,  6 Jan 2026 21:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dm4B95pGYz2xHt;
	Wed, 07 Jan 2026 08:32:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767735121;
	cv=none; b=MqTT1ZPylK6/ckD5e1/hmPQQCa6pDF4pYVPI2d15GZYdDdV+pX/2LpTZ4jscv7x+4c3nO3DN6p0UYpNJvsIKL1MAMqD4SzUS+AtuvO1o7WMFoCxhnRNNTQAQgvT/RX/OdZAEDIKBBxnZTgbia2lhCeLBbr76M/W+UOIbsDH5oO8Ixvcj+PBAUFnfAMczoS8jUjfHElVdSbkdP/mDgiY2jclGlE3IzwKrMIOlOrF2GrFg4pjkJsmCGe/4qlwdI4bm0AqaX8PzUc35OmHYnnQRGvs527AavSjbx9CfJkS3rB8c9cPXEORegCJ04MDY8iHcuCAqqWLOV2PYkiNWRdI6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767735121; c=relaxed/relaxed;
	bh=7AvG0msAbo2Y83aHAD2fhIUaGZrg+4t+Ti3xDsgkl6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+z6+sXdKLe6UT1OCuC5oi8guxdZkr3z+OTGp9rMwVQLrE0+zu1+TyHuAjtlfYnrBaWVeHf+kwRecIsLdnynM0FPJHVvfUxIlj9cGLGC3am92gNIsDivoV5mZsc9Uly/QFGirsKSLa4pgR7WoRFQjRIni9svY2k3AnioUwgppkyGAOBWhn1/P+Ke9QXV7J4pQQaBU4j5AzZCtYCWH8XQNz2QsdooOZWCs0Y0E+4VOGnaLYYtmZ/Hh34446Oc4PEkraAjheiptZlgxYJr5l7zQAOVccrZ/Hba7Md/eHSKbADo4+lgFX3/AcMrib4jG0rT+sVJlmLuaPeSkAa+B424Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jL0mkEce; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jL0mkEce;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dm4B83WSvz2xHP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 07 Jan 2026 08:32:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A5EDF43D26;
	Tue,  6 Jan 2026 21:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B4C116C6;
	Tue,  6 Jan 2026 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767735117;
	bh=c0S+UPILWQZ/bfTmY0vB12LguAXEd/SuBL+v3igeD1U=;
	h=From:To:Cc:Subject:Date:From;
	b=jL0mkEceaEmkQMi7RsnupTDbuwGDxnHWFEKBV4+1cihn6nHCd/hFhNNB1wWCV9Ms4
	 P9jdDj+Wd8VqHCbvQC70qQtN87CwUjSn5VBRysgkS3WD6zj1DvVLO0V/Lcgw6pSbEP
	 7WOfcUjN4vzFaG+RAs3lt5z5OUHopp0yTgnmQ6a91LATBLhEpOpjSiREDn5/pjsm/U
	 xwNjsv+xwgWse8vlOQq1uY5ssLSoyUApBxTrcuVzs5NYxrW44qFLBQXME/MA5qBua5
	 DkO+SWgfJshZc36iavjQOJCw9cBWHO3EBrrQyyBwfgoLj6UngEpB3WZ3vgxOqjULUy
	 8UvbOFtZN+znQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: ibm: Use non-deprecated AT25 properties
Date: Tue,  6 Jan 2026 15:31:51 -0600
Message-ID: <20260106213153.2766411-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
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

The at25,* properties have been deprecated since 2012. These platforms
weren't upstream until 2020 and 2023, so it should be safe to switch
over to the "new" properties and just drop the deprecated ones.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 128 +++++++++---------
 .../arm/boot/dts/aspeed/ibm-power10-dual.dtsi |  64 ++++-----
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi |  64 ++++-----
 3 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 5a0975d52492..561633d31039 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2806,13 +2806,13 @@ cfam4_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -2823,13 +2823,13 @@ cfam4_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -2840,13 +2840,13 @@ cfam4_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -2857,13 +2857,13 @@ cfam4_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
@@ -3181,13 +3181,13 @@ cfam5_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3198,13 +3198,13 @@ cfam5_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3215,13 +3215,13 @@ cfam5_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3232,13 +3232,13 @@ cfam5_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
@@ -3556,13 +3556,13 @@ cfam6_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3573,13 +3573,13 @@ cfam6_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3590,13 +3590,13 @@ cfam6_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3607,13 +3607,13 @@ cfam6_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
@@ -3931,13 +3931,13 @@ cfam7_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3948,13 +3948,13 @@ cfam7_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3965,13 +3965,13 @@ cfam7_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -3982,13 +3982,13 @@ cfam7_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
index 06fac236773f..79eaf442c5bf 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
@@ -88,13 +88,13 @@ cfam0_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -105,13 +105,13 @@ cfam0_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -122,13 +122,13 @@ cfam0_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -139,13 +139,13 @@ cfam0_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
@@ -257,13 +257,13 @@ cfam1_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -274,13 +274,13 @@ cfam1_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -291,13 +291,13 @@ cfam1_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -308,13 +308,13 @@ cfam1_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
index 9501f66d0030..a54be7d0af0b 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
@@ -739,13 +739,13 @@ cfam2_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -756,13 +756,13 @@ cfam2_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -773,13 +773,13 @@ cfam2_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -790,13 +790,13 @@ cfam2_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
@@ -1114,13 +1114,13 @@ cfam3_spi0: spi@0 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -1131,13 +1131,13 @@ cfam3_spi1: spi@20 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -1148,13 +1148,13 @@ cfam3_spi2: spi@40 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 
@@ -1165,13 +1165,13 @@ cfam3_spi3: spi@60 {
 				#size-cells = <0>;
 
 				eeprom@0 {
-					at25,byte-len = <0x80000>;
-					at25,addr-mode = <4>;
-					at25,page-size = <256>;
-
 					compatible = "atmel,at25";
 					reg = <0>;
 					spi-max-frequency = <1000000>;
+
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
 				};
 			};
 		};
-- 
2.51.0


