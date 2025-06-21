Return-Path: <linux-aspeed+bounces-1530-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF29C71157
	for <linux-aspeed@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPrw70brqz30T8;
	Sun, 22 Jun 2025 10:01:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750492297;
	cv=none; b=fr5BFFG0DCx9vJRzzIFOAEp6BMUUNbqrJ3pX3iiEMPkWZgSjqAiUXfeqtI7JVppVM7cbxuilJ+CDSbsZYTtvO3QS56AgchZLBRyfe8hVGAwixa2+AYxxKh8YvsZNY6+nsR5zZhUTD8WZQFh+I791jYFHBAZW5BCy9jNHhnGk98IVmKEoHok6xS/v0N9zWvL1LdPbbyvFvJxLz63LvMGfWHMr1+i96pG9yQGW1lfb+r8GwcDTDy2nRgnfi+ZkbuXw3G6GbisOB+YT+tdibGxLxHTERQn9E+BkrS1sLMfc2kd5c92R9n+hVuaL6k3UEUjYIo9kjaXVkwrh/424cbsdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750492297; c=relaxed/relaxed;
	bh=QjH3SClgXI+/6Dzi1H3p1vPtwWYmzgf9jmyxigyRNKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EfdBMaEZUPeskwx7AqwkBsHz15sGLQam+ND3UyWbQ93rG8KWdSswxwLzTeO+17UKBgCWs4KsJ6iBOIxb1ZnzU213b5b0uP3OD4iJc1MaF8lZUiDzFSHv6FceXncbgNdsviRxTiEOpTPeghYnrqilRQYHyGn9StZepiEQE5HuvWOxA9dgvCbu90mhQycZ7SVipTcDqP5msWMKmbA5wNUBzcDd/tI+Rkf8KG+8XY8m9L/EtFjXa/3RpEdmjMuZJB884qKF9sKJaSwl0gJG/nV7m0xdyY7aCjmpq4ompDNxcjIMgzSZt/uy3RZ/YRnv9w4CLupXWJ4jTM5mSr4HHehHhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=acv5BiWQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=acv5BiWQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPRPM0RnXz2xjv
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Jun 2025 17:51:33 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-234fcadde3eso35340845ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Jun 2025 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750492291; x=1751097091; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjH3SClgXI+/6Dzi1H3p1vPtwWYmzgf9jmyxigyRNKs=;
        b=acv5BiWQon84LdygMnubyWEHc/qLrxOnu+3mYFTNFaaJtWJBTsmn9pys2gHwGDguJp
         ES1n/99GNUR20eASd2rOUMlKHvThimYhGx9Cn18h9oELvWp67BlPUVLdsGqVHKoEJtFu
         NyixOZf4T5vYiYWg28XvMJ7Znqk0ybbi82zNqCmaAbOkmV0nID7Q5U7iOM0AginnsQLh
         sSyCi2x5L5aTazdSOyjN2YdjMV/VqbqpoQ4ZIMbLNsgntoYf1Xj/E3oMQEXeAi3Bdqes
         VqCzqRGNNe1bs3alw99oyd9aDDss2FLSow2SVnOaUf2el5n2Q99LAgsLycRzCvpQdhi0
         HFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750492291; x=1751097091;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjH3SClgXI+/6Dzi1H3p1vPtwWYmzgf9jmyxigyRNKs=;
        b=pywOsESVpgJqmGjpAZVa1Er/xkvxFX9KTJnxOPAS6wyBjAxUdeBtGLrzLFG/ZgaUvg
         yNMWe73u1zM3pQw9SHle51YIguApiGQl3Zdtk6dexAe3pcvg9c7WniZCDzbDoiZ5b/6d
         4819I+af3ldmouZzz12gM1ZBcSaVAd2DdDlv/81r70VYGQkpncVSrsYL2gGxX07b5EJE
         xKyaH7Hdu9OtbBO/IUdVKdu+5/Vg/xrr3DXTMSKd1hjMRp46NGpBldWpFbVaYy9rCHi2
         4dsVg4cqDBmtejiRkfQDdQdQZJxln7SdzGB19wjSfB1AGyeNSq2fCxGdR02XiDnZ43jL
         2wQw==
X-Forwarded-Encrypted: i=1; AJvYcCUueF8vtciG/S+qWFAjugVFHG5RrTncUuH4tBsLYpp6ooOcsyP9sIuUSUoGXRLZCwnXBxDS7bXfL1tiu/M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxigE4speq543B9Pd5BtlnbQM+hrd3G4lCseN+aUi84cSrq59L4
	7ynQt6dbK2uumkBCdgtEzLg0LSQP+qldXIvNQosWDf4oQW5RdVLOHPNH
X-Gm-Gg: ASbGncv+G05QKV7B4dZxfLoUdDGMBtAIBAeNp/vT/BrBqtje8FhZSDCz2fvW7e2hk1n
	NPrRbzqPFneJ87mExj8YVUpz2xdr4A2wYYaAsV4ev1d8qN+nibbFNFxkHjfOT9oIT3CjaCz9azF
	xPoWib+ofKAZBFJJQHDjw0blQNxanPrG3Y24IuQANaA2NE+oiI7bV4Qyi00F66+fVzmhWdc1aqZ
	xZC/UEiuSHvRflGKxHtFji9kEoMQduAjZ5WcCXn9FG60ok+bp6BnWc83mwIZo9u2VTR7xWU6Y00
	mOnelxPrul7fqHfPqtUvN2glAb/a/DtXV+/JNm1NlcCFm6iJw3XVVCp629fkdJTvwGRZeKOrXEp
	OA+AUrGAnEmGxUoT1Ee8QjkW6iHE0EwI=
X-Google-Smtp-Source: AGHT+IEyGXu1Hnb5EyVdRM7a2b3XmM0IodUz97aojyFKVoSTQ6nDz9nCL93hZ+xKfu3PXPQjvFm1Xg==
X-Received: by 2002:a17:902:f64a:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-237d9a74415mr71122785ad.37.1750492290735;
        Sat, 21 Jun 2025 00:51:30 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ee9f6sm34823025ad.73.2025.06.21.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:51:30 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v2 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Sat, 21 Jun 2025 15:50:58 +0800
Message-Id: <20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJkVmgC/5WNQQ6CMBBFr0K6dgytUIWV9zAsyjDIJLYlbSUYw
 t2t3MDl+/l5bxORAlMUbbGJQAtH9i6DOhUCJ+OeBDxkFqpUdanlDcwwQHzPsw8JRh/AUjKAL7L
 kEkFvEZpKmko3PdbqIrJnDjTyejQeXeaJY/LhcyQX+Vv/sS8SSqAajdYNUXXt7yNz/q7onTujt
 6Lb9/0LFAttqtgAAAA=
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750492287; l=1084;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=N2liG/VEGn1zE58WPTY+qTYBZrxC0ajqZccxgE1zYhE=;
 b=fCy/a+Emc3jwuaGbTCnI1u0J6Q4wpXHsYr7ABj3llz3y/iKtON9QG4+bPd2oXl0lGKNnIwxHG
 1cKF4oLZlwrADnOQp+1mn6tAnP3IjZ8Ko7b/XEx7cz9N0S9VWrlOWg9
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (2):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1254 ++++++++++++++++++++
 3 files changed, 1256 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


