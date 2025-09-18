Return-Path: <linux-aspeed+bounces-2271-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11650CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 01:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRyNB2pPfz3000;
	Thu, 18 Sep 2025 11:14:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758158074;
	cv=none; b=W/JScHj3PpK2eunkQQaQfVNu08fsxHvq+z2gNd56eVuSppQuXjmczay+YfZkOm1FUTQ0TbEDf4i0AIKv9kgHZyAK0oxNByXRRGmOmvS0UE1/eSInR5agP9gFwNRWXjexBC4+MTbYWkb458z1Hae6Pm09cKgRu2oC1vBftHI4PlDXnkZ5/mxGKbUwDKCASDYDCqckAy+rBt/FJ0vwpC59CAOJ6FEtwLJ7aBwHG0OeGvFSC+0hv2NiHLnpvCc4p+XARL8L0YCycRlt8DKqYh1vb/sDdYCm7TKfcSg43NfMpzKs0b7wZvgrcaoBfEP3aCmHbPkLdwXataQ6Ly6hypAxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758158074; c=relaxed/relaxed;
	bh=zSRwh1OGCLN4dqme9S9IA6D8yC9jUMoGnDnPQnGGE2M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NNQKhXoi0BVlfyqSakdH/1N8UzFIscgU2cVr+UevCB8mhzfRCp/ni+7eeuryk1P9jq0zSZufFvxMTVdB3rybIvZ4FRkAMXoAB6kslGTKR7crRQ6rQ3fG3gL8zLqnSoBfpW57ifL2hD6+2uMqRBi4Dp+qcufVmlF4lXt88GU3SMNOyq/MRACYO3rhvYPsj/UXYT+PUn9zqcVTLRYZem5CqFJ3rh0ci3Q/UHPeHgWRNAcoG4COm8AB1AaSjaPsjSLcRB8FlLbUgE+7WfnoEz2fPQlh5PgdEHJfBU5DtOr38h/80AcjHYoKvyYNWox1n3VJ1s0ygf0AMQQAnuBWytos1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQTiS6cV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQTiS6cV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRyN86nPGz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 11:14:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B2D2943441;
	Thu, 18 Sep 2025 01:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74863C4CEE7;
	Thu, 18 Sep 2025 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758158070;
	bh=g3c8XhEz0bPJ7eh9V+y3pI2GRwX8vp7wDlq6Xzmvofo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mQTiS6cVe6C5naZ9M5DZ6pnoyBwC8juaDbIpaPSjcRH3Wk7A6jygwu7H09GU9dIla
	 WjOUNunVqVuhjMT+MONnQxpQNf+ZPYP4wAnuTn8tZMy2fTVB2AwcYlz+c6NmGEerYM
	 5IdwUWNU1g7mcI7D0/UblSwouph9m0SIm406U9RFaB3JlF6xJeGfN3UVIMMVIemQeN
	 lI1GjEFs+vaxX8SJQh69XTyoX4dG5t6ZdoCPCK9v0YIy6oEGdqbuFvsAMvbWdk483N
	 PycgCnHHXk90xgOGKGufygKDBk/zjjsjXx+AeclLN19O3k1kZA+xiRGIp0+BisYF3X
	 mS8WLfropyk2Q==
Date: Wed, 17 Sep 2025 20:14:28 -0500
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
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
To: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
Message-Id: <175815739133.3885492.1346225052792549378.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC


On Wed, 17 Sep 2025 12:04:24 -0600, Rebecca Cran wrote:
> The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
> processor. The BMC runs OpenBMC.
> 
> These patches add a device tree and binding for the BMC.
> 
> **Changes between v1 and v2**
> 
> - Reordered nodes to be in alphabetical order.
> - Removed status lines.
> - Fixed naming.
> 
> There are still several warnings from
> make CHECK_DTBS=y ARCH=arm W=1 aspeed/aspeed-bmc-asrock-altrad8.dtb
> I believe the only one which is reporting an issue in my dts file (as opposed
> to included files) is the first, and that's because the code partition contains
> the TF-A and UEFI areas. I couldn't see a way to suppress it.
> 
> aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@400000)
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
> aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01\t' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02\n' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05\r' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
> aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> 
> 
> Rebecca Cran (2):
>   dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
>   ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
> 
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
>  arch/arm/boot/dts/aspeed/Makefile                        |   1 +
>  arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 633 ++++++++++++++++++++
>  3 files changed, 635 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> 
> 
> base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
> --
> 2.47.3
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
 Base: using specified base-commit 5aca7966d2a7255ba92fd5e63268dd767b223aa5

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250917180428.810751-1-rebecca@bsdio.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01	' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02
' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05
' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#






