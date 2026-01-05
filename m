Return-Path: <linux-aspeed+bounces-3248-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACBC2A072
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Jan 2026 04:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dl1pG3Ql4z2xqG;
	Mon, 05 Jan 2026 15:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767588070;
	cv=none; b=LMlDJDArF629tG7R9ZsqP/bzT/+EDWuR52YrEu2lmHz6RtGDUno7RycyYEhYoHQ3o9yXk2E8RUdlB1mKpC0tKGgb3xHaLOuu0VymIZqhmNzx86hisoqript+/4L52DYFTLr2Z4JNpbbKkM+nddpPs0vPf60N+l6reE2z5cTqmmBL7zKOKrs11FGXMhM7CB+Ok9s6A9GdnQY944HXCKaiGHrCgmDxJ3XirG14X5qTnzQEu3pXLmbF+TrrOHT3H14CjulECUdivGMNH/F/QN7cIt0WVQue55x55J/69sfsqi9i2K/Moqq3bycYS67nViLMXIJnUFAJ7w2gZ+umdjN28A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767588070; c=relaxed/relaxed;
	bh=tSnwqQ4DEG5Xd/QNiEqxoVCY2/oYuSe+axqra58I6ko=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=KNZS+qiEeHuvmjhllX6GNApRBIzF5W2wVfOl0K+y0PZmq/xMXTVNliBL4vdXdDbeq15hCn9UtGKyXf1To2z188XAE5fLt3XHyll0aU/o6m4gakVCmC0h6YFL9/4u+kqZ9m7slhHshrXVYzCyXn13XSwmFbN0AI0jo45ppP7f/U/1UQNEvBcRqvCaqJfEsm02skWFYLBUKoB+cKWuEyn/y7cvxoQjurZ0p6iYj9eK7OhS2wl0X64GZtZBYQtZa6JWFhnLWGihnT4bmRipkpa2lQWRUnEK9hQM+5oCHOScEoONZIBiHJRHRlTThQeq0ZBEroLXH5kuBHrxaxeKVXSlCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m03LK9lh; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m03LK9lh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dl1pD3hcXz2xm5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Jan 2026 15:41:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767588067;
	bh=tSnwqQ4DEG5Xd/QNiEqxoVCY2/oYuSe+axqra58I6ko=;
	h=Subject:From:To:Cc:Date;
	b=m03LK9lhp4zWDB6gJBtFLHzjJ5LzZfmvgtajryyBo+CFzyqXiXNm0e1ajCeqjHO71
	 iwH7I5qkN0I2LgxDy7gu7rzhKb9AVCCTzj2ijJdmAjI/l6TdfyCT4mBIwIUgpUij1t
	 Iy/4yN1B3Q+AOL8awvYxQNWHo6653S9Q70rohj/obfHP6FoJVlucR2bv5bcU2V43wp
	 xCjhBnBzOMJyKNMgJ2A4C9BrFF9HbZ4ZDP0JyrGXEucAjJ6Yqv4nUzz1HYreZKpjhn
	 VqFpoeG+PSbfKcGxK09n4pwHQcepK3xnMPcuVzxGpa03exudol54CAv8WvVP1BnLKu
	 WnTmw6V0TacjQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B88B7C1B2;
	Mon,  5 Jan 2026 12:41:04 +0800 (AWST)
Message-ID: <4ab756729c4e26f7e544156c8613e839a9a9bebe.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: first batch of devicetree changes for 6.20
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 05 Jan 2026 15:11:03 +1030
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

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8=
:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.20-devicetree-0

for you to fetch changes up to 459a5aa171c0f13fcd78faa9594dc4aa5a95770b:

  ARM: dts: aspeed: bletchley: Fix ADC vref property names (2025-12-17 15:5=
3:31 +1030)

----------------------------------------------------------------
First batch of ASPEED Arm devicetree changes for 6.20

New platforms:

- NVIDIA MSX4 BMC

  The NVIDIA MSX4 HPM (host platform module) is a reference board for
  managing up to 8 PCIe connected NVIDIA GPUs via ConnectX-8 (CX8)
  SuperNICs. The BMC manages all GPUs and CX8s for both telemetry and
  firmware update via MCTP over USB. The host CPUs are dual socket Intel
  Granite Rapids processors.

  For more detail on this architecture:

  https://developer.nvidia.com/blog/nvidia-connectx-8-supernics-advance-ai-=
platform-architecture-with-pcie-gen6-connectivity/

Updated platforms:

- ast2600-evb (ASPEED): Various tidy-ups to address binding warnings
- bletchley (Meta): Watchdog fix, tidy-ups to address binding warnings
- clemente (Meta): HDD LED fix, GPIO line names, EEPROMs
- harma (Meta): fanboard presence GPIO
- santabarbara (Meta): IPMB, GPIO line names, additional IO expander

----------------------------------------------------------------
Alex Wang (1):
      ARM: dts: aspeed: clemente: move hdd_led to its own gpio-leds group

Andrew Jeffery (6):
      ARM: dts: aspeed: Remove sdhci-drive-type property from AST2600 EVB
      ARM: dts: aspeed: Use specified wp-inverted property for AST2600 EVB
      ARM: dts: aspeed: Drop syscon compatible from EDAC in g6 dtsi
      ARM: dts: aspeed: g6: Drop unspecified aspeed,ast2600-udma node
      ARM: dts: aspeed: ast2600-evb: Tidy up A0 work-around for UART5
      ARM: dts: aspeed: g6: Drop clocks property from arm,armv7-timer

Cosmo Chou (6):
      ARM: dts: aspeed: bletchley: remove WDTRST1 assertion from wdt1
      ARM: dts: aspeed: bletchley: Use generic node names
      ARM: dts: aspeed: bletchley: Fix SPI GPIO property names
      ARM: dts: aspeed: bletchley: Remove unused pca9539 properties
      ARM: dts: aspeed: bletchley: Remove unused i2c13 property
      ARM: dts: aspeed: bletchley: Fix ADC vref property names

Daniel Hsu (1):
      ARM: dts: aspeed: harma: add fanboard presence sgpio

Fred Chen (2):
      ARM: dts: aspeed: santabarbara: Add swb IO expander and gpio line nam=
es
      ARM: dts: aspeed: santabarbara: Enable ipmb device for OCP debug card

Kimi Chen (1):
      ARM: dts: aspeed: clemente: add gpio line name to io expander

Leo Wang (1):
      ARM: dts: aspeed: clemente: Add EEPROMs for boot and data drive FRUs

Marc Olberding (2):
      dt-bindings: arm: aspeed: Add NVIDIA MSX4 board
      ARM: dts: aspeed: Add NVIDIA MSX4 HPM

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml      |   1 +
 arch/arm/boot/dts/aspeed/Makefile                             |   1 +
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts               |   7 +++---=
-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts    | 106 ++++++=
++++++++++++++++++++++++++++++++++++++++++++++++---------------------------=
-------------------------
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts     |  43 ++++++=
+++++++++++++++++++++++++++++++------
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts        |   8 ++++++=
--
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts |  29 ++++++=
+++++++++++++++++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts       | 246 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                       |  12 +-----=
------
 9 files changed, 374 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts


