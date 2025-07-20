Return-Path: <linux-aspeed+bounces-1754-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8DC83F22
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Jul 2025 23:07:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blfLG28csz30WT;
	Mon, 21 Jul 2025 09:07:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753052822;
	cv=none; b=DGwaUhsD8JpkcJDdpqlTqjZHAVASeKaYyXMZnSgNmPYo8sF8KVRo5SjqKbhEvSBb576aMuPtInIkCfBF4/F+YGGu8XJFVozR9gIkdiy0XfdM7XM6dkwq4bI5diScNmcng6rXr0xoqu5fftDrsZMV3YM8ENmQ8wuEimF5FJhCoVWzGbJCNy9SQUrMHFZG6U2cUWsAsqsdbiZrjC/zHogmF9CIMZUIzh9SNNjmaDzGexNXhTKMHu04CfDZhjIm31CgA9y+E3/RuQ+ApGzRZI53yiKoPacs60z3zjSkj7fMInl8S+UEvUYnjpYrOeQXUFCuYE08q2me2qwb3moW2YWAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753052822; c=relaxed/relaxed;
	bh=3E2EvxEWALBEtU5ZKCNWaj4uvlwCukMph8LNhShO29w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eEa8NcRVKEiKGDUUJtBfdngSI+RtgOnzm6YR+4VeaxPiXGxNGW8frnC6d8nSjo45SIXhFjwHbR0ulluwzZQi2wiLtdV/fMmj8VMf+KzGEPRIDB9FnDvP+ExwMfIaX4/rCO0mnZKfJt+mayl3VzLzQQUXNPpX8zIXHpyybgNh2ft/AXo+YECXVYUdr3ua6m/nuXrUlffmJJQCDAfUVkLxt5KrhQgPm5qF6tJu4vU8BG1kOwyd0bzK3kn3DhRQjxWylfK/0QtWhnK0JXkQr+SUznqbRg4XV/x70Ly7xtlKn2Q7hjrGmC6qOTASsyNA/iyb+w7c/wHzbdP54aFtMX019Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n5Qq/pY4; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n5Qq/pY4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blfLC0nT5z2yfx
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 09:06:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 105805C468E;
	Sun, 20 Jul 2025 23:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DA2C4CEED;
	Sun, 20 Jul 2025 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753052815;
	bh=CeyGM2qj6FhIEb5Nq6IgnzZ3O77Q+KJZ4smVy/r3XMg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=n5Qq/pY46OEeWti3zB3DOh/n8BFN5pYZsM1xoQTW7TEc9Wa5R9HrQrLTqO5VKObn+
	 Qi5t+CNoPtP9XzmgtorTqEZUsiZ36VXq90Nk3aF66Hn4Fkw7YJk4RKBZUhs1cFOqkJ
	 IK+i3mSsUlf016322xc//XaZN752GQwj3BKQu0Z6TOVnzmPfgvCru8OSb4wEEMb6sP
	 50GcYysUIfbPPCIKxbFB04erTJulNs0ArnSfo5AhRds+VKFI5eWp3xtwRkRF31eMvF
	 OsFaP7IDS7u9M1X08q21tr65PpHATemtkOWFBCX0409TujU5vGVO35GoA4vBqOiGd0
	 s6zQPNZ6KYIlg==
Date: Sun, 20 Jul 2025 18:06:54 -0500
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 joel@jms.id.au, linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au
To: Donald Shannon <donalds@nvidia.com>
In-Reply-To: <20250718231118.3330855-1-donalds@nvidia.com>
References: <20250718231118.3330855-1-donalds@nvidia.com>
Message-Id: <175305254811.3034422.3750387733086194199.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] Adding device tree and binding for NVIDIA
 GB200-UT3.0b


On Fri, 18 Jul 2025 16:11:16 -0700, Donald Shannon wrote:
> Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
> Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.
> 
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
> Changes v1 -> v2:
>   - Changed phy-mode to rgmii-id [Lunn]
>   - Removed redundant max-speed for mac0 [Lunn]
>   - Fixed typo from gb200nvl to gb200 in Makefile
> Changes v2 -> v3:
>  - Fixed whitespace issues [Krzysztof]
>  - Fixed schema validation issues from my end ( there are still issues
>  with the aspeed dtsi file that are not related to this new dts)
>  [Herring]
>  - Reordered to follow style guide [Krzysztof]
>  - Removed redundant status okays
>  - Changed vcc to vdd for the power gating on the gpio expanders
> Changes v3 -> v4:
>   - Added changelog [Krzysztof]
>   - Added nvidia,gb200-ut30b board binding [Krzysztof]
>   - Removed unused imports
>   - Reordered a couple other style guide violations
>   - Added back in a couple needed "status okay"s
> Changes v4 -> v5:
>  - Resumed my patch after a pause
>  - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
>  platform differences
>  - Fixed io expanders that weren't gated by the 3.3V standby regulator
>  - Fixed incorrect interrupt pin for one IO expander
>  - Removed some IO expanders and I2C busses
> ---
> 
> Donald Shannon (2):
>   Documentation: devicetree: Add binding for NVIDIA  GB200-UT3.0b
>     platform
>   ARM: dts: aspeed: Add device tree for Nvidia's GB200  UT3.0b platform
>     BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1027 +++++++++++++++++
>  3 files changed, 1029 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
> 
> 
> base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> --
> 2.43.0
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
 Base: using specified base-commit d086c886ceb9f59dea6c3a9dae7eb89e780a20c9

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250718231118.3330855-1-donalds@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: fan@15: aspeed,fan-tach-ch: b'\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






