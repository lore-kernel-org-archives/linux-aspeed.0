Return-Path: <linux-aspeed+bounces-442-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC3E7719E
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 06:18:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWhsr5g7bz3c5M;
	Mon, 13 Jan 2025 17:18:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736749136;
	cv=none; b=l21UueXIk8UHd7oNetrtduTj0qQy3akHIWn4+2y0t0cVbt0or7bR96OjrYefQm3oz0581pmj2HlloSfsb2wOR56B9eYDi4DyrCDuEgHL5Pb9ecRokBMA6L71qLoedqzPmFpl0Ld15xHueInFNRB6PhCyEiKB0IKzBjjUKtWU5HilHmbgltkfXLGk4ssEs0P2a5JOl7UUYpCkER7OTVkrdxcX+1OgpYdimEJN31sRRbyoZtrrrs902LibwJNW3vLIU+cSSYa1j2SuUgILmvUOQem+aBmB8jkM6OvX7w/A8gLlZJdB7ldIlLwvYHs9iID9B2pt0SYlVQF+E4ucBChv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736749136; c=relaxed/relaxed;
	bh=UXMYkhj5IZ9Mb+wHyrW48mIfsHQ1A9AFKPYuWPrAkpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VSU6IZkIwVQOtgyMsV6BQnTPx24BWnc7aXcKgQj4YGTJmIGzT3GYstJ+PllPZMWr4XE6yMWXbkMlAVnh1OlsMk/gF2iBOUXkz+Z5fUgL2JAlM9xS2XWL7z/noe0RnhDDBpHBkID00Rl7WN5NlgZTFDLM0FcT97HZRtPLgtxJhVt6mzrBuvQ4A1dWTzYjKVfrIOrNsDx02ALtbcBh/Sun0kl7Bgt8YhE8EvR5I5Pt7pK5+e00nlDOZABVG7VYmlQfwDLc8l3U3n4MOSs47MiFTFKfjiMFDOVwuSRWiAjUp2bt/vbCLSXvydhvXX+2RpsgHhBgh4NxRfzFEWA9zXuf1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=StVtGbJT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=StVtGbJT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWhsq0npYz3c3x
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jan 2025 17:18:53 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2165cb60719so67382965ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jan 2025 22:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736749131; x=1737353931; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXMYkhj5IZ9Mb+wHyrW48mIfsHQ1A9AFKPYuWPrAkpY=;
        b=StVtGbJT2qrmBGqpJjb5eNBZqvKU3HqmVA+Gdpnpbqty67PguzRLkWQG7ApVTB9y0w
         J/pE1XOU9RJ4300SXFShI7deJxrRs93FAYdPSzdGxHf9K7rM/+bBw8YSUCMsMwScvXjC
         USrDEjBDFMXvGitYFZ02FHHEWXGM0L1lbgzf0MftJeScD9wu/883ETU/PTwItjYAXFGl
         XYYhFEwYzj6JB5uBXf/s/CVqenqku+gJoBQLDDPTwPSFK+2+vGANFz/FRI9ApSkydWsM
         4C9F2lFpyxJg+i/qzuh8WDelXqmWri9pAtjVcYo84h0rEJMcu1Kh+tqHhwOcHo0xNqWu
         dTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736749131; x=1737353931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXMYkhj5IZ9Mb+wHyrW48mIfsHQ1A9AFKPYuWPrAkpY=;
        b=sRPBFFOelVRn4gVAVeg8IawO7pyXfXQg9qo5RRMpQxIj2Uw7fM/RlFpR3vcqpep5n6
         qZnpVq1JXa3rygGlBuxaxNZIG3kAjXaqJomuYFeT1PLJYN8A+PXfKkSVXFGU0PGak0/m
         dhQ/PudPiqQ+i+mZbZ1edmF/RVXhX2NnTDH+8XiyglgVNres5OVEgc24MaediMfRZAlw
         3Q5p9AytF5F0Tb20py3ZQy5VUYDBDatXE9vDQyMC4mHqscYwVK7O8aj7zlgM1HT/Ff1l
         F6RdI4TEQ7se322NKB7VjAYv8SvYioMS3fquSIBHv8ezy1cxn4gILy0rmygSLi7WuvbH
         nkOA==
X-Forwarded-Encrypted: i=1; AJvYcCUjFhKnnlZQgoMaK4tOIpp1mP6AbJQoMOdP3aOJxZBIyDSlbS0omvcGyX8Pb/EEXrgOkxfjukt5ceIO84w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJaxYGbwZEy/7h4dYEJjshsb1oCLuMk48VWWhaq8x7bLc1IWEz
	MoQMiUE8Q+o8n2O1YKGysk3i4UAUR5eZRpo9I/YECFeKRO4W0EAD
