Return-Path: <linux-aspeed+bounces-1845-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A7C87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75T6l5jz30W9;
	Mon, 28 Jul 2025 15:56:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682189;
	cv=none; b=cxE9BtB62za4256f2Nyq/Z5pMCqjXIkJStZHxR3gWmbq7CRFL/SXMHbNsnYHzoY0ZuaA9RccAxifBLTQCurk8ukf0mdSDE2CvQIdWc4ER6wxRVAiCE6AaHcDwG9okrT2Md5UAqydMoPFaDEjKdxnhR9+xbXfN7UGjQzlwXqH+5YkLqIDNIkvgt5GPDGAdSAhTQbYk7/TuPczw0LQVpwx8WI2t19KgHG5QNL5EmLoKCneBduwCvRQTaNpX55ZlsCQOr4jJ5mT1AyxiihF5tO40Ws3TH5e439sfcw6+R7IE7HbWhUtqFfK+aB5+LCV1Sug5h+ofNMnYxlJaH+oold0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682189; c=relaxed/relaxed;
	bh=Ao8eoPOSjBo1pqHWYqmxG6F29BfmtszTrihrIa5aqow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx5JYft7OYuxmp0IBB2/Kx+EaLSkENc9cpFjSgoRd/5AMX7BA1ui0Z8Q/Y0/KlTXH8RV4qB6DgtkPdPOOpKLWAIec/nGABRPBsgObRRyMgZwKJrMhHBfqr9pdn8KLCa2OphNdsiqdKnbH7/l9lorwelMQsyP3jQt8PC4WeLaC6Aj2uH0xDIwOF5kX87iCTVpymd0fGJUa/Gm3YGTAkG5UlaCeyPl88k1Jq04qEppdrd6JGBjTyphnijb+8NXL5Yhii7pHXbBwrfsiQVz+xhnDWfGwJozaLDqTJkJeJ+RYi7Q6xUoLKtIpCmVkb0vfHv1cziKuVCJMkox8f4qRxIYIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eKtzsD2N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eKtzsD2N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75T2dTyz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:29 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-23636167b30so36423745ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682187; x=1754286987; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao8eoPOSjBo1pqHWYqmxG6F29BfmtszTrihrIa5aqow=;
        b=eKtzsD2NN8oIsZk815cctp+ammM+/MgIyIZ+t2c6S4unp5rQjHMlpB3xGrS2JrWUoc
         Jbrv+mnNf73a4YjCXP2RJYZ1dx/t9qosxGvTsyzq3j2kvaSq1s689ic8PmNw6Av/7wlI
         sg/GorMuDaBjwq+MmOUPDZut4BpcR46uVUypSB2VZMMFR9n3NdEfDE5LMGNDXF4QD1At
         Fdg5IdK9hFzXqNJPhMZv9yi0tIZoUNDKLTmuI5c4XKqA/2TflKD5NRGH2Ruivms1hvwe
         V86mlel6yqH3Q95iW4SIZGG5U5iNY3SpKAtvR1M9tku5oTNqPS0Kemq/HccUWXKJkITT
         h5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682187; x=1754286987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao8eoPOSjBo1pqHWYqmxG6F29BfmtszTrihrIa5aqow=;
        b=rN7X1OJYYFMbS52DdO7brSStsrvsFeOIY+V06L1JEWBW6IHvKiJ/yw8j1q6nmpwSCS
         5pojonM4mLKBO/ySt0StvuYZgJqkEueoqi8H3Dlesp6M1vZMEsMO9Il6RYAKSpJhWiLT
         ze3Bd3JXevtvzaVjFgDio/GC3IfiQFBZj/3nkujJIpY4TYRu2MaIYyX8aSy9Zn2dZhmh
         hGEiB5f73gqOKIiOItHqFExKFD3UrLWZHWSdNAfz9P/cjlcQy1nVj2sSvqXVCarvyCZL
         CZPImFjKpzJMDE1SNFV8D4FOGFzf0EhqEWF+piztkL0emWspwdXpKjD9T0k+NI4oWliO
         ad7w==
X-Forwarded-Encrypted: i=1; AJvYcCXOKACe6quIsX+b6IMRkW/ocI/Bc+UTJ3CdkPo1jlXCjF+4Kk5j0If5t37PpLHwxxGs3KVcBOMjYlKEW4A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwNsqved3MhTc+f+GjJqkyflFDS1FCL6f8jHWNRvPIJJLlmQGpX
	OEF4t/L3EPg7lD6YU2FBxKWdIZkIktCHTajfBiLjf9M17n7JItpAdCnTR2baqGWM
X-Gm-Gg: ASbGncuA06PNHGZV3u42GyUit2KDeLgVSxXjKlU+J9tbmDkaAJdz1tD+AFczty9UvRM
	WD4Vpx6aQXrmC9s/iLzBTItnqWp5/g2k0EQnvZ8LmO5Mc5JdZQTcBi0agui9rldCf7GGvbyyyrr
	wZncSenwuI/bsYtvhSKTZRErBdKmCHjpyESFNlX8hbN68fGKpDWMRVipAuMBkwEKscLdUQypH5z
	viPKNBOnLRw7Sj1tvvQToyST+hfYXrlUWsLZd2nSFutKIfWbQkG/a3KOxcoQ/X5rk4Fy526hokV
	zfemKEr+lrWwirlSP+7aUDVUAXqBP5Up5rNS4fpdKVEUOKaFxB8L11c6hTmwcnQdF29YSCA6Cvr
	f/J5p9po+kD7m2bAYM+VbZuORoL17cue3EzsesmGp7+O7RewKgiMluuHMA4s02eWCPccEM4DotJ
	I=
X-Google-Smtp-Source: AGHT+IHaS05eV6o8vv06se/fDbSOemG5P7tT7lHJSRm7a5+F+76GtfyNY3WoBVTNDjM4ynNXLyA3xw==
X-Received: by 2002:a17:903:15cf:b0:234:c549:da0e with SMTP id d9443c01a7336-23fb3129f72mr148697115ad.47.1753682187515;
        Sun, 27 Jul 2025 22:56:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:27 -0700 (PDT)
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
Subject: [PATCH v4 03/13] ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.dtsi
Date: Sun, 27 Jul 2025 22:56:05 -0700
Message-ID: <20250728055618.61616-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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
Changes in v4:
  - None.
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


