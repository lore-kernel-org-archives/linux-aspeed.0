Return-Path: <linux-aspeed+bounces-1572-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C476AC7EE2A
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 20:43:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSDKc3V8Nz309v;
	Thu, 26 Jun 2025 06:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750884180;
	cv=none; b=mNUzbArGgYn/Yzcwb5k2TDkM7OJsJFqLyufufQrHXwbAF6wnHznB24bVYhERtxo80Sld3tFjJP8+th9XQxF3kDoS8ndqBmMYvI8fT7iNBU7CQN7P/KklZkzsEN1VkSrnTDLdHABVmB/g5QrM/HYguzuX+pVCpc/bLytXDKmzaK2V8ZYzQWp9cx3ZAfS338LijYSL3w0DqC1VWZ451Se70DGuzHhUCaB7EkZ6NRtDwabJEgjPLpmF3QcOyusxAIdK2vyiwYUilX/DsqwF3GkAH3mEE/ny6diqctew+YqCbEE5G0K/VWfICxDq+88QPmu6q1gUrjMGTbT7l/zR0ON5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750884180; c=relaxed/relaxed;
	bh=ylR3k2y7+4LIBfXUWA/QuAF6NOSRbJi4lKR7STfDHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgSbaxL42b81fx1Y3NE4KmcoWr1SHKQNcVNROh/LuGPWsjTu7azDx8NtZhxYtkVjb/LN581knVktnMbBUKrHG9btEHFyUS8FgirqNNJ4Jnt/7Q0b57olwaL0b/NaDCR8DJq7DhjWTv6GYfsl2kHZ+eN8xUY2XcLTMrIVW6r70Rzxq0aEXbHJNtA9kAq+iYX673s3CLbrfbXcWG6istjgYMqf+OKBI70NFd63E3iD3SA6DNW6uraDmuhJ+grEgI4Cvyk/io4/lvc1/fNmiyxunYWLGqdB7gJI32vb8Xi5cR6MD35cuIF/AUD4VMl5iJkLNeUQzMdcaJ0mWY1vApiIAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U5TLu1SR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U5TLu1SR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSDKX0ybqz307q
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Jun 2025 06:42:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 329C461425;
	Wed, 25 Jun 2025 20:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EEDC4CEEA;
	Wed, 25 Jun 2025 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750884172;
	bh=TQ2yeYtVxpuEcSzjUBWcAiYEI/WKnqX64t4Owb5qOrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5TLu1SR2eFmHmjOKeSx3aKCAWxa4XTEYdF8wwxUrjql02hOZ09fD7Ik0plJ4vBoe
	 AS237xzFgsf5hfHMH/KUE+PxIcr73d6Ck6KTq68abVVJFDYB9fbHdhtDY2GtiEz7cA
	 WTTKhgFQPy9PRD1aYqTPsqRAUc+/riXd10J7jTDsMCYQNLLBoxmbWajwTq4B5LIaiO
	 VcXlESrEBruI46HNCXmJYbHDMNwwPVyfv2R7LrpEpvvSPgk+boj603uMj71yJU7nf0
	 D4DYtZjhSYagenKy+5N3BLKiht1FthT8rNrUABrxCkP932kq32xsVcyOaIZgj2ogdq
	 3eQ/kT5FUWLgQ==
Date: Wed, 25 Jun 2025 15:42:52 -0500
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Catalin Marinas <catalin.marinas@arm.com>, soc@lists.linux.dev,
	Mo Elbadry <elbadrym@google.com>, Arnd Bergmann <arnd@arndb.de>,
	William Kennington <wak@google.com>,
	Taniya Das <quic_tdas@quicinc.com>, linux-kernel@vger.kernel.org,
	spuranik@nvidia.com, Eric Biggers <ebiggers@google.com>,
	Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
	Will Deacon <will@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Rom Lemarchand <romlem@google.com>, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>, leohu@nvidia.com,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>, dkodihalli@nvidia.com,
	wthai@nvidia.com
Subject: Re: [PATCH v0 0/5] Add initial AST2700 SoC support
Message-ID: <20250625204252.GA2143810-robh@kernel.org>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <174975871838.2916138.1953670783794758715.robh@kernel.org>
 <7b3be5c104b1fe1033570f2f3e2391991b6d9d42.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b3be5c104b1fe1033570f2f3e2391991b6d9d42.camel@codeconstruct.com.au>

On Fri, Jun 13, 2025 at 02:59:43PM +0930, Andrew Jeffery wrote:
> On Thu, 2025-06-12 at 15:12 -0500, Rob Herring (Arm) wrote:
> > 
> > On Thu, 12 Jun 2025 18:09:28 +0800, Ryan Chen wrote:
> > > This patch series introduces initial support for the Aspeed AST2700 SoC
> > > and the AST2700 Evaluation Board (EVB) to the Linux kernel. The AST2700
> > > is the 7th generation Baseboard Management Controller (BMC) SoC from Aspeed,
> > > featuring improved performance, enhanced security, and expanded I/O
> > > capabilities compared to previous generations.
> > > 
> > > The patchset includes the following changes:
> > > - Device tree bindings for AST2700 boards.
> > > - Addition of the AST2700 platform to the Kconfig menu.
> > > - Basic device tree for the AST2700 SoC.
> > > - Device tree for the AST2700-EVB.
> > > - Updated defconfig to enable essential options for AST2700.
> > > 
> > > Ryan Chen (5):
> > >   dt-bindings: arm: aspeed: Add AST2700 board compatible
> > >   arm64: Kconfig: Add Aspeed SoC family (ast2700) platform option
> > >   arm64: dts: aspeed: Add initial AST2700 SoC device tree
> > >   arm64: dts: aspeed: Add AST2700 EVB device tree
> > >   arm64: configs: Update defconfig for AST2700 platform support
> > > 
> > >  .../bindings/arm/aspeed/aspeed.yaml           |   5 +
> > >  arch/arm64/Kconfig.platforms                  |   6 +
> > >  arch/arm64/boot/dts/Makefile                  |   1 +
> > >  arch/arm64/boot/dts/aspeed/Makefile           |   4 +
> > >  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 380 ++++++++++++++++++
> > >  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  54 +++
> > >  arch/arm64/configs/defconfig                  |   1 +
> > >  7 files changed, 451 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
> > >  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> > > 
> > > --
> > > 2.34.1
> > > 
> > > 
> > > 
> > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >   pip3 install dtschema --upgrade
> > 
> > 
> > This patch series was applied (using b4) to base:
> >  Base: attempting to guess base-commit...
> >  Base: tags/v6.16-rc1 (exact match)
> > 
> > If this is not the correct base, please add 'base-commit' tag
> > (or use b4 which does this automatically)
> > 
> > New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/aspeed/' for 20250612100933.3007673-1-ryan_chen@aspeedtech.com:
> > 
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: serial@14c33b00 (ns16550a): 'pinctrl-0' is a dependency of 'pinctrl-names'
> >         from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@100 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 0, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@110 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 1, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@120 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 2, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@130 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 3, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@140 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 4, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@150 (aspeed,ast2700-intc-ic): interrupts-extended: [[6, 5, 3844]] is too short
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> > 
> 
> To draw a line in the sand here: while the existing Aspeed devicetrees
> (AST2600 and below) produce warnings, I won't accept devicetree patches
> for the AST2700 and related boards unless they are warning-free.

Thank you. If you hadn't said it, I would have. Hopefully there's some 
IP reuse that will get the older stuff fixed (if the fix is in the 
schema).

Rob

