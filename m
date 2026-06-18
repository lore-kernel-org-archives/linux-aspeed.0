Return-Path: <linux-aspeed+bounces-4272-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D77CD98F0
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 23:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghH3N12MNz2yrr;
	Fri, 19 Jun 2026 09:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781768457;
	cv=none; b=n1Q3kCOo5mTSbhDU7o1N5vDeWWDIJuUiXzzhoOGHtHosxy/Z8AwLn0S2bB8m4UJ5i8F5fJAA+4GomfsL9babRiaI78IQI5Fqf7EWxqzcVckdtuUs4npQ3cfwQobPBNIhROTB/ayQlZqENkCZggA4lxzZagCzlZ/KdKpuiOQKcS9QLTE8TqIYAdEyoMRziCxcjCUuW3SRcak6o3nzSo1nW/mcaZXdAZnDeO9HlIvxJoC2RHUQ4l4mSDYNuKaAVl3+vD1vxlbFio3bRKoqjIGlLvI1Do6V3cfv2559yfAtIBuKtXPx7Xw0wUtnBMKpXGewnkyK9M6DaBxZd2rv+Iw2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781768457; c=relaxed/relaxed;
	bh=NyTu92Zpl4iFWsunxbLWvI4/2I1YGqKD298epHlDZtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP0ieQPYNJmx4sWUkGK9mTJ+5vEd6fMGFd+BaRrZ6oNUX/pETJa2wKXfqPV3Dkv+JQ+GNOLUEc4s7AigDtZ/JWXw5AIhI0s5A7rR9cGeP9kJniGVXRzBQF+yGvgg7sHpFkR7FGA/aFDPkWWx0lWRoGBMqfm/BQvfKlcpfsDc0Al2RPakuhUioVyI8R2wPIe5ovEmH+Qss3FlsEGMLDyuI4MZ4OoGr9EMBTDijSVDcx2CBenyjBPmMvICEoOIyPbHbePgkfbbAZpebY9mVtsjDz9ZytVrfKnRvmqzIFZehyrgPuJ1CG+rYWRbcrKXctTbw3GmVLq3qv/Q+lImvMF9Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4l3wSW5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4l3wSW5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggt204Dcdz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 17:40:56 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso6672735ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781768454; x=1782373254; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyTu92Zpl4iFWsunxbLWvI4/2I1YGqKD298epHlDZtI=;
        b=o4l3wSW5Xrnl+ryum/zr61zFI9STIjiSuRgoVh9ZHjF5VXhdCFUj7cH+PpO4Jav+sB
         YkJXh7iRWkj+RCyTt7iqDXHUoh1foje48Ry2KfRatat7eJCd7Js7BLDk+AuuojTZS5I5
         aMHaH2TZ9zOUeLrHYSJh5/5/p+8hzuvQbD3M7CHLRb/+ApGqYwgyXDj1fR5cHfo8QSYx
         UkPvJyLDTEtJiaFtvzLJZkNUxH39PdkdazD/JqvZ2v+TN+wYvLWmoufC8m285qDmf/Oq
         QLk+db0J/qaz0A64TkXtOPD/uH3jyfbW6FFKLbSQTodoZemi0dRIBndKEXR5EJJCk+pZ
         qmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768454; x=1782373254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyTu92Zpl4iFWsunxbLWvI4/2I1YGqKD298epHlDZtI=;
        b=ZQRfDlh+rMzZjyJZQBhxktzgQSUVi1Mugwd5OVlNN3QASF6uqk+cmZK1W5bXwbFVMw
         5j9pLkP3dJqndY/xosQfaa/AvMekxMcKWQnfRKp2nqJLilStyBKqYrNdaRSB493yeYsv
         82ogmncO2MNYqkZkAjOyybk4fa9oLW0IxLxVceSpU2/c8OOkfDdFZyEs1U9J8GcJmFfm
         U1hRxv20CZup+KU/1iEEYrEv7VWXaVXSVIkSWglCaRyuxmjSo2F0NU+TLOZ6B/9dxd/v
         lophk9bfQ9ihhv0q9RYrxE1MJstRV0fN9k6gzPkp3TTFrzgBlmiAegMAwxJ1vGPmvz51
         1PUw==
X-Forwarded-Encrypted: i=1; AFNElJ+DfBOYYp9lA8zZVEwMqus5z6j7wKaqd0mpkGAe/1V2LBB29XP7LVTIrnOtFa/hC/MpLsoG/TBzJ4bImBg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+K+bL2k+znVX+arSgEkU3HXaOYe4TsrGiMjzINZrgs7Q/v6cV
	WfZ7DDr2ESafxdR+6wueo+3NnHwc+QOFMtGmuvYmAOr0mwNYcdoLay5cewOh9A==
