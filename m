Return-Path: <linux-aspeed+bounces-312-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1A2E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:29:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhhv4mSXz305c;
	Wed, 25 Dec 2024 04:29:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061375;
	cv=none; b=Jp+oG9jmKdBDYmn0Ae7SCb1qbyDdtVfrHUzaQWwoeQLbXTayqBjTM6G8Mt3ukC79kJzDnQDGmatIOmlWuE/z7J989xjTfG+J7qNj0h2zbd+hfbRGgAtuNdfdXPw1Km8J0wC7ybRJDUzIpUy8xsgLYVLW0+z7RM4I17Bh6DGZNmXJDKSIc9J0p0Ee4gs5lwru1wMU96TDQPAI1XzTyfsis3L4RMHWSFn9amDcwBLm+8JMDgtnIE1LSIADwHHGuTtWcYXOzpWCr7tgYD4hHcRgk0v8UxmCCsycIF1bH3rKxKBSpVZgb82AkcKgss42C8qZ18MMYtYHlNHzY1cdSmkwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061375; c=relaxed/relaxed;
	bh=r/Gn3c6Z2+oOxsTlq15aX44iSBF2ngtpY5A8qzg8rVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgaNo8tabMVrz+2UMBUJNxh1SKGKPSmY6RtOmhyhJxrOsLnTVDcj4J6cG7+136JWRIE03AB9gU8h7OiN36GujX3/zTR/Xw2LOYyUEUc4MO0XKnYfpBBdSA8IjjSb0I0IcIXv3SJVR1eIhLtE4q9AeGHovS2F4/tsLGxNxbrRnJ69jHUpvohWlxkRm3G7dqp8TyqysfJf97xSn5OOSFU8jFmvFeaQ26GStAMBNXPOC21bXNnGCUQpnN2iGPBKUor4te8hIF6XTd0e35qf9uscGIobbM7BDwkYwHD2CarpvVnaYZ8ARb71HubkydI0UMORm1Xdcac2b2P4p/CdgQ+m4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ji12gTav; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ji12gTav;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhhs6q5Yz305P;
	Wed, 25 Dec 2024 04:29:33 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 001ECC0840;
	Tue, 24 Dec 2024 17:06:38 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7712C40004;
	Tue, 24 Dec 2024 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735059983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/Gn3c6Z2+oOxsTlq15aX44iSBF2ngtpY5A8qzg8rVM=;
	b=ji12gTaveVn1lCP9UvPR+lkewDUv8CjCn0LOn5zGo0v79llUFWB6v2y+102nr1zl6n9jBC
	0clzBYCG3ZysNzwaHVFSlmYUHUiVmLTmNEocUe48zTa0Vz5JtEW8Pf44pvyi7zbtozvv2r
	LzXmlzO4kxANnZVsIvaWHRuRro9pdTSe3WVI7xKA/gaJHGhedzr0uVbu+2qROKMI4a7sNz
	ADkmUKNe+kuhpOajUlCu0MaTzP+u+fssGUgj80ySYyhqmKQYNQnF0BYJiEkzRX8EaQS0AP
	vW8Yiwy5rO5E+wjkrkXA3jg7McS1I4rk4AsLkRIAv6CgT6vbd7JEjJeycg4/Wg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/27] spi-nand/spi-mem DTR support
Date: Tue, 24 Dec 2024 18:05:45 +0100
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnpamcC/yXNyw6DIBCF4VcxrDuGmYAxXfU9GheotE6ioOClx
 vjupXb5ncV/DhFtYBvFPTtEsCtH9i6BbploOuPeFrhNFiRJIaGEjV3tXQsFIEJoEKbFtBCXcfR
 hBomqJKkNoSGRGmOwL/5c/WeV3HGcfdivuxV/678sSWOBWmKuSl2UChAGnhbb58HszvSP2vu5Z
 5c3fhDVeZ5f4IGW6LkAAAA=
X-Change-ID: 20241210-winbond-6-11-rc1-quad-support-0148205a21a2
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable+noautosel@kernel.org
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mark, hello MTD folks,

Here is a (big) series supposed to bring DTR support in SPI-NAND.

I could have split this into two but I eventually preferred showing the
big picture. Once v1 will be over, I can make it two. However when we'll
discuss merging, we'll have to share an immutable tag among the two
subsystems.

Here is the logic:
* patches 1 & 2 add support for spi-mem operations with a specific
  frequency limitation. This is not only related to DTR support, because
  as you can see I could use this to support basic features in the
  Winbond driver.
* patches 3-17 are going through all the easy controller drivers, where
  effectively supporting these per-operation limitation was easy to
  do. In practice, I believe all controllers can, but software is
  sometimes the limiting factor. All controllers without spi-mem support
  will gracefully handle the request (provided that they already care
  about the maximum speed of course), and all the updated controllers in
  this series will also handle the situation correctly. For the others,
  it's an opt-in parameter, so they will simply refuse the operation
  during the checks_op/supports_op() phase.
* patches 18-20 add DTR support in spi-mem.
* patches 21-24 add DTR support in SPI-NAND.
* patches 25-27 add DTR support to Winbon chips.

