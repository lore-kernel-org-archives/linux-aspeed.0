Return-Path: <linux-aspeed+bounces-2461-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AF0CCD195
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Xg2y82z305n;
	Thu, 16 Oct 2025 09:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539187;
	cv=none; b=R8WcgavW9Zb0lij3SgDAV0fdEWdqcQFR4omjMDgi2vZpA6MunlydtSag6cBCc0YzgtbN6JdBQmjI7A1MaWZEBaizmSIGsiyCsKmGSatEdasL9aFK73TT1WPKkBQ/2a9igygIx4WoIeRVYA5hPO/FRSvb9/ZdWNI0tx2LmlZOXfeiiM0PTIHLioDB2i4QJobgEA8JlkduULI8e964a14gmWAom5LoMSPYbwTHypQJRsrYvy+dHaM5DK8LnV8bKWEGHRSYX1aqWBSFkvjS8oNphuqEWCvvKKUDDpdNjCSFxDsIOaMCCQ9nYDGLk9ylGF2gb0lQ1SmRjTu442J7KZPVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539187; c=relaxed/relaxed;
	bh=F/LQNtZoS7OfijYrFt3rjrDuiajb22vvwUPhElheOqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRYOY+4aD3s5Wd05rrX/E8mSkN1f7O7sXV4XV29ul43nRYNCuku7cKY4e8XPGIShJ+c6TTdiWkrkNolpUf/6EiOAmzQiBuCi78Mpm8o3mH6KSg9vr1XyTskyLBG7ui/dz+6R/dl9Y9EjejjT17+N0mUW0K2DrHjhf78uazSPQi8T7uLKGHFxxr68KhoL9gxjznOZ2V1n5zU6B8L4X7tc998PPCnYgpQHCobOaZ1Z2i3KO/NWp+w1goMQzzRjpvBwi1ePufQs0jJ1Cexo1oMGRO/z3REWy1SwHW2HazH6dJ06/4Om9TV3rqKENDot/NifekkfuswOreMEEF3HLUwRWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=epOIKxSK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=epOIKxSK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyp5S9Gz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:46 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b57bf560703so4357610a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539185; x=1761143985; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/LQNtZoS7OfijYrFt3rjrDuiajb22vvwUPhElheOqs=;
        b=epOIKxSKw0k0A0imp/KtD6+YjLEQm7Pl6VA07k14OsAErL0YjynC07D4ojUDm5cl39
         ExN/K4cN1DxJ0UrXSrp35+5vsWphiMqGv3OvEYdTU3uhJCmPYmIJtguY94I9caND4b6T
         XRORMvw3U0fXEsOzzGpmG3V/jaHA55LyP8wI7L6ic4hfyKT5IU+MYVQeMlJ25bw3g2vi
         uQNB88EwcM+QI8skEXGXR/hw0xJQDKgKZj4YOKI/aPFujmwmh6WYFqPF4LBU9OpoMnWS
         MizhNSnjZvAUBtT1sOGxdDA29Vf44JrMQSk1iDp855z7YSrW39gLAb5Lw9+49IBvRva5
         httw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539185; x=1761143985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/LQNtZoS7OfijYrFt3rjrDuiajb22vvwUPhElheOqs=;
        b=h5jijAE55s/LKLPhzg8zbK1dUlee6TTMqoE79XueUjaKwNDP1/RSiy15YMJwwCKILT
         7q8JjLUw+qp5rg01geXEAxUlwAPvcNCgIr1v/YNzy3/GRIb0MbnMqdi2D0TBlu1n0Pj2
         1pVIMPkS7T+zCT5s+aBX5se9npTzOaDIoXEjkqwdRaoNM9eWfKphwEfYrUU0akFUNwUG
         hixVPlbH7IlZ70jjXKaxTfcflCJeZ3EkMTm9FVvM5ICGi+nNaX+bNfV5rVgI4ZEPjkRV
         cfLllHtCCIN9ly9MAhieDX/oAK3KVJaeLEdK+R0TVE2pVsPbLNxBeRZ9F5jqcojo1zWN
         UTCA==
X-Forwarded-Encrypted: i=1; AJvYcCUHTLNDuAS1uJR8Lk6SQff5ANopv4r5j2VbEd6zz5gI+/f/QyPTbUOeisteoPf0n9APnaF6CVmyle/zPms=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOYtIbnWCWu5QdXlNQN7kzd8nFP9IMoNN40zzzt0hgYqPeXUXh
	/p6kPMcNcwHIERpZl8nS+X5B/gqtUofa0PnYMP90+NRA+ziwDY+NODXb
X-Gm-Gg: ASbGncu1Yw+TrEc/Sc8vcLBfB7F1jviWpOrWnlIqh1HmGPABtq93Z0/swfe9N7kZrjw
	0HI+Sy/Syp582x9NVw5e0EAH/4XCdUcGa/gLZHd3RncjOltc9FbmUe74IXVoG6CL2weUhoTUPyS
	y32dRiaPZiYBvH93xQ8naKD4IPqetw3PPJgO8cbdypGz2tgBdmpFZF8DHZvBrdjQrlBqOB6Ncwt
	7mB2jiWJynk7n/FeIk+k5TkH66Ee8q3phDGv1TJNkEtZ06iS10STK7ZHzZjx/dab6GPrDVIjHpw
	rl3TyZLDijwrFBCqWn8YSFyc1/1wdAq+vS962t5tgOxIH8zPKSlNJfYAI+pAGiBDMRmbWAv+M7J
	jgb/bImBDmpqGYd61oFCsPJrW+MPdHtbADlEpRyyEiHZ+hrbPaTlz6JRoNO6no41rKpdFdjbh+P
	3QeamWWlbNdaK5ypyWgtPo8OSv0r0Tog==
X-Google-Smtp-Source: AGHT+IF2UAqKBEIsjWDU03fhnfdk79hzfXklRzmYJu0XI5WZNyJUsJl9A1TbaofF+An7RpHOubeYSA==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr331259715ad.14.1760539184757;
        Wed, 15 Oct 2025 07:39:44 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:44 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module
Date: Wed, 15 Oct 2025 22:39:03 +0800
Message-ID: <20251015143916.1850450-8-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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

Add eeprom device node for PRot module FRU.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 3ca5109af19b..f74f463cc878 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1076,6 +1076,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
 	// BSM FRU
 	eeprom@56 {
 		compatible = "atmel,24c64";
-- 
2.49.0


