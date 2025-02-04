Return-Path: <linux-aspeed+bounces-632-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E97C02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:03:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnWSc6XmZz2ypP;
	Wed,  5 Feb 2025 05:03:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738692208;
	cv=none; b=hqqU7kDhNbr8Qqn5Sf6TrFGehxDZNwLVSeg5DjuzSGd5kAXVASd5mv8aA5aTTF+xamolaDqVpAd0CPaZHDTRpYO1wbNN2VgQUnlThpO6F/IOon98e9tZQNsDGcUFopW5pVRJdJzFavEjJtJjl3sNpKrj2fDMwLPvC9lopawTQayIsvYg2+3EJlp2HbgSodjaKuzABJmpw0hi3JLFYvPcS/IQcYibtMePVbv97FdxDi4aWXR7AeGorGM39Ns4QhY5uYDhBiPuBbG3dxP1zvVS7HnPWZ1nMeyYian3rdqXgT/vGmEjimuNwVZwe4leuhfAMHMdqTfVTZHBzvgeiFGF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738692208; c=relaxed/relaxed;
	bh=4W7/uVh1SHBueJ7TDZhlHeiCdQneN4JhcxgrJWh5ZZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO6V05/0jz66qqlQG/VChvypQVI3icXymRs+Wx3KUuVNQ5hw6/LbMehntDsM+20JzigcPIL1nQOtjhokkPU+ZsDl5WxEpJWvv+PJLkFrb9XdmhXJ+K8kVUtgIvxNZy5bTqfdOq1UfOV7X0uHqxfZ/xhrIxkoTst2txjwM1rkG1xwnT/o013QeLp5j/wx/5qrxbwqpkbrkKL32Kh+xmF1rrNQhuQmPD6OwPH4k7rvgDrh43D5Qa2rGrkp7MK+GxwB8/7WjzM6kh6BpPTlAQviyuReVvB3RZZvPr9OcuBHtLTS3ckDInVXEijviGdhEOFrgPvrlzi4Q8LL3TYRoYSUNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=F+JQ2fUX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=F+JQ2fUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnWSb0V9qz2yXd
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:03:26 +1100 (AEDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-38a8b35e168so21672f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Feb 2025 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1738692202; x=1739297002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W7/uVh1SHBueJ7TDZhlHeiCdQneN4JhcxgrJWh5ZZA=;
        b=F+JQ2fUXka/dBar7xG1Cfcue54ptpo9KRtwv7ti+fDnHGjKJX24o3MrRmJcSCBteof
         2zmNPtE3KsN+dg4K+ch5JWT90Zupaoud3ban3o8VV5CNAFYuMCQfXkxeFEAYXV56+fQa
         atCPAAndaSWX5QKu96BJ3rZnnE1/yfopFoLQshGNLq/zJoLfcyeIVDRbxPiG4PeE3JR1
         D4bOiIVuKrn4WOZlgJkN+XH3yrKNHvyixWyKtROyXXOLVt6MBiXLOf21hYEHm5M0Qnob
         Dn5aqyNuN1e3N5/yBbryPucsv5mcWSrA6jT06u0iqyHFrGBFAkZc84JBx7eGrIwg+A/N
         1jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692202; x=1739297002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W7/uVh1SHBueJ7TDZhlHeiCdQneN4JhcxgrJWh5ZZA=;
        b=Q1fLQaATwASui8xnN3r9v8R7eipws9FpUavvE4GpV64ceZ1awMULrj2EDgFMCQwp+A
         i47/3+mNh2IaujQCDKuxoq5L9kJ2Vc/78MyVtdDtN4Zn0EqjC10n/PlmXcYo687tSVsG
         33On8iNTq+WQoshNdMK7KhgomssbKvWki63qUkMdvU/gJBEZLNlIhoEp+CFRHCC2dzWe
         zDM+yYNyMEFNA0rOQ1fYNB/1WFLkcGDJeU3amoOwM/DOCUe9nT68pPrIQfiNGxD5NDSv
         JjrOv3JAxQFdy6gjfeYnQcgb7zZ938R4DcCzD9/IKgboyyjyPJJ6W+oEEZ0OenMTNJ4v
         QJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfSFJOY2ZZGBp3RhvOabwjH/CpW4GAyWpZg3e1pT6n6A/SoeVuUXBRXtg6zQUZuluBP/uwvqfkiY5t+pc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxQ9zXz6+SsEXQl/tbherQLTRPWVyIzNhfOcaw6jqtY99/ZsGIF
	8Xf2854SsSfyDIB4YfVPdd2L4qbbMxuleVl48EEKF1bSaqjI6L6LzLk78DMimGQ=
X-Gm-Gg: ASbGncsQwroOzgV4BIYBT1E3IL1M+HOkZB02wYiZ+BIC/S5tdoIrY4/Mf9Vn7SAOyeg
	ptgxLA/pqApkUFACNQ/M0/diONwF0UdL/gKDfaFmb1h1WdQUHIaQ0s5Lm0HEuQMBJpGg6sDgVJQ
	+cQ0jXSBl9moRFUUnKjSqhyiX5CK0GCnFb8GfOx+2GQxzj4w4UaUciOSBkRuxZGeLMIfTxOAKKP
	4k4IYxlhLGgqkhO3/JIKnO3zaXfaG0wJqPeOBOEpqO7+7lF5xyEAWvqs0pgRQWNhDJIx7XY0P+j
	pIjS+CTg6RbND4rA7ymlICc1WP9iHbMCyRovwlvYiE/BfJ85iyiGlRG/gG0C0fXYw/3gszo1eVA
	UTNZq8lUPjcM=
X-Google-Smtp-Source: AGHT+IE/qY9aAKQmWdzpYQlP9HqBpbBqhuFIYDUB8Q8Ee1l43WimZvBDhx75rwg4/X6t6kRWcupvFw==
X-Received: by 2002:a05:6000:4013:b0:38a:88ac:ee69 with SMTP id ffacd0b85a97d-38da53ab53dmr3527394f8f.13.1738692201956;
        Tue, 04 Feb 2025 10:03:21 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ecd6sm202687235e9.28.2025.02.04.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:03:21 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	broonie@kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-hwmon@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: aspeed: sbp1: Update for ir38640
Date: Tue,  4 Feb 2025 23:33:04 +0530
Message-ID: <20250204180306.2755444-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250204180306.2755444-1-naresh.solanki@9elements.com>
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
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

Update node to align with infineon,ir38060.yaml

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
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


