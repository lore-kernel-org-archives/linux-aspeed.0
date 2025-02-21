Return-Path: <linux-aspeed+bounces-805-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F24C021B3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 21:38:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z03RK1N3Sz2yD8;
	Sat, 22 Feb 2025 08:38:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740173933;
	cv=none; b=gXjU//yRy0VrHeoCHs0xRq6y4OydKy0Tg20iJqP1w4JU2jUKn7R+bccA6VGIm0eQemKzoyzzt/JubhlFJsuR4Pw0YEKTjUlEdU4sg5HDqOqk4W34sTmyKNGxeQhxlcyex8GXjjgjSTyCvack9do+5CM32Cd3xX1iYF88nKAbMTikzaN4JMa4tQu0nmN64F962cATbRdnkfMpOjKyrUHrEYdcLPpSGsMBwhc0BEcOjY2v+y9QVw+Ko5xVQwBYXPhI9/3fEGxXxvFhQBk7DKBXgyz4HlfM3vv2ryIpc1MliUi8L2hoj5fBAXrmnDr/GbCuv22OIg4H5y/AJyBNyEEklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740173933; c=relaxed/relaxed;
	bh=sJT+U7McgsKphrcHRdaZ6L+JaOsqY4avlMmqDJFGzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e51z3JYALlDFsZaFdZv01lWmGJEYBdUxyjjv1WgDA6nNkQvrhMDMZkWrXTlt8udY3t00SEP+LRbDa7KnoJszz/Ss+L+ORbcVZK5b+AgDvp3NYGEKPhSBiBdO61FQBTVyluy2hlJr+ys89k0u1jGURv3pOzjrHACQGK8YMY4L1axCEAUE/QnqHLVhtoG5NCcZqgMQmJDPRycULwpn7FQtqa1+6FtDABSYXVA4FaB/0q4leEBuLRgttsI839t/B7kppkYlzYqGIZns1vrUPnJDEBf/ofxoRgK4UHqqHT3e5EwoLaE+V2mwOqmHRiyJOe+ka6eAsyvEMh6bllMB0ta4kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q7fFaWec; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q7fFaWec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z03RH3Tpxz2y34
	for <linux-aspeed@lists.ozlabs.org>; Sat, 22 Feb 2025 08:38:50 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-439950a45daso16380105e9.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1740173925; x=1740778725; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJT+U7McgsKphrcHRdaZ6L+JaOsqY4avlMmqDJFGzCA=;
        b=Q7fFaWecnee7CrPTqIR9lJmfs0B+7Q01ktw1TZ+BccvWdwEIvfhjgdLgVFQhbqzx31
         QfeQYBBlQ1rsZ+BLzQhCX9D7wPd2IaQesbaU68oEZD/ufJVHxS2qTIdMHxUROjL1wq56
         EUAUxD1P8r2CFjJXRi+nT09xR3TXmOM9CX0XlyeAwoGHJdbInQuNEu/4aMTT92RN2CVj
         nNR30hzgXdxKSUOzrdXYg5nOhbXDzrmB0cgcakxhCR5s40CrsN+9ADeIk7A+zTHJq3dV
         c9ebSXpnvyTs4pPNO7bj93R1brJflymtEsjZ4wGsVWGaJLAjMLPkzakCN0sxvjtOps97
         LtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173925; x=1740778725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJT+U7McgsKphrcHRdaZ6L+JaOsqY4avlMmqDJFGzCA=;
        b=guSlrAHZz96+IbOBHW89afMNHhiqKrCz29pfh/cUida89Ekb0YOaUSaYTaej65KIl9
         0lC647NooTnoyx6me8TuXzGvYlqzVk4bP5L6pVWCEH3Jjto1h/s19S6F/7akbriUXYVb
         8o6sv1oUeAU0Co/VRVG6jvM6YtgJ7Tp8+9DzZevkTQfsosnhVYQFHgnSPpFhl/mA6gj6
         sj76HKKrCqLd26JsyS+8cEWHAXItzP7KxW7dP5lINIn7z6TYfRrGDTTWhqyZbrMKrQWI
         g4hjz+2nZuMaWWI3S1XJxPkBBsumMBKa2dqez+j/Y6md2f5O6pxZyUKSl7B0K6S06W24
         PSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUTwdaH0aWy8wx8U2WVKZ5YnAkfr1UxfLzMs9YuZrzqlW/h1qqM13IGUepjjYlD5WiW8/4wG8HI/xMbi4g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxF0+CdPzT8Jxj2TU8SoYcoW/+DBANvGuUnvJXhuToPYzISAyu4
	K/G+W9XhpzQVc4/wl1pHe9jmZw5vTr9g8g4XrgtVvE1fnJxE7CEORhY26y3vq8o=
X-Gm-Gg: ASbGncvIJPldrFYoX+EFx8MJAx+t/C02OyTDdug8552dmtRXmJwrCkpt/dLmTQMnbmo
	BWnPJAywixZJHKAI4bP0W5wWPATdKAx7CVVpfrnZAXdj2RJtt7btg36/6UnglYj9JVH21IRuyjA
	OeNbvh3jAjM12rvVJdbf8sUthNqvbDzlZCroaCrlXOW20mTQSzic4l3kULrAnE5XoyM/LQmAxmy
	wRaIDtbFfIS8jazeVfKPgA6NwSNZmWPxpn82XDB7szhACZwvxWwmssj/lv/KZWPjzmgLFsIzzqU
	eh7XNw+eNUCL4j7uxci+thq7ImW/LIVdlLTIkd/lrVTj2+axLNJU0uu7xasYXf1V4gWHDEVNCYc
	ico2iNYkEANBfjdIK9s2GRw==
