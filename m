Return-Path: <linux-aspeed+bounces-4173-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B6FCD6E5D
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 02:34:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVWx03tBlz2yRF;
	Wed, 03 Jun 2026 12:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780454052;
	cv=none; b=UKrPZVjriCDrkPKfZpXvIjYAcCSKg3NXKJm13tNNSq7YFqtihZqmMDmMPcKfT7WPRjjBYrZEb3ou21rtKG8jxVzHWyTq5rO5Dq7xIQDP048z1eDVW5addRahibh8CITn5nK6ZVw1Nfixgzw6btU3Yn14V73MiEynwbO2ZJDrU6MRRHpQuqUsASUWZJIyFOj+3iXmXsPUo3zLHQ02rgPN9IPfcntI2PZqhe5XsxjnKVquYBIUPQWdtTiHd9RtfQ0kXDC+myxaKgpwzFMmakhd84sG0ZHgEsLhJ8yDp9rQB76fuDlZZUpugOX6s6eNCfOsE/pSSzSCpY4mhUPxKIMICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780454052; c=relaxed/relaxed;
	bh=0P5xTtK6qJk11drFxut88gGWQ14R3F9398eX/Saen6s=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=PUaFZlAltRawW0t+yv0+08BMEmosb6q9XTpfs7Jly7mf2hvh+LK99My7LWEVf34b7mcVOQ5a0Csq+uQ8yyZtRzAwUWiZ1//v10LNIi38KKlnAHnwGvILoeD6OvA952P51A8f7zbBsbFGZTIJ1NEZ9PZXiyt+Y5hF/FErLBezo1ZHGjHFwBjYlIz9WS/XGLKEJ7FEERzxTPLnf3rhRyiS2cm6Kt1q0fEyWilLRmHnkt7zMPUJWeuQPSvYpcWHBaWOu7XdYToBxyeVd+Mrer6ydAZzh1GHqEXn1UiBlA0bj1/2Tc1Vm1ewj6DZJJPPiW7SDEP2me45vntShStpbxK+Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LY5gsaZE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LY5gsaZE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVWwz0WHXz2xg3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 12:34:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780454050;
	bh=0P5xTtK6qJk11drFxut88gGWQ14R3F9398eX/Saen6s=;
	h=Subject:From:To:Cc:Date;
	b=LY5gsaZEH8JGU8zm2qE+glifMq+UTc38flMyOSQoQ6WcAyQUQSpa4NdyJnnAk16zV
	 OaloRtqWrAABbM6nKhJ2NqxjBV/eMzuw9kFzyHnklntr58HYkBpeb6M33FBfBIeVxN
	 IMAbL3qUOjTHOpmsPdB21cxUYB9kuhaC5/VEDsGu5+GxSr9EfAJ2eZHcFaalS6qW8K
	 E/VZUKf/kTpYVvQ6wO7QjFrCG824k8kbaUpEpJ1mNMseE+syVhLK+dK6/2z99TSNHk
	 93NZY/ZgvTam5ER0zT5A2k4K3Aqn8U/zQ5kYv3J3csekPY+O+Ucwe0ndsh1mxRzW8Q
	 MUeDo3GpFnvCw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 44A5960087;
	Wed,  3 Jun 2026 10:34:09 +0800 (AWST)
Message-ID: <55ab27bc5e09252b1dbfdf1505693eb193b8e846.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of ARM devicetree changes for v7.2
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 03 Jun 2026 12:04:08 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

aspeed: First batch of ARM devicetree changes for v7.2

New platforms:

- Rainiera6 (Meta)
- SanMiguel (Meta)

Updated platforms:

- Anacapa: SGPIO line names and interrupt configuration
- Clemente: Remove TMP421 nodes
- Kommando: Enable networking via MAC2/MDIO2
- SanMiguel: Line names and interrupt configuration

AST2600 SoC updates:

- Describe PWM/Tach
- Describe I3C controllers
- Reorganise I2C nodes

Other notes:

91b9aed7381c ("ARM: dts: aspeed-g6: Add nodes for i3c controllers") current=
ly
causes a new warning:

  ... /ahb/apb/bus@1e7a0000/syscon@0: failed to match any schema with compa=
tible: ['aspeed,ast2600-i3c-global', 'syscon']

The patch necessary to address it has an R-b tag from Kryzsztof[2] but as b=
est
I can tell is yet to be applied to the MFD tree. I've left the change in fo=
r now
as the warning will resolve once the binding patch is applied.

Lastly, as part of improving support for the Kommando card Anirudh has also
addressed[1] the persistent pain we've had with the phy-mode property for t=
he
AST2600 MACs. Thanks to Andrew Lunn for being on the case for a while now, =
and
for those who tested Anirudh's patch.

[1]: https://lore.kernel.org/all/20260525-asus-kommando-v3-0-e6a0ca1b4a3e@g=
mail.com/
[2]: https://lore.kernel.org/all/20260425-poised-accomplished-hyena-d2c1a0@=
quoll/

----------------------------------------------------------------
Anirudh Srinivasan (1):
      ARM: dts: aspeed: Enable networking for Asus Kommando IPMI Card

Billy Tsai (1):
      ARM: dts: aspeed: g6: Add PWM/Tach controller node

Colin Huang (1):
      ARM: dts: aspeed: anacapa: Add JTAG CPLD TRST pin to SGPIO map

Daniel Hsu (1):
      ARM: dts: aspeed: yosemite5: Add MP5998 power monitor

Dawid Glazik (2):
      ARM: dts: aspeed-g6: move i2c controllers directly into apb node
      ARM: dts: aspeed-g6: Add nodes for i3c controllers

Ender Hsieh (1):
      ARM: dts: aspeed: msx4: enable BMC networking via MAC0

Mike Hsieh (1):
      ARM: dts: aspeed: clemente: Remove IOB NIC TMP421 nodes

Neil Cheng (2):
      dt-bindings: arm: aspeed: Add Meta Rainiera6 board
      ARM: dts: aspeed: rainiera6: Add Meta Rainiera6 BMC

Potin Lai (4):
      dt-bindings: arm: aspeed: add Meta SanMiguel BMC
      ARM: dts: aspeed: Add Meta SanMiguel BMC
      ARM: dts: aspeed: sanmiguel: Add IOEXP interrupt pin settings
      ARM: dts: aspeed: sanmiguel: Fix the CPU_CHIPTHROT linename

Rex Fu (2):
      ARM: dts: aspeed: anacapa: Add interrupt properties for PDB PCA9555
      ARM: dts: aspeed: anacapa: Correct SGPIO names for monitoring

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        |    2 +
 arch/arm/boot/dts/aspeed/Makefile                               |    2 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts |   18 ++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts        |   34 ++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts       |   20 --
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts      | 1012 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts      |  672 +++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts      |    5 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts         |   15 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                         |  552 +++=
++++++++++++++++++++++++--------------------
 10 files changed, 2074 insertions(+), 258 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.=
dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.=
dts


