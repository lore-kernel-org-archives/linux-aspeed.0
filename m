Return-Path: <linux-aspeed+bounces-110-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C79D2E9C9
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4Rq4j70z2yF7;
	Mon, 11 Nov 2024 20:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318359;
	cv=none; b=V9+C7pZUL+/T25vRrY9+ffoyCh0RW9M//ytjdfSJPTNx/NitrlmqsZaRp18MLH9QlP2barFeSDAd4iCrK230X5sn5PhIFCG1acaGtoWofVsIqz+l51xGfnHwWvlM4l1XYNqOFT0s5FqGXQTbKbWUxJ5W6JTSZNwv1d8JP1FUeU9pAPp/c2WbJ0wjb8ZTnIP/oGA6Ovyd+OOjnKXRXzPoPkI6LHXGEV5RBOX4xxSrNXE510EXYv33wMdQYsTazHRvJrvXXa9xN8qndCCqUbwDSxiwpcO618w32JTZfd/yj1m2Ws0gGn//oDZfv3Jzg4AUEw1cfQF83pEC6MJb6A0kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318359; c=relaxed/relaxed;
	bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPzu54C3pCEEjkmOp9Vjsr/6ACldPS7iXW0thwupJkqa1LyYrk5qVkrOQ+gDdxIaZ3c6UbYDLqogqstyvqlFqA+dsiQmPuK1LyjZAmMJFqyQwgVGvSaGRcoyxo31pgNoVXX8bXzH09V8aQXsl0Hz7uP6vMLHcrDir2H2bIAOP/kMxRX5XOaYvlHvF2mVN1823pGNqaYDBR1pAXWvjvhgoDmEHHOAAt0QyVaJ85Ge2LNtv/WjrZYdzwh4T5LoQ4hUD0m04d2FhvSrBTIP6tFKyP5oiXHd4riCh6Xt289iZZ2/N1iT7wqOvwp9CXdLrSLFIyjXMSiyNQku3GPGOtVPcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bvalchlA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bvalchlA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rp4jTMz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:45:58 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-20ce65c8e13so47904115ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318356; x=1731923156; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=bvalchlA/sAw/OZH3I5k0c0zAUUjWhKS0KDU2MiFRBpQPNSGCeh2tvSjhmZuDkoCJ9
         WbUpewM6TodQIeldq8Q5Nut4NKxZWCLiOvvKuaXkAgG7qROindnHNI4EXUxXuCKSoy05
         j0lmbYPgYTdQqXi1SWvTYZZzDaBAOEcSEDmQzEpCixB+LGVhESXlHZyO0zoiySAS3zMt
         RT+DZnAKDe0Ly25DkMl36FfsLZP0vpElU7rHCyYKqNzBIV/L/brwuzTswLJDOp2gqsx7
         KWq2SQH7ROKtFbza9RTiDftPJgAqr1LGpNO40RHkTJGLbNZ2Camrn3qvNLCv99BPgQ2m
         Vo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318356; x=1731923156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=LX7EsDmyw8Oo/rGBGdY2T7jjfyZlLWGzLVvlrN8h5462aPIQPrcq1ZuYnfgkWZI1Le
         YQ0+JbJ/NgIEJCEcl7v4fnhrNhZSNKUqVNUvXc+up8vEyavq2q3sApxz9mQ6q27/6GcV
         9jjP4Lk7qx7Q19ym+sbMX05X1GziTBwXoniIjZiHE/LytcdN39oB7rIqv36sT6FAr2+i
         YMUVT0I24XNWEKs6sHlIM5RcyDZ+2aivHLCybdNmzY7/p/hGobU+KoGpG49+rAUhSUow
         FNP411ppkR2+s1jIaWYlv58kGRkOVkqeV4pamiXtQ6GPtRPUDEyrAq3ef99PhXb5qXU+
         68oA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVUY4vuX/GpoOQeM/cRTOh0BfclqkmVY41fKwfgO84quruFniTUbWGS6lAuot9G47CQr0eHuNwk6B80s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZkaFfKEuKKmLLazSQy+8/TwNX2VIW8DWb3cePwopaPUEj/TsR
	AIZkAr/HIZ/XZDXLY9sOmBTntRKpYwKrLla5IT9byvwgmSBtmJ3u
X-Google-Smtp-Source: AGHT+IEX9nBe6zOXu4Czcqkfj3xLinKY8e+SL7CCUn1NiuO6HMbeZ+foSn1y1YJElfeQZ9VKBu9SKA==
X-Received: by 2002:a17:902:d4c5:b0:20e:a2f7:8ab9 with SMTP id d9443c01a7336-21183542c89mr168471015ad.27.1731318356014;
        Mon, 11 Nov 2024 01:45:56 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:55 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: dts: aspeed: Harma: Revise node name
Date: Mon, 11 Nov 2024 17:43:45 +0800
Message-Id: <20241111094349.2894060-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
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

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d175e37c45c1..ccb45ca840cd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -183,7 +183,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -238,7 +238,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -311,7 +311,7 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	delta_brick@69 {
+	power-monitor@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1


