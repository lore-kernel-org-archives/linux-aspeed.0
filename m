Return-Path: <linux-aspeed+bounces-4019-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C64CD4F21
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 00:06:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFYfR5WGpz2xJT;
	Wed, 13 May 2026 10:06:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778608232;
	cv=none; b=n9m/L4ly8/Sz/711AqfcyfLzqTTnRtWVXNv7IGv+YYGJue4cx2EwTp9/zVQStsqaPIOjEeonvTGDw1rKwSH4bx7V1OSrv3s714IiAVfA5+wmxM0OgOuH2T7l9xmtVVdVuegAzewdxo4kt3G17pwEG85NNcw56sDk51SPvhgk8xON5gZvw/nN6lS9z4ip10UFdJFtbI9fuc0DDvUvTbItutSVZ/504x/Tj6W6/MXSaBcXF6JErtkR3h3mkjXCr5+9FxBfgdWVK+ZF7ZwOjgwawWRlKedBX9UHU34/Kejpmr5KkUnwB7fZM4pbAGF6PfQ+vU8Vbknw5Hmve3r3pDPrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778608232; c=relaxed/relaxed;
	bh=Bw7yD9Z23DvEiMo8d6kpF8dSdIAQpco59RabySZ7QjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfLe/abGsQEESTyVVmWFwOaAZe6SPdOgvkv628XCDVQXCPifY/kW4GQrurzOsmEiUNcU7GD89FbZwJtOfCq/e8sYaJTFfpdLcV1l31ZAkZErqA0wgYVNsXWXKTq/TAlBiHr5KQ0AtYzNrpY61DdQ8aSOILguu1IezBY/4CBI5qFMQEOPZFOxjHe77EXnfU/49IEGZVR80PvRNNe3g4xFFa5FrKpAexBBjcT4iA13Edazvx+RuyBbFr6bepOCmTePqOT9MSXpBoh3lEOHjYUCRFS60Vngck1rqBp1VVTdySpv3lIcd7spHy6rk1JKlE2141v5YvCnT7Dqp+jLr5wJFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0VZO/Nz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0VZO/Nz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFPJR0Sydz2xb3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 03:50:30 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so4357602b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608228; x=1779213028; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw7yD9Z23DvEiMo8d6kpF8dSdIAQpco59RabySZ7QjA=;
        b=M0VZO/Nz8MDRKdI08deceOEiAmi5wpBSwzt80lkf1N7y0aKWiWAeH17R0naDOOuByM
         +2WLFnGiWJfp5ASXefVur4AppSq+TLiVZByhv/uZUpQsgsjtKkIABPJX+138sQMhYeg/
         ZAuElx7ol6t+xJWjeS+mGQVLF4E5hb7497RV5xvPAJKocwuXP64STVWzsGV84uIAuwCD
         XciiDPq1tyX9B0NA8xsbGLbP4sT/gzikimHeFr56p5JtspyvQsPqE0qhGRT2Nxq628sz
         dvb67zizJV3p3C6M6yd63TYSv9G5s5F5ZG0pHeE3ycfFoDlXzS4mFsIUpS4ifpqa+VVt
         Oabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608228; x=1779213028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw7yD9Z23DvEiMo8d6kpF8dSdIAQpco59RabySZ7QjA=;
        b=SHCFmkAVlMV8wRkW8hrQPeeuWHAcwoGaY+mtRgP0NjF7ts/6pYyhPg2Kj0lvXHRaxs
         KW3XFImKkcsVl79Yxs1jZt6QlzqoGI00Um36kPNLpxpfp5z5c389C+E9Jw6sSpRpYlqs
         2hsXrv160XawxwhpJDfFwGOSZCSEkt3Hm1pe0AKZjY6ykYy2I8BC0PkoqcXeQFkqLzaf
         zPKdfHem440WPSWZPsy8WCdeDJ5x/9YU5lFbXpmcw4ww+nQYsXKLAu1WWa03Cyy2e8PP
         LOXpszxwu7m+spI6YkiRidUDX1fPKszcyTUkosEtXt6NB5yD0qbOX8vNVnu+enx7X+VD
         a60Q==
X-Forwarded-Encrypted: i=1; AFNElJ8QOE67mm/eRAbSwFupJUkcjCTaZJSWGSAb30GK9FDAUHa2ASvQt3l/gOTTUOHrgchBpRC1arDcRSrEBBA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMvHCprZ0SMGFV1Is6wUuO2C1mXUv20r6T5MkjEW6KrgFrEyYR
	85/w8qHPckOxWnh04f9RUK+ccqidVZwqwD5O1AOaUDnZyYo0OO+yyEo8
X-Gm-Gg: Acq92OG7h/HEVUwcyol2es4aR+U7tYDS4UdtP20dhv8CBIWshjU4iTmewD6R8uiwDtm
	PAH10iv3uNS5AJOI36TXhXPePQh7+2aJJELmex+ZjRQzliECVvUot0OU0Zwx57rweguTjq9MV8A
	ZIgGa3Zu5bWX86iNhs92A6P9NfnWoZ/myiqwQoqYYWVGVBiu+HIby5ZDkAOATci60qsls4eJWen
	E/kXhFATqH2bjrjEvBtoKPuwsOK6Pzos9Lmcdu6HMuCifCcvwIMsixK9o62LDzWC4uSNoI+euNJ
	Pg4uOAHA8J4CMHsvN1YApi+oNPgJOCEe8z9oqZ4fCRlnEqYoVMjxriyXkck1kgyEDWxhY21jD5/
	cAAXlQIs7HpA3bSYnAlbcqZzq/HJ0JI/y0JYAaVCNzfz1ZV6g7016Pl+WwEtxQyRqAqpDDmAYlA
	MmQOqKvvBueicJKG5L/jRIfhXqHTKL6xOyNQ1aqWBu
X-Received: by 2002:a05:6a00:410a:b0:838:1c02:276c with SMTP id d2e1a72fcca58-83e3b7b53d2mr14261430b3a.40.1778608228291;
        Tue, 12 May 2026 10:50:28 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm24838732b3a.53.2026.05.12.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:50:28 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U support
Date: Tue, 12 May 2026 23:20:17 +0530
Message-ID: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
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

This series adds initial device tree support for the ASRock Rack
B650D4U BMC, which is based on the ASPEED AST2600 SoC.

The B650D4U is a server motherboard for AMD Ryzen processors. Hardware
details were extracted via reverse engineering of vendor firmware.

Hardware features included:
 - UART5 Console
 - MAC0 (RGMII) for dedicated management LAN
 - I2C7 for FRU EEPROM
 - FMC/SPI 64MB Flash layout

Validation:
Logic has been verified against the AST2600 v1.5 datasheet. The DTS 
successfully compiles and was tested using QEMU (ast2600-evb) to verify 
serial console output and board identification. 

QEMU Boot Log Snippet:
---
[    0.000000] OF: fdt: Machine model: ASRock Rack B650D4U BMC
[    1.085143] 1e784000.serial: ttyS4 at MMIO 0x1e784000 (irq = 31) is a 16550A
[    1.090566] printk: legacy console [ttyS4] enabled
---

Full logs and reverse-engineering data are maintained at:
https://github.com/prasanthp20/asrock-b650d4u-bmc-support/blob/main/qemu-boot.log

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |  1 +
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 61 +++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3


