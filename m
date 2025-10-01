Return-Path: <linux-aspeed+bounces-2380-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E38CCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 22:38:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccVFL47lyz2ywC;
	Thu,  2 Oct 2025 08:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759308488;
	cv=none; b=kSSvD1WQsvwEEU+ycjr/g1rMfBlke44beL3k4vFYJkAHtZ8JcDO5/f8H0Abxb7pCNqQ0OrADRz7vAa9L2gglwB0Jg1DPArhsUt/NC+I1c/WHOdIh9J5DS5utjahyYLkwvk5yr6RzWIzST2t1ipSa4HB9/d1bXkFYQbHZiEDL/oFyvq0DylfPIRVYRL2tCX7Dhtu3mEpTcLRoWRNwOjkPLIN9hqDGBs1c2CDkTf4Sl4l+7bWascCECge92l/N0Nxah1TqDEsGF5PcbTMI48Cxen4Y5o5vGrp0xzz0xEiMSVt/66IkezpyVjTP2bv1BCrwseMHgipvMTiAWu0v7+dy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759308488; c=relaxed/relaxed;
	bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axvxo7SFy2FnWQPk6xaZE3aGZp/iFH46bn4+oVvg61YUHqbTFVNRs4B5nt8dsoXzSABOMtnf4L9xihfgwLJZ1hPW1m5D3lqexRn7qtIWy0ryqafmCbScVBLf6lu5Q1fgcnvxTvBGSAJLPhnnZm2Kk0nps+yNYZ7/s1F9mu96MGBLuGK8nvSo0aeTjgsDy+0lzkeHMYalQSvtAb2eTdQv+q4zpZW/DEhvtNtVzCs0QNLymjHMx/4niWFoNLThXT/40ykrEdonTOYMB9qQm618whQ9EwOgN1WtHx/3Tx5Sncv7oiDgKT67SFZ4lv2u4ijxsRjEKFKVIj6Raz/lr2/kfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QDkib9rm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QDkib9rm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cc7qW4rQJz3cdG
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 18:48:07 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-273a0aeed57so8799685ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308486; x=1759913286; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=QDkib9rmawi9S78aK3nMcbd32NP2sB4gR0RclxK1R6dgH48a/kw36md4GFJP8RO2T8
         rUclR+qmHMoA02WDOpmzqMYEsq2TDOJZK6hEerL3J6HGGs64coJo+0ZJYSQOEbg9At5D
         PiiStrvVDgkzSqaduIHgq6/bDvw6r6YZkFAoYwmk1y0xhNRTzmIxVIeRQxwj9fxaCBM3
         Mq1dTC29RtX2TCPTj+nrJ4aUtL9sTF9bHeYoko7u0sooJzsS46/ahwZA45wiWp6GpIvn
         ZYb0j3uXWjA6aW9zSzLH53VlTZ3YRTS4Uo00sv5wVOZrPpu7/8IJ5J3c7e62o2TrXkec
         9Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308486; x=1759913286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=qaxjcp3RTvN3mPTviyRfYt8nlz1AbzDt9xyFavlHxtN9E9dlAsudDNAw8IENmS22V2
         fyIqc9P7xnWXG5yyHbpAEjDuEgaiWebdMyHyZhFv9rtu3RaF4zKV+jhdYR+F70+3S1tZ
         k5sGfYfyYQai2OopXpmyiTGil5s+JwFa+VgFXR7whThms76CuQSny00ggVkwczo6n0Jj
         Cl6LAxtRLzDw9DdIoruu4hfWntEK94xCXwp7nkuwAsQMZR94ZKvvx1R2MFdBGnbWkCli
         6LASrj2iAE8p79L2UwciSw3+IZdsGC8neo/PptQlp2aZxXXpyK3F/yb76PNM6Js99egy
         1Rrg==
X-Forwarded-Encrypted: i=1; AJvYcCWySiAzAfuHLjBp0mYn9noGNe+UIroRfPRr0GcXCW1DH8swAeDjwqpyI0tKcQJbPdLd+YpNOKYOPbaFh4s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxeamoAmGr6hzlS5Cd7O7+QC8WGdlMKNEXbc/2BRj70FOg2Z86V
	ZqN6mNwBYaiZC4akX7rkaufpCgB9II49tUTc0ZQh8PCQkiZmOQIkywvZ
X-Gm-Gg: ASbGncsWf9+QjveFFQM7AduvoZpcFHmLLJRhIudre/Nxza4Qw3ST8lyueXclhNc9/VW
	8D0nkWrxSZFN5swpwi3xay3p9ubUccFnyEd1NC6pHglUr8ybCAkPv4qdvmC8+vJgIzNuBFM+eB2
	ERucjFFMTLyEVwop2ydwdaeOO2y4TEUAo7K63L3IvyjgvoOD1SyPm1jUkrswj8WNqNoScQ5kRLU
	H5nm1XWwiJ2G9YNnuzj4dZKPEDLdJpmCofLlIQuks9laUb8tw2ivMTukYSQilbxWhUz/Fy6AJ22
	GHY+XsWgUK7v9pv79OpnaaJ6GJg4Z0tl7XxMWKUouwWGsUDVJTMDiM1YBqO68pSfjONDThDvFzP
	pa2EhTt4Jw6HtoYyvdkL8yRIwo1KWzMc19cZURgwFyOqgOPzOQUazV4S51VaUY8xb38VeYSR9tS
	SCeWRac5aqt3N/KnBAi1XgmI+WUQX0Evi0Hgp9mzLlCLFdkNmYutnFZYufXugqFpNHsewj2WgE4
	JHbg4F37gp2c+WVUzhfXHptIne0x00ptrOh9fzRfX4iYwk=
X-Google-Smtp-Source: AGHT+IFBY/scw80qunl2/T9Vu6PBaPWzoOPWOZLXzt1OOaGSVwS1oF91+HBdH7KtkzG6z1iTX3repQ==
X-Received: by 2002:a17:902:f689:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-28d16e89030mr90619895ad.10.1759308485671;
        Wed, 01 Oct 2025 01:48:05 -0700 (PDT)
Received: from 2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net (2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net. [2001:b400:e387:f8be:46e6:cc88:b318:45e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d22bsm1789250a91.3.2025.10.01.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:48:05 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 01 Oct 2025 16:47:50 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
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
Message-Id: <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com>
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
In-Reply-To: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
 Leo Yang <Leo-Yang@quantatw.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759308478; l=886;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=YB1a54MMJXi5nKTH9gbuafJV6b8bO8PW9GeT78qICUA=;
 b=9gzrykNcBM16KdVMIcgRlrKvmyEZmO4QeUAovkAYB+AyBN+PsDPZv3TANn7fES73RwX8lDO9T
 vVHS1f30eGtApZ+9z9igVVO00ELz8Jd0iYfWzrFWVfjKYXrdqQTH9bu
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Document the new compatibles used on Meta Yosemite5.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e109a78d931dffdfe28 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -89,6 +89,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - facebook,yosemite5-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc

-- 
2.51.0


