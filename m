Return-Path: <linux-aspeed+bounces-1648-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE2EC83F0A
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5L5rz1z30VF;
	Sun,  6 Jul 2025 14:24:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775862;
	cv=none; b=LrMJcsQD/0NDM4m+D+nDgL4kzm9kIcO/5mPl7ytZ1+mqLhg6n4nyi2XKe4qTecVKa1QSHCfU/8mj3a49RvzXJxoGPsjxVSDl8qSJteUhJdvsjI1m+HEGSGxdoBb30ZUMHty5PsXXDMZfKqAPuZxmdzdOOWFuiGuAgGMOTk1kXHE8wWJoC9zJDLSHi3181xFI+Wubo1o7pLpfNjonYlqj6zbatWzNhTZTQIz/1ge9dKk13W9EWefCcbezrjc8OuzffLUMnXHPQ5OBWYqxx+6bOftR+z/xOiYcX4lQBnsD2gWEl+ggMDdrQy3HnxDRN18XCkt3oLkDKhypZKhQJioNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775862; c=relaxed/relaxed;
	bh=WvHmWGMNafItbzs5EJlmTvxiwq8MkDpapWuWormfitI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f89w2MFwf0t2J4a358KFMAZsmhQYayAEygdpjtKHS43GNhyvZl3pYcSgBPFcqJ2xulckuYSmXYfYYhw0gHz9RLor2GqZEAbxU1sfDLyj80VxnF8Yrt13V9MSD5erUHrRE9RlM1IbRN9wMi+ELMymNj+L6n9gP8PCh8BsfT7B6uiCnXA0j8ajW1lvyhvUXsMGxgm8/DJxKhqQwKgCTCZOu08GDvnwQSn3k6woLgBcQdU4u1+gERdda4X084GU6tafieVBQ03vF4TvYL4r4fQXzD9M2kuXjuMKlsZT9EAGbSNJ1JPOfBOuVA0LmnrWYjYNC6/CjGkkLe9wIJcStxBArw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Cqj4iJa5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Cqj4iJa5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5L0wCKz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:22 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-748d982e92cso1234915b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775860; x=1752380660; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvHmWGMNafItbzs5EJlmTvxiwq8MkDpapWuWormfitI=;
        b=Cqj4iJa5/BnoDCSkFyay7M7LPvlmj8Om3WCKRUAbpN/mzDxt/xe3X9RtkWDK+ZrWAr
         MTy58XXHy0fp94LLlta2Zm73YgXJr8yvvSCv0/4x36RDbNe7oK6JnN+fa4nLKIuQlowr
         kA9a1gcdZhT1vjxzqfE74H+qkj4y4N/OoXLenMhFj03KcmwJJJk8quzc9qkPnkUmeIln
         3eSxNHKmQJqQZ+hDmk+wTrlnSjUNhkuXDpasnxiaVfixnBVDiyksx82JESAChsu+35Nz
         W6puEIv4siFbXZJnThAX7viZGJGG9DQnMwcdrHS3ExbJeaAOg/sJex0M8zvPnw5sw95u
         PFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775860; x=1752380660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvHmWGMNafItbzs5EJlmTvxiwq8MkDpapWuWormfitI=;
        b=AjFlZYneC77DbzndO5VmSDeJkJbCe3k7o1ELT7rY6cnpbULimxja0/uAW1BS/g97re
         bTZEfo6WSm8aTFXfQPBafDyQdNQ5TOckVAWgcQggbJZUyEbGdDdFL+rayasQgyAmb6+h
         fpStzHCrBrcAJRTH5ON0V6ySBMAPIEmj1kLS4SB2czYeW0CROOEsoEBf8L0w0Cs14thb
         jy8aNiNKg4x4or4BeDqmkXPiaD1sCoNKoI2CBbZXtwHdEIOmgKL3zrWDYbT6miMLj49N
         xXlZ8x0ViF80c0pb+c7RqORwfP/LMVZiWQZVld8apRvZqEehgpVpgIWrIUse/WUxLyTN
         4WOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgseVww3iscdcxcUwdJJ0u008wZbXM/gXIpRpmlG0DYWjvDru23pKOC/Afo/+5zfwO3FCxKt+6MV0JQk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhXrD7BJR5IFtoJix1uu6RQg6Oy8mmn+tmN8vRVIWEKBku7vf4
	VKxvkyl5w50JQmSVzOm+fZmoNbe3pJHJOvSsBWh/3YfDp53tTm0V5bYY
X-Gm-Gg: ASbGncvSYYIh7gWjXiNKU9gXVr7QwVGnIYdqORK8sGSpUSGwanRxc/F2Hwyg+UBnfOB
	ij08P9Xv3r8PF2neQI7k5ZkJ/pOEmu394UCePz82kHKKmthEYFQ14thz6LJh/RI/jiZM9Joouaz
	u2yQPCW6ZlBLGSfiUG1ksJsGT8mIfTniUq7X7YJN7byY7yG6s7vUg2DjN09h932DrAtTE5j7Aap
	HLUEP773BVDgdMWEc/mFcDYTh3lpXSdH1ibQvuN2SObsIvrhoMFFTFmC6yoI9evE34TM2QIKB05
	WB0DPaKtFyqiMWD3K8CvHdZGblStDe7tRdjzw92ahXerxQwsaBqhY4ZwkDxWoBP9T/t6bqdoASl
	QfbozJdfKqV6/SiZZc00cfChXD1jt+RstrKDwH3FdvG/ZJkr3fg==
X-Google-Smtp-Source: AGHT+IFq/DBo7mhtDc8JK2bnjTn0hYcALs6HE7/1Y9UZXQosY+9RqR3fwqBI4vPkehE6vG/rQihI9g==
X-Received: by 2002:a05:6a21:618e:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-22720fc395amr6562762637.29.1751775860542;
        Sat, 05 Jul 2025 21:24:20 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:20 -0700 (PDT)
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
Subject: [PATCH v2 7/9] ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
Date: Sat,  5 Jul 2025 21:23:57 -0700
Message-ID: <20250706042404.138128-8-rentao.bupt@gmail.com>
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

Move eMMC entries from ast2600-facebook-netbmc-common.dtsi to each
platform because eMMC is removed from future Meta/Facebook AST2600
Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - The 3 emmc-related patches in v1 are squashed into this patch.

 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 673cabbec92e..a21742daf899 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -207,3 +207,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 71f58ad1ff06..0890b1728658 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1249,3 +1249,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 4f819bf8c909..d19897ba5dbc 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -154,18 +154,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.1


