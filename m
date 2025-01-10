Return-Path: <linux-aspeed+bounces-386-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A033E7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 04:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTp4754N3z30Nl;
	Fri, 10 Jan 2025 15:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736481975;
	cv=none; b=QMIhtAuu2Mp9h+FzSkQ7JnwZoG+UyLiqDmvHcfQY2yvJOEGurUlefjnNBvkHMGfpl0Um7st7HubZ9rieFjONetptzsx0pIgkGtbJCMPjlo/hUrdn2qOAVol0yV0GO9vVICSy4aQ/e0FdfVcMOQ58uHJs7a2hhAfmR7qj+mMnKPllGDkd85UMD0RFe7SKfdQZpRYRuZjfKJGtMiAvN79zQ6GZe5cyYCAlLEQuntZ5GbkMn4lf2I/sGrTPQUOU9DA1L58JIBl6SNDdQ5EejfWRry8gRCrXLJl/l92a2VkU/7vyntvNKtKbNHSRbeZ4ercbCidbh9LE7YzlBC+GHQ0pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736481975; c=relaxed/relaxed;
	bh=e/24BpOBFggVP4Qf5Sk+TOwiRXODhNI6Ut5pVQz3vwE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BLY1I8xSa07ejqyYiMRFR15vaEJXArlbc8Qoi9fE19hgw5LgmJZ5yYcDppb2By/rOSqxiHY1ahUp0xhI4apGoQK3IkEc1sP5N+g07dSc5+9OEJFTZhi5v6WtCwCvrkQakfB2TIsYWYM2uUh4uchQUBczwuenlfzgJLO5G45FopxNg0HGZPZQbV73xaF1hif9ChApFl8kuSPAlW06UtsX5mEeA56ZcQTrbWb9A66kpdcblEPF6EtEMTEWSREQ8halrcUrQe7injim2hoyli65zNjHLRwaj+bBs1iRKkVJe2zZU7dClAbitUmPOhAlkdygMkiFUMw9SDSNUYCXaoS4Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au; dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=LVkMPA+u; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=LVkMPA+u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTp4471tHz3020
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 15:06:11 +1100 (AEDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so336225066b.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jan 2025 20:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1736481962; x=1737086762; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/24BpOBFggVP4Qf5Sk+TOwiRXODhNI6Ut5pVQz3vwE=;
        b=LVkMPA+u5iZE/2sqFYjUm3vHRFAQ24ZEobzBtAcaNdXv2w1pVUC8XDIdYzIltLJGAq
         +Gq1Nh5TegTS+QfN895f2/QJNoN+FMU54kbZ2Ku5/m0voTzkOKjNqZuZWzf77ASqZcot
         2XW+gm4A9PTPoaGBh99Au2NuhZ3UwOGqXgo/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736481962; x=1737086762;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/24BpOBFggVP4Qf5Sk+TOwiRXODhNI6Ut5pVQz3vwE=;
        b=LHwHwduXzhJV/uU/MvMdc7w82nxqgoimaee7r/jweearg4O5kf8mjc51Bewo9RFiDP
         +7C29+OaU1w6ZJcN6a+d36t/uFXxGuavbnhqFFm/VKhxDlghOraEEA8D46UEwwvx+DJp
         g3l8QtO7cDYw089TBYAVc/ua+Mqrok9w0HCIsnV164B09l3+HirIaqsrkjEeQ1KO222+
         rtLGUe0voaykBu/CYu6gPZ2GuoI6V/UzDT3oCRdrMTkvCXe+mOPUaZD4mixUfulA/exV
         CiKhjI9yBQaKNmoLJrP7zQ0jrRZStp+Gqoj5JmZwUa3v7BkOX2D84Opbc4X8p9bZi1rH
         BD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUOOcn/3mnUrfLaed/8jqT5ANAnW3yH7/lt/+0soUa7MYSgT/kzkD08t4Swvm6V3//Zz6DEUaTFhmhN5n4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw30Q4aBn0MVAEW7Ay1XnCAuc7ObEHZSJox/7Jm9I8bPjYPqlr4
	q9B2uPhs5twbZKtbbBHPOG74uO8Q12mQiEATkGp5Oc9tmmQvdQQA/8xd2w0GvKrSzJk54VWUqnh
	EohnvAFTxou/keXPkI2INXauEQWOfwIGz
X-Gm-Gg: ASbGnctYizLFn5inEBjacOMb8mLa15zv3Plk4gjI17jnVqpnazLGTAt5iVStd5B5uMV
	QufUjHSebCtxFI5/ycJHzdycyOAMSlENY/tDa5Ew=
X-Google-Smtp-Source: AGHT+IGqymY4AvkBSU1XQNYWlZtUCEzdAxywQjDfebNLm1G7SLuFYvEUjUET31E/9WQZk30AzUm2yPHyCp7zotDgCes=
X-Received: by 2002:a17:907:781:b0:aa6:995d:9ef1 with SMTP id
 a640c23a62f3a-ab2ab6a84d3mr845449566b.12.1736481962317; Thu, 09 Jan 2025
 20:06:02 -0800 (PST)
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
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 10 Jan 2025 14:35:50 +1030
X-Gm-Features: AbW1kvZ_i72IdjrqMlOp7-vfRZRdXCzz7gff0Z42evFFJX0klOqybwJks_f63EA
Message-ID: <CACPK8Xe8yZLXzEQPp=1D2f0TsKA7hBZG=pHHW6U51FMpp_BiRQ@mail.gmail.com>
Subject: [GIT PULL] ARM: aspeed: soc changes for 6.14
To: SoC Team <soc@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

Hello Arnd,

Here are the aspeed changes for v6.14. Andrew has done most (all) of
the work applying. We will get him set up to send the pull request in
the future so we can share the load, and so he's not blocked by me if
I'm not around to do it.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.14-devicetree

for you to fetch changes up to 3540adcccc7179d243216bf488532a62c37d9007:

  ARM: dts: aspeed: yosemite4: adjust secondary flash name (2025-01-08
10:57:53 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 6.14

- New machines

  * IBM SPB1 AST2600 BMC machine, a Sapphire Rapids x86 server
  * Ampre Mt Jefferson AST2600 BMC

 - Updates to mtmitchell, rainier, blueridge, everest, fuji, system1,
   harma, catalina and minerva

 - A big rework of yosemite4

----------------------------------------------------------------
Chanh Nguyen (4):
      ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers
      ARM: dts: aspeed: mtmitchell: Add gpio line names for io expanders
      dt-bindings: arm: aspeed: add Mt. Jefferson board
      ARM: dts: aspeed: Add device tree for Ampere's Mt. Jefferson BMC

Eddie James (4):
      ARM: dts: aspeed: Fix Rainier and Blueridge GPIO LED names
      arm: dts: aspeed: Everest and Fuji: Add VRM presence gpio expander
      ARM: dts: aspeed: Blueridge and Fuji: Fix LED node names
      arm: dts: aspeed: Blueridge and Rainer: Add VRM presence GPIOs

Manojkiran Eda (1):
      ARM: dts: aspeed: Enable PECI and LPC snoop for IBM System1

Naresh Solanki (1):
      dt-bindings: arm: aspeed: add IBM SBP1 board

Ninad Palsule (4):
      ARM: dts: aspeed: system1: Bump up i2c busses freq
      ARM: dts: aspeed: system1: Enable serial gpio0
      ARM: dts: aspeed: system1: Add GPIO line names
      ARM: dts: aspeed: system1: Use crps PSU driver

Patrick Rudolph (1):
      ARM: dts: aspeed: sbp1: IBM sbp1 BMC board

Patrick Williams (1):
      ARM: dts: aspeed: yosemite4: adjust secondary flash name

Peter Yin (2):
      ARM: dts: aspeed: Harma: add rtc device
      ARM: dts: aspeed: Harma: revise sgpio line name

Potin Lai (6):
      ARM: dts: aspeed: catalina: add i2c-mux-idle-disconnect to all mux
      ARM: dts: aspeed: catalina: move hdd board i2c mux bus to i2c5
      ARM: dts: aspeed: catalina: enable mac2
      ARM: dts: aspeed: catalina: update NIC1 fru address
      ARM: dts: aspeed: catalina: revise ltc4287 shunt-resistor value
      ARM: dts: aspeed: catalina: remove interrupt of GPIOB4 form all IOEXP

Ricky CX Wu (23):
      ARM: dts: aspeed: yosemite4: Remove temperature sensors on Medusa Board
      ARM: dts: aspeed: yosemite4: Change eeprom for Medusa Board
      ARM: dts: aspeed: yosemite4: Enable watchdog2
      ARM: dts: aspeed: yosemite4: Enable adc15
      ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
      ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
      ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
      ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Spider Board
      ARM: dts: aspeed: yosemite4: Enable spi-gpio setting for TPM
      ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
      ARM: dts: aspeed: yosemite4: revise flash layout to 128MB
      ARM: dts: aspeed: yosemite4: Add i2c-mux for Management Board
      ARM: dts: aspeed: yosemite4: correct the compatible string of adm1272
      ARM: dts: aspeed: yosemite4: Remove IO expanders on I2C bus 13
      ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
      ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
      ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
      ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan boards
      ARM: dts: aspeed: yosemite4: correct the compatible string for max31790
      ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan boards
      ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan boards
      ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
      ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board

Rob Herring (Arm) (1):
      ARM: dts: aspeed: Fix at24 EEPROM node names

Yang Chen (7):
      ARM: dts: aspeed: minerva: Revise the SGPIO line name
      ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
      ARM: dts: aspeed: minerva: add fru device for other blades
      ARM: dts: aspeed: minerva: add i/o expanders on bus 0
      ARM: dts: aspeed: minerva: add i/o expanders on each FCB
      ARM: dts: aspeed: minerva: add bmc ready led setting
      ARM: dts: aspeed: minerva: add second source RTC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    2 +
 arch/arm/boot/dts/aspeed/Makefile                  |    2 +
 .../dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts   |  622 ++
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |   18 +-
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    |  191 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |   45 +-
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |  998 +++-
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   | 1011 +++-
 .../boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts   |   46 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |   27 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   |  111 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |   17 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6086 ++++++++++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts |   31 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |    8 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts |    6 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi    |    2 +-
 17 files changed, 8802 insertions(+), 421 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts

