Return-Path: <linux-aspeed+bounces-1220-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42CDC3ABC9
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 May 2025 02:12:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b11RK2s3sz2yMh;
	Mon, 19 May 2025 12:12:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747620749;
	cv=none; b=gnB0pMdWk1tgTUHs5EC8VRJWFDPa4uw9vXVnAyrS+WeIZTFRsuoaSTbxhhbqyX1cNlmwmDomkoFidzGyxFYTNJQgdWWkk7NuqDpaQcE1cnwrmLFoyOfBYMWTb4sXnPsmCLtBDhoInyDn3MzMeSh8ryV48UMTn14sn0zzESRZP2xx40zlRsHWRnaTbkT+wF97LkFrLJKyAknF57AoWwwxnZzXQgPDbZrN8Ep9CMNPP9v4ZgFeu6tXMbeqX0NnSp+BorYdL+napgqYVx/2+mDsY/nCFy3HOYk2dMJ3zZts3vz1yL87+Qzq1jrDQXKxbP1a7uaPoLZE/dlwf9PxyPltMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747620749; c=relaxed/relaxed;
	bh=8PiyfYLTOpYLPEaywpUplwwoVhHTcOz1zbW+p8rVbu4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HuiO4A7AEotHQVyDiq1KLYVQ5gG0RJW7OlqXOcHGSN/P+kju3jpXgK007H1c4U5ksGzwlIObQZ3CX2Oqn4HPTfEDQ3wgsPhDFuFF/+vU9zk2GucW/dJZ3kon7w4m4MC6gV8M9HPi4XIPDvXLozeHVyVCP/obQQUz0oRuU2DQ9e8n3zUCSqdV1QtOA35nn/yXfraZYdlqWOHuOUdaDRNmRBxpTIFhzUNlbDH9lBmpi4wSJuF/SkAmaUlctoUUZKeJtUcH3tWJa51PRTvz3Wj7FmyGUP9sGCWQz0J/bzLRBKjbWSrJETwQ4daMuvwiwlrLPHPMi/5HIXsJCDQr7h9nhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au; dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=C+m35Nra; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=C+m35Nra;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b11RH4QWSz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 May 2025 12:12:27 +1000 (AEST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso725615866b.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 May 2025 19:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1747620743; x=1748225543; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PiyfYLTOpYLPEaywpUplwwoVhHTcOz1zbW+p8rVbu4=;
        b=C+m35Nra6m3kgFLKmGMUTDUi/hSrTeuUQQplWG8ti9/qDjuQDni6q4QZq7blfIwPUk
         wLXgjACSv/j3w8a0dORYgzzitmoqcVyxuL1PYysGVXeRpyzSFldz5CX03IvOXBNi41gj
         ELiwAgFftohzq6+ZdfJMTvHLHOprx1SEgPPz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620743; x=1748225543;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PiyfYLTOpYLPEaywpUplwwoVhHTcOz1zbW+p8rVbu4=;
        b=ufhudvaJuENKd8WPz9N9HVnDBkQg3a/mu25jkAPpfKtvtaRLXgRCRoVXkA+mdbigvc
         hWU2RygvKk5CecT1goDpbRn43XGpz5snH630fMiWAhKpnXtLkcpWV1wJVID34mUxY6+F
         SbAcC6r4PvDEQbc1U0+hcevCLKfQQHH+FgYzlfzqbnr0ps7HtjkFTYl+2tJRx0Wx8HWv
         HIggJitx+irQ+aIFx2tuEcVzuxZYNMe08URI+EqB9VwXTTZwXtryicIGVkDI06Iqr818
         M0s4u9K/IQHw1FTYTbVjbcsYS/O5GYxzpwcMNw2PLVAesg08qP8cWc3zFqoFAQpRCvGw
         9Qhg==
X-Forwarded-Encrypted: i=1; AJvYcCUXONQlbI25Fve6kOTlKRdHcUce8ZRUTcAGjDuV538gR8IiRmE9V4lDekACkrv/Qn4zfqFKWHatCcB0DSU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqsSxDEb/fd0yTzldWLjPyBvx42mi5N5B2LTLQtviRUSr98FaG
	s7qruBa5y7oaX/zQPU01wkERqXOcJQ6WBloYHps67fKGoSiiRF4Nvu5SioqsCdTkgOlBTws+W1X
	4gwaV1jtRNVCptNPqiAR5VpbVPeasTdo=
X-Gm-Gg: ASbGncs1WXNz2R7P9IyjMHwaOH8ifeMhtUFGWkMSv/oBSSjrYBCrHs7SiNiSKRmG2lj
	PNTOYQdm6XfW3fuDBy3XoWfbt8PdaWvOLsTRL/q2PS/UrOgNZzHq6RYIVTB6YjgEP7+FQHWLnH0
	vcZr4Uz1VfsGpXspb52XMKqmqiBkgp+wZ6SDJwNCTYDRU=
X-Google-Smtp-Source: AGHT+IGNShkus28bhfx7W2x1K+4ajDa/8mB60w6pvvUIwPVMUfU1MM2zJ00ko3u+od4Dr2jP2v5Xp0zGToAGigcNZlA=
X-Received: by 2002:a17:907:9728:b0:ad5:5302:4023 with SMTP id
 a640c23a62f3a-ad55302638cmr525379466b.44.1747620742721; Sun, 18 May 2025
 19:12:22 -0700 (PDT)
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
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 May 2025 11:42:11 +0930
X-Gm-Features: AX0GCFvrkD8u8H305xamS26PUCKs_SenW2FoEiTxH9Jfwr-FWKT13dQX4G_y6MY
Message-ID: <CACPK8XdYLf6s=GtB5bsEw4zj0JjUBob-6GhdJzivX51y+E=KEA@mail.gmail.com>
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.16
To: arm <arm@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

Here's the Aspeed pull request for 6.16. Andrew has prepared the
patches and created the tag, so all credit goes to him.

There's a change that Andrew calls out in the tag I didn't really
like: it breaks old userspace by moving things around. The argument is
that userspace was "wrong" to be using the paths under /sys. I think
the cart is leading the horse if we let the yaml checking take a
higher priority than breaking userspace. But I haven't the time to
fight that battle, so here we are.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc
tags/aspeed-6.16-devicetree

for you to fetch changes up to 13c9c6eabf033ed4f369ad4d29bdc58ed4a411e3:

  ARM: dts: aspeed: Rework APB nodes (2025-04-08 10:58:33 +0930)

----------------------------------------------------------------
ASPEED devicetree updates for v6.16

Significant changes:

- The APB nodes in the ASPEED SoC DTSIs were reworked to eliminate a large
  volume of warnings from `make dtbs_check`. The changes to the node names are
  naturally reflected in sysfs, which may impact some userspace applications.
  The impacts are called out in the commit message, along with arguments for
  the change.

Removed platforms:

- IBM's Swift BMC

New platforms:

- NVIDIA's GB200NVL BMC

  NVIDIA GB200 NVL72 connects 36 Grace CPUs and 72 Blackwell GPUs in an NVIDIA
  NVLink-connected, liquid-cooled, rack-scale design.

Updated BMC platforms:

- Bletchley (Meta): Fixes for GPIO hog name, remove ethernet-phy node
- Catalina (Meta): Various sensors added, MCTP support for NIC management
- System1 (IBM): IPMB and various GPIO-related updates

The System1 series includes a devicetree binding patch for IPMI IPMB devices.

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: aspeed: Rework APB nodes

Joel Stanley (1):
      ARM: dts: aspeed: Remove swift machine

Krzysztof Kozlowski (1):
      ARM: dts: aspeed: Align GPIO hog name with bindings

Ninad Palsule (8):
      dt-bindings: ipmi: Add binding for IPMB device
      ARM: dts: aspeed: system1: Add IPMB device
      ARM: dts: aspeed: system1: Add GPIO line name
      ARM: dts: aspeed: system1: Reduce sgpio speed
      ARM: dts: aspeed: system1: Update LED gpio name
      ARM: dts: aspeed: system1: Remove VRs max8952
      ARM: dts: aspeed: system1: Mark GPIO line high/low
      ARM: dts: aspeed: system1: Disable gpio pull down

Potin Lai (11):
      ARM: dts: aspeed: bletchley: remove unused ethernet-phy node
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management

Willie Thai (2):
      dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
      ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 .../devicetree/bindings/ipmi/ipmb-dev.yaml         |   56 +
 arch/arm/boot/dts/aspeed/Makefile                  |    2 +-
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |    2 +-
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |    4 +-
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |    2 +-
 .../boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts |    4 +-
 .../boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |    2 +-
 .../dts/aspeed/aspeed-bmc-facebook-bletchley.dts   |    5 -
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    |  197 +++-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |    4 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts |  139 ++-
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts    |   46 +-
 .../boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |   68 +-
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 1128 ++++++++++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |   14 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |   10 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    |   40 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |    6 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  974 -----------------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |    8 +-
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |   93 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            |  109 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  249 +++--
 26 files changed, 1773 insertions(+), 1394 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts

