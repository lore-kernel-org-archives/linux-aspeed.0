Return-Path: <linux-aspeed+bounces-466-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7BE77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 06:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXJl31Sm9z307C;
	Tue, 14 Jan 2025 17:15:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736835311;
	cv=none; b=iiJkTPjYfMYNnYlvZ6Kc2C5UXgwWqBQqg1Zs3rhetq31xErydRd95ETTTXaPYN8WOsednxCI4oyUQj+VYEgZLGlmJU3iy/ARDl1dsgyf09JjLN4hRzT/rJV4dI64t4oO2T2fFpuM/sOEkTgV36Q6l1zaioFlKpUeJeLTpqhQKq5KV62H6XZM9Azre94jeDpnvB7ugO+Y5VEJ+ggJLsX1XijThaYlK8aZ7kdsGSDt+QvGEdcx/+ds5S1QICwhyMSuC1LBs9fj1CQabxp11J8X/JhLcJT3PWXzg0j7us3GV5pUa/PL72YLcUaUa0btqR98mTr0622GvRGWzMalhZAtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736835311; c=relaxed/relaxed;
	bh=9+9ADON0/68ayYIfEfVGSHZvOGdkI3057JB+jrkbu/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NWCxJuW/TssRu/T/kIqljj6o6VREJYzsXrxW6pQvGbnKZ6X1uwS4hf/kO4FNHC1z8NY8R8IDfzSLGmxkZaO467y2TwvRm9WdeIDaqteQsN7tMdO/TS/o8hU/ylH7IimP6o/BNqRdR/b02bRhs+4HZkbxQxx1VzMy0W5eIs8TBCruACp52BIwi4jXWa5/fK96QhnmP1BHRECnFHiq0g7Hh6qYQavPDYESbSjHOWwvwD7tHW3Fqgif35JmptFOYQTAQ7Tlve80qVSs9nYWqvqFpP7E7Uk+lAj0vex7oSgtR7aOkyH+zBAdxeB0xcM8+imYsa1HbohGZi3ctdrQMkDg+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZadesEgA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZadesEgA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXJl074ZGz305Y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 17:15:08 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2163dc5155fso93238755ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jan 2025 22:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736835306; x=1737440106; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+9ADON0/68ayYIfEfVGSHZvOGdkI3057JB+jrkbu/4=;
        b=ZadesEgAZ/UvsmvG7j8vLd3tPNclofxoR6o2k6EIlPNB1eCde0c/x3ntnYzaAiNCyh
         AZPyivDEOrBSYaNGjwaa2+eUH9o/FjgJkUmbJ4PlClxSKIdt/6d7BuOGemBGOzWgzKk7
         sRuI/t4WLZ6tmA3S3RwvfOWLAQqBcSL8GAN1TKFGdyDrwTemyrKeaPp22Bqe6SAnolbe
         BX0/feeZ/KdIEsCbdvbZO2X8fSN/aeUl+XssmtwhRb/6iIwGLEw0J/7EKo4kJ9+lfDP5
         +CDNXKL4B75Q9YLH42AUUXi40dZNWQjlr3Dm45VOQsU1IWn0pMwsV6eG3JfPZH7oY+Jx
         c4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736835306; x=1737440106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+9ADON0/68ayYIfEfVGSHZvOGdkI3057JB+jrkbu/4=;
        b=bZ8LkXAprNxiqb8VXFlCIxIwlUIoPEJpttQ6rDLHn3+a8Mpuk8gjmOVStnBL0iDCRu
         CU5pG/97OK1nu4HCPu8sNNZ1kXdkkGdFjqb89FmIHMdAWt+76IEhy1bVuzzI9ZP6zcXU
         wxFvhmZsWzZkkZecQzhi79QCQod1ABvseZjicoeZ5GG8pmJb5ge6DOfKxQ/9M2fvPtKq
         ymT7Vl9FSo9wyIH4/tu1IjAsqf8w+MhsU++dw+nVdIybjxaqhq+EdBzOLNacXTfzuYzn
         U/WlpY4ompq+twnqJGpO4nqC/ABjcG/z/ScG7+YEHsGe+PPwjwuyKPW7+65NZlEYdD6l
         RAIw==
X-Forwarded-Encrypted: i=1; AJvYcCUBGQz9i0V4oZpqS2nkR6nh6r9rAlOUpDURz8D/HERUI4YoNSVIaWP4oezRYeKPhzV8BFgZb6R1u7mV15k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySvU78E+xaI3h0RJ8uc+UD/XW++yN66/Lgb8YWXSnXLuhJMCIB
	+WmYyg8oO6vHcVP73olWeGCjJg0hPS08Rm74ltqiL+Vrs3NFwiNK
X-Gm-Gg: ASbGncseu2hUQApYuKbc3MraM2549quSRD/G4gpO89TJMnDUuFcPUH4n/bSV8Ik6xXo
	UM/uOP+6bRh/wVNQlCIFwQIBaGePFB5RtlCGpVX2B5hrvtTi/7A6umbjw9K9KhCy6Ys7dbKV2G9
	3C9nbgpvfUUD6To7ekYgK5sRKIwqTdX723NtT3tVA1sOy9NRTRzrAHqb91nGaBg0P0m7SoooB6Z
	sRgp7VC2tIzR352rCOHEFK7V3N4c0TU5IfIWELd/zimW2GMrmAdeK4eitavSh9oHon2LTyJRM3h
	26N6J4x47slWR3z3nld4VKmPaIgmq1tcPQ==
X-Google-Smtp-Source: AGHT+IEyP70V5BBHMys71/WsXOS/rY0o9WW3Q+/v6dsdado13jARyxFY0TuAdoBRAxFx2Ha6CPRa3g==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4771mr20947524637.36.1736835305592;
        Mon, 13 Jan 2025 22:15:05 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065c3b4sm6796218b3a.112.2025.01.13.22.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 22:15:05 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 14 Jan 2025 14:12:46 +0800
Subject: [PATCH v3] ARM: dts: aspeed: catalina: Update DTS to support
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
Message-Id: <20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF0AhmcC/43NTQqDMBCG4auUrJuSiX+1q96jdDGJUQfUiElDi
 3j3RqHFpct3GJ5vZs5MZBy7nWY2mUCO7BAjOZ+YbnFoDKcqNpNCZgKE5KP1NHCNHjsakFfe8dd
 YoTf8/1JCqkSOqaoUsgiNk6npvY08nrFbct5On20zwHr98ckRPgAHroQqMJOJLvPrvemRuou2P
 Vv5IHckHCNlJKGQGUBRmwLLPbksyxdpc/gjJwEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736835302; l=6499;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=lbOKlY5AnxmP5unErxDp8hen0opmaKpQ0vRsSWRl/Ao=;
 b=IAKC+rhHag+WcW2qKa8cX5x57+SOcI0rbFTphPzuFoDlRzL/KC5ugdzDPn5IPheQLvlXqyVd7
 ZcoCBLS4rpCCT3HUb2ZTb1dF5f2KsU+QtX5VOG6L0RGza74k9vOZ/91
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

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Updating the Catalina DTS to support multiple PDB board sources.
---
Changes in v3:
- Remove delta_brick nodes due to compatible string not supported
- Link to v2: https://lore.kernel.org/r/20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com

Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 149 +++++++++++++++++----
 1 file changed, 126 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3822bb3c9243..23583665ba12 100644
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
@@ -464,40 +488,105 @@ i2c1mux0ch0: i2c@0 {
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
@@ -509,6 +598,14 @@ i2c1mux0ch4: i2c@4 {
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
@@ -580,6 +677,12 @@ temperature-sensor@4b {
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


