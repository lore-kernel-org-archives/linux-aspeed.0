Return-Path: <linux-aspeed+bounces-1534-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BE0C7115C
	for <linux-aspeed@archiver.kernel.org>; Sun, 22 Jun 2025 03:43:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPxr41132z30TY;
	Sun, 22 Jun 2025 13:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750563780;
	cv=none; b=KPG6mDejdNeiwiuemxvOXM38NC6oK3gGzDCBLJqMy2SxQMe3Xi8556TYYZkXiXOztPqjcGV4ZLay9J16kHhBvYYzqJTAq9CrdxE4gxaa6I0regDRnllMMKH3ypaRCmM7t40LDmZDuV7bckveZ57Gc5RP9yyRQHWXEr7Gy8bEQDGJ1/n3T0HMPSYRtxiS7NndgZwu/t/IfIhd9m7QhoudmM1G9757tKd+k/K/ON37vQkXrqIknRqIB0LdlZRYFB2lJpe57HvMGF7cAD0W8jZSrQNLMkBkM2uUovLqPHwyeMmB+/Qa38D8nyMgWyeRposO1JZ6TPbz92wWS8V8lcrwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750563780; c=relaxed/relaxed;
	bh=ACa23R2a+vWrpVNOMeXLchvOc5aLFqZI4f5KCyJMeas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hd0d11G67o0NTkME1e09a1+eAqHDdG5/TiM8xZcwGv+AqNwpjiltxTNVw+wmOqG56AriM1TzrFEXE9NbEfKDA1UPncnSCwwX+NrDww4BuuTIk2V+byjiPCrCKfqk4uBzEAjrP8lpH9GzBmmu9OaycPGMl0F1M6d0XpFmPzpV7HiAGmMfB5azePJnMaZsT2IJdjS5bUeqNa/vmksHUQ+7zXOL/c5n7Awhi4a1+qNc3pmZZ/u/cngsWpR7VyFnFoTET2HMapkpq6oWumBRx2Iwag3GUHZp7ip73Y02chKKiby5P370sRsnTq14/ApWcw8Gc27uaqVceADWGQQjfYPBmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kiPizAp1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kiPizAp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPxr252k5z30DL
	for <linux-aspeed@lists.ozlabs.org>; Sun, 22 Jun 2025 13:42:57 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso2907799a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Jun 2025 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750563775; x=1751168575; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACa23R2a+vWrpVNOMeXLchvOc5aLFqZI4f5KCyJMeas=;
        b=kiPizAp1ECpMWHqRngJO9cQUSUHXRKVMVcvzSA8E1cxX6Een2YLX4wgm17oPcIYmkZ
         gfxiH3F8IDldY5dOLhv3tCWPsCBKzIy1EcAwuEYOAiN2z5moIYhQ273ca1nOuBlG5PSe
         AZY8h3QotvWkKp6drhQ8wVOv2vKECqhGZTrjyM+wTgnmrRX4f/WnQo/Owrug87hI4/ee
         FgwyOspr5+PHlXm3/ow0cz9EhvlBPFGM1RNEP2kB9L+HwvERHDXuIENDh079borTzGJ6
         KS90y683AHv2RUjPfGYJE0GB2amnYConUSBwRU7t/lpzQOxWpD/mAAo/uNAHqcE3Msbl
         mZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750563775; x=1751168575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACa23R2a+vWrpVNOMeXLchvOc5aLFqZI4f5KCyJMeas=;
        b=YJiP0Q0V6vvSVk31G2nKUcltPEgCHAGys2W6lSR2Z/Z8EcatBiq6KkX5Rsf8L1P0UC
         plFqxGnrNN42wBYQ9aaxo1D3b/BeRIKL0C5HPYdW5JndHbLs/ocJFcyE0UUxLMK1jUW/
         nFeYJbrkViVR0oQnhaZJd82MaU/jsBx5jOxgfImrMT42/CFQ7lIRYPLEgvUz16FggSUf
         XefidtipeyavIG8THUtnUrvLHq8+y2c7lsDGRKwydxI2S1TujzCBDDj1gknNZkYGEAEg
         A4Yr3nPs8gzHjwnz5EJIWQFCMhwu5idUh3mKK4LOQQNN2iOo1pOMK/cMF3SZq5jttkXv
         N+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUuQOy+YOOolskwUZosYyx0tX2JJU0IOoaAKt2owBXDajgLgwzAkPlHTPja96HebgtxqDKTaQ5ItFTMMOI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZ/IAL0B0rDGvfKsq4I60graCiuYFljsYKqQUR/uQpNDzLgkxk
	wHh3bfT4iT5jN/c+0awIhOzIDK5GZJ9Js6f26rfteT59nsOaMc1e7WBc
X-Gm-Gg: ASbGncsHhQx8h2HCsAeLhIxbBolXQx9QRAZJC3yPD2qtJgDytct7EXtCg4b+NEV06oo
	MvTR3CLT7HBSRbEC8pQ+1Wa+Bb8wJcLBMS0xo+c4n0RX40yEQ56txr7Gg7it4bsC2ZPPnNFHcCt
	Cd7pFkJ3gbZtDvQAGfB51SgdKLE7b3dCMEPeIFUJWdTo9mHJ/dR/EnDi+qmQJsrdNX5pi95vg7f
	VH4oa+JALGWEUcwr8jAxnOLZNuIm6aFw0wow60uvgLFMsivNhC2ykwQBsiahK+Cx1m5UCyPQafd
	XdbPCkeq4jcYu81ZZVEEOTaEimoDfBFss+ZQeYZsq3V7lxvnu37ZVmHhYAdSAJEVC/f6GTfCgvf
	ESxvWIXiy9UkZRSvQKYcTtyEDUG960ZFsU/B3GRqorig2KaCGEsSnD+6n7M+INlGPTKj4pMS5Qw
	==
X-Google-Smtp-Source: AGHT+IEpj0VOlzI9r7mWn9sjy0q/1s9TFnZUb9JfOL27IcJREPBlXh9zEia6LgG2v+7itLsR3B9dEQ==
X-Received: by 2002:a17:90b:2703:b0:314:2a2e:9da9 with SMTP id 98e67ed59e1d1-3159d8d661fmr11658363a91.25.1750563774425;
        Sat, 21 Jun 2025 20:42:54 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a333a79sm8222291a91.45.2025.06.21.20.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 20:42:54 -0700 (PDT)
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
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com
Subject: [PATCH] ARM: dts: aspeed: bletchley: enable USB PD negotiation
Date: Sun, 22 Jun 2025 11:42:47 +0800
Message-ID: <20250622034247.3985727-1-chou.cosmo@gmail.com>
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

- Enable USB Power Delivery with revision 2.0 for all sleds
- Configure dual power/data roles with sink preference

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 66 ++++++++++++-------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 5be0e8fd2633..ad0051825a32 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -398,10 +398,13 @@ sled1_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
@@ -484,10 +487,13 @@ sled2_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
@@ -570,10 +576,13 @@ sled3_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
@@ -656,10 +665,13 @@ sled4_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
@@ -742,10 +754,13 @@ sled5_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
@@ -828,10 +843,13 @@ sled6_fusb302: typec-portc@22 {
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
-			data-role = "host";
-			pd-disable;
-			typec-power-opmode = "default";
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x20>;
+			power-role = "dual";
+			try-power-role = "sink";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <10000000>;
 		};
 	};
 
-- 
2.43.0


