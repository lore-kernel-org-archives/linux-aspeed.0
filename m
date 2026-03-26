Return-Path: <linux-aspeed+bounces-3773-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11933109E542
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 03:09:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fh8031r1Nz2xlM;
	Thu, 26 Mar 2026 14:09:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774494595;
	cv=none; b=LHFMG51fB5WpFyjW4dl4LpW9JxmUWt9GG2VxAquhkSb0fuB74pr8kWoD9asB5waM27VrIEwzW3Mc7epX20fzqxRgDESqbmoQHWsx3Y7dzl5cAvuOdMc1+tp/miRUfWzyGlVc+WrRykObj3XZFtSSpSbkGJwRuGYVnncEXCoHnCdbejHHh5lniH3XNmzWiBXiIi8MjHLHOWfofI9qeDBMZBLFFkv0wE2dptew1VQuFxy5I8lIwMTdRTuNoZ95dWVqKyXyr5lWuIr58Qfg1HBBorsC4Z8n4F+tOB3JjI1NTGu9QbhmBz0ZbXFNSgl+dYJJxGW5WpN4M2cEMDVqflYiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774494595; c=relaxed/relaxed;
	bh=zeUGGTYgyK94YprNuLur3t1PD0YGNWfrDQg8S912Lhw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MZT3lROVWiFPVVybrqG+syHks4hXjOqSTPQQGMxUjsd2c0BHeIGLXprq3DQmQenSMLhaN43T3BHoW9+FOG37JYjxx8FGvyJ31CgYK0YOr3GDx7Sf+4k0w7s9pEF0l/M9dzGGr5WWOrgwaefEE7Bm1G1VxxO4iCRxa9oqjt1/bKtiokBSDrWqfUKUNRp0n8GK1VG2nsOPR+SODtVmrnpwfJarcHwADCsGImzk/YucJQlK5E97bgwOE92G/KgWOB0Lgt3/GUcZ6vx76rbDKifO0zLbjoqRncM9O0Ko/7g4hBXUEfFjcpy1A/G2U994b2QJmbjBH4jms8r5DNf6EYkOlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h9tzlO7H; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h9tzlO7H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fh8020z8pz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 14:09:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774494593;
	bh=zeUGGTYgyK94YprNuLur3t1PD0YGNWfrDQg8S912Lhw=;
	h=Subject:From:To:Cc:Date;
	b=h9tzlO7HVgpr7TKHSJj2CHl/BXQSp9jqI2Idzj2KXDfaP9GRr3XW/JDYKM0u5cwD/
	 rAA0ZCHXMqJykP5jihSrlPCB+p2DRCPC2is/7Nt3BEEEiG8iaNUhw0VzzhQUb+ybuL
	 YgrBjRkV3afc/awiiW+4sMx4JNX+oy44V0aHCI6f0cjMDjzbge+L+hymQFLVRASKX1
	 tjbspCnVMe5sjoc4ax7V7pDunlpEiV1mJ1uDDs8n5xIfThKsMYqfpJrU3JJVQ2i/Uf
	 l+D3SScdqg9BWOnhEfN5usNLs3nxOjJNn3OVJOdUYt2p/iKeWTWc8Hbs4hvgCcTZX0
	 TXl6HbAEMfkZA==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5929E645CA;
	Thu, 26 Mar 2026 11:09:53 +0800 (AWST)
Message-ID: <df8ef5ea7b9e254658934c18de20fd9805a82d74.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: first batch of devicetree changes for v7.1
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Mar 2026 13:39:52 +1030
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

Hello SoC maintainers,

Here's the first batch of ASPEED devicetree changes for v7.1.

Please pull.

Cheers,

Andrew

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f=
:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-7.1-devicetree-0

for you to fetch changes up to 76b4ec8efdc3887cdbf730da2e55881fc1a18770:

  ARM: dts: aspeed: anacapa: Add retimer EEPROMs (2026-02-23 12:02:22 +1030=
)

----------------------------------------------------------------
aspeed: first batch of devicetree changes for v7.1

New platforms:

- Asus Kommando IPMI card
- Asrock Paul IPMI card

Updated platforms:

- Anacapa (Meta): NFC and EEPROMs
- MSX4 (Nvidia): 128M layout for the alternate boot flash

----------------------------------------------------------------
Anirudh Srinivasan (4):
      dt-bindings: arm: aspeed: Add Asus Kommando IPMI card
      ARM: dts: aspeed: Add Asus Kommando IPMI card
      dt-bindings: arm: aspeed: Add Asrock Paul IPMI card
      ARM: dts: aspeed: Add Asrock Paul IPMI card

Carl Lee (1):
      ARM: dts: aspeed: anacapa: add NFC device

Dirk Chen (1):
      ARM: dts: aspeed: anacapa: Add retimer EEPROMs

Marc Olberding (1):
      ARM: dts: aspeed: Add 128M alt flash layout to NVIDIA MSX4

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        |   2 ++
 arch/arm/boot/dts/aspeed/Makefile                               |   2 ++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts   | 131 ++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts | 117 ++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts        |  22 ++++=
+++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts         |   1 +
 arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi      |  32 ++++=
++++++++++++++++++
 7 files changed, 307 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-paul-ipmi-ca=
rd.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-=
card.dts
 create mode 100644 arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.d=
tsi


