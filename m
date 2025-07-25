Return-Path: <linux-aspeed+bounces-1828-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD41C83F26
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 03:19:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpClm47TXz3blg;
	Fri, 25 Jul 2025 13:19:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753413572;
	cv=none; b=jdlQ6q3oq0W6O0BeqZzb5TFLB/eB+EFpQgwv796h5JEsBLQZDc1sd/1v4tJnqX45UqhVI1hIZKSTLVJ/kX0oBFDMYTF5e8oP0V62LE0J8MeCKBG72EBPIDFyq9+JgucD+AwAu0S21z59ZZw0Bm96aaeAwbV8DCSaUpnVu1T2e0ymfE90AoV6aAY32awfDkqIKdVCNqEG+NjSXlF2QmILIqUVuMZ6c3ewnHSzoktv5VauOd896i9N5yWFdusEkSaaeUUCNm2yzDaGNmbH0U34wFm6wtY6VjyFhX0AsMBs5vBe5zWnQ8cTzjnUz4ebuESNeEYo9IXAiPgL0nqpA7/GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753413572; c=relaxed/relaxed;
	bh=VXSj4O1YFwP0E1rj9+5d5Ww7Oeec5czqLT0IeouU4LU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JVihYO1Fj/TXHL/b3ouwbk93mSQSqIodMgo7e68AIt6F9rhx4gQrtyNkrsJjbJKNr7F3A9twVjThQ601lRzWQHhc06g5nSHhmxFN8H0cDZCOXSFnCkLBEJjbmvXiTBWiJWHf3eok2ZqGo7s617e8M/sHwzVKS5VtKaq1kbCCZ2qdvw7v9XutqXcoYSPDdhxfk4mgZndfzRYyW59JriJ0M5DPMuR07nBrKNI7dPdY16daT7kmVXKdbWl6NPuO79hTdwUD9Ff+sb7qn0Gpomzujsl6xHr/uT6fCb4tQL4l9xKc0QThAP+ZLDlBDBbYaICOrqd8yKtent9fzUrehMXPxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pM7yVE7O; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pM7yVE7O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpCll3mRKz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 13:19:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 13439601F6;
	Fri, 25 Jul 2025 03:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72AAC4CEF1;
	Fri, 25 Jul 2025 03:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753413567;
	bh=ab8UTnCME71O74SywAdSri8BPpfuR06qmysNi2ruFns=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pM7yVE7OH0xzIrM4F7ITpYdgieZWAmRa3ev8YeazIsXompU7U92+kO5WSDR7p04E0
	 nThQ0Vhj0bgHSXMHxOMHsiicBZgR6qEz86Ma8lhYcyOuh40aWd0Hx04GC/yOC86O5q
	 kSFhQEykjCsSX2B9kz7WNDM6SF4vhCE6dFqpj4mvMpvinNp3dNUifbMmyrXITfKPj/
	 +e06WmQ9p2QalJtIRr6DN/7o/n0KWb1qIqqTc/ogpFNX2V0WAC+a/rfsFxWt6lP+yw
	 S1gDO2iF1/ywxBcI/m4HXs6HO0EwO31v+dA+XLgK6ynYVJCPSRDZIB18cwYXfV4c5Y
	 l6NtWhb8901Zw==
Date: Thu, 24 Jul 2025 22:19:27 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
 Tao Ren <taoren@meta.com>
To: rentao.bupt@gmail.com
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Message-Id: <175341328259.3754758.1853821981943315378.robh@kernel.org>
Subject: Re: [PATCH v3 00/13] ARM: dts: aspeed: Add Meta Darwin dts


On Wed, 23 Jul 2025 16:29:56 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
> each BMC platform because eMMC was removed from future Meta Network BMC
> platforms.
> 
> Patch #5 introduces new BMC flash layout with 64MB data partition.
> 
> Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
> and "wedge400-data64-bmc" are identical except BMC flash layout.
> 
> Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
> "fuji-data64-bmc" are identical except BMC flash layout.
> 
> Patches #12 and #13 add Meta Darwin BMC and updates devicetree
> bindings.
> 
> Tao Ren (13):
>   ARM: dts: aspeed: wedge400: Fix DTB warnings
>   ARM: dts: aspeed: fuji: Fix DTB warnings
>   ARM: dts: aspeed: Fix DTB warnings in
>     ast2600-facebook-netbmc-common.dtsi
>   ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
>   ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
>   dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
>   ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
>   ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
>   dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
>   ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
>   ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
>   dt-bindings: arm: aspeed: add Facebook Darwin board
>   ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    3 +
>  arch/arm/boot/dts/aspeed/Makefile             |    3 +
>  .../dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
>  .../dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
>  .../aspeed-bmc-facebook-fuji-data64.dts       | 1264 +++++++++++++++++
>  .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +---------------
>  .../aspeed-bmc-facebook-wedge400-data64.dts   |  376 +++++
>  .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  366 +----
>  .../ast2600-facebook-netbmc-common.dtsi       |   22 +-
>  .../facebook-bmc-flash-layout-128-data64.dtsi |   60 +
>  10 files changed, 1804 insertions(+), 1619 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
> 
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
 Base: attempting to guess base-commit...
 Base: remotes/next/fs-next-11017-gdc9b385a8a2e (best guess, 4/6 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250723233013.142337-1-rentao.bupt@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: sd-controller@1e740000 (aspeed,ast2500-sd-controller): sdhci@200: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
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
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






