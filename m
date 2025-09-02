Return-Path: <linux-aspeed+bounces-2115-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBE0CA1005
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGRBm5kjwz2yN1;
	Tue,  2 Sep 2025 23:18:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756819104;
	cv=none; b=Hk72FL5b6NMrlcVGrW80vvL3V6WadIbeGuEtKOKm7Wyd9hT46liwKkcGdkTr56M09fFBPaUaRXBTqFwGQyOjE6bF9HpPCJuNcMEsSaWpZr9QYHJtM52zk29qm9trNkxf0IJI9aU8LnvyeNr9zDfWkgYuRsIDgmAV+E0C6VbTvosql6cSb/zQLXqtKaglo5iLwQSbjn0kpsb04LGwoV+vYt55d6Sd3mauNkw3f7tqHauSoqTuDDcu3F1IgOg/xPi3pIyBL1HtB0PjQj6A9gB82/Mx+t/l7kvlHwI1F0a+akroBemf1NMhGBdAP0b8M3XK+NDdu/RkGw6365RfGYCSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756819104; c=relaxed/relaxed;
	bh=v1Iud/BNQXl+o9o2nITUUPcYaRdViAkZtM2OJ355Q3U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YZksWSOkpSorF4sIW2lKOOIpyu3+ZdLj5X8dH+VwoYvMv7iyvmLCGlZvPdB8gmyIt6aHNaTAd4RnZYS5i/GGIDTDvFYB6D8KuWeOWfCIspMhrfxsVDFC7ARiM8FIA71Z+0k1w+1vA6RWpleUyV/OToT4LlyVe4AsVLJZfgYrIN6QEuB9RLOplH8geTndthe424CzK9GCwdxVJl3YhKzwmFQ2bC66kvWOhXbUE6Arbkas2YWSfXyVGRmHsyPLQwS4clmsnA9G6R1Rvbpwajh8u5YAj5fEoqAdC/Bp4v43j0nRZRbD5JA+xci8nlZv6uf0pOAMWOAE001wUI4/myg6zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pFPc0Bif; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pFPc0Bif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGRBl2sVsz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Tue,  2 Sep 2025 23:18:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1296144377;
	Tue,  2 Sep 2025 13:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42EC4CEF4;
	Tue,  2 Sep 2025 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819100;
	bh=nva1mBFyuVVPLmXTARaBeIiR0B0nMGh017Yl7IN3WDQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pFPc0BifN8nXlB5qQF3uMhlUA2pS/cvrdR7LZYW9cfLFnPrqKhQFg8HjdWMjkJSE6
	 /2DAUy4Ow72fxShmqCwuvTiaivE2iaaYrs3CaRCSLz4MDrEggMLXEoHOdZU7WtVYM4
	 MEndwIA0vPKw4cTPzji1gUMPgiqc+rB4UpEb+PurhEiWcQ/BVdcLdovRKdc41HaapM
	 75mA1fV9TJqGmNZF/F2wZLUNbkbGmvmkYfp8SMpmk0pUj/e4hJFI665+JmZx5p9jSn
	 YV/YMps4fSvpGyBnJ2r8tz0J4tPp0+KmQ1svnfeQk0qLMqKuWbfwYjyb9rezfsfz/o
	 7F12oFvJN6sXQ==
Date: Tue, 02 Sep 2025 08:18:18 -0500
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
Cc: soc@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 dkodihalli@nvidia.com, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org, 
 Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Yuxiao Zhang <yuxiaozhang@google.com>, Joel Stanley <joel@jms.id.au>, 
 Eric Biggers <ebiggers@google.com>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, spuranik@nvidia.com, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-kernel@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 linux-aspeed@lists.ozlabs.org, Rom Lemarchand <romlem@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Mo Elbadry <elbadrym@google.com>, 
 leohu@nvidia.com, Catalin Marinas <catalin.marinas@arm.com>, 
 devicetree@vger.kernel.org, William Kennington <wak@google.com>, 
 wthai@nvidia.com
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
Message-Id: <175678731287.878052.15508784585002236677.robh@kernel.org>
Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC


On Mon, 01 Sep 2025 11:13:06 +0800, Ryan Chen wrote:
> This introduces initial support for the Aspeed AST2700 SoC and the AST2700
> Evaluation Board (EVB) to the Linux kernel. The AST27XX is the 8th
> generation Baseboard Management Controller (BMC) SoC from Aspeed,
> featuring improved performance, enhanced security, and expanded I/O
> capabilities compared to previous generations.
> 
> AST27XX SOC Family
>  - https://www.aspeedtech.com/server_ast2700/
>  - https://www.aspeedtech.com/server_ast2720/
>  - https://www.aspeedtech.com/server_ast2750/
> 
> Bindings Dependencies:
> - intc-ic: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> - scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> - gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> - mdio: Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> 
> v5:
> - modify ast27XX 7th generation description to 8th generation.
> - aspeed.yaml
>  - modify missing blank line.
> - Kconfig.platforms
>  - modify ast27XX 7th generation to 8th generation.
> 
> v4:
> - make CHECK_DTBS=y arch/arm64/boot/dts/aspeed/ fix.
> - modify commit message remove itemlize.
> - remove modify aspeed,ast2700-intc.yaml patch.
> - aspeed.yaml
>  - Add AST2700 board compatible.
> - aspeed-g7.dtsi
>  - modify all size-cells from 1 to 2.
>  - add serial aliases, gpio, mdio, uart0 ~ 14.
>  - add firmware for optee, reserved memory for atf and optee.
>  - modify cpu@0 to cpu0: cpu@0.
>  - fix intc-ic for yaml dependency.
> - ast2700-evb.dts
>  - update stdout-path = "serial12:115200n8";
> 
> v3:
> - https://lore.kernel.org/all/20241212155237.848336-1-kevin_chen@aspeedtech.com/
> - Split clk and reset driver to other commits, which are in series of
>   "Add support for AST2700 clk driver".
> - For BMC console by UART12, add uart12 using ASPEED INTC architecture.
> 
> aspeed,ast2700-intc.yaml
> - Add minItems to 1 to fix the warning by "make dtbs_check W=1".
> - Add intc1 into example.
> 
> Kconfig.platforms
>   - Remove MACH_ASPEED_G7.
> 
> Ryan Chen (5):
>   dt-bindings: arm: aspeed: Add AST2700 board compatible
>   arm64: Kconfig: Add Aspeed SoC family (ast27XX) Kconfig support
>   arm64: dts: aspeed: Add initial AST2700 SoC device tree
>   arm64: dts: aspeed: Add AST2700 Evaluation Board
>   arm64: configs: Update defconfig for AST2700 platform support
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   6 +
>  arch/arm64/Kconfig.platforms                  |   6 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/aspeed/Makefile           |   4 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 452 ++++++++++++++++++
>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  22 +
>  arch/arm64/configs/defconfig                  |   1 +
>  7 files changed, 492 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> 
> --
> 2.34.1
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
 Base: tags/v6.17-rc1 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/aspeed/' for 20250901031311.1247805-1-ryan_chen@aspeedtech.com:

arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): interrupts: [[0, 192, 4], [0, 193, 4], [0, 194, 4], [0, 195, 4], [0, 196, 4], [0, 197, 4], [0, 198, 4], [0, 199, 4], [0, 200, 4], [0, 201, 4]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@12c02000 (aspeed,ast2700-scu0): #size-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): compatible: ['aspeed,ast2700-scu1'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 0]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 1]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 2]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 3]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 4]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 5]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#






