Return-Path: <linux-aspeed+bounces-1245-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1015BC5AD49
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 May 2025 23:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6Ttq5qhLz2yFP;
	Wed, 28 May 2025 09:51:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748358618;
	cv=none; b=Cn0n46YpHN3MxsXRMzjsovlvE9F0DgVOaeiV8PHa6QyGPRzWvpm8O+Nct7eyzTmLlnHBEdwJGsm0uCDKVXrCgGW0a86HYeLJwwbGlJZwW7+Q3ji3mmXNPMHl4cZgiYtQOo5qOw08hJtZAAakIafWo2u/hdyMnSZ8RuZ66s42jnM9GfF4so1dkQwXOjSsTiT1X45fWEx3s0k1mRw7h4L/JS3r8LsFBWUEN81v2YJZOIyFFPbAeCy0NNPkvX3tCEXES/L2V0CRBz7TuZ7IrJQEX8IL6YQ4hgkUSO9YU6rAFf1OQwYlNCgyaRDNFvSdm5JLoS6HiJB/duddZ8goaUmn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748358618; c=relaxed/relaxed;
	bh=gqD0/od9qaSOr72rB1opXGkuaDPzcvzJRRaU7EuNDzw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fJhAIY+3OgUD/jpflB+nY9OIe03PnjnT8xEfdFDSnf0zNpTqnvleaPydweAoTCQZE6JtOx8ueNJE+IvKF0idHeqViDGj1U5cmhLvGhGSb9JQWsOG7zmLYRkqTyvpF93F85J2ZPY4jAWVM6l0KzeySmLCfy0mNJltkOkRryA4D8amI3qz4iWoyHU/lstsomOsHn09Ni14CJl+ays4TVtAe8FMbj5tNRJNUHtmJhG/U5jkYGvaT6DuaSBscGjywunYJ6kL6KzJy0stGMDTsWWTiyHkKzASPUnJsshslwRu4Ohb/+RDk5GkOhin1YeaSkh84a6qf4SsTTUgADcbbKJLJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKDnzOfK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKDnzOfK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6GK41ck2z2xPL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 01:10:15 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-742c9563fd9so2357542b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 May 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748358612; x=1748963412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqD0/od9qaSOr72rB1opXGkuaDPzcvzJRRaU7EuNDzw=;
        b=dKDnzOfK9lZRj35Y6JcwZLVsBMw7V3iEKpmPGqMdHlFt1ss8jslk1aHLlZ6pFNpi8S
         BB0RC6oIMj3/W39iruqmDRvDKJTNIGHaRiCwkUDq3YfJ0SChAI2PVbEc7Rv8RN1+SuRC
         1jjfSwy9obrQx+sWYixvwYlLu54xUgt/AcbJI6DObkzzrW4HFkG19oDhmMVbo3gBrXOj
         eYfaZ4TRVyGlhjeBrtMCNs50+Ybv7UcYQgoMpPGbHRVdJ6UP9YUyYeNkGfTOi6iWJvXp
         mpQEDpF7m5Cg5pYf92b4134l1OE/vd0b2Ytkpb6svpR0NdnBeBBg3Dfu4UNnAINHTX3t
         LPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358612; x=1748963412;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gqD0/od9qaSOr72rB1opXGkuaDPzcvzJRRaU7EuNDzw=;
        b=seWy6GmZv4hJBhfBT6tpyiRe8kJGVa2k/mYb0HEjTFgesDCBLRoEoXYpJq7f+88AWu
         28iRa3ttlC+GZCCjTOv7PfwgeiOoQQ9efHkG2tLmnohCPmMSJweN+HQLgBYcDrzAcxLI
         w8kxHKRIjaa7z2v7xrdc/aXm9rpMLpPfaBB2tcqvf4+4n9dRyCVO+Ef7ROhhmmuYZve7
         Q/gzammvZuOoDXVLinisokm/UrYEB9+0dI6cuy/p03abRQZ0Y50Gd6jjTy+27kbU3Klr
         Z7/6Nkv0dPk0R6KSYR1eUFzefiuha0dAEfFEJ50gzF840Wqv+D67Jfj1WY8vMN31Inx+
         HbUw==
X-Forwarded-Encrypted: i=1; AJvYcCUlyKFlMcoiF+VzAXrqLR1ujXdQdPc1BhH3uSJn7zOoKegUh/QUT9Rz9yRsrMwL1N/Mfyu1XY8pGklgDUg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoXqqXarHr7nhFJWJJbKuXuXaV2USHK1DheTGEP5kHizKlmEH0
	/Y2PuVu02VMwrtEfnrbEIg6jIERCdXOb3+p6iGyTSSeBxHFpjcn8tbUC
X-Gm-Gg: ASbGncvxJTqQsaXyrwWBKmhPWaJ7UJnGOfeJGJaL31dOTXtTGh2l4P6EM/1gPiUjRW6
	cf+J1oOojuJLrv8RYdlMd/xLvRwy0C70OIOxI4c08FqDfHAR1va7aI/CXBdK2oNGPbBu9shbhPd
	YFLcu9BmLyzRNMvftdRQ261ZJJ/5xubBZtkJ3ITqyadu0NRaM71KiETodNtkO/CZTAr/qmoK3vd
	YFdGImT6bQbfoHE4fdg4RYEjd39D+Exbi8IUe1SdLUXz85+22LDZNFoGRblqBqxT7rpdvO//1TQ
	1nUWIpQxy7SAVQjPqpVqx2tmWr3pwan7YuXs7esT/ekR8LK+9m0jW8qDKWsZcse5RvaU6Anu
X-Google-Smtp-Source: AGHT+IHKy3vWfh1PGy1ku+o9RNhskr/quenhtttfB2tDE91aGVAU8V526XbxdfEk89gY9R6EfOonTw==
X-Received: by 2002:a05:6a00:14c6:b0:736:5438:ccc with SMTP id d2e1a72fcca58-745fde87a75mr18828988b3a.9.1748358612384;
        Tue, 27 May 2025 08:10:12 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de11csm18869987b3a.31.2025.05.27.08.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:10:12 -0700 (PDT)
Message-ID: <6835d5d4.050a0220.14ffd7.0e10@mx.google.com>
X-Google-Original-Message-ID: <20250527150946.2815348-1-LeoWang>
From: leo.jt.wang@gmail.com
X-Google-Original-From: LeoWang
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	george.kw.lee@fii-foxconn.com,
	leo.jt.wang@fii-foxconn.com
Subject: [PATCH v4 0/2] Add Meta(Facebook) Clemente BMC(AST2600)
Date: Tue, 27 May 2025 23:08:47 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f168126c-e0e2-40d3-9b9b-2a5002a75474@kernel.org>
References: <f168126c-e0e2-40d3-9b9b-2a5002a75474@kernel.org>
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

From: Leo Wang <leo.jt.wang@fii-foxconn.com>

Add Linux device tree entry related to Meta(Facebook) Clemente specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
Changes in v3:
- Dropped blank line as requested by reviewer.

Changes in v2:
- Fixed all dt-schema warnings/errors reported by checkpatch.

Changes in v2:
- Added 'Acked-by: Conor Dooley <conor.dooley@microchip.com>' tag.

Leo Wang (2):
  dt-bindings: arm: aspeed: add Meta Clemente board
  ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-clemente.dts   | 1195 +++++++++++++++++
 3 files changed, 1197 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts

-- 
2.43.0


