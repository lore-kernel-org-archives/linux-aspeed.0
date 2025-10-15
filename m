Return-Path: <linux-aspeed+bounces-2463-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61316CCD185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Xz6pRZz306S;
	Thu, 16 Oct 2025 09:36:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539176;
	cv=none; b=UWyhJR0ae2vdzrG2qWW7w2PIOlsdVx+figCxmgR2ODNgArlmPF5V5vUcqKSCAn36IyGLJtwCXTtqsTZgN/pNBlPeEAPEcv6Xh7BpsDOveiTCWIzfhaUUNDJbplnLF2KSy+5uM8raZdGBg7RBpSa+szkveTzK0hKlJbeAPTGouFd2f69ktn/Wxq6TriadJtiiUkHN2LmXKzEQa8jTfMpFJmIpFsXp88RLT6qiv/Yi6zmMvnYXhCqs6ZjXxD5ACL6sHxDWTMUewsOOlRSTAu6v2K9MuritaguZ1RKP6UkdRLuAOFHUOgTde9C+8pbwu7N2DbEPsIIvfgWCgL+t3VAvag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539176; c=relaxed/relaxed;
	bh=cZnPPw1yHb/kgpk5HVTCc5i/nPN6HTsBrippheu6Yfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1K7kSSdj/mfPIR5u5hP4K6GNNsNi8zVsFVc5/B8GA+0iPks+Ccoo2Ze6Ky/89Ab3VgJI6ixauWJRo63QWPWd2rVW+GJzEWf/zxtrBpgZmytqUJSEhxOMiqaHU4BbwO1nwBGnmhXWqe8hloT82ePo7wMYrzz7udCWgBURRIw2KNIS3ncHkaopLZEYv/QUTnL39NNgtrWLtP91/LeQIT87EhnV8mCIj8m2+zOJNP0vA38M7RrwN8kOUVusAWFJcpY+R3U6EvhWX8JhyMdr5kIxEFuulQuOMIBcRSdo6zPJZSS55qJ6p+AItl8xRSoGHzmR1+5KD1pDBIP6IlQecb2WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=avwvBo+k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=avwvBo+k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyc2f1mz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:36 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-27eed7bdfeeso13019715ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539174; x=1761143974; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZnPPw1yHb/kgpk5HVTCc5i/nPN6HTsBrippheu6Yfk=;
        b=avwvBo+kqLt+v7EslpDu7tZ9mq0hsxOy4iWWewkoB2lFqCGwhGGOdDlma95Z6SGiRI
         7kSFP/Kvz6RIIjw/SgK59pDRAPYQDA+JOWj+R8ARbKNLEd/d251OGwke3vmLtk+hA0W2
         MGoUT/JZIOQL+3uW7QcNMcNjEvLNS4nmRovVMj4scEGWYBuhEckysgf9ejHgklD/e6as
         ucDkaGdtzBK73tJmscmVva0URaB5Puc9UQUGichoMWliN6b8GT7dhufZZbzPuJYjTE59
         N+3j/Ki/1S64JJy3for89T14EyzZ019FjZ3o2pQ3rBGaUkT22SimrJLzoBmewANRWq4Q
         HEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539174; x=1761143974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZnPPw1yHb/kgpk5HVTCc5i/nPN6HTsBrippheu6Yfk=;
        b=QS051JQ+gZTq8DuuayXUowDdJCuLpRnIoWXZiw4OE4iNS+obawztkzhVuRBXTJeKqb
         L9/M3iZ2237aTSCKqE6qJh+zIFQg27FfC77EdTURzSUdQqeE3m1m7GTkoxhBhspvWph2
         oGkKELU9AioNTr9/Sz4Xk3E8tISAY5QGjTYU6USVNz2WGAYWGXpzfAl9ZA8Nlm8R725t
         AqmfVYh53+qFv4fQdXTA+fbl7pCxA8VRIsfXPRc7sLD+SQsu8OY506p4FNqegvuu8mJx
         7mXbV/HTkFQKmI6xYbc7ArZ68BY4aTlmCBAzdy0vtoUzzU98D6IQWBjMMF2fvxj16ZM4
         cWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbpNhtmTFB4NXo89tkRvh9ABKheJzie3/mqrAFA8vFhVMyNJE8mkgcZNHCywQyvIq5pOTIjzKDN1ImbpI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVaZHAMH9C05mnGi9e7nOtRzDM8og/7IITLPe8aFx+ZmpBw8BO
	7UbUpl56CSEsWkIW6gmoPveSKRIQ/G7DXT6+5vdtQoOJK3Fh17DONg62
X-Gm-Gg: ASbGncsFNNWx2YQvefmXKuOc4DbPv8ZINHoCMccHJtp1qc+8aQXguD2wuVAWsfvIT8f
	6ENz7w4WgQBnATBW6xEEcmAx332Y3I2QOuP0rZ1kP6kIxHr5stMSlaSSJ0zpUSNRp6MDBf3ALPu
	Aw6K4A+/VVOxatzPcFlTyQUmNdcaZYefvL8ykhu1iIknOL/C3MoPxcRCBVkmVDgCwPJ0ToYW74r
	vI2d7wmAX9YO8nsMUZr8Oo3akKe07ME/OgKsNMEWCqE2F6nZPszTERIVKAzZuc71Sj3m4FlL4re
	R2qn2aDdw2i5f0nlM9HeqVRZNJMlabc3h7VqcXquNgR0VL5pzWILrnBrjDg6fmVUG5znCpznCWC
	L9pSe1f3l4JFFAxzycbbrSEWhoK989ISvM7gaxRbectgxB9zKP9pmMUF+go4CdERU3apjxWv8IY
	THn7wkvvFyKf8e0ficwbt/MweVY6mhCg==
X-Google-Smtp-Source: AGHT+IEwVX/ElMrVL/1slVqgh0aEHLkum2PuLtXRVZK0Ha5cnSjmuPAFvQSxCr9PtIb+PIE7Zha0ow==
X-Received: by 2002:a17:902:c951:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-29091ae4cdbmr4400655ad.10.1760539174469;
        Wed, 15 Oct 2025 07:39:34 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:34 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
Date: Wed, 15 Oct 2025 22:39:00 +0800
Message-ID: <20251015143916.1850450-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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

Add a 'bmc_ready_noled' LED on GPIOB3 with GPIO_TRANSITORY to ensure its
state resets on BMC reboot.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index b190ab344aa7..c0334abf9cda 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -104,6 +104,11 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


