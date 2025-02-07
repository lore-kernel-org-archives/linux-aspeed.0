Return-Path: <linux-aspeed+bounces-686-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB7EC0219C
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Feb 2025 13:28:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YqFD04n9cz2yh2;
	Sat,  8 Feb 2025 00:28:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738934912;
	cv=none; b=Y5HlL5fR0ghfofzftM/q80nPR6isDMWvCmGBS0OyIYl9ZMMEOBGuOjro0K72/UoGGac4CWd7r3yiLDLYGb0OxzU2VMYoE5Ksq4adfpZ4mHOMJzqJW+TgHymSRzdYFTKyxHEDhBGVBtj3FVJ3P8xjAxKiGYlA2QAxLWY3T+fp5TgJYcJy24473IhVTxRy5a0zKiJ5mz6Retya3r71QJgRHD/HVW1eByxqFwOpj16BILbjPMyk4G4rw2mO+hYYpAjhJoH5Zux9HjCd9mhCL8W156bt7opffiKSHT32vn6V+mHJ6NcdT8f6Po+FEUBqc7cEoMqnkTsiCBVu8qi3fNSrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738934912; c=relaxed/relaxed;
	bh=Ljes7wHzysMxiQ2RSq6rzU3Ys17WdodOahX8+S3+D3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTREnFUALE2/po3/0cUUSdmpdnymGCu7N/J8BdoyY4Wys9FhbUvv1jjih/XF8pFbepdbeOetcvArJUM+8aOHKuTksazneJ0SmdG095FHa8UqZiL5GF53FJy8MWZAJCsrUUK6COo55QDL8qrtvn8nO4r876VkKBjYlTudeRer8kx0rfK6Pp78R+mAHxOHLJAJPz0yQhK8yDD2e2tFSYQTVDFr3lb7Q7HgPgtmZh8SPkQ/xHTpbh5Tie6TlkAxzQz/HIBQuZPW4qN2/ZTaJO6QyRivhv6XvpfrWTpkuf9leNuv4JFtWMynpQVxzs2ufjlm0n7RGgJpzZZ/goJEcJ+2LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bVQEN07C; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bVQEN07C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YqFCy5YxMz2y8X
	for <linux-aspeed@lists.ozlabs.org>; Sat,  8 Feb 2025 00:28:29 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-43690d4605dso14234845e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Feb 2025 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1738934904; x=1739539704; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljes7wHzysMxiQ2RSq6rzU3Ys17WdodOahX8+S3+D3w=;
        b=bVQEN07CrI2PgP04+7pt70oHNcPL/uFbzf4Aphmycae/GLzZ4JpNrrRyPE4jCJBTjI
         h38yGgh2CBJXG/qUwds0cjAGd/Hh6Enzuk0CiBLK3u90gVXafpz5Higs31GZ02Ht/RQi
         wNf9eiERSdBj4R0s5uX/M5OZh9+PMLVmp5r65LazgUFSevBanrxCaH8M4BluTkx2QPSh
         /JqTJaVeGEygocyuJUXi9oS9zckmiQ41YgLV/AFo1Lisz1KDkyQ4u4NTEtrELD/rMR0L
         A/TfluxqqxETnbi3LAFSUvkLXpDYhO7HiYcywPpCRJ9VZ5s4Lj/o+lWfK+ArYTazO90Z
         lB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738934904; x=1739539704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ljes7wHzysMxiQ2RSq6rzU3Ys17WdodOahX8+S3+D3w=;
        b=VgnKLjbNQGQUyfbvSSgak0cIJWU9eC3sNRqpmorDSpf6K2BpWJgToJ4ONbTsvdde3v
         3mWCJ+dR6gFr8b6ib+TnKjVFlMTxbvfDGjnH90oaRM0Do8Uuk7QfKv0sicYT5Ya6OS96
         E04jWPT3mkHzgrUe9tmM10zbkKRbjsgliGymR8LGz0D4pyeDrD7vqxg5LtfKVCF2ma+Z
         yPAYnkpwfQnBnyyuYbEWsL+X7CnxaNEQ90BjFncilg9RyVkZk2FybPmI6sftmXtE44su
         bswHtr98FaHgq89qYdmEFRjW9+XlUoFABQlEIiyilcxWm3aoqbyMjlPF4XRmo/Tgv1rt
         byWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmA4rLy53HzbmXHh/QYIK2MjGDmfyd0IhXgJLQ6S88V4gBcWNC5Lr+hPvouTejXuC6vaq1DzsxoPIBWPo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxtm9/vvdhQ5nOWMNGbI+CQVC9NccdpTjFPbEkSJ9la0TT6vJE7
	7/qB7f3Kd1Ck2dyN35lPkEyfZ45SS/cSzyQB7GwvJGHB4IfhP+fcKTRozo9NFm0=
X-Gm-Gg: ASbGncuuroayPgON8cX7DF7YGfdNUwuipHxHwZaYwxENldU3vNqSmye1kzrC0yn8DzG
	ZomPSf7zh8Uaq3XYEJ8v+JuDef+FjkDGvNDxKmErJV1WOqf9bruSGzvuDhwp/Xa5JC7bOjpJ670
	nlHf4vF/g5wRlvZqRkbSwaZZbznwT9bZ6eIsPlc2aQEajMtRUAudtjAgTbN2NPldkdBgkgC88tR
	6beszYxwgrZ3+xdL7taGwBVzLJHFIf/r/s4pwm3VMQgOfNfobvslXXdg7tjaMRAUYDCBIp4YAzk
	kH9FwYEQWxgcgyyIAsxkNXWushH/ojrwJL9fTXDD89dOh/MgmUB7k55C3m21yvaX8is39i/VtFR
	/XZv4/293IjM=
X-Google-Smtp-Source: AGHT+IGB4XJKYpEGae7tPR5GuQ2osyg0LoIfkHVlKh5g+8ClsDOeUgh83BithY47hmF8ctYqNIpOjw==
X-Received: by 2002:a05:600c:4e55:b0:434:a7f1:6545 with SMTP id 5b1f17b1804b1-439249c384fmr25835735e9.27.1738934903804;
        Fri, 07 Feb 2025 05:28:23 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc6b89ef5sm2641562f8f.31.2025.02.07.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:28:23 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	broonie@kernel.org,
	conor@kernel.org,
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
Subject: [PATCH 2/2] ARM: dts: aspeed: sbp1: Align regulator node with Infineon ir38060
Date: Fri,  7 Feb 2025 18:58:04 +0530
Message-ID: <20250207132806.3113268-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250207132806.3113268-1-naresh.solanki@9elements.com>
References: <20250207132806.3113268-1-naresh.solanki@9elements.com>
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

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Changes in V2:
1. Update commit message
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


