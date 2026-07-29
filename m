Return-Path: <linux-aspeed+bounces-4582-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD397C53200
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 11:43:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Sb33VMz2xwP;
	Wed, 29 Jul 2026 21:43:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325391;
	cv=none; b=Wbcpbew6dPzkkGiufhxU9u1Su+R/9VPYBzvjPWQc2Ll9WrepQzQGotI40bcPQ43b4xlluk5l5+ElPbHldW9cyk9fOa1qF5G2XyJPRMIK2X39jUIRvt3l5xQ/syfmU53z54jPK3Bs6BI3LypnVYtq3p+80nEBlJ+/574a6E3wHSX3Y2eHuCaGQox/ecGEKMJUXZ6/NAewsbK1oNlvTcpPvwEJhV4WHqA6lrL8CYDiko4euMLVsS6PCcnMYbHU8vCFJ7Oq6u0F6JN7Rca9nwMtW/QtuXOlUBjqGUTWl/bA09eJoM158BwkTz3DQHMKxp7+xdRihmrAIJMMNokVN9aAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325391; c=relaxed/relaxed;
	bh=c+h8NJ3p4DMHwqN+FWUP3u5Jy7dG3Az5SXXuJ0SBbqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3LivngSrncmMKN/VhTgbc9NmxPrJS6IaqfRZNCBqTOlCl03rJZNjUUiRnAN6jg7EYbWJqsmMMe+BCgE3J/+Zzt4EWw8JMLPnryiZGUeJ6kBlTjgWcpDsCe6cwwb74J49THsFW6C6SiFpT+yYrXcCk8hXGnqg3VbErwRhTG6BQ8oy0HneSWGoWRd6d4iIvkeK5HgnvBeXn+Gko7mRwUHWoZ7+v2cgpSOEm0KZgq2KRq3Jly+ZBDXF7EPPEzkFwQEB50WlPeG4x/5agvoXT2En/Aoa7/inAyBsM1r8DvxVx9ByFJGeWtaNoCa6F3c+ufOhxAbWVdNxjXzV6AZT0gENw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmL8VKdV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmL8VKdV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99SZ1Dc5z2xnp
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 21:43:09 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8485ef63b68so871863b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325387; x=1785930187; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+h8NJ3p4DMHwqN+FWUP3u5Jy7dG3Az5SXXuJ0SBbqw=;
        b=HmL8VKdVu4wsNDu6JvIWAw6JGswXrUi1pbFCdpHVRfZj2mzwV0YDniiHgCBecQzcx7
         IuB8Iy0ZFBcyKPH98/F9VO6+QRtImQKkluW2f6s55Rb6My8lHnOuU1vvR3EmE0IiPj9f
         ef8tTM66EKtBldii7s/VlR33ICuXAgtRh3Y2QgPBPHEDFR/c7PG7NPepS5UHvIzyf0T8
         pNESCEW9q+dS90dIhm2kLsRqelDJf2c4rINa1Ceuu3fUXJsIA7yU6GFE4APqrp4b93DB
         9DyPQIFmn+KqNAtiOTYlV0VuZtaSDD4nTUxxm7+GxgiP1r1z8wI6Jx7HYCx6XFXEJvAM
         6h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325387; x=1785930187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+h8NJ3p4DMHwqN+FWUP3u5Jy7dG3Az5SXXuJ0SBbqw=;
        b=FYAdbIN81t6a8azB6XplzFdtuFNHJYjVBJPpk/8uIyrGG0V8PBh29vurs6QM2x/w+w
         XAPY8woExDBNKQh8vrAKLo1J4i4OwSrcxBxdVeXidCpN+mo5Z1tiiISvLZpF+iYL/MXK
         xyu8PXKXER47zNbJ6KWIjexJc9OU5ltIfDkIXkRke7gIyZyaoB2UjH8XrMloUruAgZds
         DtEzs8BrF5smzPlGrlYJtx+UGDYKRnrhMb115T+pOPcg47cRKkWKxlBIJSzwBIhFVhN6
         UvsvF2/FTANSMhq/CAoFeYhezsKu8SEdy6Hf6hjWht6+XWu+vM0kXIU0GP0LbcGq8zXi
         dlfg==
X-Forwarded-Encrypted: i=1; AHgh+RqVGicEB85lFm4qSyT13+KJrSZ5snaHWbhrNjDVfsA9Y1H0t5A9VBcNQicSSBxf71JDsSm1pBxn8p2DTcs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyM1Dd824lQfcUneIzXrmbXcILnpnCgNkENmIYGPAlTbJFykcL/
	fV4pg/yaKn12/FvsHAVcaJNCPN4xQWwY7yJo7dzKoRX2d+pSFWSid+DJ
X-Gm-Gg: AR+sD12PHVkWq6MdyLKbCN1su7jB9tDrwRdpNXqoDCqoaLw24B4I/jCrYybLvh5bHmL
	bl4zdwIIAVuJP2YVoBiKvP3lJ7UhGoKv9siYcYOipxR19pBTaxtRWSa+QACv4Y9hwdPh/Eb85wv
	ob2hHMcalSs57AB1tJ4YMszq3NbEeDSLcKk6Oh/d3YDqTZ5w7Xxgg4nS34Xt0K0ZG8FoDucSM2E
	00TqjGdXMV/0I5wm7UJxBwwNCkw8w1AHniT21eVKJwlGrZE7e95VmhGx7pXXYS7qiJWgKVEIs1m
	wrGz7oS1+GA5KkHXAm6IRJspKSw8GonqRX8kKVt/ZpbThQe4YQlJYjISKQCFDXaDCSHV4wk3QRu
	LZrceBNAbV1307L0iO9FWZot4nQAFe3X7xiM+2+zUHemgr600vh0AsmN1S5XT+sPW20gsHnmxL9
	/901mIG1hkQTAaBkzmckM6WjSjPvbh2/sFwRRNxA94VAbGUiGH25ZmM1EVGpWYVSb/JYPgyOb7W
	ruN6F0OWpDOO2rL6Yaa831HnokrNUvnDEM=
X-Received: by 2002:a05:6a00:10c7:b0:847:83bc:d2a4 with SMTP id d2e1a72fcca58-84e931f6966mr6315709b3a.2.1785325386605;
        Wed, 29 Jul 2026 04:43:06 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03cbd1csm1263532b3a.53.2026.07.29.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:43:06 -0700 (PDT)
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
Subject: [PATCH v2 0/4] ARM: dts: aspeed: bletchley: Cleanups and second source devices
Date: Wed, 29 Jul 2026 19:43:08 +0800
Message-ID: <20260729114312.3947300-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series resolves dt-check-style warnings, sorts I2C nodes,
and adds second-source RTC/LED support for the Bletchley.

Changes in v2:
- Added patch to sort I2C device nodes by address.
- Added patch to fix dt-check-style warnings.
- Carried over second-source RTC and LED controller patches from v1.

Cosmo Chou (4):
  ARM: dts: aspeed: bletchley: Sort i2c device nodes by address
  ARM: dts: aspeed: bletchley: Fix style warnings
  ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
  ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC

 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 1317 +++++++++++------
 1 file changed, 903 insertions(+), 414 deletions(-)

-- 
2.43.0


