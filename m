Return-Path: <linux-aspeed+bounces-4436-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07532C43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwYww2gWYz2ydq;
	Thu, 09 Jul 2026 09:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525127;
	cv=none; b=g9g8qdziUC7B3gzqTtI5VDLu0YjrM5J/q2dyJKaPH+FCFTej/7VZTv45DceNh/B8HxZgt+gCsYH8h9IQS4MaLFcuYCU50Wm161Weos872HSSsh5G5Su+iBW+ITDpeyyVtDcEKwhYUkIcK/giEGXHqvdahbDjfU80yEiAu8O5G2/qs62Xf3817wTH58UZk08YWB1nLHMAwjaqaUS3eZrwaUZXPG60csCTAMKwhNcANmIkGOrljR0w1Xo1zMHzJ9uokV+5CMbBjGxrO4P7w3JmOzVGQAbhksRQtBTfm0IU/EkQHW+4X4gDCkSMRfXH2dAw0t/kvZXP7yBmAlknvOVmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525127; c=relaxed/relaxed;
	bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqJMRZlxjbssqEZ0Hea/OhXoTOvM8wvw6g5OBJMCGIpNmu9eudB+zgnFl6m0oOEVWSbUqOBekQeGUsEvb6BWXqYifUXvE7vQuXFOEV6x+r4TdEXWMe6+4g2xXcGx3Ku3upHwlPuX3IyHV9HFqm5b1QOcyRye16yyUhmQv5t5ux0zXCn1kJUVeJU6s5Mp68qkSADCYs3saDIu/2lTZdRtLapN/nd1REnjZYfO/Tw0fSBSvkmLmamJE9h7hhgH55P1r+HlhEGeQoGQyMcasYU+/3UKcnumDilT0aC8JDdF5CMb9ucR+mB/DfU4qv6c2H76QJ3NMDVcoamch3bWhRYCOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=F8mtGMpt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=F8mtGMpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMh61r3Lz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:46 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47dec32798aso860330f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525123; x=1784129923; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=F8mtGMptzeIRf6pfIKuXh0nzm+450A8y68L7ZF95tiGZKJm7ORSpx+o09jKStf8omI
         iZmZa/9K7fJAP8aa+UFTB91mQonhneghwsuqVX0V/kVZfkXOKJjlWN0zTYrW85UjLYH+
         3mcptiZu2RbEdAooS45HJh4aTqyQ8rM9uIfVcEyVofENgUyoLKIEaCj2xgpZIyjl5qJY
         8HV4GBQKfjP/A+08pY5SeCCaK8Cbid+e3PNc7C7ZImRvVlIyU/8y/XJSvAy71W+o9W8D
         b8AsCj6FZ+RCpfaJJTCgQSNVZr8Ut0mHZ3bsWWV9OQ22ylBqd+GKhxbh3KCn3O8qfRzT
         w65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525123; x=1784129923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=LvtgmSwpw+EAdgzUV9KTmcYm46ITy4eqRO44ODNN+8U/j6XcaToD0V+dUJmqrUEJAV
         fOIARvjee+Kl5gAr70jeulsk41/a9SDCBMeOnNtJcP/XWwTasSPHSHQqNauLS3HMCBr9
         ghQQ3mDlnkrhVkz2AXYodKXfagUFQn76cMkJgrMNI5XxZTSShmyv/hujsiiLHJnK1Q5K
         rnfrvNrbQV5A7imINWbd0uIlGRM1xeqDgGxRLa+G30zPHWni9qAM56j7Up5XCFxAtZtj
         UkoHz8vqBobjA2kjMWn8aoplkdz/DJ81JlOMRmFalogacHal2R8Z+sp/aa8mSqhdhr7p
         iPVw==
X-Forwarded-Encrypted: i=1; AHgh+RrmjYSl7LpKV1IGf1pmB8zpZECqgFSmjj4hYb4SK0C6VU4bpfxsrUYX3zw1MRRS6RE5TbNV8SyZpHbxJA0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymXxLb+bsoqLch4TTLwGVg+NQSXrxzNXy3bucXyMRZy54sOrPz
	9ArkxtGRA6bwsLPRSsktcNZHMISpgWs42SmD52cum+CfJgkVePDg20jET/qvZ/+1SX8=
X-Gm-Gg: AfdE7ckieMhukQwZr2Zat0CFV/+ZBwoq6pMT/E6o0p0/f5VEV0trbjBYR7cNLu6M7z9
	GEcy/lQJjqNwjvmXLXgEg3cP4SANRrfw7pF5JJExtt7pKNkJd3+0+B7EM7/9KJKwPSAcepE1Sdw
	+VlCct8jNU8bUr9EnBiw7qG9sUgJIBEO4+Pxb6DfM2m+Idv2wznDLW9Ta7BWqSvEs1Mo8dy79Rl
	PpEJOZCwf54wQcbsd3ftn+EEjXs99iIHX4AVnhop5+evRDJSMZGuwbeDnF6APIeM2vNnrfKSpH8
	n/S0ueZy7LMo8s5yuf926XgFG0mvSE854d9Z7sNaPotgYsRELrChbC5AXRIDYc2SUvE6atB19ML
	MKwS/1xdcnS65icq6ajjKoI72kLYuZM8iJ3O6zp+teUsTYGUunAWAVQH+Ty8tm3eq3aPSb44HdM
	Gjy7EH2wFsU81LluSgHVNKaXouXZqt5IFRx5HVhTjazbytKfeTImvhkEnb6yGRYqtWhkfVUw/U8
	OXtxaAONg88Hg5XQ5IJssQwE5y6HfCaGsPCh1s=
X-Received: by 2002:a05:6000:4709:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-47df07c5accmr3512417f8f.54.1783525123283;
        Wed, 08 Jul 2026 08:38:43 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:43 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 6/7] ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
Date: Wed,  8 Jul 2026 15:35:58 +0000
Message-ID: <5875623c1b20cf5a1abc980eab4c31a47cc58468.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the ast2600 compatible string.
Make it more precise and enable specific ast2600 properties.
Still use the ast2500 compatible string as a fallback.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..7c02633f2bd6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
 			};
 
 			vuart1: serial@1e787000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
@@ -717,7 +717,7 @@ vuart1: serial@1e787000 {
 			};
 
 			vuart3: serial@1e787800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@ vuart3: serial@1e787800 {
 			};
 
 			vuart2: serial@1e788000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@ vuart2: serial@1e788000 {
 			};
 
 			vuart4: serial@1e788800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.54.0


