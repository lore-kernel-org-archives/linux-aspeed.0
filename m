Return-Path: <linux-aspeed+bounces-2247-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954B7CAC59F
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 10:18:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRZVS1mpGz3cYk;
	Wed, 17 Sep 2025 20:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758104320;
	cv=none; b=k9hFYRuJPJKX+mCRKKZuyIsz8rFQfd9ZQHZWwmXXpfz9Pq2QWlNG3pY5KVzizEXG+21U2YLTMMzZF28tp1ti2wlhsuLTVLfutw9Wd75O3UW2+6bAX0KgClGuyy+xQZrgXiYcFQ9+Vme7hdb2hHv2plHcMH0jmG3Ik8N5W2FvGLdrOXDQQG8wzq1aIjBbxm/2Znxihe3T8/UHh6oqcokVYUIAJrOm/R91F/lHuDg8dPWwE/ysUyHFqTl+j763ePlRSnLZwN2w79jBuKbd/nAzOR1jeCEy/6rrriZHwIUFEyxfKnvIPliHrW3h1p48hiJbQ0cznhlD6CxiGESAsF5SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758104320; c=relaxed/relaxed;
	bh=t96kEL8qjy4YgliK0l0rnhpDDiQlebw3W1jReBJnKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz+y4nOjq8C+tw2fnybwY4jv7Yz75SObxCKnZVagKGNDbYCYi4Y3IEsPYkZWhXFYISkXvxeLnTCijbHBz4ixcVYExHZinLhii+yMYcSsWzQkHLyYQQcgoyESGTwKq/rcFePK87N8uhabTw9EVcaKdGbHQF3HrZ1HUKRij88Sxifs2/dGqCX57MXqnYEyFVmYhQbbzqN2DOMiUi0+DTGT2wGheEsCgiZP4CvVackSZELyPxVLMmRZgyqoJNzQVV9aFYSMqtOL8kMp9GKs0KAgkEiyBm2PCWa+gD1bksL0OYE8RYe65lO1vGi/qnmr1MOxlM8t9FJ6drFA1DUIE5r9Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vfkc1HR5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vfkc1HR5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRZVR4S8Tz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 20:18:39 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b54b301d621so4398555a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104318; x=1758709118; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t96kEL8qjy4YgliK0l0rnhpDDiQlebw3W1jReBJnKWs=;
        b=Vfkc1HR5OvWzX3xq5tnK/GsRWCbbCc80YXRz5L3nHpe6rDBXquOkEW9xCi1oeRaewr
         b56eXTXM4Jurxt2tzM7hXP5RiNxaio7da+NYoha5PA947LyS9ikl6cyJ5SflxjRP456y
         cNmzKhsC8QCTrAHvwe9y5i+UJV8NpYZY7NmJXWGzBH2FlOdxZJ3TDB/t8LlZqHNAB8Jt
         GhMUqwnA1RR/rIiz/dFjT/OEk+x+L4Nn3wBUi5Feu2KBbP7nOCerJvDEPjXXW60bMC1O
         J7kmv8GWOdCsc0PRZHPH/i808gMxlhQ587de+3QfIiUWbZk1S8lgZbWm7Zb6gDOHwNzH
         Bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104318; x=1758709118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t96kEL8qjy4YgliK0l0rnhpDDiQlebw3W1jReBJnKWs=;
        b=HREOFOWd9/2b21z69uGz0yc1dZZL5i1Nvi2oggkcmiKDlyYGu7houPBv5+lu8QY2BA
         cch+gkA6rCz2HpfGzQhKI1Aw+5yr79tqgljyAEHeFhE2WdNRHZw8VzBTxD6V4VHj52QK
         Qw/kYB/TYJRA0le/la3cFwpmbY1PxMBJXhobs077Go6rjr44DG+oXJgOSTWEqmOKTv7J
         p8J75GmkrWWY+TjCxgRspOjzSiqHJOojrmKzhB75cugt95h3sCC9y3cFcEGWbTNWFSJn
         THkm9oqkaFbHzmMyft+BT+BpzSYPPCeNsLv0VaWEVAwgr6d54wFFta8dw+YPt7m+0vxV
         M6ew==
