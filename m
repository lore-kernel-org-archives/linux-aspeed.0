Return-Path: <linux-aspeed+bounces-3227-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE3E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMR2lkqz2yFs;
	Mon, 29 Dec 2025 12:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389626;
	cv=none; b=EEtsQi5P8cl64jWgCta5AZ+0rwqcnGJWF+Rk4Nj/pas66Thz/DBNaOOXdf/ljY/AGuCIyKE39I2NlCMJlG0/2OgBgYTq0gnmrOMzmk8zknMReGBxlZPnc2l0AoKR2iUWVAZ3LOGhXs1gURquDAVPnktmvnvGzqkbbctDd2XVbmrJc4Kkl1lYY9oQPnN26d0bAYsMYunhHovAKJWpgqv7N7vVFjJsI/yAGDquR61W93OQinejANjFTPyIH5GHccYL1mw3jUYa2s71AlegzBO9gVmBiv4hlM0c82XKPPlbmL+E6gckUPEVD7+65+KYYNRMSiLdmwnksvr9knk0EzRPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389626; c=relaxed/relaxed;
	bh=1Fm0ytkCzzsZtMoWmt94fz5Tfw5Toxhya5YWhR+90lM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IWgmWZW8/0VkLpky49KDlIBiI1dcwPhWk+Kfcyd4jLTfd/0cxdnVCIylZnLWi/FDsQupRq+iq+gv2/5F9wWm+6L7qRFUWoBBrKGDAsdQPyxj8rzizA6J5wI7tZbuoe6gqzf5UFDEs/RCjurzx0EqAxs/JgpNE0x/yQb+THATzqRDxAnxiYYBs7fXfYGE6KP3viaAxHpIrGIz2Ch5lXORG8WI2vPAn5Xg8A22sQthHWq329isjwrZAQm+/7foGYfaR2Uih2IRkL8WNW8/l3+R5rwJdAKyNLuTC8clYdOdNu5GprDDihWVHbonCwg/M2dlgU7W/l+JQPyEUxuxaZ2Nyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VLVnaUWS; dkim-atps=neutral; spf=pass (client-ip=209.85.214.175; helo=mail-pl1-f175.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VLVnaUWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.175; helo=mail-pl1-f175.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVbF3r2jz2yFY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 18:47:04 +1100 (AEDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a081c163b0so34309985ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766389562; x=1766994362; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fm0ytkCzzsZtMoWmt94fz5Tfw5Toxhya5YWhR+90lM=;
        b=VLVnaUWSAx+jQOfep9QWa1Hk9RhdoVaQXePyQhPqnkFKJUM311UyFhUcAPg3sAswgF
         8vPOKZzCOxa3ateytRJfSiyjUFPQm9ypUtkSYAdJbTob66RUVuEFDpJ2QTQjOMvSvP3P
         ZStsJT31PkmwpPoyPrvhsbN6zjMptSUlOx+CKzg8VtWhp1buEwTuqQ7+WklcE0RoST+y
         6tdUs5M4BXgb/U/y0cU+qsBG7H9ky1CJG4GJ8cLlA2bqGksHyio6LQVrSO9tPLBb3NRS
         ddLQBYLRRjjwppsbKxgTrt35NK5J3UWUIShwkzy7pMlM5RNjR14ZCUMTiJjxjZdOS7uV
         wnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766389562; x=1766994362;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Fm0ytkCzzsZtMoWmt94fz5Tfw5Toxhya5YWhR+90lM=;
        b=rLanx+X7LFDDJ00JxFjBQ68RFBevuBpjmplh/ECvRzNNXQS4vr8MjTDWMXTjwk9+zV
         Z6d374WdJQ3PHgf3KrRkb39Adan2aauR0QwttTYJ/Dkf7zdVHww+L++3H4PDGWxZZI3a
         TwOI1t02dsdF4pPK3pQJgWaMwrBBoygN0G3MbAHQ76zwB+ECpRrGrB+EoJ7vstKQdPZE
         NSb5Gw9gf59fMK1A+LV22Ci/Y58WF6yx9bI2wYyyKoM+ApdBbxGheKU4ZF8RYy5S3Pom
         7f3B5CD/UimdqUz6TFJz3usuAb3wdCwcCD4GxeLSAZ3b28ODkpWCmOSt8UvRal6G6VUY
         c0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNFrsqS8P8mDdAWdbuchrtElu0HZhfJP0TwzjKn3sdGvoS43+rUwrMptAYMAr3oir689wN7NuldomGPbE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyb0sDUZ7RqWD6G5y5Qm/lm3ulOW4xgedQYR5jKfGHWKTKx2Jvn
	nPkdqjfo8kGEbthKehiB8t4HOhK7zdUN4msTFyfv0ltlnu+mP09MZiG0
X-Gm-Gg: AY/fxX6hCkDdad8UEUnSwOdCO31D2SSXGalhU0qAaBzF7H1U8FqTSTGZJJTPYvU+vMe
	/HYVjl7ZX/xWKlpL8xKjFkk9NGoxeinVClVytGaZTRZkT2LBcdsHvijmkoK6PUsRVxdkjXaQmoK
	40jObspMncWzdeD2x3GYPqP9QE+6vxvR7cPaUE7HAziFq1ZItRIwXhywpFfZYWAhZXsi3enFL8P
	6j+zeYCok57neM65LLcPmVRHl65H4HKKO3nIIKjhdqYzaCfkyeg0pJjC0lH3XCgXiNZf9ZNFKc2
	IsuYdYNABbKT3yA5exk15QsRNi70t9e7T5sGgEhhgT9Ym4oAT75RR5zr1y+ef+dGQxB5E3asr2M
	2jA57hnjU8jUbOV/2RWaNKFyVpqBukUFV3XApU0WB89M5DXfX8YOvBHxX6BIBDLQHxcNBSttPyh
	givBHU2maVzv76pxtXkgfY/B4skRL/NrZec0X+R7ghQsotaEMwtSWA9lAnQ82AFph6LITc8stwg
	MTXRD10W10KfsLg
X-Google-Smtp-Source: AGHT+IHZy+xdBVzO/GB6/G2tv0TmbUIkORQVBt6UpRip9g/newtl6CMwaiALwAcivww2CRbJvKrmhA==
X-Received: by 2002:a17:902:f68a:b0:295:99f0:6c66 with SMTP id d9443c01a7336-2a2f2836964mr104720125ad.36.1766389561828;
        Sun, 21 Dec 2025 23:46:01 -0800 (PST)
Received: from [127.0.1.1] (2001-b400-e3a0-2ead-fb96-4f50-681a-bce4.emome-ip6.hinet.net. [2001:b400:e3a0:2ead:fb96:4f50:681a:bce4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm89605105ad.59.2025.12.21.23.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 23:46:01 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Mon, 22 Dec 2025 15:45:42 +0800
Message-Id: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACf3SGkC/x3MQQqAIBBA0avIrBNyosKuEhGWUw2EhVoE0t2Tl
 m/xf4JAnilAJxJ4ujnw4TJUIWDejFtJss0GLLFWiChvcvHyBkd2HNnso41B6lJPFbatbZoacnp
 6Wvj5t/3wvh/iKNU9ZgAAAA==
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=1U45K3W9FRxsfbvvzg7mdtDjI/jjVfHl92eXMQxiWlM=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpSPc1Shs0Q0pMY4uKrv/B9B9j/btwZgk1uTBRM
 mt4115VUEaJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUj3NQAKCRClg0K3CVbE
 gSqoCACl+GJeVtCd6QqxE6qc5Fxc86uBRSxPbrzRkBEviqVGBcy2mry3Uy3SkDFxPZePkHmFY8U
 2et+EtaBHVuzCWQYHRJESKKwWbpOlGCxX8oL9xaLbmUxbnb61aNxd3QGuICWWc9jiR7/H5scRjb
 MFZ8Vn4CIHlfQZEntkPzDWj9R2mbvzoSUVRFVTPpzkmqDFL0Pu0YpvXKJe94xDm94DZ1mAKXnpr
 JaEv/N1vjUm7W4BdKHMNjBR49ezPwzeATHpwwcTpnLWik0W9xCAOjhrEAJnWv7xiXF0I3tHNaN4
 Q08DP5L6ufRxcAb0cV7ndXyvyzfFEaGP5dltz45ztEr2J3jw
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2950 ++++++++++++++++++++
 3 files changed, 2952 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


