Return-Path: <linux-aspeed+bounces-1379-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82524C71134
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJ9w5qdJz3089;
	Wed, 11 Jun 2025 18:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629124;
	cv=none; b=A2vS4UV9iOSRESJWdSmBWVYyNJThUERSyotcWIS1GMMm4dHSaePTPFMHAFPQTSoWWVGZdW87QF9ByKgAjO6ONafKxi5Nd0zG40ty1vIa+uIBQbkjl8DQqZSJU3J75hHuToGOestsv0Y0bNoNJtFxD3CWdWealKC38kd/17K8BGeCrfgsOGskZX0zFoNzWQnQj/Ni2Ny+7R5PAiMtjyPbemNJCvrXSfqeB/bhzTFYvtZgfNvrT1i5yX74tY+QUTdgOhi8tFWNxRZnTqVZFcEHeZdRAvqACWeafJG4GnnqkOER8x1v2J0sJsAZii71pjL3qD4TKiaNb8qjwY4HGpeRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629124; c=relaxed/relaxed;
	bh=lXPMVnUwf3/EoxHQfzIlGfhIh7pfwuueI5x8/O9yKtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WIulJqyGrq42OJknhTTV2vPwacssj7y37Fe4BRfItOF0VWqpcBhySwSVPeOEsFJvY5OdDXyprWrpoumqltbyxc20kzASxfiYWDgjgHlhvuPkbzrsWLGMR89yNuYB244KtbpbsJd20HjEg8jj0tR0gIgbtPShLBL2MIBqM+sjJ8dhmN++LbJ88kM2Pue6BsbYwX1egtamldT80AbMdjA4HAxU3/K4D1ck1FdQKmz3q90upqhsgEl+ZZlfPu0bx6TvcAAOUNGEL35MCtCfT9YPVfTnx4oEkIzsTbBcH/VbHQra3U0uB/+UzgNxnkt87qf7pyp/5z+/p5NdApljKeo76A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H0sd7Wc5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H0sd7Wc5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJ9t5c33z2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:22 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2363616a1a6so16700025ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629119; x=1750233919; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXPMVnUwf3/EoxHQfzIlGfhIh7pfwuueI5x8/O9yKtc=;
        b=H0sd7Wc56UGI9JlrTlR8uF6cQPL9rmqzDq5v91eJjwihZwnicjdDRzcXggHgASxJO3
         OKZ3Y5oq6bR3/Qehc20BFlO5VrX2lTrnSZ7b4vj2vf+sGQQvw2xeSw+Poep2Sq7OCtul
         GFeoofL0LxSZvrHi0ZhhYjMlV0NhqfiqMjW1t+Kphl4Okvb2+cusgXSWgWYuCXsBO9tl
         HAr4mAd7O8aLZDY/Tix1L63zi/CbeAg8K8btfbfSsM1q+s5mFHyRRd1Spr5zFtNjaESF
         Ra0/YtxHHrcH6adJ9pPlaHb1o9HtBZrEZ7rSGX3BxBm4gwDB4AObvtOCAJfNRYHttKKT
         n0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629119; x=1750233919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXPMVnUwf3/EoxHQfzIlGfhIh7pfwuueI5x8/O9yKtc=;
        b=LS9PyA8YY2FK0y8l3gVPGbtLk2aI4HmBh/5tnqKhbEE9VgqST0BudQS7DazfSB2daO
         yhpiAvyO9WivEiEy/s+YSJrk1asBCGhOgcLbgcIv8RUqwIEBgVuwPedafkrk/L2Nx+Qo
         fLLVIz7X0vNlXuhvEbBkTbYsZgBhrSczbD4p5aNRTfT2vgnPYRjYaTPEXN0W4QmaPokj
         2ZiayqelObFifvYNJpMVsTNWG1cdcBCyNqAVzan8XqZ9+SMiKaV84HJo6+98ClIeGbRn
         dvWuIKnLK7mSmRKa4lu8i88ImxsZO5N/yLYn8nqlcdpL+QN1ufLgnU3nh/L9p+mPRiIB
         MoFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4zVeWU57/XMxXX4fneDZURlH5tJl/eCUKUBNjKhOFB90OqAauTZf0e51hfbf2YTukwxWLh4brjBrMFog=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzC0JY1gfKsSjTtE7AeiIDV6snyrpnMYo2gwx9HqEF6FMLwdeq5
	XN+u07q56DxsvBsZ7PlXdgokxQwZug4E2dB6kTPrrb31loeD5nzPgPCs
X-Gm-Gg: ASbGncsNl87J7A8WHL+S9zFnhS2ixT3ilNwTpZtgCPOH7ierocxSjf7fiT47EL0PIcP
	w87cxHAXwu23IT1utBLDDTqM6TQOUa729V3WQGQa5LjFprNX3Vw1ROO5fhbl60Scs8K+6W1ioQh
	b4FZNVQNNXfII+oMckyMOwtXFnSDevWx4zNFn4JU9VcvbSZwDwH3KFe38WRORAef1tPmtdi1Dqp
	oZ+R0nlJzJG9cyF1VFqCKWIXw7MsbF41S06JdtM9bLc1Lp8WGJXolKhT89+Ur/w/SpM/GSlmxvA
	Uc4GY3XO+PxLJfZTfTk/LTuVPgtQ0l9MNvG4oo7e/5o/G99PbfBjyFHL0E9XhOD1vEVrwbcc044
	bBSeni4hGu4enxcwfMnn5MqVl1cvstHrjll9afHAFeryw3W16eiC0RFU8lOfHB3VvuQA8iKyDkZ
	lW4HEOmud9loUqhnIK
X-Google-Smtp-Source: AGHT+IHeguJ9PfRvFO2Sr8bPSpOlwMx9Qn9l4lODdIxgT6Z8X+BhIHgTKrD1PU4ZUCit2Tge/jE+KA==
X-Received: by 2002:a17:902:ecc1:b0:234:ed31:fc98 with SMTP id d9443c01a7336-23641b14d61mr29238475ad.37.1749629118911;
        Wed, 11 Jun 2025 01:05:18 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:18 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Wed, 11 Jun 2025 16:05:09 +0800
Message-Id: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Based on:
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
commit-id: cb3f397b17bbda3f2998eff9e54b040c8fa85cc9

v1 -> v2
  - Patch 0001: ARM: dts: aspeed: harma: add E1.S power monitor
  - Patch 0002: ARM: dts: aspeed: harma: add fan board I/O expander
  - Patch 0003: ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
  - Patch 0004: ARM: dts: aspeed: Harma: revise gpio bride pin for battery
  - Patch 0005: ARM: dts: aspeed: harma: add mmc health
v1
  - Patch 0001 - Harma: Revise node name
  - Patch 0002 - Harma: Add retimer device
  - Patch 0003 - Harma: Revise GPIO line name
  - Patch 0004 - Harma: add e1s power monitor
  - Patch 0005 - Harma: fan board io-expander

Peter Yin (5):
  ARM: dts: aspeed: harma: add E1.S power monitor
  ARM: dts: aspeed: harma: add fan board I/O expander
  ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
  ARM: dts: aspeed: Harma: revise gpio bride pin for battery
  ARM: dts: aspeed: harma: add mmc health

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 85 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

-- 
2.25.1


