Return-Path: <linux-aspeed+bounces-1674-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6AC83F0F
	for <linux-aspeed@archiver.kernel.org>; Thu, 10 Jul 2025 02:39:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bczZ270Vmz30MY;
	Thu, 10 Jul 2025 12:39:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752115146;
	cv=none; b=fcAmH3Up+Q7a/9nZzpJoEoZqGdZCaW9Xx+xSogbLCSb5pgz3s679pm8ikj/la7wX7btYEnJ8Blvkicn/og+MMJH1MLtBNvnM+7/xAWCh+NgOzcoe1uipPVfosUnuwLlG1aFO+X0Xr3ecgHmcnMSyHmm2EoU0Q/EvzyGeLQY7+NAeg6kdmmxriVCNCY8zKbrFk/p5MnGVGC1XJG5cYAy4ydWFDEEOLoXJ9CATiA5QliAwIIKCu+lY3JjNjLXk6YmYRaNlmKSoN3gmcFqbwwKxWM4D35rokbiySbTNn1mI/De+EwcRBO26kXsZ9n/mrYK7tMnb8MwnQP3oR53XjC9mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752115146; c=relaxed/relaxed;
	bh=kzQmumURQa/WWjdaeL/eWLu8XO9uaBPc5m+hWTIurSU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fR4TXH9G4nz4WzZQOIB333j8DoXrTVE6P48MLz2vkoIQFz5W6nkNz2k5E+FUCxuyK1BzPgOY1D59/JVNkBbLxr6QnWA5MSxiTRkMzaW9zDUaHhKqui1iGEktYVg8phZln8UEsAKd/LLd18J9wRJNWv7DwhyaYNA3o3LDv3252VtZ2p3RJT69aVgfUdIpU3+ew7+Ok4mjGwd4Izj/+/4/dgTZ4hw2DZRxNVom6vnwolbf3+djEqR075/z8njUxB+mQCuX+DmZzxVGr89bB+m+8n2Hgrfoc7ylIH2DTIWPWeIWqaPLbkvApGHTUHKANua+0vhiagiB/TqLYUJsQ6+CwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Qz9PHANp; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Qz9PHANp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bczZ22DyWz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 10 Jul 2025 12:39:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752115145;
	bh=kzQmumURQa/WWjdaeL/eWLu8XO9uaBPc5m+hWTIurSU=;
	h=Subject:From:To:Cc:Date;
	b=Qz9PHANpkZmXhsQ1QpywiV3j6KHolnaUt+F88h8Uj72O0vrTQk27j0DMzsqBBHR8k
	 wrGPG+vDdxZyORnbwih1LVnTSxvztUt3omWFS1MpKZZi33fL8ulhSAl6P5hHjrOpY2
	 7dFiuliA3LUccGPHZ09dJSgef69Q56DiEOKS+XjA41+Ad27QBbvEi6hkt/NkvYu6LI
	 bWlz7agQVAfaoHFzVLFdumhta1EM4wy0bEKOHZ8rDyT4qWucB0foTh2HYd4QbiL/VA
	 LXnONg7yqdXDCYb6R/JIf/XLkXyrwdxZ9iD6gxjhgukqVgWZrgxcVRcogIbs/YFzRH
	 sT1HrpifSgZqw==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 632596508A;
	Thu, 10 Jul 2025 10:39:05 +0800 (AWST)
Message-ID: <36d50489cac1fbae01ec699b742f6c6c459a01cb.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: devicetree changes for 6.17
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 12:09:04 +0930
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

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.17-devicetree-1

for you to fetch changes up to 1c15e359ba53b297ba5fd72bbf626ede72c3de3e:

  ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel (2025-07-04 1=
3:28:25 +0930)

----------------------------------------------------------------
ASPEED devicetree updates for 6.17

Removed platforms:

- IBM's Swift BMC

New platforms:

- Meta's Santabarbara

  Santabarbara is a compute node with an accelerator module

- NVIDIA's GB200NVL BMC

  NVIDIA GB200 NVL72 connects 36 Grace CPUs and 72 Blackwell GPUs in an NVI=
DIA
  NVLink-connected, liquid-cooled, rack-scale design.

Updated BMC platforms:

- Bletchley (Meta): GPIO hog names, remove ethernet-phy node, USB PD negoti=
ation
- Catalina (Meta): Various sensors added, MCTP support for NIC management
- Harma (Meta): Various sensors added
- System1 (IBM): IPMB and various GPIO-related updates
- Yosemite4 (Meta): GPIO names for UART mux select lines

The System1 series includes a devicetree binding patch for IPMI IPMB device=
s.

----------------------------------------------------------------
Ankit Chauhan (1):
      ARM: dts: aspeed: lanyang: Fix 'lable' typo in LED nodes

Cosmo Chou (1):
      ARM: dts: aspeed: bletchley: enable USB PD negotiation

Fred Chen (2):
      dt-bindings: arm: aspeed: add Meta Santabarbara board
      ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC

Joel Stanley (1):
      ARM: dts: aspeed: Remove swift machine

Krzysztof Kozlowski (1):
      ARM: dts: aspeed: Align GPIO hog name with bindings

Marshall Zhan (1):
      ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel

Ninad Palsule (8):
      dt-bindings: ipmi: Add binding for IPMB device
      ARM: dts: aspeed: system1: Add IPMB device
      ARM: dts: aspeed: system1: Add GPIO line name
      ARM: dts: aspeed: system1: Reduce sgpio speed
      ARM: dts: aspeed: system1: Update LED gpio name
      ARM: dts: aspeed: system1: Remove VRs max8952
      ARM: dts: aspeed: system1: Mark GPIO line high/low
      ARM: dts: aspeed: system1: Disable gpio pull down

Peter Yin (5):
      ARM: dts: aspeed: harma: add E1.S power monitor
      ARM: dts: aspeed: harma: add fan board I/O expander
      ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
      ARM: dts: aspeed: Harma: revise gpio bride pin for battery
      ARM: dts: aspeed: harma: add mmc health

Potin Lai (12):
      ARM: dts: aspeed: bletchley: remove unused ethernet-phy node
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C bus=
es
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management
      ARM: dts: aspeed: catalina: Enable MCTP for frontend NIC management

Willie Thai (2):
      dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
      ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        |    2 +
 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml            |   56 +++=
++
 arch/arm/boot/dts/aspeed/Makefile                               |    3 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts           |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts        |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts         |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts           |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts      |   71 +++=
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts       |  209 +++=
+++++++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts          |   85 +++=
+++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   |  982 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts      |   40 +++=
+
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts             |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts             |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts             |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts             |  139 +++=
+++-----
 arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts            |   46 ++-=
-
 arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts         |   68 +++=
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts     | 1128 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts             |   18 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts              |   10 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts            |   40 ++-=
-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts             |    6 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts               |  974 ---=
-----------------------------------------------------------------------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts               |    8 +-
 26 files changed, 2685 insertions(+), 1222 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarba=
ra.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc=
.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts



