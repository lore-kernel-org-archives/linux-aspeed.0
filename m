Return-Path: <linux-aspeed+bounces-2248-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C52CAC598
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 10:18:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRZVV6fJzz3cYy;
	Wed, 17 Sep 2025 20:18:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758104322;
	cv=none; b=Pqia2nCscgAM2wPaL9+te5aSm8OMYtZcODCoItbS8DE8i4SotUlx2zQ4QxeLJ7cAsvt/pP+qKwEKtOl111KtxFVQDF1iWRevWvwJ9qepj4jbtVnfJ8Q1RciKSDwbNsLhMc9ejmU4lOZA3aZPnQkpe/GrY51zW2SUwvYawkj9jznNrcKfGvLmZybZtQawaMryqzv2My2RkP7Yni7a45HVnEFpoQ69QVxCsTZaFnDUfyavcc8JE+EtVXfJGXZROn+zmh54UV9ET1PfXbmkMdmS/3O8uTzk/lkfkW9nZNAX9zQmnlJ3STGRiOyPopcXlwMLvEMyvaJD+O1mLIpyRg5maA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758104322; c=relaxed/relaxed;
	bh=k3lwBMTCg1xkGzoFZzilNGQBuvChETr/ISTszxUGZzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxD0L4NADbSxTMPcjDq/WVaGC2KItrSvFwaPBFtQX49UDogOryI8AKVsoCkW+SorqiRk5rzdkaBy1PH/CzulykRWNZC6xCiFHdiJ04oyKyT+QcYYgeZNNXR6F2V0yUo8jnE2N6e0V2TMfo5TwZ/aqGaxvVB9dYoHvpZhf2LfJTdumgNmgSvgmJncAp9empGMJJMtiHuyn/yRDKkSiDk2+vOen3Z80k01526ODLcdXxyfJ+TF1/gXkcnx9GJdlMEWJrwKtZDwX+pOSJi2go6lOFsLZPToybHs9bWnAoT5S11QFoGrZbvitbQV3QILSgjJ4JhlCcmdfCnqK5cJ4i/kDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fdm3X3Z7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fdm3X3Z7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRZVV1XD2z3bjb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 20:18:42 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b54fc45db56so44585a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104320; x=1758709120; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3lwBMTCg1xkGzoFZzilNGQBuvChETr/ISTszxUGZzo=;
        b=Fdm3X3Z7LiJtvNAYVB0bXc40eCd/DbEO6W8k+Cd7vecBQWQSU9GqZhq8fAOl6n3NoH
         kdoiV0ZnEPPhjAGP5cIyzcOrVaIwbQFAurQfN/+eowr3yjcCE1Cnk2J/IeyutXLBQacJ
         yAwYsuJaTehFc4C3hfCyky11gPeUlycr78zZVnyBHbJn7MurSpgQBaqVwh5ePHrY/nwp
         qGh3KCmmhxhtbi84DHWqAvYrwYyo7eTkogxcIHmObEuD/4iMGiFI7Ar9R2dnDzxE6yfl
         1RJU/PWF4cu5GKid3XemFxNjO1I7x33TUlCvvkQadM2FKstVNT0C3l+iOCk4ET8h/D8O
         xJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104320; x=1758709120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3lwBMTCg1xkGzoFZzilNGQBuvChETr/ISTszxUGZzo=;
        b=hxx0kaGMWHEQtU+uWb8yu580hQSlEy2hXyceGCX9usl5FKSiqkkFs2Zw0ZIMsJiGCs
         6oFlTudaGQky03183qJRduokYUygZnDHk9FNmivGPpBBqfRLXKU9eWA2ucuAuFpmQTfR
         g9JhlgGoqzwOPzN79yEcRQt+8zOWaboWV5HlHeUy7nP2N0AqdeEv9tpHQ78JETgImnpf
         t/SWrIoUx34XNfehG8SaG+0+1HmR3H1LoyMB9qG9+borUgmiimX/yAioLpXRTmAlceBn
         KpN2aBnU2F63yl/QQuFhJaJR4sZxpm6I6UPMexsJOmrFVoHJnHz4wFaDQDH9oR0tfB2B
         Jvdw==
X-Forwarded-Encrypted: i=1; AJvYcCV6AAC6v3T40Tcw02nmbapgNCRZ93YMTpl1BWQI7ktzIIycAOj5c5JF6b2eIc++9xq5TgelTiOjoqY1cwk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHSwxDVUDEa/Oh5ggvyN+gKqYJhzId50wMQbqHGFltwKboVVaw
	AL2G94EIcQ06ml0QOIYW2OtHKI2e3U73LNlLLmhpuWkc4nqnQt0Mg00B
X-Gm-Gg: ASbGncvCOToc7UbwIg9m1H8m5EJkaJrWZP98ic0g8AhtMpPX4Bwee/KbQyZBv5jchcu
	CT2Z8saJC2OelwMKADKlyujCVhVW1DcNeOmwLMlIAY907iq3kZ7EezDTt4qpRz4I67Y12jg0und
	H5NyQ1AUVQHirdW7e1yrKXV1e/8qE8nyr1U8ZLu6B20O/6fCYkbQCw5Yi4PaxBO5jIHiokBtdYK
	e0q2GWCbtAna3NUAUX5L/AWK8oJC3WDvFSqhojz089MI9bAoIZA5DcPK2nE5h+SwB5PkiZNxnbH
	WYfTY0RpOsmv4lXWQX7WA6qo1FSIIvepZTQouiVdQj+XncJpIly1RIycW2sTCXVweZNLhVm/zKJ
	SpF/UHHEss6ijWFXvhlxz/byUJsv884d/e3MclSSBkD/Y5S5nIKbcI2h9hWToE6jUOh/Mq0B8ZH
	CsiM9aUjqbvtyGleEe1Bg7NXT7rYehDDR+sX0I
X-Google-Smtp-Source: AGHT+IFpwu5XMkJV8ZMehKfE4Wk0PNKKgC3/i2DNW5XrT0jCQFnppvNab6Czf66Re5ST81k11mqhQg==
X-Received: by 2002:a17:903:11cf:b0:24d:f9f:de8f with SMTP id d9443c01a7336-2681216b692mr25942835ad.17.1758104320167;
        Wed, 17 Sep 2025 03:18:40 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:39 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power monitor device
Date: Wed, 17 Sep 2025 18:18:24 +0800
Message-ID: <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add the SQ52206 power monitor device and reorder the sequence.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index bcef91e6eb54..fe72d47a7632 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -353,14 +353,15 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	power-monitor@69 {
-		compatible = "pmbus";
-		reg = <0x69>;
+	power-monitor@40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
 	};
 
-	temperature-sensor@49 {
-		compatible = "ti,tmp75";
-		reg = <0x49>;
+	power-monitor@41 {
+		compatible = "silergy,sq52206";
+		reg = <0x41>;
+		shunt-resistor = <500>;
 	};
 
 	power-monitor@44 {
@@ -369,16 +370,21 @@ power-monitor@44 {
 		shunt-resistor-micro-ohms = <250>;
 	};
 
-	power-monitor@40 {
-		compatible = "infineon,xdp710";
-		reg = <0x40>;
-	};
-
 	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <500>;
 	};
+
+	power-monitor@69 {
+		compatible = "pmbus";
+		reg = <0x69>;
+	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