X-Gm-Gg: AfdE7cmjaXhE7TYnTvALof2qoZjkiYLbP46PUNcL97ahFfwgHtR+g1N2n45qRZxVrz3
	E2dzrDOj9YE7x9oMzgjuLJblLVigujbLTXnYVuL9KkNQfD3MWbZcusYYzTGJIn5uENoPoEtkHr0
	tqJfOhOKPNl0f74TWX7wo9F5wmYNSkaxGct4nR2mnfFuJFfNfb5ZJdcwyQmOG4blbEc/+fFZWfc
	qRCcNUQNJboMJMu5bt/YKnCTV8qVaeFaDIWD6Lre6Nb+P2V4XOn9VfW8g1PgYqkUSys0EfeNVGm
	46cuUq6dObAsGvaE6WIvyNkjl1COK8gDrNzWlWSv77/C96lnldI4AWkKO1kQLFP2Qdw7xYDAhxq
	2q4fBjTOrr3KA+Zrx1kFEs8uF2j3k0XGrawIcYiDA4Zp4PhmIe8C7E0xxHD6FdbOMffMxc1d1nS
	BuhbGVjHM2DNipJB0R9HYyjg7gnnCUz0RWry/zfu4uzUetO6WTB7bDp09Y
X-Received: by 2002:a17:903:950:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c6bbca9fc0mr82427775ad.0.1781768454016;
        Thu, 18 Jun 2026 00:40:54 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac80asm170465445ad.39.2026.06.18.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:40:53 -0700 (PDT)
From: Mike Hsieh <mike.quanta.115@gmail.com>
Date: Thu, 18 Jun 2026 15:41:45 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: sanmiguel: add current-range
 property for PDB HSC
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
Message-Id: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-2-cccf959c9b78@gmail.com>
References: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
In-Reply-To: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Mik Lin <mik.lin@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mike Hsieh <mike.quanta.115@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781768507; l=1681;
 i=mike.quanta.115@gmail.com; s=20260522; h=from:subject:message-id;
 bh=h7xakdJPR9hp5BA+O9WCA+8GKkcNDqtrcIFBDvQTtso=;
 b=4B0AKEFAQOcmD4z2TjXWcq5Iu8iXFKS5qLvXFAVhpN8p4jGBM4FxsZpp+iXlGTIDWEOvwsfhw
 gBfwcTkj7R6DM2PiBnVgBz7fPy4LsIpCOXtkY74OXnxA/XwdsOumh76
X-Developer-Key: i=mike.quanta.115@gmail.com; a=ed25519;
 pk=DRIErV0xX0KMBlR/irAsbuN4L3egitHbC8FHruUH4HE=

Configure the ti,current-range property for the four TI LM5066i
hot-swap controllers on PDB board.

This defines the hardware current limit operating mode (low/high)
for each sensor to match the physical board design.

Specific configurations:
- HSC1 (0x11): low
- HSC2 (0x13): high
- HSC3 (0x15): high
- HSC4 (0x17): low

Signed-off-by: Mike Hsieh <mike.quanta.115@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 3faac0925a79..e518e3fc1c97 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -451,6 +451,7 @@ pdb_ti_hsc1: power-monitor@11 {
 		compatible = "ti,lm5066i";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <1000>;
+		ti,current-range = "low";
 	};
 
 	pdb_mps_hsc2: power-monitor@12 {
@@ -462,6 +463,7 @@ pdb_ti_hsc2: power-monitor@13 {
 		compatible = "ti,lm5066i";
 		reg = <0x13>;
 		shunt-resistor-micro-ohms = <321>;
+		ti,current-range = "high";
 	};
 
 	pdb_mps_hsc3: power-monitor@14 {
@@ -473,6 +475,7 @@ pdb_ti_hsc3: power-monitor@15 {
 		compatible = "ti,lm5066i";
 		reg = <0x15>;
 		shunt-resistor-micro-ohms = <321>;
+		ti,current-range = "high";
 	};
 
 	pdb_mps_hsc4: power-monitor@16 {
@@ -484,6 +487,7 @@ pdb_ti_hsc4: power-monitor@17 {
 		compatible = "ti,lm5066i";
 		reg = <0x17>;
 		shunt-resistor-micro-ohms = <500>;
+		ti,current-range = "low";
 	};
 
 	pdb_ioexp_20: gpio@20 {

-- 
2.53.0


