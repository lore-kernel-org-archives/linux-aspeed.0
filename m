Return-Path: <linux-aspeed+bounces-2042-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0967CCA0EFF
	for <linux-aspeed@archiver.kernel.org>; Mon, 25 Aug 2025 01:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9Cl70jcvz3blg;
	Mon, 25 Aug 2025 11:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756085091;
	cv=none; b=J001y901SIYw3c5mTy+9miYRzm9gYQciSiapBM+HuZfWLp40/3rUPMZ9b8mzN+QuvF85pYiFtdufrO5dgJt6PbNBhT9zfRxbLQJgLyY19LC4eapD/TpAzYr0gYT6t44nNK14OGM+9/+jKvVjA33WrYWXOepD3tUQpSx+6H9PP4Y0xWEgpPjFJoSHtkXL9jDzu8ETllLO0f5TW/Eg4IhpRF++pojKcn7oyst7Bt+og4iSWi0vwspGCu3Xr0QhOqhBfPMHbSznYfNNyuJLjIE1H+R9MUOd0OZf6A2xTgwgH6qiyz+GsT7xcFMqsEv+uS07xF0nzdCdJv3dKT52Pp/0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756085091; c=relaxed/relaxed;
	bh=9eI//ifONMcYx8OuZ4RyDvs/wIE713deTiuA/p5E0LQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iBoztKVmrj5Y/uI4PqveEV5cRFIgDxWkqITPOAN5WfCTeQO1+HjvezU6afMdw1W1aUS6TMCWQBu2UNSMehcMOFIh0DBpoeCmHhf2ZQayaA4AhkTMA2krJhb6JSeI22vEnSWrvWpdxPkhrJkmDcJomtR/xmi2I/ADw/PaCkFZP9FKWllo7o/Hnk9eVQ72bK8+39VwxqMs7oxqmHRQz4Rv6gjVajJgxHezmRDEnsNVbyq1N3wnftkGy1B2QDbHJCk8i+IpyANQQVlaP7ziQXADjTJSkPYXE+GSGsEyZvu1FJEE3ZDSuFUlZ+oeD9BGip5NLHrOwX3Pkp7qO2wdxLYwUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pc9r9rdw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pc9r9rdw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9Cl61lSYz3bcj
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 Aug 2025 11:24:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756085087;
	bh=9eI//ifONMcYx8OuZ4RyDvs/wIE713deTiuA/p5E0LQ=;
	h=Subject:From:To:Cc:Date;
	b=Pc9r9rdwKIaqaqFzHA42xd2Qij0DYpICdtD6inYMnMEaNit74E9HeNCQSjMXPJfuw
	 BXaPrlnESDziCtFHqGheuy67ZBJ09aJE44B4x6OcsQxbR8GLAuTn4HLAxfzVDapRwn
	 uwMR3ac0XAQBt8vgVXVaY1k5uLYYgrM/P0yeSOZNFoG2Agl0iv7iGK+9lG3fXWGwe1
	 8HPmxKn7y90ohEJmUF6d6UCE815cSOs8Tt3umXNPMUNToPZZr4LzLJcQVP23+QLWZ8
	 bXPQvlvPbzQnimiYxIIYisQwU3KvWt99aE/fSVg+okhGF+V4EVR7keS5+01VdvvKEL
	 mGM4DjglucP8w==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7653064C1A;
	Mon, 25 Aug 2025 09:24:45 +0800 (AWST)
Message-ID: <cb634cffaf0db9d25fb3062f0eee41e03955321f.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: early devicetree changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 10:54:44 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

Hello SoC maintainers,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-devicetree-0

for you to fetch changes up to b785b5d88cc27a521ea22b3afd85804c4c321d4a:

  ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax (2025-0=
8-11 09:37:48 +0930)

----------------------------------------------------------------
Early ASPEED devicetree updates for 6.18

Notable changes:

- Meta's Wedge400 and Fuji boards have had parallel devicetrees added for a
  transition to a new static flash layout. The original layout is deprecate=
d and
  I anticipate removing related devicetrees in future releases.

New platforms:

- Darwin (Meta)

  Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
  health monitoring purpose.

Updates and fixes:

- GB200NVL (Nvidia): Networking, I2C, regulators, GPIOs
- Wedge400, Fuji (Meta): Fix warnings from devicetree bindings
- Use fixed-layout for NVMEM on Asrock platforms
- Various: minor fixes for warnings from FSI devicetree bindings

----------------------------------------------------------------
Rob Herring (Arm) (3):
      ARM: dts: aspeed: Drop "no-gpio-delays"
      ARM: dts: aspeed: Drop "fsi-master" compatibles
      ARM: dts: aspeed: Add missing "ibm,spi-fsi" compatibles

Tan Siewert (4):
      ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
      ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
      ARM: dts: aspeed: romed8hm3: convert NVMEM content to layout syntax
      ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax

Tao Ren (13):
      ARM: dts: aspeed: wedge400: Fix DTB warnings
      ARM: dts: aspeed: fuji: Fix DTB warnings
      ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.=
dtsi
      ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dts=
i
      ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
      dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
      ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
      ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
      dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
      ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
      ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
      dt-bindings: arm: aspeed: add Facebook Darwin board
      ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

Willie Thai (4):
      ARM: dts: aspeed: nvidia: gb200nvl: Add VCC Supply
      ARM: dts: aspeed: nvidia: gb200nvl: Enable i2c3 bus
      ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the HMC gpio pin
      ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0 for BMC network

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml           |    3 =
+
 arch/arm/boot/dts/aspeed/Makefile                                  |    3 =
+
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts           |   12 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts           |   12 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts           |   12 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts             |   18 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts            |   72 =
+++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts            |   12 =
+
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts       | 1256 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts              | 1247 =
+--------------------------------------------------------------------------=
-------
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts   |  375 =
+++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts          |  366 =
+-----------------------
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts                |   24 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts            |    3 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts        |   54 =
+++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts                |    2 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts                 |    2 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts                 |    3 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts               |    2 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts                |    3 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts            |    2 =
+-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts                  |    2 =
+-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                            |    4 =
+-
 arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi       |   22 =
+-
 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi |   60 =
++++
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi                     |   12 =
+-
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi                     |   12 =
+-
 27 files changed, 1925 insertions(+), 1670 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data6=
4.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-d=
ata64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-=
data64.dtsi


