Return-Path: <linux-aspeed+bounces-3822-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B6610F9309
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:21:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flkdw3fnTz2yVt;
	Wed, 01 Apr 2026 10:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774958994;
	cv=none; b=c5NhF/5v33RZ/Fh5c5ZkvgZat/DDtDxT0MmIyWGKclS6WaojRZ87txN5eTMVHs46gmrgIM9nU8P160ph2Y3VFrcdAU95C+Dz3x1Unz1ntETCBwR+kTqoolAlvMQXRAZlsPphoxfCVs3s+3apur8u3m4BHB0rFWsTYdQckAB0nWY1hCiJ0wClgJPFgstIuSmCyRFCsWH3uqKnH+QmbRo97pAlCAJ+1EfvXpw600qqclTxYOYdMYtfACOUlytV44ycA5ZyB90QV9pZOGOGoYGG7kMADo5e/j/nhwknqESjcCopI2K5jpv0cJ6Fp9ssoNPQquOygye1YHKYLPmc4HTh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774958994; c=relaxed/relaxed;
	bh=YJsN9xOorEStaNzhqVyskGIBPrVNwL+4GmqbmijKTAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHv6OCjMA5zkHmf0ahSnE/nnfMwYi9yd48qnTDBq+bIXdiokmaLTbrN2XFmK+BOUo1L9dPADDPDbbcmjHG2pBPBOZ3/NmQVshLYsrItXY0Rrv6ybiHPh0tXDM9T7LOkxZarK1lOWgxQ5WhM48GNV43N/6qy6CcFI7DjEdZYYoa69BOGAJMiEVQaUOcB5YdGKtClEThq6C5joMBCe/DGQWYV7w2jeH7C38H8wcDPQEyv2DDPPpmuTJl+x9PRJbe83A5cP+WyJf6JjYDkvf0acAC9XusP5LE7aWM//n8Dci4JOpAJEc6IRojED3CxF7RU4YBaT0AXm7i5mH4h0p8cUNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q/JWp//x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q/JWp//x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flRkn20Ctz2xSb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 31 Mar 2026 23:09:52 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b2503753efso18561175ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 31 Mar 2026 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774958989; x=1775563789; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJsN9xOorEStaNzhqVyskGIBPrVNwL+4GmqbmijKTAk=;
        b=q/JWp//xivD4ZAKFQOP5msyZM8j5+R7W4vl4QhB3CHXd8aIdodvcTVITpGJXyDGZBH
         8l6ea7ZTkJd/aE3MuvAhg05cF2nOiHIM40VtlbrLpkcgNDXUqHAGDDffmSpDZpN0YJxz
         VkC7lEeUUq+13kvlIUMP7MmT8qkfxx5fkQ5wr+01KlIRUvIj+VxHojWRJkQsCLDeSCSc
         +3Ez2FhzSp/bF6F1+lMoNiPCInskLF3O7NIXF2SVEQnJq9PBd5aU/PFDindjGNHhkjsP
         EsmRh9cdZehrrE4wtzhcgzxAjCd2wWKqqVpI+k/iIPPqanZ6ZhaNFC6TOIwGVP8/S0vI
         SY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774958989; x=1775563789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJsN9xOorEStaNzhqVyskGIBPrVNwL+4GmqbmijKTAk=;
        b=C1EZHh5vcENPaSKuc2EHD7r710sJ0jtA4RpwTXxtUT6Nln82yWc2LWFn+lCHW72Qi0
         Z2sky9x8e5qZ3p+Z1mfQbMZBZmnLGHnpcggzW5tumiYhlk+Ubrznu0HDR+5tox3qYmLM
         tG1RUPfxVN4cUvu7ySKCx4gxtmbYiqw0aheRZxY/yCPN+gYKSHNnOPza6WWAQ1ezRpyw
         mQ0wBOefFogzldMaskHD4T7hOWqNPc3VJCvzFvN+C8H/ecCLqbrFiTpC3tyAdob2YkHa
         jbDJ8UwNjc59CEFyflLHhlRpWOUjnb1hLa+ciIZg09cde3je4a2Y1MNAdvDnvO0OVg1R
         7Jmw==
X-Forwarded-Encrypted: i=1; AJvYcCUaqeZjc7hSbPmwLTE5DnbXCgAi9hdpthCzewbsCKPhPWcql6Nh4kwICJR2mxtIl8QVAnUXBlDNDM6R8tM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyDNtn+3mqHREpIQAQ0sTylcpH2Y410dHD+eqrch03I22OCQtW2
	HUiwLZ1uAMD2mW3M2FVdtkCUxBZu+jSb+oCNg8SIgLzZivxvrniIxN0E
X-Gm-Gg: ATEYQzxjjLEcDtZbKtmHhaF44awevip684l0MmGoK6XI1bAgd/Iou3JHxmiq0slertc
	+GDN9OvHsXQ0YEFoNNtYeo9PgHQ7RnQ8dgdeHL23kkP4nB0J80d3gJ1GQ+Xl3ZXtVa5aMZ29lpd
	/ZAbXxD47y4W2JyDXG0mUQar5iOAfzZMVvBRyMHuZQydiRx4UkFStQam3lbjrrqkwV+Vo3zaK1L
	rGBnTVftJioYVYFl2ooCdFV2Z7pmDsA4kEV4wijKybDG4nKgcccqOCzoueYJMZ/SJsqbBefJI2W
	nBineuMHxUG0a2a/xv0H81GYTLyLhWpiTxWrIshXEyT0yLMO2dMZwVHxroYflbuSM+drbjOtYXn
	veJqO4R/PgKhd3u3Ja2LBqXe/DQbHUtgBKrFRAOltr3H4ilX20QetmUf9ya2nBbDOGa+6r1Q4Zj
	E72Mj9MzTsySTjVWt+5yfwj730YdOSEu+2vP8dfG4h1b1A+D8TD/khTn85iJwVQe70z3GAigOOF
	yBnBaz9HK8OyLy3lByoYg==
X-Received: by 2002:a17:902:e846:b0:2b2:490c:411e with SMTP id d9443c01a7336-2b2490c53c4mr108364095ad.6.1774958989240;
        Tue, 31 Mar 2026 05:09:49 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642c5asm109350915ad.7.2026.03.31.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:09:48 -0700 (PDT)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH v2] ARM: dts: aspeed: yosemite5: Add MP5998 power monitor
Date: Tue, 31 Mar 2026 20:07:34 +0800
Message-ID: <20260331120734.39260-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.43.0
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

Add an MP5998 power monitor used to monitor the power consumption
of the Paddle_P12V_HSC rail on the Yosemite5 paddle board.

[v2]
- Describe the purpose of the power monitor
- Remove software/driver related description

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6b..6287f80d70d9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -422,6 +422,11 @@ power-sensor@45 {
 		shunt-resistor = <1000>;
 	};
 
+	power-monitor@46 {
+		compatible = "mps,mp5998";
+		reg = <0x46>;
+	};
+
 	power-monitor@47 {
 		compatible = "ti,tps25990";
 		reg = <0x47>;
-- 
2.53.0


