Return-Path: <linux-aspeed+bounces-2856-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F4CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 14:34:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4scw18jQz2xqh;
	Tue, 11 Nov 2025 01:34:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762785280;
	cv=none; b=J4t4L/IfmODaGHx8evcqlCNq52SSmPj4E1pJyxlkOPpNRBXRB2g83EJfX5EZbWXRCzKdtPaTiLRQtHM0yoQZQzUrrVToDdrhiJWkRVocMiUU1wGOinmXIY5aU8rc7u+MIXoABAONW1Q4YnBP+8VXKaUrbDR5rZZSVEk61acCEaDDsiI5KbpdsdYkgSHdtQ7Y6YOtcjb1rrYEgfTIE3PRsz/BTn5S4Wrb2Jp53YcFBtPfn5EldV6UeSdkG/Tb1H6+H9kZzOAV9kxAcPa9aJPjE6i/HwzmIREMrtBBwegekuOKsU4+thmdlIQEO6F0qKnPs57srNTbEv68zw1OWJgdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762785280; c=relaxed/relaxed;
	bh=iu3r4I7Gj8VIjTe3J9xjEn8HAd6H7XSOIR9RoBwsEkM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iEUVOt3U6wXxnO7LcRHb713rtWLMkNHf21GdxAHB88cg584iSNcjUZFbirQ27cDKAFNgzZmnz/F7pC5zhkROxc0LdYWzXCvSS1qe0LklisL7YmQegM6oUwFm+OnwmBbQJe43FLfE+alj2MQH+zdCpAuDtNM1D85tY4rTRm0FIBZHc7F07L+qpQFwS0WCQglWqMwKciBr7hrKMUYEZFgxbLfELSBuPob0RHzMVG4oDMkiIv9+19wRHuttfS3RWeDA5ahQC2jkep/5f88pbuUrlJRRIoRo9dCLqh7CljBxqk3VTtVm55XC/82UwiylaSX/oUWh+a6/qVePBOU4uchvJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ni9jDhqG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ni9jDhqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4sct4WS4z2xqL
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Nov 2025 01:34:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 35831601B7;
	Mon, 10 Nov 2025 14:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C8C2BC86;
	Mon, 10 Nov 2025 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762785275;
	bh=m8gTUwErcvUiLoD21fSkXdLe/TPUchJWC+DOnE/nmic=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ni9jDhqGDQszcc6X8xP6kCNgsY3pkLqyvvt3nY7zUGfJv+22tOmMr9dM0wKbPm+j2
	 IU41u7pUlRJRySt/4TWVdKut8H2+rpqtQ27pb09TDhiRoq2qZbo0cxMFDz1iPL+7Fe
	 nm8Gvx4TlOx3VCzWTvJYWt7FffLO8XaJvMF37dOBwbjjABojf5vieP3hvoHP07dN7g
	 fxh7m1qEgS6dXsfT/ikz3bbb3OBjHroAE4lr9RE6SFDp0xOnsnQ27qZefYg6azy2Vj
	 uLE1RdCuZ+vuQg47Z7lUa+b6wwQDVuCyBWXq63TO7IGZvKjzotc3rE+n01QVOnBoU5
	 zGHca64JaUoJQ==
Date: Mon, 10 Nov 2025 08:34:34 -0600
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
Cc: Joel Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
To: Marc Olberding <molberding@nvidia.com>
In-Reply-To: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
References: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
Message-Id: <176278493385.154655.886985963575839587.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add device tree for Nvidia BMC msx4 cx8
 switchboard


On Sat, 08 Nov 2025 14:24:33 -0800, Marc Olberding wrote:
> Patch 1 Adds the binding for the msx4 cx8 switchboard
> Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.
> 
> This is an Aspeed AST2600 based reference implementation for a BMC
> managing the nvidia mgx cx8 switchboard.
> 
> Reference to Ast2600 Soc [1].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> 
> Signed-off-by: Marc Olberding <molberding@nvidia.com>
> ---
> Changes in v3:
> - Removed mac and mdio node completely per Andrew Lunn's request. Will add back
>     once the mac driver is fixed
> - Link to v2: https://lore.kernel.org/r/20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com
> 
> Changes in v2:
> - Added ack by Conor Dooley on patch 1
> - Changed phy-mode attribute after discussion with Andrew Jeffery and feedback from Andrew Lunn
>     and added a comment with a better explanation
> - Link to v1: https://lore.kernel.org/r/20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com
> 
> ---
> Marc Olberding (2):
>       dt-bindings: arm: aspeed: Add Nvidia msx4 board
>       dts: aspeed: Add a dts for the nvidia msx4 hpm
> 
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 235 +++++++++++++++++++++
>  3 files changed, 237 insertions(+)
> ---
> base-commit: 38a2c275c3d3f7d7180d012386cd6fcf87854400
> change-id: 20250908-msx1_devicetree-7af2c1fc15d0
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
 Base: 38a2c275c3d3f7d7180d012386cd6fcf87854400 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: sdram@1e6e0000 (aspeed,ast2600-sdram-edac): compatible: ['aspeed,ast2600-sdram-edac', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