X-Forwarded-Encrypted: i=1; AJvYcCXfGKY3l+ICl2J8x8zMd9qIUXDzlCmbF77GKC3x/vsiEYpGIKUhaVckYUO9UPztH8yJYiOK0O2wDplrhSQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwNhMHAK1J7ds2ZPHHX0vgIQ0jsV38AmnZWWb8rwflxuPupDAy9
	kJsAHEA9V96jRhJJZH+ajI61RPmvPSap1rrxgnm+Tz7khghn5wwJyEiA
X-Gm-Gg: ASbGncvNcM/aJxJciSGOKz3y6Z9A260yfDuTMY/UJ0/5TGC4oEE0T4h6XfV8fs9i8mp
	rTTbxaoZL/+8SZjnImnZP29AMllbHQsghzs+kw3uQQnCeUCuLry//hjPfiVAXNFGYUJUFmAj3FS
	4ULiNu/4X4CIcbvCr3oSIKippZkabIxNept97C8BIh2N4vlY7vtSUtdTDnIMPencKpMRTPgSCvc
	C2FoyxATPNIVD1stDmUSpEQPMu9lDBiovyPWrNuI6GHxag2NJH697KY4HEw2DjWUAI2WI9pQUV1
	8bb2w3JTqVtpTwr/QQ7e60aAf58rk/q0+Dby2RwU4obp7WCKgQxLUSxoKyPVjY5fVI1fsUkqvuu
	O9V2XacYY1Y/oImULhmY72AF1zYHnyvDW+UHXre6n3+Mf3d+tzOxQW4m8mqhemz8sWHNUgHXjEZ
	B0MAVW87TRLqLn8orGphR2ifexrA==
X-Google-Smtp-Source: AGHT+IFwCJZiejFhBOaCOBZZ9XSV1F4l94l6zN4IWDTuh2gTutWzk7T5JzgCvehFOl7X++T/mgLFCw==
X-Received: by 2002:a17:903:2f0b:b0:24c:92b5:2175 with SMTP id d9443c01a7336-26812191675mr18151565ad.24.1758104317549;
        Wed, 17 Sep 2025 03:18:37 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:37 -0700 (PDT)
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
Subject: [PATCH v1 2/4] ARM: dts: aspeed: harma: use power-monitor instead of power-sensor
Date: Wed, 17 Sep 2025 18:18:23 +0800
Message-ID: <20250917101828.2589069-3-peteryin.openbmc@gmail.com>
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

Revise the node name from "power-sensor" to "power-monitor"
in the Harma device tree to follow Device Tree naming convention.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 41ae86180534..bcef91e6eb54 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -190,25 +190,25 @@ pwm@5e{
 		#size-cells = <0>;
 	};
 
-	power-sensor@40 {
+	power-monitor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@41 {
+	power-monitor@41 {
 		compatible = "ti,ina238";
 		reg = <0x41>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@44 {
+	power-monitor@44 {
 		compatible = "ti,ina238";
 		reg = <0x44>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <1000>;
@@ -264,25 +264,25 @@ pwm@5e{
 		#size-cells = <0>;
 	};
 
-	power-sensor@40 {
+	power-monitor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@41 {
+	power-monitor@41 {
 		compatible = "ti,ina238";
 		reg = <0x41>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@44 {
+	power-monitor@44 {
 		compatible = "ti,ina238";
 		reg = <0x44>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <1000>;
@@ -374,7 +374,7 @@ power-monitor@40 {
 		reg = <0x40>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <500>;
@@ -520,7 +520,7 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			power-sensor@20 {
+			power-monitor@20 {
 				compatible = "mps,mp5990";
 				reg = <0x20>;
 			};
-- 
2.43.0


