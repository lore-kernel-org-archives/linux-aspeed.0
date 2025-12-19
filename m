Return-Path: <linux-aspeed+bounces-3179-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2EEE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFX02r4wz2yFY;
	Sat, 20 Dec 2025 17:54:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131876;
	cv=none; b=HGmyqdqc0xDoQWlCnJ/Cz1h8MBtuY4iX+b9/SJIDHDZYawzJrKaptHrTvYHSKuD5yqya9bnLB91MOtCScCrZLKh7aXxrpnwq5g24InqAjKBsBHiDscER7wywp0SNgqXv4rVu5MvSASBhd6hccTxBcoMYlgmN7PbaXexXDeIu+IjHgsC/eIuXq7TrgflZDzt8kkuI2ro/aTiKuoBlsZKIaOwM3Uu2wo9LTAAeIn5o/XyxYkvqoARYRSS9j67Tu4RZGjxen6x+riuousj72MwSPPxhhtD5pL/ZyLFJpz7n8F46S9P0h3NID0YrJA49vB67bdm3dhK/PwVUYPvGRYhXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131876; c=relaxed/relaxed;
	bh=B/wATTXzUjfrmjvqBe4cpw13hqUTpsiU8Co9x75TxGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EefWttHUpzy2uFWOAW3tuAxQ/8UMK04ZOsC/ib+BkJwFfS0owvn1xiug3y2o1CtJ2OIhgkV/UA0KZsda93oUfMrF6WHEs9OH9sBuaJr4HJh6mpHT9QUxLGo3yt9Q5RKm88JbZ+dfkdHob1+36vYz9vAY30kYJJoYsnQjytR12RrzkzCIbVpJolG2adzT5Ds81cfVKAtNq+nYwtIsJ0nI/DL4Kb4D2egj8wRXXUWL8bR1GppolBq2XM3m1+aMyMElOPEHt/g50t1EeIFhKI/RxRAGctgpcrQXc4m88xV4nfzD1Tm41dYGn300r7uXAbQyRPuj4Sj2/6cfYXYnxC8DWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kjObXKjt; dkim-atps=neutral; spf=pass (client-ip=209.85.210.172; helo=mail-pf1-f172.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kjObXKjt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.172; helo=mail-pf1-f172.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGW60d9z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:15 +1100 (AEDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso1580626b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131814; x=1766736614; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/wATTXzUjfrmjvqBe4cpw13hqUTpsiU8Co9x75TxGw=;
        b=kjObXKjtctsQBLssjGPyA0KWj2NZW4xH9yKe/rhVNaXigDKZjAXbJ4DHMmXGeRj/yL
         UScred9cjMp8kvvIbWHwiNz6os4w1850MKGJ8745O9YFCchNDUJe34LCnIDrT9tHzFh8
         jRMivehHBdIWLJ/m8HsPaiEeDwAuOm8QMiUHVz9lnRT5mnhX2tj7j+zudW5RptMabQNn
         7sVOQT3bfQTWn1ZEjrSbKtRxnFbpBxcWEF/RUDKWa1EHUZYEpbbXhLCP5H63ACJhUDTL
         CPOcZUZzmxZxXE9c2RnenkjctPnSdTQzXsUqleAWTK9vnjv1yMyMQ6WkmMSzHex0Mnv8
         ccqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131814; x=1766736614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/wATTXzUjfrmjvqBe4cpw13hqUTpsiU8Co9x75TxGw=;
        b=UacQWd3KYl0CL6+04NP/IYmdTa3v+2yutsMGOSt8AvqRj/dbzSR0zy4GC2Wk3q5AtK
         Q7+gHivb2bETa6hD6K/a4J5dtcBtfc5po2kYpESqLABLxLcKPxo5grGfogdrE4OAK2Rg
         nRtlFhUrW9rsfe2yFWkRsuzcb+U123iSFIMvF+5Ey8UIEbj6T6vxAKuo1rFpIPZ3y56S
         hb79detbcGoOeqyDhKuQbCvC5JXIQ2ktK6FlLGCJJ+xrmW3QMf7VpCZ6wk4TBZrzoGY+
         25vRTyZGa6IT2oYssjYy1cX2eewUbyQxTF89TZWN5LzHk7YMAJEUB/ukNc8ZDlbc/CXy
         5Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXL8/lTKvSMGbcv9t2+FQQQMEiD1TlhGnvH0bb232e5Yb9UcJxJQLi/41CbTt0Fu/L6XVtWV5cc+E18VE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpSFesjW7g/igvuQ3s58TZJzRBBMcGPq34scaj1QMXtk3dvfhB
	pXxNF6mNeqj1WSvLHu+2fttIoqNqY5tfRbjuFkc3/nWgLdJsq4M+RzcR
X-Gm-Gg: AY/fxX4aFqvcgSkEzgi4l9fJd2y7b5eghvgIY790wjjfMJ4z2ZGODINRH9h1xyOVBAk
	NqbKMQSL/+R5MrvHXXMuL0fAdgaYS7EbFA2nsytaAArg85jSfnwJr/xLyXKAQeeZW/Cdk3basXv
	bgMlJCFYt5ItAoTNVpoXV7S7yszU2itAZo1AE4p3n1dfHW6VPlQJLeK3aZKr1Xpaj2fd9efd+NX
	xG0+YQdzT6KRR8qdbIMYGe64Agql/HPH+6yOwdQNw76GBQiwq2OEPOCZO41iabHHdvVosutXChC
	reLNZ3hyPdVSmgHJSeCWEzdNFaf9gTeGpTP01SxwDSA8i8acCKFVxWt1m06JlqCaO614tIkr0hM
	2HgV6ebYZSSLWGLFSSX9PinyvFx98Q205J4eh8vSxTnoVQBvQHXa914AMWbVgoBRIYsWKGWz1CM
	tS2sUky7gjdrIjHLvNkbHmasH5kV0YyyVXUB6ESTEhamWMvbMRnlb3+Umx0vmf+A52gbErRqn/H
	6fH2pPKiTf7STNLne2xKumM4wY1eE9vUyMveheynV/Mc/shehOCf75AW0wzMqoJia63qLKm5DQ0
	NoaigJnz6rEViHgLU0BESg==
X-Google-Smtp-Source: AGHT+IFgG/kkmFnup93ef4j7B1YogbwF3xY5WX20Fy1r8auW4FLn7n6hE0zs3aNr4OERdmMnPXW5Zw==
X-Received: by 2002:a05:6a00:340b:b0:7e8:43f5:bd1b with SMTP id d2e1a72fcca58-7ff6735eb46mr1956944b3a.48.1766131814009;
        Fri, 19 Dec 2025 00:10:14 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:10:13 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:09:58 +0800
Subject: [PATCH v3 5/5] ARM: dts: aspeed: yosemite5: Correct power monitor
 shunt resistor
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
Message-Id: <20251219-yv5_revise_dts-v3-5-ca1d5a382013@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=1969;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=d6+A4ye/JRSrS7pJrCdCy2IGur+aajOHCYd0dBHk7cc=;
 b=qSGjSNQeX1Dihy5AoAeuN0WLNCmP9mWMxheaWMyYmyLGs6Z5Fvgxy2/YCQj+mh1ZmYpDVu1e5
 rnyjJgRsPAaClSr4Yh6wFnM2/xuqfEFAb4P/YClhlBd0Uv57GidsdCb
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Correct the shunt resistor value in the DTS with the hardware setting
to ensure accurate power and current measurements.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 84d3731b17f7c7c87338672bbcc859de2b89b722..524597a81365ef10cd03b67d35eeb88a965cbe0a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -415,7 +415,7 @@ power-sensor@42 {
 	power-monitor@43 {
 		compatible = "lltc,ltc4287";
 		reg = <0x43>;
-		shunt-resistor-micro-ohms = <250>;
+		shunt-resistor-micro-ohms = <100>;
 	};
 
 	power-sensor@44 {
@@ -461,25 +461,25 @@ eeprom@57 {
 	power-monitor@58 {
 		compatible = "renesas,isl28022";
 		reg = <0x58>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@59 {
 		compatible = "renesas,isl28022";
 		reg = <0x59>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@5a {
 		compatible = "renesas,isl28022";
 		reg = <0x5a>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@5b {
 		compatible = "renesas,isl28022";
 		reg = <0x5b>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	psu@5c {
@@ -723,13 +723,13 @@ gpio-expander@21 {
 	power-sensor@40 {
 		compatible = "ti,ina230";
 		reg = <0x40>;
-		shunt-resistor = <2000>;
+		shunt-resistor = <1000>;
 	};
 
 	power-sensor@41 {
 		compatible = "ti,ina230";
 		reg = <0x41>;
-		shunt-resistor = <2000>;
+		shunt-resistor = <1000>;
 	};
 
 	power-sensor@42 {

-- 
2.52.0


