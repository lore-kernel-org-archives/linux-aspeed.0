Return-Path: <linux-aspeed+bounces-1797-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA8C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjs3sKKz30Vf;
	Thu, 24 Jul 2025 09:30:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313425;
	cv=none; b=O4VYFDyPP6s4MpaAYm9lR2mOknPrzicLirZav6zZ8gowlTboc5dl2kgbjCP4AcoeDiQ0O2I6tUjdEmK/+GAk5rS7jKc5d/IazsWHiKtsF0KOiv4wxqkkvpCBLRdr4fXS8qiF6JOjGSMHeMQjswoxqppCh5LVp+JCXQ09E6KBMv9dTC7ePIRBzqoCrHsb1DuysSm3TbC4y8QVFohLHqJQmRJCOHliLdklbl4R5vb7n2rqffuJ4Clrv5FuEheWjM1MmVmPnrFheNyEyOC1k8PklSscLUz2jVaEVaU4ENEcAie8dAOq3e00upWevR6WZ5e1SR3O5zNTy5vv4rKqXPmbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313425; c=relaxed/relaxed;
	bh=tO98iZ6qt69jUEbguy5HbBMQSIcZbgLgv2m3GdQZx/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddqSaDoP5bbf5nrThOlt4rJzOdyDUDBW5yh2kLuUaieVjWL8QKBoNQlGmIQ+FmAIayNRE2rKOXXDmLIMYxm590ioP1CqHDGmoEu84NYDKnqaiPgVHxavNMNS9XUzK09drK0m+YbkS6dqosSbpqcOM3oab1jFoV42zk31jAaSqB4TTpWeZKy+NurlW6ivasE194TFp4kb3ZG4jUkzyRLS054qGkZO0nhSPg0u+Ntxs7hbYjk1j+ncx7qKdS4LRtPMszIpoSzGii5eDXT1dGa63LyccJXeLA1zC8mp1bHpFXpcM6rqKQ8fwjFBEIELvIz/ystm72gPkh7EI63T66aM8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g9aN+Npf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g9aN+Npf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjq6X1Yz30T8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:23 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b3220c39cffso492606a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313420; x=1753918220; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO98iZ6qt69jUEbguy5HbBMQSIcZbgLgv2m3GdQZx/0=;
        b=g9aN+Npf6gM10uHXZdqfWDEQhFWdHtwfRk6EJQL4Hvtww2kE1b6e28717AAghtvmZW
         4bf3YLKLvYj37DeA8yWTNF1AAklytIer8YuxWtx4uajgcY24C0g3Oqa/KPkI+yvxgmBN
         zpnwhx3IFMaXhAmboeZIKRgypMJLs4t8a1pB0p6l7Z7PD7IQucyTcvs+4XgieVHoW5Ot
         fprs2+de+Xy0aMEZA4LVto4Tcc0YJnEICGgMEN85W/6HPpsYOHwigZl2cYHGwaMQjLPP
         Nz1rl+My0j17gTciwyY9bQitQDxsCo49A7BFUv5GqUoSPWkG31XT1PEVDpsiiCnei6H5
         YtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313420; x=1753918220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO98iZ6qt69jUEbguy5HbBMQSIcZbgLgv2m3GdQZx/0=;
        b=XdNI0zgtvK9R6H4UR7Piz8TvRWqkgoH3Gm7yP6sPNnnKERhzxJ32yRuwo5IrwesRO/
         mNitpjjIZERihBieyHI60kpcJbBlepVTHgDvVfDulreM5EAqkHcoi6VLnrOBLSCL6NW5
         7ORS7YWpTDP13SMg3HfBcxqLIkZUtyk/0URCQKmyev8lCfYCVvJBYycYO0FPLAZ+RBEI
         vMLTnCYuA8dOvqGn+MuM+0hFvAmlj24WWOqNsXgEIXGHWB1MVRMhgoOYQ8VClZquwnWo
         V+Ame7Ny3ZWiYGJTzob4iTWXGWdL6aLgq52mA06baXkaB59b4V2mF7cnfNKA+m47Ksn9
         jGXw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5moSBRoScUzD1W06l+7USR08M53w5H2SGL2BY25OhnPaqpWzf8rApLblhiPcSaEmII3jSYb7e1TlvNs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLkaxDT4LhJBzfpilOsK9irSwfGU08SkLY2BOp6y9lXy9K33I2
	vyRky53VTvSDTve2WyGIV2j/zjqyreKLDh2rXpf8xy/ipPCZJxFDo1P0
X-Gm-Gg: ASbGncvUGduLiefzBg5C3megi+iE5Y1iRhXnX32JZcec6jQAW1hwIzx6T8EDRoFj6VC
	b5v6Eo6r6lzyyWY2qHkDk94ZyAm5knyFKZ/77EjkCOaOs/P0vm8tiPoSk0cQAvrH7tLpA+QAJSz
	pnlqYRlEncoueQwFokfl7Hq1GRbgYzfN7rjCqniinttOIxRf4qoTAlsFQ0W4L8K6slCUm5WOpm5
	OOZjwC9t6ZuBouT9TJ2+m9jW2uBi2cfk0z0PaNEjL6InetbwOkDBzyn0Fng5J5nstd0m301La/O
	vmSkqYH6OLcyPS3K4vGCeftGsQOscxoF9eaclQoqPb0MOzN0tfNh+g3jAWH5CieLbOqO8tOFico
	KvFkxOTEj6R4V7PyFoTHdUfnmu0c3XDas0XMzAXOVx1/xWCPhYN0rqI52KPYbbgDhgvrtVXRwN5
	4=
X-Google-Smtp-Source: AGHT+IHquOPa+liQqhO69zsGDdk2cs5CLA1oks7YvYmwOswhNilXRFUh4ud2Z4J4AOjCHvVS5OHHPA==
X-Received: by 2002:a17:903:1b4d:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23f9812b6c9mr72043025ad.4.1753313419923;
        Wed, 23 Jul 2025 16:30:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:19 -0700 (PDT)
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
Subject: [PATCH v3 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Date: Wed, 23 Jul 2025 16:29:56 -0700
Message-ID: <20250723233013.142337-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The patch series introduces the initial device tree for Meta/Facebook
Darwin AST2600 BMC.

Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
ast2600-facebook-netbmc-common.dtsi.

Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
each BMC platform because eMMC was removed from future Meta Network BMC
platforms.

Patch #5 introduces new BMC flash layout with 64MB data partition.

Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
and "wedge400-data64-bmc" are identical except BMC flash layout.

Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
"fuji-data64-bmc" are identical except BMC flash layout.

Patches #12 and #13 add Meta Darwin BMC and updates devicetree
bindings.

Tao Ren (13):
  ARM: dts: aspeed: wedge400: Fix DTB warnings
  ARM: dts: aspeed: fuji: Fix DTB warnings
  ARM: dts: aspeed: Fix DTB warnings in
    ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
  dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
  ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
  ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
  dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
  ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
  ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
  dt-bindings: arm: aspeed: add Facebook Darwin board
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    3 +
 arch/arm/boot/dts/aspeed/Makefile             |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
 .../aspeed-bmc-facebook-fuji-data64.dts       | 1264 +++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +---------------
 .../aspeed-bmc-facebook-wedge400-data64.dts   |  376 +++++
 .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  366 +----
 .../ast2600-facebook-netbmc-common.dtsi       |   22 +-
 .../facebook-bmc-flash-layout-128-data64.dtsi |   60 +
 10 files changed, 1804 insertions(+), 1619 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

-- 
2.47.3


