Return-Path: <linux-aspeed+bounces-2707-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327ACCF9E3
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 23:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cyKb82sThz303B;
	Fri, 31 Oct 2025 10:10:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761865828;
	cv=none; b=Vu7FwqUWWbAJapfZp7oq8uLSekHr5u1pl6Rwz3ABVjoN178SlnMIzD5AYsnFJFD5abtvQ0zpl9dAc2abmelRc9t+Ugo6CpBOgp2tP1OaPrCbk2Wyshos0meJvnRcUwubRHOC5p4olVQXXs7kMCjsZgRESzEwcimjQdwVqLEC0Lst1RHpJoKLLaLCNdrtcaYxeImEnqqbIfg4RFQKJqv2jXIYlFXvAOYrGktbZiLOnAp+Dq3iR99+kdjJpAcuWolhN9sWpJhe4mUMlwZcXwumoUcFeJajAjB1V8IsrLGU1mrnnzS47qlCS1o3s5srDNQZcwyq0SF+Cv552tOd22bMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761865828; c=relaxed/relaxed;
	bh=88KBlL4xUTV7siG+o+5Td6u+tNx+n4ecg/FuEBRQIzg=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=cTQb4y90w8AT8UE3MZxulLt4fzi6/L/+mYqhNTSETjFOCgSIaBfFCsjEFjRC6PhFXxe7M+gitpI5uasuWh+pW3vIpOKRHh4+nCyL7jS59Vb06R6gDO5KZYII/JHAULUVyfR9Q0nUGLAVDNk7Lr391czgnJbY7z1R/30d2GrgHP/oFYmNoUyeM0M7ZpjLPS5CQRetID0bpPw8CqZx0gWKLjTLPu4IB/9EXWW0hnZLJCWCw/dwG8sRcZrZme8Er92siksllliOpNENQhYYnuOXk26700Ovs5SdkTSusb6zCM7A2WoH0fU6IjhMTnxtYd7I3Eb2oXeKMVl3bb4fGQBITg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DyVQKM9A; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DyVQKM9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cyKb76FHvz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Oct 2025 10:10:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761865827;
	bh=88KBlL4xUTV7siG+o+5Td6u+tNx+n4ecg/FuEBRQIzg=;
	h=Subject:From:To:Cc:Date;
	b=DyVQKM9AN351thCoS8lCuUYSZbGE3zHkEb1My2e1PTyKyUc4BKNLPTaBen5Uj9+Zx
	 Tf61VjJJH8VUfWMAmIG+MzBqGRvacQmjxpE3QmZh/OV8GIvjLBnqrJiTaOTaEN9I0x
	 xnZEdWwRfuF4rHGF9wzEWsGXHdplY/6rh1B/5k+m7Zy6Uw1Rz6zwqFEUArJgWaBGkm
	 bjY0cjy1YqQcrtQ/C70eCsbvIy7Ddis84NYNxM9VzbWfn1/rsuKvZ+dA1kSiaSrF9O
	 +MyzJjRDTnDG8HSHgtBAWcK5qSZz02oVJTDU7i/Bu6vhMK3g/m3qjpft6yLlNHpRgS
	 yomLHRmC3I/gw==
Received: from [IPv6:2405:6e00:2421:7372:17cf:8b2f:ac7e:ac4d] (unknown [120.20.6.198])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9C2D278C99;
	Fri, 31 Oct 2025 07:10:26 +0800 (AWST)
Message-ID: <d2bd7e3e6045ac68875fd220e528c76f4fb2faac.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of devicetree changes for 6.19
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Oct 2025 09:40:25 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.19-devicetree-0

for you to fetch changes up to 6953afcd81a2cc73784e3dd23faa0a1aaf97441a:

  ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module (2=
025-10-17 16:44:13 +1030)

----------------------------------------------------------------
First batch of ASPEED Arm devicetree changes for 6.19

Significant changes:

- The IBM Power11 FSI DTSIs have been rearranged to accommodate new systems

New platforms:

- IBM Balcones

  The Balcones system is similar to Bonnell but with a POWER11 processor.
  Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
  tree is needed.

- Meta Yosemite5

  The Yosemite5 platform provides monitoring of voltages, power,
  temperatures, and other critical parameters across the motherboard,
  CXL board, E1.S expansion board, and NIC components.

Updated platforms:

- clemente (Meta): LEDs, shunt resistor configuration
- santabarbara (Meta): AMD APML, EEPROMs, LEDs, GPIO line names, MCTP for N=
ICs

There are a scattering of one-off changes and devicetree cleanups for other
platforms as well.

----------------------------------------------------------------
Daniel Hsu (1):
      ARM: dts: aspeed: harma: Add MCTP I2C controller node

Eddie James (4):
      dt-bindings: arm: aspeed: add IBM Balcones board
      dt-bindings: arm: aspeed: add IBM Bonnell board
      ARM: dts: aspeed: Add Balcones system
      ARM: dts: aspeed: Fix max31785 fan properties

Fred Chen (7):
      ARM: dts: aspeed: santabarbara: Add blank lines between nodes for rea=
dability
      ARM: dts: aspeed: santabarbara: Add sensor support for extension boar=
ds
      ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
      ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
      ARM: dts: aspeed: santabarbara: Add gpio line name
      ARM: dts: aspeed: santabarbara: Add AMD APML interface support
      ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT modul=
e

Kevin Tung (2):
      dt-bindings: arm: aspeed: add Meta Yosemite5 board
      ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

Leo Wang (2):
      ARM: dts: aspeed: clemente: add shunt-resistor-micro-ohms for LM5066i
      ARM: dts: aspeed: clemente: Add HDD LED GPIO

Zane Li (1):
      ARM: dts: aspeed: yosemite4: allocate ramoops for kernel panic

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml      |    3 +
 arch/arm/boot/dts/aspeed/Makefile                             |    2 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts     |    9 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts        |    8 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts |  919 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    |   14 ++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts    | 1067 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts          |  609 +++++=
+++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts           |    4 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts           |    8 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts           |   12 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts            |   36 ---
 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi                |  779 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi                |  769 +----=
----------------------------------------------------------
 14 files changed, 3405 insertions(+), 834 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.=
dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi


