Return-Path: <linux-aspeed+bounces-1587-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F76EC7EE31
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Jun 2025 14:06:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTHRK4l9nz2yNG;
	Sat, 28 Jun 2025 00:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751033197;
	cv=none; b=jtbZnDokqS5UjRnL9fcGeb8QX1jEU4JheM+jS/NhrNxFv8OlveDXjrA2vdefKFF/RoIICcgljA2EZaP3LFUXRadjW57hCvVTQFWBHt4txrmBB9UZdlFIGx3wpyBa70+lx2UGFN6eubxi7cMBgF0nIhJ/B0/wXLvM9OW83/gwYGewrlAcgdiRgnkCAT7QEZnpuo1+3g3ECA7clpWQA9IlJTJbKrI7h78j1M/lcGNUlQKYvFswofGAqGSlrRrShoyEa6DjHWi0EKfhKVs9JjTDyHe6YKQH4YTn999mbf0BSf8vaVEFEsn0fjIMCt0CAhYEf8886h6h8G0JwtjrJ9WKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751033197; c=relaxed/relaxed;
	bh=+UbijZInFk4dXPNHD4GC4y2Jv4wMdcjqDPm7y0HgJpU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=B9Vi5E51H0u2iaL8nt1HRuDuB/cnzC+IDOpcTGMNhiSFvPS9AH1g5yvDzVMtoF1yx/nYjI6S3opuN84Z/F5MQIpNI9dsRga1/P70nWRi2gQBsolk/r0kAwpKPTKpYJ40d+cx446t0k4xbCDROg5/weZV8IjMxH5E2ZU9iK7bXYhZ9O6MsOtSkMfAm1X6nm3VuPW0wdNA7rvxlbRlCfM9sD5jnlZiwm57dtzT2wW5ktBwsv9K4MPZo0HpAmR7CYQU4Jtj3OlzUJ+Dy2Hghi6RSTNZQ+8XVGZhmPvqyV95+6bXuApBKR28nvJKSfEdvlQmNjGTQU0dUxvQCKk31RusUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jZ5t9e4S; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jZ5t9e4S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bTHRJ0D2mz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Jun 2025 00:06:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 298D761120;
	Fri, 27 Jun 2025 14:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD77FC4CEE3;
	Fri, 27 Jun 2025 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751033191;
	bh=adVsjIBtKgCgfvIZbKXclC2cbdubaiTo5YZIsWYdjqA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jZ5t9e4SSWnGYL0n2bI4xn1iOrlC+e/Nf4REXNYlxgqerKtOjjvsgPzXd1jxylOOC
	 84facDh65ry5zHJWSewulap42brLM0ofT6G9YDow0rqvEv2ZEv9FUwfkB3V7NuuZgT
	 BS5i2jX/1UV7J5+17yFOh59uv2yqTerAkTBlzgDobTE/JotqgYrOayXgfGoYjZfcbK
	 zUHOG+bOV+n8B+jSldNIDoD9lfP3PJses40Iu4uoW6i732j0lHhxu+N6H02JPMF2O7
	 NZ0/POcs7Vy+K2OHvbulthQwNu9CNHwasY/HT99WUhkBpc3SmaKB9v55/wvz3KlXtg
	 W4HI7DsBO2ymw==
Date: Fri, 27 Jun 2025 09:06:30 -0500
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
Cc: Leo Wang <leo.jt.wang@fii-foxconn.com>, 
 Magnus Damm <magnus.damm@gmail.com>, george.kw.lee@fii-foxconn.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-renesas-soc@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, bruce.jy.hung@fii-foxconn.com, 
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org
To: Leo Wang <leo.jt.wang@gmail.com>
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
References: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
Message-Id: <175103315156.3220577.5517131859109984485.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] ARM: dts: Add support for Meta Clemente BMC


On Fri, 27 Jun 2025 15:31:20 +0800, Leo Wang wrote:
> This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.
> 
> Patch 1 documents the compatible string.
> Patch 2 adds the device tree for the board.
> 
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
> ---
> Changes in v5:
> - Remove accidently pasted texts.
> - Link to v4: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com
> 
> Changes in v4:
> - Move properties of nodes defined in the same file from label ref back to where they belong.
> - Move pinctrl default configs for ncsi3 and ncsi4 to aspeed-g6-pinctrl.dtsi.
> - Add properties to i2c10 and i2c15 to enable MCTP.
> - Link to v3: https://lore.kernel.org/r/20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com
> 
> Changes in v3:
> - Modify leakage sensor to reflect current design.
> - Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com
> 
> Changes in v2:
> - Fix patch 1/2 subject line to match dt-bindings convention.
> - Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
> - Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com
> 
> ---
> Leo Wang (2):
>       dt-bindings: arm: aspeed: add Meta Clemente board
>       ARM: dts: aspeed: clemente: add Meta Clemente BMC
> 
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
>  .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1291 ++++++++++++++++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   11 +
>  4 files changed, 1304 insertions(+)
> ---
> base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
> change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
> 
> Best regards,
> --
> Leo Wang <leo.jt.wang@fii-foxconn.com>
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
 Base: using specified base-commit 52da431bf03b5506203bca27fe14a97895c80faf

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@34 (maxim,max1363): '#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max1363.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@35 (maxim,max1363): '#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max1363.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