X-Google-Smtp-Source: AGHT+IEJdfP86XwonfKjpWl9cuxaXOkK2TY/AbasqcdUgfrAsr/wju12Wjkvh2xGz6T+sDP+8jaxzw==
X-Received: by 2002:a05:600c:4f91:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-439ae1f15b6mr39164505e9.13.1740173925072;
        Fri, 21 Feb 2025 13:38:45 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm24767461f8f.52.2025.02.21.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 13:38:43 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	broonie@kernel.org,
	conor@kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-hwmon@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: sbp1: Align regulator node with Infineon ir38060
Date: Sat, 22 Feb 2025 03:08:35 +0530
Message-ID: <20250221213837.1594057-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250221213837.1594057-1-naresh.solanki@9elements.com>
References: <20250221213837.1594057-1-naresh.solanki@9elements.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMBus driver expects a regulator node, which was missing in the
board's device tree. This was corrected in the latest device binding
update for ir38060.yaml.

Update the board's DT binding accordingly to align with the fixed
device binding and ensure proper regulator support.

Fixes: 1d333cd641fb ("ARM: dts: aspeed: sbp1: IBM sbp1 BMC board")
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Changes in V2:
1. Update commit message
2. Add fix tag
---
 .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 124 +++++++++++-------
 1 file changed, 80 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
index 8d98be3d5f2e..34f3d773a775 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
@@ -1838,13 +1838,17 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			pvcore_nic2: ir38263-pvcore-nic2@40 {
+			ir38263_pvcore_nic2: ir38263-pvcore-nic2@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "pvcore_nic2";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					pvcore_nic2: vout {
+						regulator-name = "pvcore_nic2";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -1853,13 +1857,17 @@ i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			pvcore_nic1: ir38263-pvcore-nic1@40 {
+			ir38263_pvcore_nic1: ir38263-pvcore-nic1@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "pvcore_nic1";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					pvcore_nic1: vout {
+						regulator-name = "pvcore_nic1";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -1874,13 +1882,17 @@ i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			p3v3_nic: ir38263-p3v3-nic@40 {
+			ir38263_p3v3_nic: ir38263-p3v3-nic@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "p3v3_nic";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					p3v3_nic: vout {
+						regulator-name = "p3v3_nic";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -1889,13 +1901,17 @@ i2c@6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			p1v2_nic: ir38263-p1v2-nic@40 {
+			ir38263_p1v2_nic: ir38263-p1v2-nic@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "p1v2_nic";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					p1v2_nic: vout {
+						regulator-name = "p1v2_nic";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -1904,13 +1920,17 @@ i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			p1v8_nic: ir38263-p1v8-nic@40 {
+			ir38263_p1v8_nic: ir38263-p1v8-nic@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "p1v8_nic";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					p1v8_nic: vout {
+						regulator-name = "p1v8_nic";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 	};
@@ -2070,13 +2090,17 @@ i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			p1v05_pch_aux: ir38263-p1v05-pch-aux@40 {
+			ir38263_p1v05_pch_aux: ir38263-p1v05-pch-aux@40 {
 				compatible = "infineon,ir38263";
 				reg = <0x40>;
 
-				regulator-name = "p1v05_pch_aux";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					p1v05_pch_aux: vout {
+						regulator-name = "p1v05_pch_aux";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -2085,13 +2109,17 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			p1v8_pch_aux: ir38060-p1v8-pch-aux@40 {
+			ir38060_p1v8_pch_aux: ir38060-p1v8-pch-aux@40 {
 				compatible = "infineon,ir38060";
 				reg = <0x40>;
 
-				regulator-name = "p1v8_pch_aux";
-				regulator-enable-ramp-delay = <2000>;
-				vin-supply = <&p12v>;
+				regulators {
+					p1v8_pch_aux: vout {
+						regulator-name = "p1v8_pch_aux";
+						regulator-enable-ramp-delay = <2000>;
+						vin-supply = <&p12v>;
+					};
+				};
 			};
 		};
 
@@ -3596,34 +3624,42 @@ i2c@1 {
 		reg = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		p5v_aux: ir38263-p5v-aux@40 {
+		ir38263_p5v_aux: ir38263-p5v-aux@40 {
 			compatible = "infineon,ir38263";
 			reg = <0x40>;
 
-			regulator-name = "p5v_aux";
-			regulator-enable-ramp-delay = <2000>;
-			vin-supply = <&p12v>;
-			vbus-supply = <&p3v3_bmc_aux>;
-			regulator-always-on;
-			regulator-boot-on;
+			regulators {
+				p5v_aux: vout {
+					regulator-name = "p5v_aux";
+					regulator-enable-ramp-delay = <2000>;
+					vin-supply = <&p12v>;
+					vbus-supply = <&p3v3_bmc_aux>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
 		};
 	};
 	i2c@2 {
 		reg = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		p3v3_aux: ir38263-p3v3-aux@40 {
+		ir38263_p3v3_aux: ir38263-p3v3-aux@40 {
 			compatible = "infineon,ir38263";
 			reg = <0x40>;
 
-			vin-supply = <&p12v>;
-			regulator-name = "p3v3_aux";
-			/*
-			 * 2msec for regulator + 18msec for board capacitance
-			 * Note: Every IC has a PTC which slowly charges the bypass
-			 * cap.
-			 */
-			regulator-enable-ramp-delay = <200000>;
+			regulators {
+				p3v3_aux: vout {
+					regulator-name = "p3v3_aux";
+					/*
+					 * 2msec for regulator + 18msec for board capacitance
+					 * Note: Every IC has a PTC which slowly charges the bypass
+					 * cap.
+					 */
+					vin-supply = <&p12v>;
+					regulator-enable-ramp-delay = <200000>;
+				};
+			};
 		};
 	};
 	i2c@3 {
-- 
2.42.0


