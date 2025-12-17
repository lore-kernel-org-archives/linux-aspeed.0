Return-Path: <linux-aspeed+bounces-3127-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEA2D6406F
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ583h67z2yNJ;
	Wed, 17 Dec 2025 13:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939404;
	cv=none; b=ROWN6S5hzF6Orb13KQvcxvodWbs3qIHjq5J9LytsqxyVQktL7eFkC+PR68psqLa8d6FKY5z7g0nCsqsNlElcLCixj5/zeqJj8pLiqBAFxZ2PD90dyjymotmXmWQeGFRERLSYOGEl3jYIeq0fN7EAG6jiMJ3cxVYuIein8Ew7G0h/5qP1y9ZdNK9vRSKfA3gOEnF/K43V580WidBgOM0TIA6pFFIboC+UaYeK3mFmC/82FhA719cVW2yXY1CoCB2N3dtj+4uM8GlNHjyTFCaYnK9Z0fmuSdSLktY79lhMHNr7WlVVVZXxUxWamww4IGgGkRdVwTluB/uefR4wC44ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939404; c=relaxed/relaxed;
	bh=Sk2qbkT+uPe7dB8QD3lp2P245Y8mdzpsNSq+cs0R5ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQmgclbUCmyS5dk4v9gmPGpeANhgRuLuUzUX5exLnZkrmzoKDMD64RSgqkAcrvi4esRUHazhP7M0ct5dvtvQcBLN1GbK+ESDt+hqJ7kTlU7sMBxm/IQHYQJ2ijterLaGT3B4JylUztmxg9HjPBUUBnPQxXWRcqhejl5+k3096F5m752kCPaPCig3mKT3DqWFuHo4ERqMRaM3J63D4HHJKH1ndyB1GUZhlz1/ZgTgUuUD0hTJpe90xtBWd9TVgsGIGoGh/ICp8jruyMXz3c04P9a+B8zlOKgbKJvkaD+2292nAgNx0DveanFzcOJZc664Qde+P9Cvxn/GG7S+cLkL7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fUfJjbG5; dkim-atps=neutral; spf=pass (client-ip=209.85.210.180; helo=mail-pf1-f180.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fUfJjbG5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.180; helo=mail-pf1-f180.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ575JXNz2yGq
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:23 +1100 (AEDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso5900448b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939342; x=1766544142; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk2qbkT+uPe7dB8QD3lp2P245Y8mdzpsNSq+cs0R5ok=;
        b=fUfJjbG5mM29AOJi/RtzJrN/tmRHi7++a1j7Vb2ZP5E5mFsXHrPQMFzA2CIJ4tSynU
         hIvuZNDVvBQtzjHC5k7RY+fjlgn/his7mVsK0jYqDOc6gpIqfOErT/HyTu7jIEsvjpkk
         29KOtC1RbtzlK5qP0R4EGzhDLHW/3FaswT6ysR5rSA65Os6RzKv164XPYjwQsfWlKfAF
         +qctV2/oU1WBVPRmLceEmdpw2LERbfmpnXgBtcd7Dbon/XAJiZ4Jb8G7JFfRoul79An+
         0abB8UvOok73DoqezLQXE09APTmqeiWQTkg2TFR5divg/jgv9FZOY71HjlhJZ2gJ5cs5
         JrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939342; x=1766544142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sk2qbkT+uPe7dB8QD3lp2P245Y8mdzpsNSq+cs0R5ok=;
        b=kjUNTFRz3vmEQBTm/BjDXtxBiO6QMZISpGuK5skXcSpAjNI7oLBEuguChDaPjuvwr2
         YbJnRgn3Y4a36aoJY2XYXqUUIBBgTetE672p1cUEEInGANHrmQosm/XZD6Q+NYlVc9na
         uGj2K1pos052n/scgawXibO0OcsNQJ6iPdEa1F7Tj8cKOnqgLDQl+ivqytS9Da3dm0PS
         LOJeAMXzriBXFskigNxLhfzWKBBq9E604JmzNdOPQwlnqri+W1B6VELbTc7iQOvB56cZ
         LD2VhSwho0HW3DQJgqxjiPo+9yQCJsRhbnjXD4cf1BfoRYkVpmBLMd45NsV8fOi0izpE
         cbFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2SNBi/oLELVxD2kbi0kOz2iiisXiXY9YPm91KvHRHN/Yj+NZWPxqJBsXRX6gvynz5YICJPxkusUHdqRI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx53fKXIKuJBOcVilCjkBoFjbt9ClGbiPH6T8+wEueJEdvjTkfG
	r9lK9++jpCd8aVgDOb3a4Q3815v0aFIws8AKo9su7xZoBF+F92XODalypaFFZw==
X-Gm-Gg: AY/fxX6qhP0NLgz2HtdwuqYuOIYuZRFigQRthki6Qntv603bev3g9Nd+e9Org7JA5gE
	cAHVEMPF3KLvpx5qTuSna/xfzfXyh1yO028fgIxCQ2wv/bYLTSkKQShq4j7fgJ8T/BI4HRUQhED
	CKCP8qEFWzRZsrYSmAOknMaRcbzQxI80Hi5ezITOPmjUJ0qaRBn4kECUgdqXJ6xc27dVZMzSuJ2
	2Q8zGX7l8D9Fu6f5WJxi9+tLHPWCxudJSWJNS8hwPqq4oydiyoVauInerqO1TEKFgMYk/Cmm0+Z
	2Odaw1NAg7Uy+0TDJcRWTK+eJLIAl4bGfkmjkHoFqsmG1XxGDNXFLJggrlNXSWh6go/P91IpjTs
	w/YkVMszXrJjbP5N/AyU/CcjsU2hqkOHSmKXMa0bWMcmsJzcd2XiPKSpsnwuHovkYAFTsB54fqC
	krrSLWD+kOb8mM2wA/AT650O3RUQFP4oL5nx8zmvNjySSbIoR68lPpr3zBGuV1VCg8Zrpi6uHTN
	7NqULBHLYx9Fyw=
X-Google-Smtp-Source: AGHT+IEEKjfjDmcAxd44EGFsYj4XdOPu6wFwNvyi9NIvCiiOd5PWZPd+nRHMqunn54uZ6fUDCXQHcA==
X-Received: by 2002:a05:6a00:bc10:b0:7e8:4471:ae77 with SMTP id d2e1a72fcca58-7f669e80094mr13699793b3a.67.1765939341840;
        Tue, 16 Dec 2025 18:42:21 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:21 -0800 (PST)
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
Subject: [PATCH v2 2/5] ARM: dts: aspeed: bletchley: Fix SPI GPIO property names
Date: Wed, 17 Dec 2025 10:39:35 +0800
Message-ID: <20251217023938.445721-3-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
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

Update SPI GPIO properties to use "-gpios" suffix:
- gpio-sck -> sck-gpios
- gpio-mosi -> mosi-gpios
- gpio-miso -> miso-gpios

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 9cb01381e482..5919a5046078 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -39,9 +39,9 @@ spi1_gpio: spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