X-Gm-Gg: ASbGncug3UmZo23dv7Jd/+OGlPw6r2EqsSs41tN2q+b8bdKaGI5nGGNhVbPxjmz4Ybi
	F7z7Ty83GDFdiWfwnNVBguF+LlgQlRVuaeo18zwVJ/44pdMegvt2Ddok+1b4SHWkNS8gAQhmvBb
	ao+IUYQo+XoDcMrivZO5F/DouS19WYpozXhQO16tnM0KRZqbShGqQxQembGaV3lQYphZhW65bn0
	/I4b2M/0JJcvNo0drMZ8Zq5xfOOov9OdEvth9sMnCijd0PHa6aYS0lvsslqN3LwWBQoLMGb9q2I
	kGNbTt7oL7qxrvk5LS3gwZsPWxz2bMiu7g==
X-Google-Smtp-Source: AGHT+IFigaJwgK7Z0NX1dvC/nKexlb3PogVsWIi3IglxLkUsghZrWcqjcsFlHJl2DP1Q0iXvPWIhFg==
X-Received: by 2002:a05:6a20:6a25:b0:1e7:6f82:321f with SMTP id adf61e73a8af0-1e88d10749amr27730415637.17.1736749131204;
        Sun, 12 Jan 2025 22:18:51 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e8ecacfsm6279705a12.38.2025.01.12.22.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:18:50 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jan 2025 14:16:23 +0800
Subject: [PATCH v2] ARM: dts: aspeed: catalina: Update DTS to support
 multiple PDB board sources
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com>
X-B4-Tracking: v=1; b=H4sIALavhGcC/42Nyw6CMBBFf4V07Zi2PBRX/odhMX0Ik0BL2ko0h
 H+3kuja5bm5OWdl0QaykV2KlQW7UCTvMshDwfSArrdAJjOTXNZccAmzT+RAY8KRHIJJER6zwWT
 hd2lFpXiDlTIKWRbNwd7puUduXeaBYvLhtTcX8Vm/+vIf/SJAgOLqhLUsdducr/2ENB61n1i3b
 dsbWGRFVdQAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736749128; l=6860;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=+9P1SAFUTyPeHDsem7TQlwq42JcEr9R7g9tjaiPQiIs=;
 b=q7cGmq9jtHu+sNoOLc89cs/9abzrthQEj0V4PmdvhAoWoyNT0lNHWSLu3QYfxAkuzcEU+acMA
 7Tg1EZrRPQwBE6NOoGguYQPQg0a5TPmzZ+TijEtlbwyFcTemAXAhs20
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch updates the Catalina device tree to support different sources
of PDB boards.

Changes for Main source PDB board
- Thermal Sensor Monitoring:
  - Added IOB NIC nodes (TMP421) for thermal sensor monitoring.
  - Added FIO remote thermal node (TMP75) for thermal sensor monitoring.
- Fan Monitoring and Control:
  - Add fan p12V power sensor node (MP5990) for sensor monitoring.
  - Add fan controllers (MAX31790) for fan control and tach monitoring.

Changes for 2nd source PDB board
- Fan Monitoring and Control:
  - Added 2nd source fan controllers (NCT7363) for fan duty control and
    tach monitoring.
- Power Monitoring:
  - Added 2nd source HSC nodes (XDP710) for power sensor monitoring.
- Address Conflicts:
  - Removed all ina238 nodes due to address conflicts. Moved the driver
    probe for ina238 to userspace.

Changes for PDB brick board
- Power Monitoring:
  - Add delta brick nodes for power sensor monitoring.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Updating the Catalina DTS to support multiple PDB board sources.
---
Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 170 ++++++++++++++++++---
 1 file changed, 147 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3822bb3c9243..49230e6a749e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -190,6 +190,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -200,6 +206,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -361,6 +373,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -371,6 +389,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;
@@ -464,51 +488,145 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@42 {
-				compatible = "ti,ina238";
-				reg = <0x42>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina238";
-				reg = <0x44>;
-				shunt-resistor = <500>;
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
 			};
 		};
 		i2c1mux0ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x1>;
-
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-			};
-			power-sensor@43 {
-				compatible = "ti,ina238";
-				reg = <0x43>;
-			};
 		};
 		i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			hwmon0: hwmon@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			hwmon1: hwmon@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x3>;
+
+			delta_brick@63 {
+				compatible = "pmbus";
+				reg = <0x63>;
+			};
+			delta_brick@64 {
+				compatible = "pmbus";
+				reg = <0x64>;
+			};
+			delta_brick@65 {
+				compatible = "pmbus";
+				reg = <0x65>;
+			};
+			delta_brick@66 {
+				compatible = "pmbus";
+				reg = <0x66>;
+			};
+			delta_brick@67 {
+				compatible = "pmbus";
+				reg = <0x67>;
+			};
 		};
 		i2c1mux0ch4: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;
@@ -580,6 +698,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

---
base-commit: becaccc292bfbd12df81148746043c5221e49da8
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


