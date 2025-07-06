Return-Path: <linux-aspeed+bounces-1642-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C0EC83F03
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5B0KKwz2yb9;
	Sun,  6 Jul 2025 14:24:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775853;
	cv=none; b=klZ7P1ntJvTXwm7FQL7kQkFn6SdOQ094cEbI4KPCuyMfaGiDMcLKifsvV0nP3BfQazjzzyV6dbYERzqxLRa7pLLjQ+2VIW1ELJXLP3GJ49x9cDeiHGAdOH2J0ZDsEQarfk6AC00kD2m6v6QqKRDGd++L4jteQ123vKq6zV4s2sF5r0iaXBGvjVTGcIZ3WALDMkVAmNDFYI4R6XjH5+B+WpZ74A9URo14TgvsMnawyW/Cu4VTl4dIDnIRC9eI3TGJLuOD7+XTOYxZ6PvmaXuuV244fafWrx7Lfmld06AlF3ewZ6lEQ9uvDY181aAlOlCPqZeazjdilqPBl+cBDG3o8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775853; c=relaxed/relaxed;
	bh=onJ/SiPYut3DmOwlVXhMRtyJ+CvjIISGxDqve7qmTAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOcVABEDljWQxzMX1n7ylPPjgg/UrU2h1ahIVYNnuzZdv3hG0z0IKAPQY1xPR+/vv6pTCCX2hlmwGlHRlULiJx4B1Gnjcn2h1eHRz9iPMZEpoMDh/uKBghmNuc8wt7bvdj2UBKl0u4R8ButHgeaHJvRfOta8ERAcJjve3DRTHi3jFGhLPyhE4q+8KQmw3SO4KrbZndbLEu1cwi1mtdcGli3LKRlT9TlXBL5lejPrwTw2kfgeFGK9tzVJPiYK+abr+iNo7X7NmSsynpc+5Fkb2nkZOF6+cvWAULEg4tsX0qRk/UzEedtmMCJJJfZJqnEXRo1DWAZZteUzSOezveBHfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GKF2fV/a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GKF2fV/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ586Pcrz2yRD
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:12 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7481600130eso2916924b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775851; x=1752380651; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onJ/SiPYut3DmOwlVXhMRtyJ+CvjIISGxDqve7qmTAs=;
        b=GKF2fV/aRl80lLMFucPXSppZAHnnLKyPybab9hXkRepqhOZX5bzPADBbn6NtIOWMac
         8BfrcHEejwGSYwHsv+hl/xUnhBGrPxvSdaUievAiaikyLvPoKqfytcp42bIAyWVXPZoZ
         xE4VstO5LQ9z0wrqzBxdShqDZcB8pH1mrLRxzZ2LO64Y2GTek5ADnIMrZabo/ZOVvW5s
         ibelrbm2KfL2MItWtY5eOFmSG3Z0Lv7OErumvT094+G9IExe8v1SEMJmgc3osOVHtoGE
         UQR+YgVS6lNzWNrQj/mUjb42fYVJ7K1yP6SRufZ8aCS6/j6+qbI69QcvP1W1Z6en1H2O
         PVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775851; x=1752380651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onJ/SiPYut3DmOwlVXhMRtyJ+CvjIISGxDqve7qmTAs=;
        b=tZP6rdMjhyuZhOpP7LALz8OUfM0memtzEbcWP3PPvkEd57V2ZBwVTHgfkaCz2HvGxd
         pJkMHLsW2HlOJ5uDNWu2+YT+xdxIyKox+cpU9DXi+Kz6QTwBhoNSOK/8bw+WOb9pUfvT
         XQsRtjzkObK2XA+Tk6jEJD2pU5/lSIwl3dUJwulIXX7yHFTqLhkF7L+FgPub+fTazhch
         9sG0nazpjvRdM8eYkf+M7JPWELp8NRlOkD/MAlxiudyOELMjkZnQPSjtIX01k4fRX5zq
         36nomrbklUERZmqcSJRMi8plBFd2ZZEQ1AKlHkS9gPSP/lxUZh8tqBI1WfkHsEpUeZhB
         k2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgtPB7sbTyDZ1twaU7o6oQ2NbcRP0Hra58siGlS9qBfkg9c3EmwN0T+kwPSBl4HO4tOwHkrmPxNaTLIGs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywf71KRDJ1YtzBiRs4JtmnKQsQl/BG5Fbpfd7Kx8Dmbo9yCSVH8
	YsXvFpwWZymJxFjrjP9aQdNvBDCobto4rGOoUlWeNYvj/jwpBrT2L+ij
X-Gm-Gg: ASbGncu6xxZ3aTmVWB18IVuZBpPzhsiW3X6LNg55Nj9PJcFULiXcJ6WOiMah9MukuN+
	Pwo7dcTHfV38a0sq+0SXVEZzGOXXjHf/AEZBudmmaawsBXjyfcSWfpsAWAz3DOtO5bfr14je4JG
	sMC234vyQLTLjZsxQBuH2GkIsSoFJcek842rQb/dt3A8yPbvkyB32SAT9tgCVKVUVP6Fp7XL96h
	QK5jLALihoqpWXJJBAtTOUuGXGlkV48Q/kboc8RKFUISs7hmXPHnhUq6avyogGukrRr5MJV/Qg3
	7mekyIvMOuQ09vSl1CrspVZc57Ai8gsgYTlgjSFiN14UGsolScMC32vR32/fnlErE4dQhI0ktW9
	bhJ49Rw8ILV8Zd09IWljmlW8fq3/hkVRUp9n+swY=
X-Google-Smtp-Source: AGHT+IHvMM2cUvioZG3LBq/FM/U+WNpT82w7MGHWKcdsUztGTKRn4oRqsD6DH0I/+oFoaIi0vt+LAQ==
X-Received: by 2002:a05:6a00:130f:b0:748:2f4e:ab4e with SMTP id d2e1a72fcca58-74ce66697a2mr11229443b3a.11.1751775850900;
        Sat, 05 Jul 2025 21:24:10 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:10 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 1/9] ARM: dts: aspeed: wedge400: Fix DTB warnings
Date: Sat,  5 Jul 2025 21:23:51 -0700
Message-ID: <20250706042404.138128-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Fix the deprecated spi-gpio properties in wedge400 dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 5a8169bbda87..3e4d30f0884d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -75,9 +75,9 @@ spi_gpio: spi {
 		#size-cells = <0>;
 
 		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		gpio-sck = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
 		tpm@0 {
-- 
2.47.1