---
Changes in v2:
- Fixed breakage reported by Mark.
- Created an "adjust_op_freq" helper in the core and used it from
  spi_mem_exec_op(). This way it is called only once. The main parameter
  must still be casted otherwise we would need to do the call outside of
  spi_mem_exec_op() which would imply about 40 different changes in the
  core and drivers and also the assurance that we would get it wrong
  again later.
- Reworked the logic for picking the best variant to include all
  subtleties due to maximum/supported frequencies. The choice takes
  slightly longer now but should return the truly fastest variant for
  each case.
- Removed unique parenthesis in some kdoc comment.
- Fixed the inconsistency when handling the maximum per operation
  frequencies between spi-mem and non spi-mem controllers.
- Fixed many typos.
- Added a core check to validate the per op frequency against the minimum
  supported frequencies by controller drivers.
- Removed a useless check from the amd driver and turned a function
  void. Also used the controller parameters in this driver rather than
  the top-level definitions.
- Clarified some of the commit logs.
- Collected tags.
- Prevented a patch from being picked-up automatically by the stable
  team.
- Reordered some terms in macros in the spi-mem core.
- Rebased on top of v6.13-rc1.
- Link to v1: https://lore.kernel.org/r/20241025161501.485684-1-miquel.raynal@bootlin.com

---
Miquel Raynal (27):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
      spi: spi-mem: Add a new controller capability
      spi: amd: Support per spi-mem operation frequency switches
      spi: amd: Drop redundant check
      spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
      spi: cadence-qspi: Support per spi-mem operation frequency switches
      spi: dw: Support per spi-mem operation frequency switches
      spi: fsl-qspi: Support per spi-mem operation frequency switches
      spi: microchip-core-qspi: Support per spi-mem operation frequency switches
      spi: mt65xx: Support per spi-mem operation frequency switches
      spi: mxic: Support per spi-mem operation frequency switches
      spi: nxp-fspi: Support per spi-mem operation frequency switches
      spi: rockchip-sfc: Support per spi-mem operation frequency switches
      spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
      spi: spi-ti-qspi: Support per spi-mem operation frequency switches
      spi: zynq-qspi: Support per spi-mem operation frequency switches
      spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
      spi: spi-mem: Reorder spi-mem macro assignments
      spi: spi-mem: Create macros for DTR operation
      spi: spi-mem: Estimate the time taken by operations
      mtd: spinand: Create distinct fast and slow read from cache variants
      mtd: spinand: Add an optional frequency to read from cache macros
      mtd: spinand: Enhance the logic when picking a variant
      mtd: spinand: Add support for read DTR operations
      mtd: spinand: winbond: Update the *JW chip definitions
      mtd: spinand: winbond: Add comment about naming
      mtd: spinand: winbond: Add support for DTR operations

 drivers/mtd/nand/spi/alliancememory.c |  4 +--
 drivers/mtd/nand/spi/ato.c            |  4 +--
 drivers/mtd/nand/spi/core.c           | 15 ++++++--
 drivers/mtd/nand/spi/esmt.c           |  4 +--
 drivers/mtd/nand/spi/foresee.c        |  4 +--
 drivers/mtd/nand/spi/gigadevice.c     | 16 ++++-----
 drivers/mtd/nand/spi/macronix.c       |  4 +--
 drivers/mtd/nand/spi/micron.c         |  8 ++---
 drivers/mtd/nand/spi/paragon.c        |  4 +--
 drivers/mtd/nand/spi/toshiba.c        |  4 +--
 drivers/mtd/nand/spi/winbond.c        | 27 ++++++++++++---
 drivers/mtd/nand/spi/xtx.c            |  4 +--
 drivers/spi/spi-amd.c                 | 21 ++++++------
 drivers/spi/spi-amlogic-spifc-a1.c    |  7 +++-
 drivers/spi/spi-cadence-quadspi.c     |  3 +-
 drivers/spi/spi-dw-core.c             | 10 ++++--
 drivers/spi/spi-fsl-qspi.c            | 12 +++++--
 drivers/spi/spi-mem.c                 | 64 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-microchip-core-qspi.c | 26 +++++++++++---
 drivers/spi/spi-mt65xx.c              |  7 +++-
 drivers/spi/spi-mxic.c                |  3 +-
 drivers/spi/spi-nxp-fspi.c            | 12 +++++--
 drivers/spi/spi-rockchip-sfc.c        | 11 ++++--
 drivers/spi/spi-sn-f-ospi.c           |  8 +++--
 drivers/spi/spi-ti-qspi.c             |  7 +++-
 drivers/spi/spi-zynq-qspi.c           | 13 +++++--
 drivers/spi/spi-zynqmp-gqspi.c        | 13 ++++---
 include/linux/mtd/spinand.h           | 58 ++++++++++++++++++++++++++++---
 include/linux/spi/spi-mem.h           | 56 +++++++++++++++++++++++++++++-
 29 files changed, 349 insertions(+), 80 deletions(-)
---
base-commit: 9100187b36091e5cc046d1f415f50a04ec31c25f
change-id: 20241210-winbond-6-11-rc1-quad-support-0148205a21a2

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


