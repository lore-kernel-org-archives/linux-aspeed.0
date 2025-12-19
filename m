Return-Path: <linux-aspeed+bounces-3180-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E31E6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:55:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFX43R92z2yFc;
	Sat, 20 Dec 2025 17:55:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131874;
	cv=none; b=NjAozJxxkTGdtLCtH0ipcPR2yNCg8TCR+d+PvcYh8xbjfF2TXFcujnGUDBdFu+wgVXOo+Q5yJpDvjc7vADPGOtMXQ3imu4BDQDJVjJnfeZBq8NT84F078UZnZfPF0Ap1nL5xxuaezv8SKytVHh3p93Q3Eqy6MswHkgmictiW9Dmun16D420P6EJa11X/5dqFdEURL+SZ+3IHmnAQVIYhZqbhnxnIzJyjTbJqm72h5tqyE9b4uYyUrc6YOPsKAS8CSSvZHtqU3sMqd3dzmyiQK/KeGGErCYJI642BQpOTPF+IQqqxqHth65TIA7UaF2Gotyth/hpI7i7elR6+6/1Slw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131874; c=relaxed/relaxed;
	bh=uPIX0W/QwqFfqblc/FqF0IeuPkn1Wyp+rRntpvN5lJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMnzte9DxWFl25rjNpn1DoN/j27Jcbf5FRifp3o7r3qU3qJ9j6BEMOwIRZjjSjbj7MySQ/aW1SQX6iFjH7es+OBByhwlLUtuypDyPo71YlCfDr81X3+JjJaZEeH3On9SAogXJJdvuS23CusDn9QJjG26PxhYibN6v+seOXOs4jnp6mjRwuh9CLJqMXM0hKj5SfrKkOVifdHxNU2CZTXLa4zFAbftzKkBWt4H65bNMPG563U7hDYyu3Y2wnApK/I6WIyW4n5IbVU7plK9NgzweNwlZPD2lXtz2jmItTtCdfhuHZHTNm6NvfWkuZr93gm3tAMqdPiYVLGd4NSsLY+LUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N4P/RkHm; dkim-atps=neutral; spf=pass (client-ip=209.85.210.176; helo=mail-pf1-f176.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N4P/RkHm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.176; helo=mail-pf1-f176.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGS6lkzz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:12 +1100 (AEDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1351435b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131811; x=1766736611; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPIX0W/QwqFfqblc/FqF0IeuPkn1Wyp+rRntpvN5lJ4=;
        b=N4P/RkHmCKpktxLQcEHDsO3ykcozEJnv1Rt9ccbRiUDeCMlw/yGPV6Us/QEseAeNRx
         UQWyHlo6pfyDKeQYxHRMPfs0aIzKrEuKNRuoHek8o8vFQXnh0TQClLQ2NpSzshYEX5+J
         PpAGW1jwmMjNlHF+jVGA+64knwRMFkJvCJcYXCzTJv3vvtxY9qC+nbf/FH7EoU2gSD3b
         WkNgl5coIMXosoEDrwCTc3yIDwnZmJxfAg5igxWtL+ZxGF5HDJXTeN800OnFmeFnFSE7
         Z4bRMAOGXojG6S2sTjaCBiMNBvIoF7gxxE0ZUTJQS8gcNtZoBImcjTlv1QeNzzE9yYET
         4wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131811; x=1766736611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uPIX0W/QwqFfqblc/FqF0IeuPkn1Wyp+rRntpvN5lJ4=;
        b=RGEkBT6ud8zJCvL+DE1yWB/or4UbC2fKqPlPjMbv8r0opi5P1OH3lbkkS9JUYOIQV5
         P2QLx8z0Mp+urqAOEJ9JOXmyAwH2fBIRg1aftokkR1QSg2t6SQex/YDUhW/4wEsTjWB+
         8PoauXvGHuq0NCBbosJsbQi3Y0shoWErI/flZVbkyvj/q5O+Gz177W9AvKJNkfxFfMe3
         IpXuU3/RfH0Q4mt2eZEAAmY2fG+/y+hEDpyWy/9hgbs4FF77FKuGJJiVngEXGfRxtWI6
         8D+TpgnfrJfbAll856hOPas9M4YblgrZq+ho37jHglMojDHJ5AGdndOEqaK3zqsOT3Sj
         8nBw==
X-Forwarded-Encrypted: i=1; AJvYcCV0+suAd6eghztU+snjIHB8oZecXxVSTugktSK1iwDYWhR8e0OOO+zla7Gv0fxji/SkPifbGYCfwzFWNsk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0hLZnLR/u05G6RkG9bJ7wiO7uWTHlWbPQdX+Ff8BcfVR4pLXQ
	FuKI+TW0hvCHGkIHeD+Ty/Wgm4z5k3Sh5BV0JZY0uDm5fIfSIzeURmip
X-Gm-Gg: AY/fxX4l9nsaZAuGXsbsUSlChiN00IuhRCsJUqC3Gb/ThnSn1lIviw1QJozCiN6ldI9
	8GJt2TcT2VaClo2RympR9thdqdoD8fNxceuMUvGzhu3+fCp/jRIUNExJ0hJw2HbV5KYa43P2NvR
	JBRNkw1M1+e8zvRhWVSX2vdfmm7vG9XP16e1wW5lX3xCEomzvCtOzy/klQqaKJ/VCPwZPbeKBfg
	QkmLzHhUFOHAMNodFmNMpCwH3Z2LCh3za6tOnZVTJ6vUnQSU5iPfT/uZPX9mcH9yAYPhzxR1v6P
	KN7xGsfn5GBfUYxpZhZrNkzUDTiIoU60jEu/2oEH21srt3JwO98FUvtCdph1/WepHddfi9lBUoS
	aUA7w+8nCODBTig/P7jFrYLxIHiF6ayPfLLOVLbUDqlugrw96sXzdY1OMZNiS9fFgFMuPlE9YdE
	UQo01BH1337wqV67mhXNFreDXXBlbG5vANYk2t+8+MO+tvCX6BTeFeZUpUH7jMzkcrm8Gh7bD+j
	aHhQK9ErDbo13SpQB/a8DE9c2OhDtnTnOho+MAclhuYd07jBtl0MzZVY9dspR3z1iEhoY5dGDVY
	C96bEK2Htbg=
X-Google-Smtp-Source: AGHT+IF87dMR0WTlxFT+/7+Q4zUVJL2d6oeF6cDExs7FgCtve1jDteHOK3glUIJGSLFIIdCOD5Huyw==
X-Received: by 2002:a05:6a00:b904:b0:7ab:6fdb:1d40 with SMTP id d2e1a72fcca58-7ff64211d5dmr2128649b3a.3.1766131811124;
        Fri, 19 Dec 2025 00:10:11 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:10:10 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:09:57 +0800
Subject: [PATCH v3 4/5] ARM: dts: aspeed: yosemite5: Add ipmb node for OCP
 debug card
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
Message-Id: <20251219-yv5_revise_dts-v3-4-ca1d5a382013@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=881;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=MUMRve3kRE7pUB71SRAZkcB7pmeSsMqBTIHoXuxoOoA=;
 b=bBod9LQ2/l1kdPXL0FiT4KKMhkm7xMnJ7m3S7Ae0Xy/Iis5bj+nUNmVS1UUStudh2mGaqBoeQ
 aqDClYKp1g3Bj+g1OiRNd9fryaRH8FVrcvjYcUTwcgW3B8YpAP5hyub
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add the device tree node to enable the IPMB interface used by
the OCP debug card.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 983aebc394d9159c7e3db2e7c39e963f7b64c855..84d3731b17f7c7c87338672bbcc859de2b89b722 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -365,7 +365,14 @@ i2c6mux0ch3: i2c@3 {
 
 /* SCM CPLD I2C */
 &i2c7 {
+	multi-master;
 	status = "okay";
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c8 {

-- 
2.52.0


