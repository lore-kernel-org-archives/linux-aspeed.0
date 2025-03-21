Return-Path: <linux-aspeed+bounces-1106-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C71C36000
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFM3wYyz30NY;
	Fri, 21 Mar 2025 18:28:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542119;
	cv=none; b=D+lKwsOOvIVLIk8oM2jYm3GxrjVVbK2GG75guHiP+Twd77FIDmGXBhX2s4/bs0RsZIrBVTIVezHj7ZyAENEorqRe/e2AAjvxXItZU1sGL6n++FK12xRye6CoqnT5gvbA27vlfzsv04HsdpiMc4oOdYb8DVcQ8VsPzgumsdq400fKdbcglCKExLEyTgpDOV24HMmZ5uB9fNdIfjhSmR3ydUo2uWN3mOzfOvgqFA4jP9K4snW5d+vvjM57FaTUjNwFGLv/75vaZX0WzMn+ClYcPv2P+AjDFKgjhSHsU0nKLLLGwA1pgXwbMFMhCImkrbTdfVa/ULmHGPmGJUSFefuDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542119; c=relaxed/relaxed;
	bh=ZKGzggxqR/JI7t8XueEDBWptW6/F6u3t8TVX1C7g4ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSud44wz7WYUF4VdoDAglBiXjT22WB5HvsMgI4vPAG0HgywCUReg2yheSXo6La24nO4ewL5eNaAhPYxpnfb6XT644d9lUQ3YdxmCDBPiX5wNy4nL81Wpc81FbOwaJoxC3uZcKoQgDbNN98U6G6k4GU+xf7WbU92CK8mn5pWhofBaboY4Z7TS7vsgxUwKqbLbCnc1CbQ98I3KDSzKYiSpcHUsrrCX01AEaM7yAKPn0yZBQG7dKkCqFROyvHVKdJN62vOkmnu8/ZaOmwxTFcXDFjjzadwvGDxa1R0Ac10QX13V6dZcPjUp2bV7H0XfisytsUyQB6d/XGgGeaSeliKzeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HWwAUV2g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HWwAUV2g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFL5wfQz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:38 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-22423adf751so32868305ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542117; x=1743146917; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKGzggxqR/JI7t8XueEDBWptW6/F6u3t8TVX1C7g4ps=;
        b=HWwAUV2gjJYRP9DwOrOAkDTUjr6c1WDRcCqS6lDyndkfrt82Q36BZHbf4KzFG0ARJ5
         9fSI2IMFu93pJnMBSL0EZzA1loz3dMYAQ3ChPoOatfblFcIYpg1rKsz0eQ7LPirHySu/
         Ek09xYkoCMK3SP4Q6ihq0YQ05oR1yKxWN9oiG1f4tdBdTZNY6VuAd3pC/Bufp/wyCmfF
         ogiLzmNa6Dvfh4jCIUp2mstOWU/ihDbPNCnZFlmsAd/FfKkGNFnLxTqc/DhWfPqVCMrY
         rwstX26ckiimJcsmd1f0cOwg7ccerXgOFQP7xSnE+YnotqQJSni/wRTR3UfqVGE5sbrr
         2lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542117; x=1743146917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKGzggxqR/JI7t8XueEDBWptW6/F6u3t8TVX1C7g4ps=;
        b=Kv0lrQXWZ7DXPWk+Aurc2f/sLXH7U1XK66+2yiOh0b5+hrQCmyeDL92HVdKSMAPDnv
         /KMl18oinhKssr24QnaL7gWIHcF8bi+4+OzwmfxQ6diG80hmCspuqHQBRyhh/Xwi2W/4
         cmAPRX59nLylrGm8rlywM5/fzLen1apeFh+I1YMQ/zFllaK4QKW76TMwRRBr8IZ8+/El
         u89jYBK23MgFE295Z/nBKeO2o0/IpC9rQAuvCOwNW4ng9dGHZ10jx8m+46Z+feEuwf+x
         xZdyRGseQktzPUJLepUNWBXEUA5FVZA6l/GslRf/SmDg2zvlsHy3XSCc0R0uzDcHbUOO
         pGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw28kOaNuI9kOF95FUnffSYG9u1+jUg1Fx8hAAn0J8ZJM6foTQcguB+sMZb90qCEVjoMux/2o2dPt69mU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyk7Mlmjk3iSo9+guzvxQdO8rEtg3gerczuyDqNW5rFMehRFysC
	b9wIRGFYjl0dVvFl/k4nBfWFYpABuZuNCxjuHr5qdYGyf0aueeex5wmD4w==
X-Gm-Gg: ASbGncvLpVPSsl20aY4VX+ySz0HHBW23zCvh8InrEekCFHfuhZGmQymDWmQMluPvfPf
	ghIZfYQWKnv09skX/GpBT/ofvzVExjCdTTspwlPxQiY9lWl48qae+fvmSL7FbDo37qQEnymVke8
	T6peyl9Q6+QHSbIiArZGwFCgk8pOIsxzBV/877DslR9AhiN1q2JnU5M0Ej9m1QsG2MA24R0fcRu
	ePssSm1CI2VhUdcRpdJXxI3hXAPyf1bODQp8FEXf96kKCDONRxlAJO+mUcFyyHPQHB3HWAap105
	tIeEkPB78ee9XuOUq1lZInbPI5R4J+YhXB/7H8aJlFK52mjl+zMIcMFINhhj8p2D2iD9EOJjhsD
	4RpMqnyKZjnKph0L+kcsBjA==
X-Google-Smtp-Source: AGHT+IG4Ey9POVcNaA5EGYOeSpcSkXZH34RORqBkMDNOebesXmi/pjhykauo5+xRwD9ve+EX6szv5w==
X-Received: by 2002:a17:902:ef49:b0:224:24d3:60f4 with SMTP id d9443c01a7336-22780c786c8mr40390675ad.15.1742542116766;
        Fri, 21 Mar 2025 00:28:36 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:36 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:05 +0800
Subject: [PATCH v6 04/10] ARM: dts: aspeed: catalina: Add fan controller
 support
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-4-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1059;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ulbtp+kTE7qMNV9lUn4Tys8j+TjW1Jo7Lvsg5SrWzbM=;
 b=JffdhqzDNi+p7Ljhq9yTdsOYOGNKOk8fYUlvKqY8GbPQyJNDTlH0oW4aQKk2VDjnBCxsfBLX0
 xEZpBXbA+R3DaTWCTvQUw+39xUt7EswRSzrHKgKWxD6u5I2ABVAvK4q
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f5f47245796a..792b739b1103 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -466,6 +466,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			fanctl0: fan-controller@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			fanctl1: fan-controller@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


