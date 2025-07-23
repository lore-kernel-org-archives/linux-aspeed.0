Return-Path: <linux-aspeed+bounces-1799-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD2C83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjv2cfsz30WY;
	Thu, 24 Jul 2025 09:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313427;
	cv=none; b=Nf6x1WGIT+yurPRcSzDqfQCGgFntSQZKmvmWQvYqEvS9xFEzuOB9TKiSPE+FlnoxqoBqMLj19F5nQAK5xwnUjJK5yi8QVwVro6zbyTEb5mZ/EJm7bp+d0m4lsFEP6+Eb+dLJOCGA9Q8AfHre7hizFfWBW0RbX/Z83RWuVXjHRqxG2aJXz9myoAi5QP6bE4cU7Qc5fvn+bA3hFjGpoFTY5SggmLAe+qYdZXx5TI/6ioyZtCSUj3rQ4bKhtyIcpZQCvoj4vQncrvQhLUteiaWdE2ZeNvmxhbgRqahVQ3u1ZNa1N3QkqELGPWqObGQ3kBqUgcKFW24nC3miyTt/UwoZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313427; c=relaxed/relaxed;
	bh=hexKS3OBdUuka6mz2tsiA5AZ62DQZfbT13EVs55U9NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJv1EsMINIiZIXvZjXrfQy0s4UlvKe2JDrg9dVezpyCvJM+lvQXRQSrJgYApZ2ZlOTxWtOAXl5l0jKWw6pljsnKBCsqFzRjenXfir0w+Jm+jzLFQzxzBM4psq51M9jSUMSJV+j+Q69OGyf49Aq8CLaAoydSvMmfL9PaljjINXiZN9apeaTVHThTz5gIYBgcfxHTSAyqv0ewFG1PtgPCJHmGFwW8sXggdll6oLw8zkqQtib3o799Tx9TQFEAjv7SjDQa70NF0xkNbNGM7nHTJCkH+HZrukPi6vBY4v/9GyGKH/QbB7sG9rWq8gBdvdr+b2wUU6UHTLT4OAh1Lurr94w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Uzi5Xcqn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Uzi5Xcqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjt5SgDz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:26 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-23dea2e01e4so4929355ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313425; x=1753918225; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hexKS3OBdUuka6mz2tsiA5AZ62DQZfbT13EVs55U9NQ=;
        b=Uzi5XcqnW3h45HRRyALGynRv2MlUt0e12tVQ4M4VqlKlRymRd3ueknAYsH1hYPMnQ8
         tMYSfqsvb+N+BuTxFZfvxECOzAtvn5SR71nLE8EjzH8qnvScH9A6JCnvCg7+99hUl5Gh
         vpSGxCYUrOs4hLbkxoOJqSGCrenDE1QDENTfKOBDceJK+SwnbK21XzOx9QoDhkcyuCw9
         oa01nHu+6ywQPaDan994zLWQGV/sbNGuMoBpJvGDlXSLlaTWBLaGdOw14oTFTcxH/BUV
         UVKIXMvjOG31023poO0fYUxgPqoT6gW7ulfzPlHG11fqz9vIFAjvUyVLi0Za28dNuTu6
         SW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313425; x=1753918225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hexKS3OBdUuka6mz2tsiA5AZ62DQZfbT13EVs55U9NQ=;
        b=V4z1JiBOrFbgkSWPsPWgh448Np5IvmS9/9j//ByNC62OxJlnuYeZuNvZ5gJk0HvMoS
         BMaKC13teiVe2spPpcrVrz0tdcpUigmrzr6NDVPqg+XcKQy00++dK+DfgLbRMiXOXMI+
         F2FDfSASzUNiEbnIizPUtv8fM/XVCGEytWBHIyAoqe/6aWKllZJ0XP4EQPhm8Iy8zeir
         3T85nyT+Pjp6pdD2iv0cGDKjMA7ep1gA8gs4ILja8e80vMmizNmUTsxtGY7Iyg0HVlA2
         O3X6yA/BAWLKA9Orbqj6COV/vXqOIecI1IUA5OEhgQ2XcH4xAHfd9ZS4lLyRvnetz43m
         1yuA==
X-Forwarded-Encrypted: i=1; AJvYcCXN/YtQF9F4zxES7AtK0GxIbknAzO+i3c4l8famBV0gUcVT5iA/I5nf4Y4hnHAMxsj7LejRN2CllvohGAI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUOVKIJw4xh4R3kdaAc33yabV7/zqZc3dpB5ejOYO7x/Vt6Cw3
	IrKSIE0kaywsppdhCuVCqUz4OG9O1c913IcTiBv+Zo0hkGu9g3i9dqx9
X-Gm-Gg: ASbGncvl/hmf05a95PbR56iCaFtEdxUrebUe4XU7dh03dQk97qODDj6T47oY9AHvjdV
	j9QX/pgK9Hbmlxk6GHsgEGF27CNdeGnUBElakNh9XC5XrG+FF1seTHKMGaYrn5mRCKFjU8yu01q
	PK+RDUewOIPX16pX7qZLavuFRXrszIzhUlQsIrizRDv9fdHruV35AMk11N1Ux6zQxMS53PB+6pV
	tL+dQabX5L49+sNjgRbUYAG194HKsMZ766ypVbjKJcSXaFRTi8ojjBQ2xRB03ZFMekiQtGf1smX
	+87cEiZZEilw1nFSG1Xhp/UuCkuC71aRYi1dOxYTz87t1sQyki3b2og1jF0eu0mlIeRRUgsV35d
	6x2gv1R7C5YbRVm0d5XAkExUz4Gb2zlN3rwIyOMgKBVd5/BQrAwwuZaDlzJSN+qyLYkcGsFjriF
	8=
X-Google-Smtp-Source: AGHT+IGI7TnYck3w9Hntb7EBGOSxlq7HH1YPFTWNRaeivNj40fXsheG0i19dTMp3Dq/70CdQsBEbvQ==
X-Received: by 2002:a17:902:ce11:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23f981da200mr67178985ad.46.1753313424830;
        Wed, 23 Jul 2025 16:30:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:24 -0700 (PDT)
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
Subject: [PATCH v3 03/13] ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.dtsi
Date: Wed, 23 Jul 2025 16:29:59 -0700
Message-ID: <20250723233013.142337-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

Fix deprecated spi-gpio properties in ast2600-facebook-netbmc-common.dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 00e5887c926f..208cf6567ed4 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -31,9 +31,13 @@ spi_gpio: spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		/*
+		 * chipselect pins are defined in platform .dts files
+		 * separately.
+		 */
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
 
 		tpm@0 {
 			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-- 
2.47.3


