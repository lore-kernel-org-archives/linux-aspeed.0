Return-Path: <linux-aspeed+bounces-2880-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EB5CCFA1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 14:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d65M66gfKz2yv7;
	Thu, 13 Nov 2025 01:26:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762957618;
	cv=none; b=atA+nxbqmSGh2DTJ9xyMy4CxJAhk4rWrIYf1N51tsK692GAOSGw9v35XzaJOLcK+IiE/bKGgkk0lQYdHY5UBvAQ5xpjDBYmKcrGHFgU6vpvGhcbVzZSZjzMyke07EmbhF3CzsfHaoQFTq9zf+UkEL1c3irW8OcMVJB+0NSDYOnuvmDlvOWzkMgOe7YCqYjwIecrdgM+xM5jVsHgdLzvDFZZdRh5GfQknJMvUsQtXs1Yn3zq4kSYFdcGAPtClAQJYr2dwxr27joSQo6PPsq3/H7aNnLwtgbnRkwmtc6ZBS1bbfRLUIEEPghnCG3a38/I3m2y2+vh2CXPTwOKcfHzVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762957618; c=relaxed/relaxed;
	bh=/jRKol/2vDQz4Em/+Xoj5ebiBdSpA++VR8zmhfcyWbA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EF3+BucSeQ3yyO/MBDz+DF/CRFB/R9mDg6gw3NaM03kelFc9wzlO+opYFUE/tvDwMvSLFSEsEdVC9DCtUzeCUqjBb4ks2icVMWe13z0vg9zVr5HxduKPz1mroHS0KcIU5Z5ej8RPvUQDQkUYS3Xx6Z1WcclDO4iHJ3qMFjHvw0sQpxxiNQfhOEQHGOXkipNp6qhKYN4vFxJBXZ1NoTb81Ik5AMkBwUoyfJTVdYKvWvvam82L56ltvUX/z+5CUkotmU4cM3481+ZTZduLyOxkakEmElWobhwzIoePEEZe8xcTHxAYzTmiwv558iLI3XjSkQHYvOtmB2CqczM3ifJXJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pvZ8qQDd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pvZ8qQDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d65M555ZRz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Nov 2025 01:26:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 66F1B60257;
	Wed, 12 Nov 2025 14:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E41EC16AAE;
	Wed, 12 Nov 2025 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957615;
	bh=8LUezGoas/zmkSOZwz/kzJnb2VRdwiKxlL8+JEtsPf8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pvZ8qQDdJVqzltMy/ze8Er8u6IJu173ESkYNKVw9z9pkLu370HHo94TsqBRIXMVFz
	 CGp7TZ0NXOecgl6ATmqX+YFTvmG2e8rNYf7N054NmVCC+qVBFSq8RhMIAOTYB80f6Z
	 ZA/vYfyDK1C/QdDU7RiIiuMxvxSzqzhQn+tD6RkAUg4NrQqONLl4UTU596/pf0HJp+
	 lWa4M5csMx5+HuF78H9Nk1j8Vh962P4W5SJMim4KcJDOLkHPREnoFU/R1TG/Oj83Mc
	 k+pr3wLPI4Pfn9tVAv5ZvaCoDmE3TKBaEM2Hs5YdvVvl6+Dd64+41Xrewppnu2YP5K
	 d0ArcASWF6+NQ==
Date: Wed, 12 Nov 2025 08:26:53 -0600
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
Cc: Conor Dooley <conor+dt@kernel.org>, nfraprado@collabora.com, 
 jk@codeconstruct.com.au, linux-kernel@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 Taniya Das <quic_tdas@quicinc.com>, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, bmc-sw@aspeedtech.com, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Eric Biggers <ebiggers@kernel.org>, Nishanth Menon <nm@ti.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20251112101157.2149169-1-ryan_chen@aspeedtech.com>
References: <20251112101157.2149169-1-ryan_chen@aspeedtech.com>
Message-Id: <176295563530.1637905.10146284162033916464.robh@kernel.org>
Subject: Re: [PATCH v8 0/4] Introduce ASPEED AST27xx BMC SoC


On Wed, 12 Nov 2025 18:11:53 +0800, Ryan Chen wrote:
> This introduces initial support for the Aspeed AST27xx SoC and the AST2700
> Evaluation Board (EVB) to the Linux kernel. The AST27xx is the 8th
> generation Baseboard Management Controller (BMC) SoC from Aspeed,
> featuring improved performance, enhanced security, and expanded I/O
> capabilities compared to previous generations.
> 
> AST27xx SOC Family
>  - https://www.aspeedtech.com/server_ast2700/
>  - https://www.aspeedtech.com/server_ast2720/
>  - https://www.aspeedtech.com/server_ast2750/
> 
> Bindings Dependencies:
>  check with "make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs"
> 
> - scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> - gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> Binding dependency patch:
> - intc: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
>  - https://lore.kernel.org/all/20251030060155.2342604-2-ryan_chen@aspeedtech.com/
>    (merged into the irq/drivers)
> 
> v8:
> - Kconfig.platforms
>  - update commit message and help description.
> - aspeed-g7-a35.dtsi,aspeed-g7-common.dtsi,ast2700-evb.dts
>  - change license using a dual license of MIT + GPL2.0+
>  - add company copyright.
> - merge original v7 patch(3/5) and (4/5) to 1 v8patch(3/4)
>  - that can do build test with make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs
> 
> v7:
> - remove aspeed,ast2x00-scu.yaml modify
> - separate aspeed-g7.dtsi to aspeed-g7-a35.dtsi and aspeed-g7-common.dtsi
> - move aliases to ast2700-evb.dts file
> 
> v6:
> - rebased on v6.18-rc1
> - aspeed,ast2x00-scu.yaml
>  - fixed dt-binding yaml issuse report.
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
> Ryan Chen (4):
>   dt-bindings: arm: aspeed: Add AST2700 board compatible
>   arm64: Kconfig: Add ASPEED SoC family Kconfig support
>   arm64: dts: aspeed: Add initial AST27xx SoC device tree
>   arm64: configs: Update defconfig for AST2700 platform support
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   6 +
>  arch/arm64/Kconfig.platforms                  |   6 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/aspeed/Makefile           |   4 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi | 154 ++++++++
>  .../boot/dts/aspeed/aspeed-g7-common.dtsi     | 351 ++++++++++++++++++
>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  31 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  8 files changed, 554 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-common.dtsi
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
 Base: tags/v6.18-rc3-15-gbe755eb2b021 (exact match)
 Base: tags/v6.18-rc3-15-gbe755eb2b021 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/aspeed/' for 20251112101157.2149169-1-ryan_chen@aspeedtech.com:

arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): interrupts: [[0, 192, 4], [0, 193, 4], [0, 194, 4], [0, 195, 4], [0, 196, 4], [0, 197, 4], [0, 198, 4], [0, 199, 4], [0, 200, 4], [0, 201, 4]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 0]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 1]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 2]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 3]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 4]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): interrupts-extended: [[7, 5]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml






