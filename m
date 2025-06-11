Return-Path: <linux-aspeed+bounces-1381-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2733C677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJB253lTz308b;
	Wed, 11 Jun 2025 18:05:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629130;
	cv=none; b=H/xYre4SPE/DTxmA/5Pm92+GJnforCwmUtXBmDfnvvI0pEw8th6c1rIYg70YOS3MBaEYMQT5vqORnKcy7smNqKCPGN9PLzGV9vp1QN48wUSB6QDPpvmiYJEBHSkCLUccsizTmZun/CqYe8mCy302isHphExjfidA+Y3g0Epbr+3JfduozQ+ZDfRwAmjEioaVzpOdEd22NZnFvE37JFQdxJq+EB8DXlv/Alkmb5LH49TAQ3Xm6zQLeMyurWfjUCCdtXe5iBJhkJrDytjSPuyW/b1i00FKAog94Plb3X7rFEUBA+ME8qFCc4QgXY/6uPiFQGFZfo8p92xNJdQRfuxQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629130; c=relaxed/relaxed;
	bh=KKbu1o95QNnYrie8L7Z3Lpp3SPlLgdV1zXb1UY/Ga98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEb86hmNssjep999JrcOx0tBA9Hb8lhBt8kXQgwAkKIqoalfU2wjeWkc0eT5/GFcTInsnC/c7GBnb0CsE7RfFncYaNNa9p3gB0bceAUDR0JR6jT8mdtSxWgAM81gZzAeN6Qrqh7hociSHMR3G4ldqo19OKeXcwTcvhQmhum2j6U5TH0rJjQHoc2MuhIfNkDUCxndcu3MWJlVBpBqOmK0PggZeba2LPbdoKElydQtQHTLL0JTiJm+0q//jckV1AsEkWyAguRBp+vcnIdDi3RJ8AmBOmJKRvm7wq9JWtrvhZY2YRdthyx8Eb/z3INcIsXpxqj9fsWL5pWxLxnP8BvAXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h6OXUS0P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h6OXUS0P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJB20cmnz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:30 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-234f17910d8so61542615ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629128; x=1750233928; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKbu1o95QNnYrie8L7Z3Lpp3SPlLgdV1zXb1UY/Ga98=;
        b=h6OXUS0PqVeGq7FL+vv8XElEDSpadjdyDIXJbU3xGkEuHN/LJncAXywIcEfBW6xZW1
         S/zSoDJld6iPSU4UNDuLZBzAxenD76kqqvN9Wn/eVA0fk9Y9YyH7BmLnWbMsauKssd18
         hbcBgT/VqmwnJ7eXJF5zlxu6UebP0KKLXgY9OuHwkkI+vejfsTZtMv6YGJxN+SsjExii
         8mms9vJdG+hKc8xl7lCzv27tMQt4oVnkBCk0LhYyQ7TQys1m7rPp8fP1XNoaWloLsbyj
         ZDxrGC/Ir/JyvXmm/fmoTQDdJYSEjSOiMbd3xO9eKkigzaaxJOAXuGbWS32fagDutkHj
         A3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629128; x=1750233928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKbu1o95QNnYrie8L7Z3Lpp3SPlLgdV1zXb1UY/Ga98=;
        b=MDtLpkJtjCBgQCGWrEjbURYNOumzuSUDqLRDCqHwTV0B3nmHEqAejFFTGfGjov+R3Q
         gShlwTS/8IBRt2L0vFFtIcDm9nr0i8B/SCAPCS9pihwO8QOfHyjcvd7bd47qPEVwh8tr
         WH0ek3Mfq+P3MPRM6NJQ8hK3ud3F6IHRXSMgsArI91F7IXjB37jngqNSn7CkimukURba
         kc1TROjgdjn6eM/+qCS39smXBmfVsjhMHInVi/XD7k/oeWkFZgQu0RjGSeG7kMWlDndN
         dz2JBONLneI1svOu21p5n+JT/4Q7ftYWWIbOIWyRRQE2qqpPmCuUcMm8pwybv0CCLyF9
         KwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo4dYSximZl/QT72DExdOQog2csUzmsbW8S/e2ue4VuY15jp7jm67W/2+jYaGTtZKQyBop7iINeRaLMq8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBFEDScv1bnstaC0ju5gX+zGGcFc3NCskkW7CyxoyhIIJPdC8o
	BTdcojl2HW+kaZhWN3Kesfy48Yr7/OsrG3s4JSf8bykexUo64EZOyce4
X-Gm-Gg: ASbGncshWTex9c6mfHF3bKjQv3oHAx0cTIWNQyZcRupm+TWtoB704AocIOYCkIZzUwg
	K2xKL+I54IcsK39A5k0esl28Vd07HMMorXi26Q1Fl32DBICeOZ69BOya5p+HIebfPg4qSdJRvux
	GPrG+yylsOZBqOJABoKV5MxwD1dTRsvX0b3XiWbUi5Bd3ZLv3qJTgjhPepoKDHiaYbxCX1kziMx
	g19+AiSpueXKumHewbprkZ9nSFCB0TzZnT6iKJ+GMdzchYs2QI+AV/J52CPBEltiUgIMttEbtcK
	yaS1odsPM+pXodFzDrk6Cfq62gpJKMdALbH+e0feqN3yKgFUny8ZsmiU7oLx7Pk9AHGXLSM5Svv
	8Hj1qH0RKA2Hk9NDN2zWBk/TUJvvB1M+6Ic+fp817vuzqoCIRK27A5oCZ8af7FuOF0PKLtXR2X/
	KuwA76Dw==
X-Google-Smtp-Source: AGHT+IGeLq1+OHxDZevQ6QLgjMpafO8y79YrpEjfJFZArC1M6ed/pAiO8LgUIMW+68fVDNOZqDVkAA==
X-Received: by 2002:a17:903:3c47:b0:235:2375:7ead with SMTP id d9443c01a7336-2364269a903mr28755145ad.28.1749629128388;
        Wed, 11 Jun 2025 01:05:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:28 -0700 (PDT)
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
Subject: [PATCH v2 3/5] ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
Date: Wed, 11 Jun 2025 16:05:12 +0800
Message-Id: <20250611080514.3123335-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
References: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
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

Add the ADC128D818 device to I2C bus 29 to support voltage monitoring
on the Harma platform. This enables accurate measurement of system
voltages through the onboard ADC.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 344e20394665..25b873ace2ea 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -529,6 +529,19 @@ eeprom@54 {
 				compatible = "atmel,24c64";
 				reg = <0x54>;
 			};
+
+			adc@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
 		};
 		imux30: i2c@2 {
 			#address-cells = <1>;
-- 
2.25.1


