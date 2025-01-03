Return-Path: <linux-aspeed+bounces-315-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1944E77188
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Jan 2025 01:44:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPRGH1mC6z301N;
	Fri,  3 Jan 2025 12:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735868695;
	cv=none; b=SBqGt2onH5oHkQx84Fv9ZAOWOkKrP886D1kZBezHgwEfJuTIM5+/f4NMfdnL2G6MBmtA/h52NFndcmYHqjerLQtpbUBnb1myyJw7kuIEOC9+EZ9xCqxT4wJ0jGdz6ejdRhLusMR8eZgYgYtnwCRe8FZOytjVTXj+MwcSbgMP2zSIlJSGvj3HcDzKej8Tk4nQTtNoPm++dLe9o3GuSo4djhpGIolP2vjwcoNpEApq9vaQ8yK5m+pf9czArVWMjk+xdU0W8dTwoK6b9i31E+71Fs+qw72vcVE7vOSTaEFZdDaogII5Qp38dBtAkW8hKktwpwNPQ0988IWuqSPeh9Hg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735868695; c=relaxed/relaxed;
	bh=k2Cl0qLA6Zse6X1mOHGAIPpGxF7+VgglAz9fd0zm31c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZopezTyQbtSGsXuyl5H/TRj30t4DsN+E0c1lfkSgIlPrAL0UZ32O+spIQ64Y/gz/Vn+11Ue+R0acZcLCccyMa5fmYRjQ9Q4bL/MCQc2XiCC6oNZZlJJdhwbBZi5PZpyetNiXfejFJTsTrFhKz+0xwqbK+PsczAkv4J9yYllIqG71gDsdEeEKkgnPhjD1SVdVc9SBNIn1zixbYQk4WX8N2hCojvRcGan5tUnkZtFuVoKY888JXAwedTaDlkdveV4yXNNS9nx5ftZxqiZMJzqOIpmp67s3msSJZAmeHAg09Q2EgBwRX2/x6q4ynM5JwSk6hgI435uYqYzVQ4vED9BwAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dk7VJzdB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dk7VJzdB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPRGF6gGXz2xxt
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Jan 2025 12:44:52 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2efded08c79so12926481a91.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Jan 2025 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735868688; x=1736473488; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2Cl0qLA6Zse6X1mOHGAIPpGxF7+VgglAz9fd0zm31c=;
        b=Dk7VJzdBw1UZRrP5OvDQLrQ5oJtNf6ZIE+TFZxAiG3lnWVLrg44tbcinLGrtd7zkLS
         Xzckz6kH1PLUstS1K7QhAxPnr1+ggux9NnfkaKdKStFfXO3hfyoSwl9UFo7ghhMNlQ5d
         A3HubJFJOIg4J798y+tyfLPTPwR07dW1NcQgE5aHG5y1zc+QGxDIwHMGnRHdS0o4GWeM
         pSFUnOVWyAfJu5YerIZ6MaqwG4FkyXulXRb19EDOm7iSwR+u+Zy9EcAoa5W8uIPgwk2Q
         FfC9qj66BUVG4/w5nO+LO5uH2P7nvbY4vSRWPX+EjK+jF2tKrdLrlk9F80CWm0Rmcesh
         1hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735868688; x=1736473488;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2Cl0qLA6Zse6X1mOHGAIPpGxF7+VgglAz9fd0zm31c=;
        b=h30N3A1BkGgyeoVfCw+F0XtQsn9WMa61wAY1hjVi+Fvbw+bhYrf+DTdAXlob7RGxUt
         Z40XSTp4oS0iAdmGviACjx5lBWLSFM/C5ZJQHsn0SFT80sq5BdAY1cplKKibljdQOkDx
         6t7e7BmLMoAx17mOheZ3qB7joieSxQqcZN+1iqTdmuVlR3YLh9WWIpnbFJT7wfew65Z3
         3jYbkHJs5MCZ7ZgWAjKOlxNiRR2ffkpX45hq9cS38CHjUNdXhZk7MQVIhuXjiI7xFeWd
         o1+ASh7Ol3uIO96uG993lBdxq3ypsc6sPkyW2BAoGIlO044uHieuR9KPNYtyg7ClmgjW
         MVFg==
