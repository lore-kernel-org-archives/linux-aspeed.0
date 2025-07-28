Return-Path: <linux-aspeed+bounces-1843-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA69C87FCF
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75R4lfTz2yLB;
	Mon, 28 Jul 2025 15:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682187;
	cv=none; b=a2u9n1gGBIY1El58PIwiJFyBRnGlMOHX5miPO4yHjeKNNaSpTEZ0f8ZEH44YmsS+qTrVLEXhWocaOZXcMHWLMsOuDIl/O5HzrPW10IFXuI3L2pFAz+c3LAlV6JkI++Hhyk14ZbHUnJFIvLV6q/TO3j3NPz5jOl2n5HeeflKgSgbALKu54etbFFKbwIxYXx02UvjBNvqI9gY9/NfyRD/I8E3Rv+KZCliVSC1rlgqGlmynjB69u49Wekh+f6pi6GFqaJVsEIsBCWyXMTaObb4FEbS67L1ae52SbyRIMJJtGJzqWKFG1CBiy0nEJDRFfIDftaAVZmLDX34kXRtRTNpJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682187; c=relaxed/relaxed;
	bh=+vkeH24+gNLlbvhdNPWZDqLWHaKhUsYjVBX3EEgueV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF6laIDDnT14RMmH46Kw8tjAP5kNusiFXohxsNiGojMwf7txQntupfmkYBLdNMfLKRIGvgR+vwZrtph0w/WO0FEA6osC9u4uj0njiPP9bh13nMe9oRVy/368if7VUMZmJ9s2zKoD+WCeFqCkUnbJ+HYFcA8NBFdpxtJwCCaiHqIsQ9ia+nH84jnkUsVn7vpuS16X6hpqz0S8tgbqVdySNBwz6qsYXbV/g0fIPHy/YeUZCSEAjgforWO/a7WUdMlrULeHy9CPDtE3F9lgx34884FM7RRwjfm+BdI5ibLKBRIveRDF7oJOZ3E/d54+RQgcqGnZDVHWj8r0yqLwfZ3RIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TlQZyYeq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TlQZyYeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75Q62sLz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:26 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2403ca0313aso3193635ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682184; x=1754286984; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vkeH24+gNLlbvhdNPWZDqLWHaKhUsYjVBX3EEgueV8=;
        b=TlQZyYeqk7sAK7LDIAN/9MtwYCVvdWLdD+TdBYzsb4lKLLgcEgSFIgmHJUkFcvqLF/
         zYYXi6rhfkcGWITcpYONbfr+7b9BLScS86BzIw7CUThlAMqL3v2j0YigoHC5b3mfSfX8
         ALpaivCqop4Ryeqe3gbkXkkLu4Q3kXCqkcZxBTXXeMTmOUGQUksDys+LuxAh6umvrc7k
         us8URU7vNw/bkSOGN5EwzUa85hJL9JzjuNXyU+A7/a9NXnVisQADVF6eyh59Msr/2eAc
         dj96Shk2ECRl5TDWD4VZO/Yw36VlE94CXoVAECFP/SqyTuRrxoa3zCtUBFsz3DViIh5A
         rKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682184; x=1754286984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vkeH24+gNLlbvhdNPWZDqLWHaKhUsYjVBX3EEgueV8=;
        b=OiHMh3qJlLcJY1TbfNPp1H4R8XqGaHL739Rh7OMPi3R6te6SfRt4k39CQE1MIfFf3U
         vjnlrU3odIPFdsmnNeHv9JHWhEXlKsOPca4hY86g3r01UsPVlBNAzDVJfAWToyhAIbEw
         c0p77NtVHAnY+IEbhsV0ftGSzDdBqR2yz09h+6RklePcDTfmIb/xh3pMu0CnjQOUgt6r
         7/73srZi2d4a3/cieiNPFASoZRd5ahMQMLW+nq6F6v0bMvHORntzLigQMK6aBubSEF2n
         NG6Dnf6fTXERVeuZVjBlXqOacUbxYDBscfBtTiXL0U5gA84vgxQaqyKawHg+B4zoTdGx
         dGxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzSpMdIv5Gw8x3Y0NB0Guvp1pQjLEMkWZEDL99pFZiG6tbRgFRCIOOenvOsy0RWqki3AJDgHqfYLc26sM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxokl09MblrvrrCPgkvhhp8RF4tKJ76K/qqT8q5LE1oLiqHGxHl
	zSCtgCTm9KTQD7YM4FoJ32DK7KIwMh/o5fu0v6JZ8jx73hhE8Qh2r4UA1Ub6llns
X-Gm-Gg: ASbGncuRNQAIeq+KCed7i8Es7F8LtLFQKKIHIfFUmi+jIbj4lCvGWVJ9Bs373YUY+nz
	1l/jXzpueRRV03YvdEIlz9VnTYK2OucOsgN6hsUy5sjNp97uDq9x5ZRUI/yo4bBSMwG5vOIsbuX
	r70iDzvs4t/6536tK6NurgQULpk46P4Bjv+PwkGNoFqv3RN4aXV3LTE3uN3UPaOgVBdoHoh3fk4
	H+BTNwO6rs641QdcjPy9BdyfM5Md4HjdXXxH0Gbr3CXbJnFY/Irc/GTnMQ0KqJGeuWRRR9lsHCo
	7DQL2VwjtN63WBC7mcTR0jtVO57S7BS6QEc4WzHqWY7esM78BgcQoLguxsP7zu7V6ylYQyRMtmS
	KlavNOlI79tFYxmeyFnl4ycLdWN/E+mXnCeGrycrRzj06y4ACu/Zh3shLU3lLaaE/X4THoP56+X
	w=
X-Google-Smtp-Source: AGHT+IEe4NPcl+6E+41WcJkDUHNM9DOXgmDHX/lVp0PVK2XqtqJdjesfJx4tkgXmB0ihpgb06l3TIw==
X-Received: by 2002:a17:902:d591:b0:234:d778:13fa with SMTP id d9443c01a7336-23fb30ab963mr126148285ad.26.1753682184183;
        Sun, 27 Jul 2025 22:56:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:23 -0700 (PDT)
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
Subject: [PATCH v4 01/13] ARM: dts: aspeed: wedge400: Fix DTB warnings
Date: Sun, 27 Jul 2025 22:56:03 -0700
Message-ID: <20250728055618.61616-2-rentao.bupt@gmail.com>
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

Fix the deprecated spi-gpio properties in wedge400 dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
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


