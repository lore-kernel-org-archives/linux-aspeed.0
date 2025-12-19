Return-Path: <linux-aspeed+bounces-3183-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246DE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:55:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFXK43zTz2yFc;
	Sat, 20 Dec 2025 17:55:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131868;
	cv=none; b=bUMHacaXkHIoJkt0uVTE0T1bSa1vwPWxH4sKAYBKFWLY3v6xA4ulzLMGSJP0laXkeQvSGD575yLJQpHwTs73DvzWefjZGNDM1MUKAz6mIW6EjhsogOrImXXEboij6qQzn7XJz8/ktPYRc0Kg7kp1svTTevek41y0QpqN6pP674XoZ5ei/hUJK3v4Spc3l5fVzXUlBaSsTzKNZUc8ebls9jSIxfDxiUZNEVM1YIZTNbI8meHS1FVxJ9scFHqaBFSUFGT4xr3JgpIpxQoAF8KwTPdO5Xw/xQHS32x7doO7vPCiAf8uzvb1c9apbpMxjIkL1GFhxq4bsXrRFLHHstZkow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131868; c=relaxed/relaxed;
	bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoSS27fMPe9ieua8M9tuaDmvz/ilR8zUQOqJGmxlGINTuZ7EMmY/g0RkXW8s6olF97oRWrQ4KYrAM/su1DGu4y0419wmp6oHFIZhD62NmadCpd2FF1kSJBgKq4L0c+QxIuV2s2IizzYK2sHfzYnPWCEmqGdC2lrcaV2JbPHYgSxKnInQXBEE0dVAj3ept2VlWHWb7nUW2QswAraiNEdusDo3TGonc9RV2aXwB2iGZUeIcXe4Bo0JT5HCiTo78OFh8U5CmoxzAizPkVHZgg3ww+qMn4nJaWN+lCcZl3jGLHWvRnZs1GHo/m2lyaXlCFZlg35gf40WxwX+lHQnV1Adpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fi+vTZ2o; dkim-atps=neutral; spf=pass (client-ip=209.85.210.175; helo=mail-pf1-f175.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fi+vTZ2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.175; helo=mail-pf1-f175.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGM2xX6z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:07 +1100 (AEDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f651586be1so746532b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131805; x=1766736605; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
        b=fi+vTZ2orxsX4donTM08KXShsmefXoQwz4J0rctvyEw80g4N8M1v8DaIn9w75NWdmY
         BZsfXvYvcN/S+8lUOgYaVowCO8rjEjHruk6D6GYVM067EZUv2OyHwP8G9hNaf+kjKlzY
         +YC9Dauf18Y07UrFsqQfDDsiZ8fKXxpHiA/PrgwS/TnRzBWOFEMxdUcd8NoZfK78+FRR
         g55FYrjXLD65Pfnnmhn8FDiUms35obZeBj0njB4SHhaiZZ3lnrQOjo3CYuRMK/LXDKTx
         Tnn/Do94x+jNSS+3rNKKAUx1+tEZgrXx+hvnwiH+K5MZzPBsaBQmu7EZThFMpi4JJZh9
         UJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131805; x=1766736605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34Z/wqK33nY+/r9/my4gnemDx7jJlFUXcUiWHmEPYyc=;
        b=bePQm76a06YfEjfbwVZjh1SXgtRdG91duwRGJZMHbrVIeepemsqeOqc4oZl/Bfw+fS
         MzRkkuDZaqkhTltRpKV+1cBAukgYlQUfp7qZxsgbEN2JUFG9aHBk+DxMWSROGf4v3/p3
         2q8PXbU6xKfFL8bTh3MP3NBXwNoedDOkwVDtQ3eXIZkPbseY7ys49arC4DdY4/n9fkB2
         ykNP+26zK8cj1WR8Xc+O5KUjfknUgBeParac2DeYh+IhSDJZzzt6RE/zq3yjNKMWIfIF
         C0x8Q5IiW0j2UvQt/dYlZDKaXDoOJd1JKjZBy9d8HOAJLKAwWFVavby2k1/hjo4kn++q
         gN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNgSlGmiaNx/OqLqfnGuvY74/Md8X/7rSqpt1HvGjOK1HN2BRZkm5rKa3suAlKkUIWEHZkquj+5dphOSA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2GP6JWyclqAysuntRiLM3AAg1dcDNbx1bfihi8R0lhqmuhyzS
	GHAlv83zJ6uCdOBeSqJsQPQLIJ5o+L/anTAp4PSSVRKf8+blFMx8hmOZ
X-Gm-Gg: AY/fxX7SFtGHuRQk2vR/sJNprcloWLbiDQRYenuevRuVaFbokPWH0se6N7YyMSRMoRO
	A+n8yOp4sDzQ+5UQ3miO7fxoeOEYSMC8zGH3xJm2rsBHoXb51WGD/x+1SUcFCCgnLeyQMvzADUO
	SuxytF5ZnOOKwut/Pinjx+fkOftcpVnWxPmz4kMV5TKklVKul7m6TRIbAHQhBKTcR3b7ugOoflg
	4JiKJAgfU/VeBZ3dZNmLxB+aQGIUJl674txTj5+qQ0RpkPB4YWza7V8VQEWbyhd56t86C9bqaaA
	KKSKCwI+MQzMs4vXm/ZHKnhEzmoC3OJOz6CxTn0VFtOZJtBEK/8BIaH5ie7Ds4jgrkiZv4d94+4
	a8r9o4CazMMSHfE4ytB/GPPV76MPhqT/n8/NjWtyd6M8clMyyrb+nxJ5ZSDP9L1jia0X4cD5MU3
	5Kh4YbuZso+qEVlJvXq9L9QrQdGV9Zf3yuo5XuwHZDtdZORHh3eGANHwLv8ZpgycZ8xIPI3+hWU
	cJTvdjYTvKlXPcMhhndiv1637hFl6fICrJlSKtJdJFgDBaT3zc+DkAwCwys1R/Or7N3zowMQJ8i
	FaNRjXG7LMCFED+W6WAGrQ==
X-Google-Smtp-Source: AGHT+IGqfS6t0BtWWUQ+A8QtFK38ikOJaZeZ58xc+M9BKY805z21T0J3RpJjQXDHps61ueUVFOAmaA==
X-Received: by 2002:a05:6a00:4514:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-7ff5284da68mr2523709b3a.5.1766131805321;
        Fri, 19 Dec 2025 00:10:05 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:10:05 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:09:55 +0800
Subject: [PATCH v3 2/5] ARM: dts: aspeed: yosemite5: Remove ambiguous power
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
Message-Id: <20251219-yv5_revise_dts-v3-2-ca1d5a382013@gmail.com>
References: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
In-Reply-To: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=1501;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=PuGP3tDDyva66stpyd0PfJUp+oeZiyMMNMGNoISiM78=;
 b=ty83E+CYPB7Z6jW6eduvzKPvIngjQn4TpP4Y6GcwiwBZ0tmTuJIQuwghpPnsofiRPA6UAL0hO
 BjCASEV0a3fAYR1htzZYqxa15v0nKqfsi4GSl0D+O9I7qe5YfHNYPRy
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


