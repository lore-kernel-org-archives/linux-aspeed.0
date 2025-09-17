Return-Path: <linux-aspeed+bounces-2245-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9B1CA0EE8
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 10:18:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRZVP0tvwz3cYP;
	Wed, 17 Sep 2025 20:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758104317;
	cv=none; b=B3Deeeh84fawdid71Oby/BToHlAdFTGnJWKXjJnZ62keBZuimLBHFKuWQZIQEeAiQa9Y0ALVospJMTlcsV+yHFl+jY9SrKknF4z8zbWQ+zD/XcCX8edzd+afVkEpvDcjd4OfFzqstu2kw0iebG3jS33Tx0m1MZOWmWuhkuHw9SN6ofhNi3tHss4lXT6xJxdfUTPwDC1b2BPTetBiR9fDDHSwnB1q3JRTz8WOW0KPFPAi+EjbvjsjdRzLUC43fpy02W/cyxkOXTpdsjR3xH1IZgg2fwajDEdtj+chAE8YNPGQwRUVdNq2Vt3UxwQx0R/W34RNDqgZxiJieVh7Xi/b3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758104317; c=relaxed/relaxed;
	bh=jZgFdo56U5Rjwn/0fXd6egZkLqMBUY9dg2lSu0VhJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3TcbXCTgJ7eVteYfTIl6ZU6bH7Slnj0deIoYcB2Al1BFxmu9YmoaHWvHTGsrjIkBcSCg3tv5YCrfw8OSknRC/vtySpXrVgwADvP1tMMF0UVtsc9nG7srORw5zHwAcoeGxBh9eQOhYyhOzUvJF6NVQ397HlOb9Z1KaxvzCuEQ8OJb/+xt82apBgY5ndkaWx4ZqbdO0BrSk5LrQJpwrsP/raMkIjXRgVgRhpyi2qQneiVS/18sfzX+UWES/35UiceX4CUFt2wn5TD1S+w9Y5tm2GQH2EjtIguAl3SMeYgCT4JA48lRVVIV+jWXm2zVs/qhHFK8TpUejhOCMIKZn1NpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IbH0oHjR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IbH0oHjR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRZVM4GBDz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 20:18:34 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b54fa17a9c0so73862a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104312; x=1758709112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZgFdo56U5Rjwn/0fXd6egZkLqMBUY9dg2lSu0VhJvc=;
        b=IbH0oHjRQy9X48G2SkScDzpu2y1XtDo0OtM3c/hndLrY1o8DZAMe1v/4HDWrh1YRHJ
         EbfTK1tjoxfVAGILpAClTfFqpoejzzMDPPgXHL9yRKGMq2daR7EkOLvqamFQXXTIBXa5
         MIo0gJixj9aiZ9b+9xPHVtKLHoYElgZfbMoJxOMOx2usZKKIwSplIDphdVSSpU2INjQU
         7JRpAbHV8ZAy5Q7c8/VZb4rVVZ8MDLmVUePavoUlPeCiH/6JRibTUa2N1yDE4nPQvXth
         gHDNkSvg5mXnSBYJl2Fb+A7AQKXBGPU2wOf2UiYLr8XOBPjzYQgTdfxa2ZmbEqx5382T
         3yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104312; x=1758709112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZgFdo56U5Rjwn/0fXd6egZkLqMBUY9dg2lSu0VhJvc=;
        b=Z9gGX7tCeR8VPlfHfnOOKbQ8VrNFhcd3GK1eqW0e+owpLplVtvvWojDWukGLnF+UXD
         77YVJDgJ3BLLOzhzFtZ6Z18uNPlxXfx5GYAAngDAbmK48wJpH/NFWkJgGFEqY7rs2pH6
         +KVs1SULNI/AFbH82MCBkxqzKNZOuNlIXCIzieojjMSsNVbgc0NmVeWFbwVpRBYfo9C+
         TwLnVKMO0GdaLRAHlYwfgN+adJWdK6uMzKhnpp7Q4yiksdW3JYuChIrBQTE3Vj3XH8H/
         6ON0aMuZdf4AMD1FcP0h8HmV77CVEX7NhbvZcXH0nhhPpREv2YAHWw6oOGAEKRXrIJuT
         dfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0p8pVaVS7NLhojz+jVhP0e823FZqXlrHf6NSOwxftC6vUMhRPnyzuUZwnUu3+qFQa8QnoexaOdpfxKmY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4vIfufZUsJDQixjETWZd9pAPDdLa+IKJkN5UTClpiY538++XQ
	JZ8wftHm3n9CkB87PoOMjYeFI0H/GvtsZ4XcLnJqyaDWeXsKbYeH7Huf
X-Gm-Gg: ASbGncsX8Bu8sqKqS2zy3DLO+WidvqB1auk1LiRSMqFT/Ym4a+3cdVcNywZnarsREIv
	XDBI71QQjzPNtAwLM/b1fakILtUkupyO4ZbfsM+9t57LXtYTezMpmKbCHgskScc6oD5BvxFAOdk
	iHf3aD/6UOZQxppgG78E/ZrIcYft2NxtCQUyMnnz7GQsYQ0K9FlzlzoYlr728JlslWcMgnrE1II
	2kDu/Ls4rSiv+MDcHrSotoDkYODFSVLVTb/gpt7HQpCAQCipuQJVHLA7KrxeuVdOSqGbnxJcP1O
	7+EioziqQPhGMuwwVRRaoNNFeT1Po+0eUNRGTNn5y9LY5K2U3Z6ec9NblOwUp5eM0niGg4VZIKL
	DQDM+t6k5mZkBchqVyAoh299mOWNy4LAi5JfxCWayzuGh2d9Q6kBFmzkh64GnrG3bMR085F9pfq
	DVBZYAvMNfn/e9uZL4rfpVrMzpJiEh38+lRxoT
X-Google-Smtp-Source: AGHT+IF3QgCkXxslVB6+8cU4cYQ7hXjdu0fR318XHFqwWXVd5FRKAeNtm0+mTEJzK5nwiVQMB620Aw==
X-Received: by 2002:a17:903:3585:b0:264:1afd:82e6 with SMTP id d9443c01a7336-26813cfb4fbmr18125285ad.53.1758104312186;
        Wed, 17 Sep 2025 03:18:32 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:31 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 0/4] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Wed, 17 Sep 2025 18:18:21 +0800
Message-ID: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
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

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

follow-up: https://lore.kernel.org/all/3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.camel@codeconstruct.com.au/

v1
  - Patch 0001 - add new line between the child nodes
  - Patch 0002 - use power-monitor instead of power-sensor
  - Patch 0003 - dd sq52206 power monitor device
  - Patch 0004 - dd retimer sgpio

Base: tags/v6.17-rc3-39-g07d9df80082b

Peter Yin (4):
  ARM: dts: aspeed: harma: add new line between the child nodes
  ARM: dts: aspeed: harma: use power-monitor instead of power-sensor
  ARM: dts: aspeed: harma: add sq52206 power monitor device
  ARM: dts: aspeed: harma: add retimer sgpio

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 59 +++++++++++--------
 1 file changed, 36 insertions(+), 23 deletions(-)

-- 
2.43.0


