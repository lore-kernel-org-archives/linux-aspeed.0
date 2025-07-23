Return-Path: <linux-aspeed+bounces-1796-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7B2C87FC5
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjs0Jjdz30TG;
	Thu, 24 Jul 2025 09:30:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313424;
	cv=none; b=oDsoz6gQokCsXfhUnDw7yJPzUAjirtgwsS6cum6T7dd3tNA/zjt6RawnPyiAXRENEA/oONR/XyBV/DvyHzz3cUsjIFG0JEfdeEaLxbfItZszL+Ft+NzsW+GEQDkw6Vqf8ynaaDPFOE2Zc0R3s8G4ilLUCNbewshI7acEwJJ2KHr2l3GlfPuLY2L+1/NhZ5LcYp5Lwyv17koTTsYEHRlE39/3t9KBgEmb4jfz3vg8vnIwOl3dfqOysrwyUNV9BYwJqlF8ZAkhWcC3l/DNp24+b0iJgmpdSGU/0gHROGbLjHDQ34j++u6cCeaOygk8JTmMKYYDbB33tI0PgfwkSYtNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313424; c=relaxed/relaxed;
	bh=PJcZT5sTnEC+iZOaFw42qNp6Oam8rPA+kK5DmNYfLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMRv1H65+bVkscCAGZ5YB5C06FhPErX5FEkQvsfyqlgxt7UeO2f4Yq4vWsjmrs4qJqL/fPsK48QiDxM0Cy/CTh9k3rRhDQefVvCrRwxUrJ91D/FgJUvmRrKh7ob+LpQa3iZpzwAs0PW7LOkKTuVmlU6F51LZF/wBYOj1qaxK5w8e9N075usHgSPmTsQ7lzRoiRiS97kJYYbMDb2IZM9c3S/X97qgzG6Bjxuk/V7XWByPbSrwdsV8XqGwPqjIrpFmDeJsuOWoz679Ik4baQICLiplyz2FUOZPhbEFgSqq4UraMs4WGeNXXLMuT6U1lDYE4++ItlYELVYJaRJObyf19A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M3c5LNvL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M3c5LNvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjq6F4sz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:23 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so554965a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313422; x=1753918222; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJcZT5sTnEC+iZOaFw42qNp6Oam8rPA+kK5DmNYfLB4=;
        b=M3c5LNvLIc3obm26AS77B2FXv5mG1qlkodkWOPnMSZczNJKtX7ZiHIzBwfcEBbAI6V
         6dojpu2+R02KhhDbiIFHKH89EBQ1J1G2b1GkWmn2zt1Q4piEsy6zlARRsgwcP585syMz
         8PFy925nKvp8cgWcpkz6R6cxXtS5WD8oc4exT/MWzT+YzF+5Hu/EVfH8gC8kl+Lf4TAw
         spfbZC/RfF9x7MhhZboFsciHceBVHzlK2u/RH8jZcBs+zwU/2FDsBceR9I5IY2iCjK+g
         IqtNhxHJraXx+pYkM8346kT4DcLdmLfxWadJW72dsnP3v0TfgCv5+kWCtI1DwUdxNt3o
         zGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313422; x=1753918222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJcZT5sTnEC+iZOaFw42qNp6Oam8rPA+kK5DmNYfLB4=;
        b=GeNbnmFcLwDvwKJfDZgnBDI1EpujLYgku5T2LuZxDVmIjaH+RG0wRjYPwK7oKeuul/
         OEmAVGs6hNKZTuh0fAqRKpV1b9R9D1AomnRnnC01qKhxvy08m80lTakqIRg2Z8qXuvjT
         kkTive3NlnR/tF+zAoHMyOjJg+W0hFHYYC3KGdEdWcieMsTJPTEOPB0wjYN34jBuT5V5
         JF8xNfB4iCl1fstpGKpMMvkckoUGVwqs02rN8o0Ndv/5C+0nI+PTlXAipJgYxcgff4ik
         mWKzjMG/lYgVLZpgq+3SStF5bdiiE3F0UQbWzSclHqZBFu2aJgzII77v//2Ny+wUQipM
         LWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Lu3cXYcUhDIjdQK+5JGHu1FZ08NWtFiIYC/xhI+c5bb/34Rr2NMPq7OawBLPYTdO2pmvEB0YnlDGUQw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxp3gf9+6YuM8vZH67LR23p3Cy8GnY1M9QgialnImXwJmFqKrsO
	VyoqdA5MA7Ow37sr3ZqutX80tNzIkVnHseSv30TtHrFRB87On+VFnHmm
X-Gm-Gg: ASbGnctSikg5A9CY0q5vY4Jt8xzw2+UPxQZJ/qX2upwhxmRq+bqNmmz+kz4uQqdJRcs
	kaIGQfJT/aLpBNENRdvuK36GPA1EIxx4dytgdgsQVJd/lTP09BPgo24XnWI+NIf11e1evNmEOku
	wbKGGrns40S67xCkue2Nio02zUkR6xrvueZ2uOa2M03KXB99WSmPboezIgrpqBrna8ahJ0p029+
	nRM4cbjPxNh4LaNMD1S6eyB7jKT2T7lgcjN8T2EFFRAq0P5+WhVilhY+qIvjt66Mmu6UZ7BLehe
	2WAxZfYeNaL65KeD2ZdOQO7jjIOahKZU+Z/fJuTX/Eb5XMiO86jWXifLA8m1IPb5KVL2wQSXqiS
	rBZ6nGK2qLJAciabJwY+jlYTj+GHppsmq58mggo1+VHMajCcfkLdgOJjsHe8jwBUft10woRhk3e
	8=
X-Google-Smtp-Source: AGHT+IGSyr5vjHqYvqddRwSQUnOAlvyDwmDPLuFwE/6U7+8I2PtDzuTJhVb5R5FfzxoEVDx4YT0l1Q==
X-Received: by 2002:a17:902:f151:b0:237:7802:da30 with SMTP id d9443c01a7336-23f981a83e8mr46507505ad.31.1753313421521;
        Wed, 23 Jul 2025 16:30:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:21 -0700 (PDT)
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
Subject: [PATCH v3 01/13] ARM: dts: aspeed: wedge400: Fix DTB warnings
Date: Wed, 23 Jul 2025 16:29:57 -0700
Message-ID: <20250723233013.142337-2-rentao.bupt@gmail.com>
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

Fix the deprecated spi-gpio properties in wedge400 dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
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
2.47.3


