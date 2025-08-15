Return-Path: <linux-aspeed+bounces-1985-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79DCA0EE4
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 23:39:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3dq71Pm5z30FR;
	Sat, 16 Aug 2025 09:38:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755301139;
	cv=none; b=MxYg6EZtwfuRx8Gt9/M7wxcVkP6GuO2wriSo0EhLfhm6avcL0RH1i4yavL9fkIPWSctR6VMRziIyfXxEDXLm/0YkzLAyHllV2eRWeM7YtmyrZ9R5zbuO9bXdBuUCLARvVvRwUDbAnpqh6E1+9p5oA6xKlVBi3zlRHi5dXzwssgrOcQqbM32UzVXbRwx8Fs8ZM9VA4gLZGlyzTcqxfephYFIhpPoEqHVmp93u5mRUf2WIP4leKJGDzMVGHiUUHDUs3afJbnTK6S5s3nVw9ZDs0L7mcYJGyJv+Qm2sZXCAGa0loJoUvs61lotaTvK6dcPJLi2UXFqpumdQycqzuzHW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755301139; c=relaxed/relaxed;
	bh=sUObT2MtRUdeCzFIsyGIpQowt/Rz746ae833Ij+XOq0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OghslsZBJ8Y50LoOjPWnMqJTQe2d4cIFpoxL3nLiOLmiEPAsy30cP8ujgXFX+qx1lJ6wGVTuaSaXYyk5bchNfCLx8a3oKiv0wICqMn/qlSAvkAH9GCJH+L/AT9QwZHAQRFeaq4P3UoQV/nbkIpEitEfK+RmJvV6z89eHytVs89SHSoS9QRZMN4yyGOAz01vnT4oBEofnAfl9Pj+gL4TV+XyQJVX8PTXpGtZhazju4ZUS0f8F9Gydm9r1GNM01IH4HvTcRcbJjx5ENP61wIkVpywyedy+KJCQPbaSKSiXHCnQiDr/w2O27EIcovax+Lg1eKQz9crecLxfTLzj6J2A6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=teuQ+iJs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=teuQ+iJs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3dq61sxyz3ckP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 09:38:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BBA1245EB2;
	Fri, 15 Aug 2025 23:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E596C4AF0B;
	Fri, 15 Aug 2025 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301135;
	bh=x3QDZ47I/8OT9hBSL+4EmYWUfQlFHbDh875sGMUYuQc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=teuQ+iJs6TC5M7TxEj8YRoNklDeYEImgUx5QraCvkXMQBNQeFc2A2P/DJNUxXp6Wq
	 CshfdPFxt3JZ+XxEiEN4rjuLcsXtRognT8VspIwVULcZDWk9Df17Bt55CSUlXhUc/r
	 FM9Y6x6ajBXlWfxPystbS+FfwcSZ00acog7gS5gwuALAD/SghpWoXIsZ8WzqKnWlqv
	 3KgjV1hkP7kXr4VXubMEQdFAdRWJjbqAimLxQEIkkCE7rQyi3b7JMm1Hn7OGDCVutQ
	 zDiKagsLthTNSng8v1tG1GGZ0Ch4Ue6ZuiTwlimen30blPEdEG5QfUS3EcToWDr0sM
	 59c2XA+hCGIIA==
Date: Fri, 15 Aug 2025 18:38:54 -0500
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
In-Reply-To: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
Message-Id: <175530106151.3523036.5305359646677111575.robh@kernel.org>
Subject: Re: [PATCH 0/3] Adding device tree and binding for Nvidia mgx cx8
 switchboard


On Fri, 15 Aug 2025 12:45:54 -0700, Marc Olberding wrote:
> Patch 1 Adds the binding for the Nvidia mgx cx8 switchboard
> Patch 2 Adds dtsi's for the mgx cx8 switchboard itself
> Patch 3 Adds the dts for the mgx cx8 switchboard motherboard reference implementation.
> 
> This is an Aspeed AST2600 based reference implementation for a BMC
> managing an Nvidia mgx cx8 switchboard. Dtsi files are broken out for
> managing the mgx cx8 switchboard over i2c, so that others may reuse these
> if they choose to implement their own board. There are two dtsi files
> since the i2c topology is not symmetric between busses going to the mgx cx8
> switchboard.
> 
> Reference to Ast2600 SoC [1].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> 
> 
> Signed-off-by: Marc Olberding <molberding@nvidia.com>
> ---
> Marc Olberding (3):
>       dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
>       ARM: dts: aspeed: Add device tree includes for the cx8 switchboard
>       ARM: dts: aspeed: Add device tree for mgx4u BMC
> 
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
>  .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1078 ++++++++++++++++++++
>  .../dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi    |   80 ++
>  .../dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi    |   80 ++
>  5 files changed, 1240 insertions(+)
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250813-mgx4u_devicetree-c2e130607089
> 
> Best regards,
> --
> Marc Olberding <molberding@nvidia.com>
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
 Base: using specified base-commit 7bac2c97af4078d7a627500c9bcdd5b033f97718

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: spi@1e630000 (aspeed,ast2600-spi): Unevaluated properties are not allowed ('fmc-spi-user-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






