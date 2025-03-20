Return-Path: <linux-aspeed+bounces-1084-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED20C35FFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTsG3Zfcz305D;
	Fri, 21 Mar 2025 02:24:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484290;
	cv=none; b=n0H0hi4JWQIOi66j2m6XNeE97htaITDgtm2LlFx8XBXSk4JPOxHhsdrgexDf2XDWBolcD4ZzJ5FV5lhSQDPoQXIa5QZ5Dh3LkSyZWqxEuNy1GQCHS5CMrLNuNmRkdpxa7mEUr04qAlBVOagtX7XDsAEhkdlQr9I6cfYwwhls0xYho+W0wwRlYwkapvXLd2baz11QGwqCKH830X/ACYLuyX5HVXtOthRSah42YGVOZvmg6VJkai8vFFhAxtYl5+10koIQwVIUohRb/kt0Sy+gUm6xNoQBCGv6BWQxYBhVPnyOGMlk8fTZsgKw2a7dSfWY+FHkTuqKfOePneuhy2eJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484290; c=relaxed/relaxed;
	bh=sUfisYcWp0a9uSKCTzhEOlOpswYrDKtyklCDtr9oI7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pc52R1RGCMJvlFbmYpIVkVKGMDYonV5cJ58WVWat1j9d1TGlqOnCsMvNMO69b8VGptG5S0ReDhf0UPi2yNaRY1Z9uLTi9Om3puDFzhCzVhBl57CqzloSNca1o7kAPlo47KmLQ5WaEVMaRtn1GTjoF1yCjYOZ01Aht8eYjQcionkEI24lJAuhzMG3HadVWblb13tJqsgeyWBTfKk2RkCbhv7sYN6+D3I6nwJgiaKBuUwrI/OgQJ6lQDN1FPl1vvM2EfcRlmoxTZnBEFqDxIG6MxgB/+N/fxD7u/oB37UI4aFfCBGai9c7xojByOPJGwePy3arKBdnmSKPGOWtMvtNgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BTzDtHm8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BTzDtHm8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTsF2Schz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:49 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2235189adaeso18915795ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484287; x=1743089087; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUfisYcWp0a9uSKCTzhEOlOpswYrDKtyklCDtr9oI7U=;
        b=BTzDtHm8XBl6ZUp/pcZU0Jksk/zEfdX7PNyFCcSyc8EdUVn9x7/vxAUN3Oha6KUK0r
         D3sxubCNwh4gE9hvnhyqkQlQiLjciKIdOEZIozyZlJ45WJSl3MVb19EJo4METx+esTTJ
         6yc4XgZcsETjgD4RDPP5qF5r0gZZtMhwm3z3YVV2LIzzUFd9o0weY4oDtuXDn7GfdbwX
         aiIOXhbu4lngMLSp+V9eOjgSF3t3792z/YTLNIExhEoSXrj1S+8RfzeRH7lcxpjNkZx3
         3FK5C+DjI3IIrONlqJkTuPveYVB6rJQtZGEZt7pg9N2a/KYWLYkbfyWPb9w+UPwj5guC
         VDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484287; x=1743089087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUfisYcWp0a9uSKCTzhEOlOpswYrDKtyklCDtr9oI7U=;
        b=EXwbHNlD6Y0uKf8oXfwZehYF1RSc2LJkJ3gyq8cm24EYjUI3cesNOdC0VmCi5dHZhH
         yDJWwYzXu4RHZyKNPivkDlD5QvdH3eh6k6ZOBR2fSU2bESHflImB4lrzFMOlkhOuv226
         kpCfNW9kosP7Ul2k5I/gXm5O4fMwQ2AIWuxDhiXPfPINK5p8nZoqqwzmlRXFXi8Hdenb
         1Rqr7WUcV2z9RcTJqeICD+SrtPPuC/cX7fIC4a2lxo+gAJNE/Wf6lL2HEvaAX0ESTj/t
         Kcfpj+HvFagcshh98t+Q8O6l/ch2HSr5LE8rvzMf5vT3IE59okYaSWFR15F8L69ki+MP
         38xw==
X-Forwarded-Encrypted: i=1; AJvYcCWRJe01bJGTsNRz2RGj+vSrmojILkLwuRocZ60wM/SToRSrH/e+dlPwaj/X/deQOh6Q+6UnnGKOygIcGw0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNCsHLvlylilH9q4MNq5PU2lwlL7mX+WSZQ1T7b0iLFMpBl+6P
	XVR1Qm3qfXlEhGX943Jh52Cn+jFJkDr1V2gLA97HGrvCCBTPSYGQ
X-Gm-Gg: ASbGnctINr0D3W/7zR7NjevrBBv3yUM9glOFJl2riSvd7v9YD9TbtZC++ds5H1OmOJj
	ub81LJQY1TLnMZLTt3cA+zRyX5ul+vnYtp/S4WsBgR1XxnRW+4ZmPaFdYZeOtgI8CvI3RCazwac
	iCyaCs4Ua29zS1cVhGssYqTY35xdZoedXa0uErCIIMq4QQvw7RDFX0VDQi/CZolwFoKRK+Nv2LG
	ByEOkWLI+lKIt3rL5tbjtbq2wbrVA3RlwJTU+SVutTJ1AIOEYkABWbWjC/yH8e6ZmYYJE97U7sP
	V7ac2hiMnu8+OHVCsKnYSELEnGm/6zkzZIEuQgw8Ws340FHG9pgLk/09AU/e8j7kOGbKvz0mJR1
	8NqHeCbgOE6KCgBUvlT6yGQ==
X-Google-Smtp-Source: AGHT+IEhD+AwDbS1bWQ1xV8+/CAKiat6otvbsanGzMCX+jMw60SVH48Jml3Jk1BukssYExoZ1JfSjA==
X-Received: by 2002:a17:903:1a27:b0:21f:98fc:8414 with SMTP id d9443c01a7336-2265e7c2830mr65399575ad.26.1742484287128;
        Thu, 20 Mar 2025 08:24:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:57 +0800
Subject: [PATCH v5 07/10] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-7-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2083;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=QdPjNftOZyhcrxaBENJ2ZcCMQ0d2Elbpse3JT06Zbt8=;
 b=ahiqRaLzLCuBq51XXJGrLe1R+4sfoCcFv/8CoxoOuZot1U3ktNGhpx9+KLCyQx04a92RUgyp5
 LimJ83PUITOBAM65OVPGU6vgHp/CdOyT0QXMr9zq1HR18oRBnRzLvxr
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove INA238 and INA230 power sensor nodes from the device tree (DTS) due
to incompatibility with the second-source ISL28022, which shares the same
I2C address.

Move the driver probe to userspace to handle sensor dynamically.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 45 ----------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index cf8a31b50074..1e1bcc9ac2f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -432,35 +432,11 @@ power-sensor@22 {
 				compatible = "mps,mp5990";
 				reg = <0x22>;
 			};
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
-			};
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
@@ -753,27 +729,6 @@ i2c5mux0ch7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-
-			power-sensor@40 {
-				compatible = "ti,ina230";
-				reg = <0x40>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@41 {
-				compatible = "ti,ina230";
-				reg = <0x41>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina230";
-				reg = <0x44>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@45 {
-				compatible = "ti,ina230";
-				reg = <0x45>;
-				shunt-resistor = <2000>;
-			};
 		};
 	};
 };

-- 
2.31.1


