Return-Path: <linux-aspeed+bounces-1082-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E144C35FFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTs80GP3z3055;
	Fri, 21 Mar 2025 02:24:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484283;
	cv=none; b=mbRR9n901YiZ/pbR3o0xYyDnufhpZZlxyZseEh9MMDeVKbz0ye5JOEp92zQa74zbdsBY3EuIpmGx9o+wWCrUhLp5Nih4x3Da7Wm4spBCev4z9CM3CvN0joXDhlML1CkJyAUEt/p9BbeXgZi9Zvmdb3kvr1Nd5EdNTrFa9tCMyE0hr83aZzwA4S5FWt8rRNiSu8WLuUeCN32qeeKc6P0UOA26l6LjR61dXHXDvgMQ+plbBFiLUph26EHtNJrCb0Px7CIE14bxm0inHtczuC4oqc/QCng8UVJOSPoHxTAHRvaINo1wU7erP5pqL65S/EKb0ADwoPK48oNUlmbo1YCfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484283; c=relaxed/relaxed;
	bh=HhPGWpSJf4aEvLnPhTJquxIyNv0KK5Phy3xNH0kC5O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GESoo2KH+FYfrp1/oqRlNIGZMlbLO/eIKYkbwhz8H4xfIUAkDYKSD8fdYv0vGBLojzNl9R6WZhI4kWKyfN3cvo9Qgdc05jU4FXfSWgaWKUkCpTlyy0VVdgP5nbMa1w18wRTZxHhJB9cfuOOe9tR1m+Ecyjok3DeyXZuCNUxlYS940z8wlWU6Wlkvte0reSzZ0YHqMoxyecb+1QeCWPio7610iuhZ8WLx6t6YtBtRgB4m7pYMydgSifu1k9FVbzjaoL0ecaYaVFxy++YlbN8/CK+uikngMTDzgDNdSkz+m0cRys/BeTzU7wMhCgr+/T5RFW1Zh4/eezqWwV9bR29LaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dZWKRiG0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dZWKRiG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTs73Srnz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:43 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-225a28a511eso20993495ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484282; x=1743089082; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhPGWpSJf4aEvLnPhTJquxIyNv0KK5Phy3xNH0kC5O0=;
        b=dZWKRiG0OW5IjQfezFBh0GF3HaNUPHeyeVgbe3KDlEh9w1oHCn3nehlzIZR92gZfAU
         ZC1AYahdkPTxcxjR2PPkHwnW2XC3oImlClXoinz5Mdk/lMD+95jFXfh+2+lJEPWPLMRF
         dCo4T+tH7itHM7pRBVimCHPGYujvYy58gJ6FpEY1NK6GUSDhp6CpCPaGiUwdu6rBdHq0
         3O15do9U+1/9nqiULCNseLKuZo8RgTJbLiCQAuKo1ncMC1EGKoS7a7fgYMDNryAjbcmA
         GjPaqO3lOLCEzAccnd8mHPAs+kH6OAmC0ze4TwT/i8f4gCuf8zmg2OAYzptdTmBoeCw8
         PVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484282; x=1743089082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhPGWpSJf4aEvLnPhTJquxIyNv0KK5Phy3xNH0kC5O0=;
        b=VFfY0a+aQId17/2FjcMYpuUJ4wHJ7C45vcLPVFa9NSJzB/cFry3hQSgj074bKIMCGg
         5awCGaniAY9k+oO+TSB0xhyB9DTkGuwwbGToL9V6WMKM8SzrH5jtJ68dQE3b0PlIJVzC
         +/z++jdMu2/DeCIgh0o92ze3nwadPtC+z9OlCC90LWucNTVP2yKq9eNcH7AHaqkPV4Ji
         zfskP1y8XYz4vpBZyrvo71L3/XbSIUh8Xg7vecilRL9awI8C2VXd7XbmhIkr4/mhCd7a
         rjxaKwKwyxUW8heG9EA49YWcVw6b9HC4acI196yJogCrJaEDsmbw7qU2sD3D87xl8WC9
         8Oew==
X-Forwarded-Encrypted: i=1; AJvYcCUYZJ/fG3da4nCTddT2tPpMFYNQ+K6gdEFQKK8THDyYSS/1B/E8n9mnmQm0a03EcEuvEcB3tzhHeu+DwuY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6K8wBjTjcVCAwVoT434cpQ801yBl754abkYBzMCtkW+8/kYdT
	+uV7VPrwDGDNjUv/xdLnBK5AQbbNH9eL03YkZ12PMeMxbKKplssJ
X-Gm-Gg: ASbGncv/Jq3gvpmcqs96fllPrPz4pYXbfLgOVWEs6VzlhejuCHPEbWBgwbd09uxDrZ0
	KaY0M3sLAROld3lD3pqI75nGhhcNqr9jiD8vZbHEa7W6/iMJ11wCKRdY41MuhxAVd5tD+r5YiHk
	tSsl97UIYSikK0cCb0NGzcV09ImW1kxRyrIGBJq7cpmiNQGKTQXA8CtTuX+b/0TkyqBmwyQajR4
	7Nf+O2A2ig6haCdp35hApk/RCdeyxh4Utk0EqmnfK2/IBj4cLXs8mD9DnjlRokzq8QPmomxDnpG
	v7FUpNjPxaSXWYrSeisS9f2rIedKQHZRVc/gFazSyN/s7/uu736j8niY0ocoiaUBLvv1BRqq2Hj
	hjPZaK/ndBLG6fw89Jj/6yHiftu1vI3M0
X-Google-Smtp-Source: AGHT+IGkYoRpTwvX0SPQrV2WZJvZ/92oS7+7U7y4cTjAdvt5uiAV4eA9Zp8uehwfG/gclRTVojzHSg==
X-Received: by 2002:a17:902:cf07:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22649928472mr115859395ad.9.1742484281811;
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:55 +0800
Subject: [PATCH v5 05/10] ARM: dts: aspeed: catalina: Add second source fan
 controller support
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-5-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2445;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=zyB2uaDDv1BAG0YqbiEdmRLnG2B1bXVWmRwVAs+kqS8=;
 b=yaNv8/tBD1Dp9LskMzc98/pZcRkIlWncgoAtHa/Wg9TwNWL4CEXyC5gYPtOviqhsSEpoBkEsx
 4B7gSQTFjQDDSpT4l2vBGBkj0T+OQloWQevOabCyJnZBfpDX4KalonZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fd22add90449..9cbb296dcd9e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -467,6 +467,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
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
 			pwm@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1