X-Forwarded-Encrypted: i=1; AJvYcCWGZkaGbyl6vlhna+6F19dSNGiPd8uez6TTYalj18lySVRvsnXlKVmd0zGM7N871sorwKB+rUoViIeruLI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz88GIP26M/ixHUD/DTAMgU55HxN8p2ZzKJZWCQujM2DjVSLDMv
	Rh+0NUSfGlsowUL2tnLVVDnkF3lTNfY2vqq6XtBd4HCX9Q2I+gjI
X-Gm-Gg: ASbGncvL7RVoDIVQ91S5SqqQFT6dHiqgK9mX0n3GRrooh8P6vrZcBF4HB41Yhxozd37
	53/TDjnXME4A2TowjXHsiKp/dSJA4h1l6RxnGNvDgYPsOT6DkSceeIZc0gmVvTStDNfym3E+3yw
	/YP3Ht0su+RDNO7q9cwYgVSf4q7PyGDys7Jo6VEJ1CAz1v6L8HPqPcG79Ymp9v1/B+Kc1wwyCPr
	c2IiQYR9Q4IgmAwmGn03DNbxtrWdw+aL1fdEfUkiAuArBIAoyN10RcCgud4mA9QSnwTIPhcucmg
	Gi+zsD916Mr9TH7qevoYtBDD0OGm/H/qhg==
X-Google-Smtp-Source: AGHT+IE+4fM40xvU28AzvOJIq0548U2gC/Q8aDCSFhqHoK9P+D4GoUQlU1aKGPee55+jqzqjHIgWuQ==
X-Received: by 2002:a17:90b:5244:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f452ed6a0dmr61484494a91.31.1735868688516;
        Thu, 02 Jan 2025 17:44:48 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02f8asm234551495ad.279.2025.01.02.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:44:48 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 03 Jan 2025 09:42:31 +0800
Subject: [PATCH] ARM: dts: aspeed: catalina: update catalina dts file
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
Message-Id: <20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIZAd2cC/z2NQQrDIBAAvxL23AUVW0i+EnJY47ZZCCpqQyH49
 0oOOQ4MMycUzsIFpuGEzIcUiaGDfgywbhQ+jOI7g1HmqbQymGKVgCtV2iUQ+lrwmzxVxlsZtXX
 qRdZ5R9BDKfNbftdkXlr7A1Frn790AAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735868686; l=5772;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EWxIpZVzkObHrj3L3XnSjp1bXarY9ieZwL9MOGdfNcQ=;
 b=xLRs8zCBojbAOqgKdmTqa8vcJFMyCMitfwkdSmBkpFbK3jD0OBzbcb/9meKzqok8jfEm2f9Wa
 ILsB5P38XJWAMc9AP5VGhAC2QxyTvQ5tYWHwFeC/7JfPlT0FD4DTMHG
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update device nodes list below for driver binding.

- Add IOB NIC thermal nodes (TMP421)
  - 24-001f, 26-001f, 36-001f, 38-001f
- Add FIO Remote thermal node (TMP75)
  - 23-001f
- Add Power sensor node (MP5990)
  - 16-0022
- Add main source fan controllers (MAX31790)
  - 18-0021, 18-0027
- Add 2nd source fan controllers (NCT7363)
  - 18-0001, 18-0002
- Add 2nd source HSC nodes (XDP710)
  - 20-0013, 20-001c
- Remove all ina238 nodes, move to userspace
  - 16-0041, 16-0042, 16-0044, 17-0041, 17-0043

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Updating the catalina system device nodes in dts file.
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


