Return-Path: <linux-aspeed+bounces-3448-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1486D172A9
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V46bzLz2yQj;
	Mon, 02 Feb 2026 09:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761224;
	cv=none; b=A1Z159QTB4fmPOJ8p3Hm7c3M/E/5T5lu/kk46ryK5jvDj02nS42yuPNNOroMgtCseJ7kTHgkeuSRLQENrYWmKheZ4UGWZSS6rAF875tddTh/T8ywhMnGflx2N9Zq+EbLU9DTHqtF5EabSZdvVec05u6lVgaDT4sNcX6DZCWNc3bd0KgPpkkSs9/Jzq/0496Px3vJ/H3ion5xrM03w+WTFUfOuT6tbRei+Bud2U4uvaR30BuCDKGMYFPefVATpnAcwhFcFwe63a4ggrehofLxshlctsUCKS3AM1Fx1KGinsB+liw4ZF/SmVNQI8dP1XNcBzzSgwLTZbXlDW/t5qVRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761224; c=relaxed/relaxed;
	bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KayiR/VIfXFWZ7bVK3d9RU0ITFv6f4WJLk6R+nB13GG5YWrQfNySsynhXr0T6mi6RjymEQXq3d9CH6F2Ciyj7bozIN08IT5qfcbKYY25WdflnPLX+/gDBQp5REtQjmuGDgVkFHYl9Qls5apxO+W1nmiiI5+Mod3/7d6Bn2L1e3+avf/Q6ttHE7fMGhxPOaAYlIipb2s0LZD6wEDHVZ5hiWjMGpT4QB0HRRuWzvw6ic8bQZocpJ9A+L+vOhoww7boJiQaMW5OMdTGU84+uM5U8HGpTss4m2fEL8MhfmZCJIgaKiWbHrStZlMsm2FcwasQqzA4sKuWpnf5jca/vs45eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SS9E8HQc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SS9E8HQc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTg2qzlz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:23 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1071272b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761221; x=1770366021; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
        b=SS9E8HQcw+n73xWl/pUKxLQO3UBX1B6X0qv+dXyTFKzXOugekkil5TlRQ02MpqlcdW
         0Zr0n+f+ZLRbbPxI1BVqugewcNFhhjCok2BMB33OC+3YeMSCxCHkc+kH1BreIR6llGeS
         imFhg16QOlj6o9XgwhVzStKHGNppfTRT5c7x+tfrBzio/fvtfHfAbfRKNQdRHsonBdb5
         xxYZh4KuMA8HbflGoy+Q5VFmqF1rkJZygmGl3ZYybOtxZyZmoFueIE+2+TCAIIWVNXwB
         GbUFUZ6+WEBXgNU7ItL/W31TgFvF7j/YNX0bPLD+UWEREv9vZvVvsaMJzog90i1oAIiU
         ofog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761221; x=1770366021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
        b=L3RS7x48tJjuXncALkAdXdnF5O7bz2PgpykBmZfwHybuiEg8YBOJrowAILacjBi5Sl
         HoXzTQti7vTGMWPrfNg5LEBCF9aIBO1Tv7jaoRvJnwoM/J2AXrAjCdqihiGQR5iH5Qi/
         FWUuZbKT42moQ0WDZR9qoEiGPaeWgwYynf6LxMIcA04bljIKIazUYUwXX1wcOZK/9yTu
         I7aw1hiNIhqAewsScTpDuWQvIL8pvnbJGkh0cgDdErNVpIwI2BulyGO8Ue6I1NKu/lEg
         NiIo/gf31an5VepyLgbt/iZnMmoZZh97Wt6e5/Z33wWd+lv4zgkgHYpnSP18Q3E6JPwy
         cyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFcgH5GgVCTK10ud7I2/m9Y+W4Uh32mWdf/1oj0JyxO+eo3xqK9yHH1L0aZyBXx7VFLpARCzmrolDz3xo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoqGIDLQMx60rwEix1cmkHReXI8yFvWSeqDKwpPlRDFV5kCsGR
	+RsflxRXPUf8P6dmX6FnZEAiVQyt3BzgyjDN3H8TUIhn0tzR0htaiMMu
X-Gm-Gg: AZuq6aILQ4iIbQukpsNECDVn7zhsIxmYZPrjw7jYaK1wL/v/EmkfQfNlI/9csvJnHyi
	by6zDzVof8+RSuLG3fs/extJi0tzMZHIAKzc/BlIjpLY0g/A7zDadlXHOPcKYPw3XU4cjQeID1g
	DB1u9yDuyeZh/HaOIZLn4nsx8SO3MEr+dTKGeASkflqSsomWeu4R2r/V/JrdAV/2ilR6dwPIXVM
	XNMpl5brf7q4sBsDgHHPcQzKwqUXFwICw8MaiIeyqK1cRLANd7Ujq0MXu0j271kBOU4tmkc8ix9
	JcVliFgt4A00wLzODWQu2/ks515pKQPpp5lF9AxNpYIwGpBXx1dnLpyskHfUwYZ7RQTHXqOueA7
	mbp4y5PWmfun6veKEIU8qpl+OMZeOABfIK9MuWYjtQmKEi6x00zeZh3wOSXpllBwLMkuUJ40C/v
	fMnKsDAFi2n2FhjpUeFZGg73ngSTgRgNngld9Fcl/a8w8PlWZW3UIIHQqHVZOUj+HQYNEZj1Kis
	SxDwL3zMIDhcyktQsaBP78916SyFoQaOi985mWPRv7+AYyGeO+9BQMFBgTXQoyAIazV54DtI4J/
	k0BxdhHoOhFEyUD01RdFvYY=
X-Received: by 2002:a05:6a00:aa8d:b0:81d:a1b1:731b with SMTP id d2e1a72fcca58-823aa43ff6fmr2318436b3a.19.1769761221359;
        Fri, 30 Jan 2026 00:20:21 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:21 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:20:10 +0800
Subject: [PATCH v4 2/7] ARM: dts: aspeed: yosemite5: Remove ambiguous power
 monitor DTS nodes
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-yv5_revise_dts-v4-2-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
In-Reply-To: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=1501;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=PuGP3tDDyva66stpyd0PfJUp+oeZiyMMNMGNoISiM78=;
 b=TkgsjuG0FPDCBBvCJEU7Gmye4sri5zyhSShXC2Zo/dGNnIavQka/xIB6cRiuAZMXqkNlek+OQ
 Mx0ZU9FdwbaBMNc40TTDnumCuh5KoS9T7cuzDeDg5RYpSsyCvgV7BG7
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Two different power monitor devices, using different drivers, reuse
I2C addresses 0x40 and 0x45 on bus 10 across Yosemite5 board variants.
Defining these devices statically in the DTS can lead to incorrect
driver binding on newer boards when the wrong device is instantiated.

Therefore, remove 10-0040 and 10-0045 device nodes, and let the driver
selection is instead handled in user space by the OpenBMC Entity
Manager based on the actual board configuration.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 7991e9360847532cff9aad4ad4ed57d4c30668a0..45b8ac2e8c65a4f672e64571631b7f6944f26213 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -674,20 +674,6 @@ gpio-expander@22 {
 			"PWRGD_P3V3_AUX","ALERT_TEMP";
 	};
 
-	power-sensor@40 {
-		compatible = "ti,ina233";
-		reg = <0x40>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
-	power-sensor@45 {
-		compatible = "ti,ina233";
-		reg = <0x45>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
 	adc@48 {
 		compatible = "ti,ads7830";
 		reg = <0x48>;

-- 
2.52.0


