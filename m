Return-Path: <linux-aspeed+bounces-1658-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D4CC71130
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Jul 2025 17:55:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbX2r1RXFz30Vq;
	Tue,  8 Jul 2025 03:55:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751910932;
	cv=none; b=YQYJ/Kyb7LzYCgd1C5mneMhi97+y8/IR5+z847LiKnoYEA2sVA69DtIq/yctt8Jthl2fCiBQtP6aSpCZqxQL9bEXRiAujBM1rDz8AgERCEZv/1E+5LjGwtgcWUxR3ixasRg4rNXM8r1ObkDqPjuOTAS5SZ656pLgFAD2z3VCP7vuq2dW/NzebbNuk3VXFPw2tj4krvDza4FWs6VeoJiONkbCG5B7+8BDe7nXeAROaNolZRkCVrMfP8M0y9KlxSFAMzUJb5grMDckUQt9QDjL5MMyqkmxNA5/WhFWFUg1IB8bOv1bEO+3wyWa5MiQ391V10LB7Jy1yIxYXNctxNOQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751910932; c=relaxed/relaxed;
	bh=EvwzZjahsqw8FsxwE+bu4+lDyomFMNmplS19AoYeYAk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ips/+NEnkv8dj2sNuLBL4uxtKnJa1YDj/Rz9VwfH5ZRX+9UOrJ6kG1tjJmmz8irdGsKI4/QI/aIVBaUsdbztwAiBVkw5jXVVOze04YIUDXw9hcy+goEIoGov1fTyWdw6kbASkcLU3BXo5kIhEeXoxaVLe9ez4xozgDYoXPNiz0+JCQS476Y2ulC+Vjs9SpN0pRLl3JPXb7X5TTzaYtgK69EZO1Sh8o2dfJQj32YJQbKWD5cdBIywl/LgZ0N8f4n0rB4VkGGyhHm9fNDxyK3A+dX6k+tlcC5/gkxkwg6kFaZz8kjx+nlJqAFVetyt6b8Tj7OxuWka5LfIeNWgZ5Ce6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AmiC+WMo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AmiC+WMo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbX2p1p7dz30TG
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 03:55:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5860E61129;
	Mon,  7 Jul 2025 17:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB013C4CEE3;
	Mon,  7 Jul 2025 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910927;
	bh=vgYK0V6XyKINQM1isjd7q12NdmEW5pYbAiz0Dqu3Dk8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=AmiC+WMohJRXU0l8khOeO3+F5TR/E/8QuGW8Je6JpiRubRYuCBU9vQQbM6z5iGWwr
	 OGldsKA2N92yvxMrrFXtCQVyKMZj8zDFNFakwsHqpOJLCFhq6U/oCoqZXPBKWFBxMl
	 Auns+PFM+0CrArxxSSX920lGgu+7q93s71CVBHauT0igX1TwtaYNKPHb4v2Ld0O25l
	 TX3cmAlpB8v5K+oEswKb48DRm4JIl3RpJrLZcjLXDp24aZJ5MNz4WV5tEkbzEXJ12Y
	 ShEed/WQspQ1JeU+3WixQ44M97a2ekcTo3J+9qsrVCqgJCnrNbY8t4kXQOIUNcT+8A
	 cluIL++2h4zZg==
Date: Mon, 07 Jul 2025 12:55:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Tao Ren <taoren@meta.com>, linux-aspeed@lists.ozlabs.org, 
 Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
Message-Id: <175191074290.3364643.3141046769008476356.robh@kernel.org>
Subject: Re: [PATCH v2 0/9] ARM: dts: aspeed: Add Meta Darwin dts


On Sat, 05 Jul 2025 21:23:50 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> Patches #4, #5 and #6 introduces a new BMC flash layout to be used by
> wedge400 and fuji (and later more Meta Network BMC platforms).
> 
> Patch #7 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
> each BMC platform because eMMC was removed from future Meta Network BMC
> platforms.
> 
> Patches #8 and #9 adds Meta Darwin BMC and updates devicetree bindings.
> 
> Tao Ren (9):
>   ARM: dts: aspeed: wedge400: Fix DTB warnings
>   ARM: dts: aspeed: fuji: Fix DTB warnings
>   ARM: dts: aspeed: Fix DTB warnings in
>     ast2600-facebook-netbmc-common.dtsi
>   ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
>   ARM: dts: aspeed: wedge400: Extend data0 partition to 64MB
>   ARM: dts: aspeed: Move flash layout out of Facebook netbmc-common.dtsi
>   ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
>   dt-bindings: arm: aspeed: add Facebook Darwin board
>   ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |  1 +
>  arch/arm/boot/dts/aspeed/Makefile             |  1 +
>  .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 78 +++++++++++++++++++
>  .../dts/aspeed/aspeed-bmc-facebook-elbert.dts | 18 +++++
>  .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 24 ++++--
>  .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  8 +-
>  .../ast2600-facebook-netbmc-common.dtsi       | 24 ++----
>  .../facebook-bmc-flash-layout-128-data64.dtsi | 60 ++++++++++++++
>  8 files changed, 187 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
> 
> --
> 2.47.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250704 (best guess, 4/6 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250706042404.138128-1-rentao.bupt@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






