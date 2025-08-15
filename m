Return-Path: <linux-aspeed+bounces-1984-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A523DCA0ED1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 23:38:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3dq62ckpz3ckQ;
	Sat, 16 Aug 2025 09:38:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755301138;
	cv=none; b=nhFmL38DljwCXjRHWKC618AEMyWyWGxXsyHp7s1zLA0Tb4bQ8PL4qwXEbzD8SDHMB2Ey0rrefSeXh4gxg+EjXogF+upriEgpsitsGJPpLLTuZKuV/BCfiXruTnxLAD996hlCM0GSggwv/xUS8ICJ2dMkyIZ/gVUpFwS41TqWuW30+qSaMrqp2u48LMQhPbz5vUF0jE3/2WHJBc29l2UF8IQ4VALlFc7uPthRsRvIItzzVHJGJVOIU1bVCxUvGpBqqC+yw5J6CFdwL4pzU/D5vEJsrgUOozn5WWtJjNFJWncK7m+6Pk5c4o1suqejGgxTApv2/fkEdwO2GF6AINHRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755301138; c=relaxed/relaxed;
	bh=y91ud9mNc7MRBpMXPVE8EBnay/S5TNuuPBs+MaYSIjc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LBjkW5057Sgd+qQM9UXW9pa+z8bHDnm4n2zrPAm74PsTcqP448FnvugpeybewccZHfaj/wkyudH9QCCHY4O7BSUmnUs4pbxGmJuUxghKUtwbiRTCJ1voxs5YyQMuMJa+/XMJXzixwycBLfSm0Cjjna03HttoVIbx/g3bQ/ScTUkbiP0ZLNVJ7DOExUTSJ/6MmAOiWDHqWMmJtgFeXyGLEOBXY68kLj51tJtXfDhp8uPM9EsHOUTn2EftpTlIB2yE3j3XHM6cCZkWxWMjkdGPMuwXUkQuAvqdJb8yV488H0ANAD7eX4WNyzROhQwB8jP3pTLqnQlzUGv2ikYNOjNLpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LQutKugk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LQutKugk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3dq53p6lz30FR
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 09:38:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D94D26141C;
	Fri, 15 Aug 2025 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F9FC4CEEB;
	Fri, 15 Aug 2025 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301134;
	bh=r1Vq7mA+j9OXBWosTNsWgWDh/jOXc+SDmqEDap08/Oc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LQutKugkJGGn54Oq+cSgY6i2Lv/Wyg26+cVKSib/qRuhStmffBn3/hFonevcqwy+I
	 NhuwJ1mNDO1GwRk5I+paI4LIJRUTHAA6scSLJbtU06a4uOAeQXAuXDgjxlKF5SwtTM
	 ODeA3dTB4+0RA+fQTs5numTXi9pHCaQoNQf9fXnxYvc9q23xwkevLNmVH059fSCY1G
	 d0cfi7cce+WtprBT6uUOSteIqrKI9nwhUdjN0S0a139ixwFjQygukJLoPKgUa+FzfL
	 rcGejXA3shCoQkySFUeOEd5DaLw8SMvF9ypZG4epUZgv14L+MtA+NKpBbfJQPEDXu7
	 IbQYGT5678I6g==
Date: Fri, 15 Aug 2025 18:38:53 -0500
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
Cc: linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, andrew@codeconstruct.com.au, krzk+dt@kernel.org
To: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250815194730.41695-1-eajames@linux.ibm.com>
References: <20250815194730.41695-1-eajames@linux.ibm.com>
Message-Id: <175530106096.3523003.10423924922951806073.robh@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: dts: aspeed: Add Balcones system


On Fri, 15 Aug 2025 14:47:26 -0500, Eddie James wrote:
> The Balcones system is similar to Bonnell but with a POWER11 processor.
> 
> Changes since v3:
>  - Add max31785 to the max31790 document instead of to trivial-devices
>  - Fix minor formatting in dps310 document
> 
> Changes since v2:
>  - Fix a couple of incorrect i2c addresses
>  - Document dps310 and max31785 properly
>  - Drop the UCD binding documentation update, it's been fixed
> 
> Changes since v1:
>  - Add all the ucd9000 driver supported compatible strings
>  - Fix node ordering in Balcones device tree
>  - Improve commit message to explain addition of ibm-power11-dual.dtsi
> 
> Eddie James (4):
>   dt-bindings: arm: aspeed: add IBM Balcones board
>   dt-bindings: iio: Add Infineon DPS310 sensor documentation
>   dt-bindings: hwmon: Move max31785 compatibles to max31790 document
>   ARM: dts: aspeed: Add Balcones system
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  .../devicetree/bindings/hwmon/max31785.txt    |  22 -
>  .../bindings/hwmon/maxim,max31790.yaml        |   6 +-
>  .../iio/pressure/infineon,dps310.yaml         |  44 +
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  MAINTAINERS                                   |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
>  .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
>  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
>  10 files changed, 1442 insertions(+), 792 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
> 
> --
> 2.50.1
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
 Base: tags/next-20250815 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250815194730.41695-1-eajames@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pwm@52 (maxim,max31785a): '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /: failed to match any schema with compatible: ['ibm,bonnell-bmc', 'aspeed,ast2600']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1', 'fan@2', 'fan@3', 'fan@4', 'fan@5' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: max31785@52 (maxim,max31785a): '#address-cells', '#size-cells', 'fan@0', 'fan@1' do not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#






