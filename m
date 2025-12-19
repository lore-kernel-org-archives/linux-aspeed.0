Return-Path: <linux-aspeed+bounces-3153-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A9CD74956
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Dec 2025 06:33:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXd5F2KwLz2yFW;
	Fri, 19 Dec 2025 17:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766125985;
	cv=none; b=JB4+xcnai6bjoZodZ1XnS4aLSJeuWWJCFR59a3bLCVvJ3B360lBixVGVWcJ+e5aw7FhTsodOUu6oiIiuvhb/2zwdTc0GzpsC1dtSCSbftQzJ4hE2hrh/BG+/ONWL2Z3SW7d98Wf2ZavodvNx3R6w7mnYyoUB+nozpv3P1xAQyvw0kba2phKijWlFfTR9JuzmYazoIOEmfvuHrY89uZqwHdoqS+kutxr+jRXkscU1E1HqhMyTkGrQBGJ8ZfKTojjJXygkmK9/0glP3W5U+mTtNzhgWj9jPopI7i/fKeyAc2LbLQVMSx7KKQiW2ttbR3RL99X0wfLmX7Ua6H40f8mL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766125985; c=relaxed/relaxed;
	bh=ffCxZ2nFXFTlfxcGv5zSYTwlGZiMvXvgW6fCFKo5KtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpDx69ny/hD7ST/gvM4Xf0kLMRNRh1XVCRuHzdK3MxnmDuBafrWCyOWA/aSFqpMXoYM+DTa9B3Q8JcjOvsZocNu67yeelQ0RaIadHQepjBkl+MMHOfATormOcLxnkMBpTHBVAc6iOJM4d1v/Lrq+VOK3ScpulPLR48y1Yd7EUlkC+6UhOiHnLkHoldK6HL+arJ5ysFHgN2VlA/0mqvIA2c8CIv0L1/ljN9YIJm0MQaXjEIOR4AdQ9XULMMZqfc+OjvknKLPaxjir4WKTY3bX/KiklSj7YKCzARLR90pMhOTPaHboQ7e6tDL3jrPRZABGCuP/49Tqs67uXkYYE/3hfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IKNtKl4e; dkim-atps=neutral; spf=pass (client-ip=209.85.214.173; helo=mail-pl1-f173.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IKNtKl4e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.173; helo=mail-pl1-f173.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXd5D20flz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 17:33:03 +1100 (AEDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f1bc40b35so25841355ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Dec 2025 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766125921; x=1766730721; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffCxZ2nFXFTlfxcGv5zSYTwlGZiMvXvgW6fCFKo5KtA=;
        b=IKNtKl4eLA2N9gDNAG5sJfdpCi8PyrNnNvmliwbX7jnD3IzUJ9YBsER2B3Org3h9GP
         kLhdNLvd19XLV++t6wQYJAfYODRA7pUvAiB6QlWx+x/w7BMsjLOba6DhJ12c3zxBoRi4
         vZA24bQbL4SNq7rkXXW8H/+9bX4ElcgBuAFXwdNJ68ZbvDcsmE+bGFPCVRG9ety56vFV
         Psb+DmnUrlVYtJrNEsLpSFtnr4SXq2UuWg+K9xKm2S6gkcMgbj2PaIQoak7iv9U5n9eq
         xZxVNCCCYY3i2fMWXdxb+XZzrH0Igekrsw/rVTOmJ7+Ss2VmmfVeZD0uReIZywgc0uD6
         o4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766125921; x=1766730721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffCxZ2nFXFTlfxcGv5zSYTwlGZiMvXvgW6fCFKo5KtA=;
        b=xBpZfAC3S6bZNeOyBBDseIPBiMbtDXOPDke78PcBRIeX9aLNALKd/n36sYxlBBxvSJ
         3cnfTn/9FWBVVHgpe2OjepP09OAzT+F8iLrz6vL3wTDuYlJlP4EE8vphWTmEIuLVMupD
         vuusizXlNi/SHY2y+2Grb8XheiN+eY4kIJq2Qk5lxkQsA8JbO6ubEo4IG0WlYy/H3V/1
         qCTmxLfB0A76j14Ah9HbL8NiXazs/9mYWySaVky3IMQtXCMxXQE7izsvzwbtfcnLPijk
         2pqZISvQLkgtVzjWV2vriJnSBpdB2D3fp4HSYPCJwrXv8mJOW49GC8FgYzN/VRMbhdF5
         1tFg==
X-Forwarded-Encrypted: i=1; AJvYcCWTN9vYR+7eM9QljrFhehCiTY++Q5sTxaqpi7ugb/K70ROhjP8Ma7jVxn2JzQQ4KAeLi4Zxr+jYs9Xy+n4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yye+iufaIvuaCn5kdXiYXPS0gckQYwdq5zfntlLBao+X6iAgGvC
	b0ZN66F0S6164p6V5hj8EhS7UD6GaWCCnAXNQBy2WLAPfQGXk9L+0tcB
X-Gm-Gg: AY/fxX7/zi6yp3/ZZ7NEg3Ru8/QxaRJN+PXqcFLESHMuZAYzIuX46XFgYtuLQ5I9CkT
	pMXsqod2TzChxMYW7BTbogCJod3xSKoR6f/Ew+nioy5aJbvQhanF+5rYEiFMKmQ7kq3nxHSDakh
	FCE0DyAPXY4CCjrfhaHAAskfjmE69PSboEiUdstz0/YoE2DpgrhZZL58raYkmU/5E061VmwOHxY
	nWKsdChJqoTNba9F3zd2/Uputt1+twSynGZEUWj09/kF8c4x5iCk6tl89iUr/5kUEOQGtwt0WIc
	cXcAoA4jHQkkTHhuSszFlu1/RSGTUA41IQcnXzoKCXYQpvIbCcw/2NVv+HiK1Ijl1vWw6vvoARB
	oHlG7k+ovh2TjgJJQTrJMYRZr2UN5R+CJtecGyK5p1jaGv7gb8RR+S5dSPEzwocbvNleZH4rhoM
	Br5p3aaQaLccPBWvTYv8wIqf8hjddTsoEowKRfVNRoZ6Aev17PCkP4OSphz12wRyC6tEFdlIkpV
	ZtsHAU0mE1P5Hw=
X-Google-Smtp-Source: AGHT+IGyFhky1G4hqCr+wi/pSF3CrrH4Dip8ZF3rUWremoK9ISMKxqO8TRKZ2xEf6hlUkzi4PRFAIw==
X-Received: by 2002:a17:903:40cb:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2a2f2a41a37mr17259965ad.56.1766125921058;
        Thu, 18 Dec 2025 22:32:01 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm11679335ad.5.2025.12.18.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 22:32:00 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: bletchley: Remove try-power-role from connectors
Date: Fri, 19 Dec 2025 14:29:48 +0800
Message-ID: <20251219062948.528824-1-chou.cosmo@gmail.com>
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

Remove the "try-power-role = sink" property from all USB-C connectors.
The try mechanism is unnecessary and wastes time during connection.
Since power-role = "dual" is already configured, standard USB PD
negotiation is sufficient and more efficient.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 7c27bf6bb51d..d1a04b63df9e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -414,7 +414,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
@@ -501,7 +500,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
@@ -588,7 +586,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
@@ -675,7 +672,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
@@ -762,7 +758,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
@@ -849,7 +844,6 @@ connector {
 			label = "USB-C";
 			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
 			power-role = "dual";
-			try-power-role = "sink";
 			data-role = "dual";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
 			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-- 
2.43.0


