Return-Path: <linux-aspeed+bounces-3451-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A469ED172AB
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V65Qydz30FP;
	Mon, 02 Feb 2026 09:41:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761233;
	cv=none; b=hZ6cEg7BE/GDOEUycZxhQs8gD4lMzW7HNqnQJkYBvndobGZk8CM7eSWw/dxORn2sQ7Bngo2HY+Ep5nhQYsYrzUETOs4AQumnjO8bmkTfPrXdNlKxrDnn2Cl/BPO5RR3z8+Vf72Dv33VvWS+VDuzuf9KuNSsK36N34w0B0Wwjv6G6F61YG4QWlxuMk6hSeMoOakFtFgY3weR0nexY+T2Q9SpZZwSYCIgHyMmyyVsPI/xCRlthHPmGH+y+Co1ApWziPrCHDCWIOQWMqm4lbSCIL2BT12HrksSCo1n5rFT2F7ShB1E5U9uSpL950c/qiBUbwUHrPlxL2KpdRJqmxOmbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761233; c=relaxed/relaxed;
	bh=ajY33JbgcBo2+n4qVxxMLBcw2crou+yf+Z7Z73b2liI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3QiaoTHDTI19tA/Q6OFbCgJUIFaJwaIh9LDAtgYT2YbPf7Uh08QHOZ0cHQxjx2bQlegdddARBYKajmTtLNvJNB5C0Rn6JBzHls2ZfSlUJmqeFTh2c/GYbOtNm7zmBnq716hokYF47K/oO+/U2yY3Z++GqIS8zCHGosg1aqNtMHOG9VPO3Q+lunU7kl0FrytqJX3JAXbg4DEQutoiRZ2QoUMZFUCvBksi/cYOBxUWtC6kAx7WR2OEijgyI7tA03QsQ1pAgnJ/QbXIJTmyPwE38EJuLeILng1JTyowO/rgfhNZkZAsz10rROHrZaEYsFfQ9JQcdQ3flfNF467v/STOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DFxhiD7X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DFxhiD7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTr2r00z2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:32 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so17850195ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761230; x=1770366030; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajY33JbgcBo2+n4qVxxMLBcw2crou+yf+Z7Z73b2liI=;
        b=DFxhiD7Xs3d/qOBwayZdb+ylHPLH5m1CBHljA8dJ1Z744sSr6rmFVHE8KARFCi+D7F
         pII7o6tnXWgzVDvDXvRiPqZR2Mcz0fd9jlliIVtZ6Gr5Miv6Z7JUUBJ4TnrWNmTDjAUJ
         6y6BkvmcfQjdHsN5e8rknOjLbrwDR5xsZo7TYTdQWpZ6kfwoYe8cbTNpn3RTG+P88UOn
         /du2JP0BsutW3x7fILhTGmkWWlpo24XguWWmIKQh/1IfDanWDqe1Tn7oiQXEbuEi0FW6
         pFOUHzZiEeeco/GsRfdVhMB9ok9uyo61vaPHnnH6K4XXPbAIWzg4m+ldN+PejXxZ9Cne
         W+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761230; x=1770366030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ajY33JbgcBo2+n4qVxxMLBcw2crou+yf+Z7Z73b2liI=;
        b=Mgt1MWz+GrGQSEY31qG7Q86f8/fwmjmpUwvgHoqKw31yIF7Ilc2sUSxJ1nvdXn4c5I
         goMaXWGptMz/G03hK+qh8WhX8OTFX4iSR5k7Y9SvDoOVA7fBqSnqDcbHM/BiFFNe2Umj
         Ga/v/mDz7nrHg+3hivy2jbQTg4lj2+v+8MU5uor8X1tG6sCzb3QVMoGffKcxHWwpVnYf
         jp7PM98ACVNAD/6o0OxFP+1uPKO6oCAskMkOG77bA1XznZOov6e1ecMB0Xu6/jknjzPo
         NyUpCHoa6xzuYUvv8fMkZ9qZB5Kr5eiHIxZBcFeaqX6xBgL2HGzbgS/90r2E7rWYtq4t
         ko1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9GbZHGsS9HQJBOgNvwigvlNO5ZRLtSp3cs1Bh1FJ0caY5PDPcWyacnb2Gllc3IQakMJFpYH5FeL+eLTY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxE8TyGY5OZRLyVknns/e1G6Jf5Uds8StZ3de+yNU27Q3UVeBB1
	0L8OKtXDcJCuqf/hBe17j6hwhMN9znjkoMdfGpsQBc3wdK271Agioird
X-Gm-Gg: AZuq6aIn66GkL5uqqtsukahAT2E/3EPaQb3CDzBAxc0olSv6J95uzl/warJv3VqRu1w
	FzDnvjBqTZ4bkmyHF0s8eKkYkHy5t2UR1OvoOIUW89Ni83Sy/H73k97ihPpfI7HB/AFqdQhPpeI
	dL7rHZ6K5wEHWqWgU2ZZ707czksUJKojQqkl/VPd0SLUyJ0piHZtTsIEPkKa7d14RXcdW/TaX/G
	whk1vyqKdFCDZWYY8P9mI8SiA4BOAz42pyyWh8oTbmAdsA6pQXjYIJhMQDuXP5vqQUCWgzIWyqf
	vAO1xx8CbUztOWndK7m2MR3w/nkjNyRQEPRk60Sy7FyYRbSQTvE/MPlnxp7tMaZRuDDznAypxVQ
	siTJ/DgKM7IQY8dCI9xOLcv7AQbqXQYAj7D+ZiXog0821IfSCEmu7gr8b8LKWs5GH4YBo0/VD3I
	Aoq491Qzzutxu50QNMKOefA1oyx7J1WhOEW78kyJG8Pfi5Uh4wrYDz1BAGTsm063h2SjV0HCwCV
	GosTF2PLuEVXy7pjqOgV0dn5gb4zAqi0j9zldRn/sHPaH04nzezhy1Kzn/GtUmf3rd9btEmg3QH
	2JcP3ZeSIpNA
X-Received: by 2002:a17:903:1447:b0:2a1:5d2:2e45 with SMTP id d9443c01a7336-2a8d9a85d83mr22102745ad.59.1769761230333;
        Fri, 30 Jan 2026 00:20:30 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:30 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:20:13 +0800
Subject: [PATCH v4 5/7] ARM: dts: aspeed: yosemite5: Correct power monitor
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
Message-Id: <20260130-yv5_revise_dts-v4-5-4d924455f3a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=2209;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=xJ4jSm7ucaz8Rq11dl/v2sadnR+9Q4t/tqVDqA3oOEA=;
 b=MPGZXI3K7EwDVf3iP1xdEiwNx8Gw/EdFZ5MD8WuQYvke+Oa98YGg0p8X/7fw9xuc6+aD3ukLf
 Wz12IaCBA24DhksL6kj+wgOmVgfjrmA9401ODbKemoi7XzkIXnygNwP
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

The shunt resistor value defined in the DTS was incorrect and did not
reflect the resistor value populated on the board. As a result, power
and current readings derived from this value were inaccurate.

This change updates the DTS to use the correct shunt resistor value
according to the hardware design, restoring accurate power and current
measurements.

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


