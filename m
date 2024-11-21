Return-Path: <linux-aspeed+bounces-154-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C1FD75BA1
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qP42W4z2yjb;
	Thu, 21 Nov 2024 13:53:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157617;
	cv=none; b=DrP8krmBpjAY7TGeuU1Rwa3kRUEl1ucJ6hX03RD0DydEkb6g8sFeRoCOB4Szi1UQ+Nm07crbaz59lcgOzzD/WnzGuX2ud9mrOI5Q50iq9HseYJf0qXm7HDYlOsX2oYwe2p41yIXLWlvr1E+/B5hQ6tGA3GPPbbfoRLNzV8X0juIWWGVptT6TPJQfz5hYHD2Dt9QTpTBZrCr1laTy4rbF/8ba5zxqB4wZ0uazz0gEf5pnOkyk/fh6+FLsytC+b8OeWTkWU59EyBBn5OvWOf6dnCRkpBPXZRDDS06JJtQQhm4nvM2be3mQWyRyBSMLbfGoEdXVHm3tYjI2UwXtuxLRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157617; c=relaxed/relaxed;
	bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKGb0jvt/39bJPjFBn2WOd3Ed7Ifu17qijO1q2/f5bVdvFJixb3kzNbZLttYbkLHrjNyIQGErPtQXZX8MQift3LWyp8Ph6ejDAw2PYA7ypbrI6wShTsagkgeRNakq89lo8L9paMYzqNa/7EpH33pI23fNAnH0WqRd5wHaJD6EozR5HqJI5/g2OSxV3htnOjUhWfWJ277bm+uR9xsaRcMN/GwGRDd74GBt7oq5wAyw8iUgT206MXt17M6xA9h2COpD/+Zz8Ak5eIg1/zyMiQtyaxNDpX/yJavz1PU3pZtJrT1ieWg5QpTVVT+Ba++K1qvFT9/pdSRR8mHLjyIxvtyOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=D5sLsBxn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=D5sLsBxn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qN05V2z2yjR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:35 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-6eebb54fc48so3628957b3.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157612; x=1732762412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=D5sLsBxnh4TJFDH/RDE6Lj44v03IjLAY/v5ioMgnrhnzHY8X7W++aCdTtvf0CcSrBU
         vSVNKMs8nGU67KEiM0U2qlX12mYmcyMiOE8O9CAiu8PABfnvB0YiLxbVNKMDJNcFTBWh
         8RgJo91woUvX1m/QbTr30Lfo6jLqfKcJLH4/KfvzLAtVwgX7sHMYFK98J79iaD7l8iRH
         Nw8uThn7yQvXHYO5HKiHODtsyVMEsHXct/zS6sbB4fxb0B+qzzr8haLIFeVkOTaViJ93
         qHSayqpFCTWYnzFFMM4Pp8Gdv1bI94z/sbunQ+fuk2YnPeZ/s6NKRbxpUqjmd2Sv3g4c
         QeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157612; x=1732762412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=w3wzw5JIjDGx4RbJtRec6Ku7+a0okXm6Yzu1hpQoZCckQqEevkV0Dvj4TXw7My7ebz
         XhAvvqnf7iOlqGfTrW+XAK84VP6+eb8eW1UDj15iqcT39w6Gj8pAGNhkoSvkJAq7ZBGe
         LkmFnVHBb0AKfsUZ2Cll/BQ7eCpYB1CvsILucN3aZTHlVGuldcHKi/CtBm7XCOeLp875
         9okv/S3rtIFODRPX1FXXrT7LmUzSPrNrrK6LSNzCN91o50MQSaR7ULPQbrBPyd6EVmvj
         4Qc+bNzHGri2Mg6GiEfnyu19mVcpEQsNNx0TKuzxrx/LB9apL8WzT0csf1IxH8D/9m9W
         mhaw==
X-Forwarded-Encrypted: i=1; AJvYcCWKSQA08Gsi6WJKP5u0T7c3wcSL+LsqUMvEUOHGi8xwRre3yLa53brWvxil2826ifi3VgbWsrLeYJeA4qA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZM6fdbjAmeDbX0756CCLwfRkKhkTYT82nUHFjd0vVtFnR6mAt
	BLeDsqqhVtmUDoI6iTLMbY921DxtoW+GVJAFaEi2WgjpQ7v9viJQ
X-Google-Smtp-Source: AGHT+IHXjRyb8nS28IN/wtJ8a+jvzEJ9+GyffRQ8T5afNpb4mgS2TbqNu1e0VRuzfkOWg4BumlDkPA==
X-Received: by 2002:a05:690c:4c0f:b0:6ee:b8ab:56a1 with SMTP id 00721157ae682-6eebd17f2a5mr59339787b3.20.1732157612091;
        Wed, 20 Nov 2024 18:53:32 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:31 -0800 (PST)
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
Subject: [PATCH v2 1/6] ARM: dts: aspeed: Harma: Revise node name
Date: Thu, 21 Nov 2024 10:53:18 +0800
Message-Id: <20241121025323.1403409-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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


