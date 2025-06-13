Return-Path: <linux-aspeed+bounces-1434-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A1C71135
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:29:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJSdT6GgYz2yMF;
	Fri, 13 Jun 2025 15:29:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749792589;
	cv=none; b=atVfOO4FDWq8bRGeRwTjzrmUtSvGx03+0AXfEjdrKoKB6uwnD9lSXOFAiIy5O551tOUO69Zqbal3WszYF+SuLuliHuV/WSxpZtS0UUt5oGHOiUGfU/uY/EldjxfWkW9Cr9Hb40+CMMR/VXnZMflBNzx9mi24SmjgpaKeFdqDZ6IupW/nOkxxJjmAkmbiTzBN9VViBh4DHFWk8TS+uZFd7A596uqHUc53grapgdtxmLSeGXXEABsr9DCdVW4n3KoyuP4DPqK4OLfoAwuUp54We0JWTKbL8hW1h021rYYZ7c/XArlwTMTy+rLEPFp7xmk4h0Yz1Pzbmy1coTOFmpYiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749792589; c=relaxed/relaxed;
	bh=o+ZXJK5vabVpIbj4thHc31K5dbmHYYZH1fC2DzTsqBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJXVU5z0+z3gLw7ZuA10+93wu3YZlaDVsJvf/1WRRZcqFKFDocc9ddGNRX0Ji4mX/CVmXwZ5klJYYMrMza/CphEe65i63XBD46ICsEOVQ5eojF5813x1nF7IGGv0Wc9AYC/NqmtM5LQj4h6W5xegP+6d0Yh+nbRzEE+0Zpr2EbQfQ7ayi4kWOdRZ/rZxQGaYe/KxuizYMXjbP8L0ss+fJtMdlVYHq/xxBmbbmxhypWnrrjxSdXikDSrpfbM96INtG9f+v9lpkh1V0TtXsafzW1lzq2Vcx7AUdOZh17w2PA4RItIdEQEOUZGsT4hCaAjs8Cl8/F+LPmgMLP7cfQK/0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=N9MssL99; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=N9MssL99;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJSdT2Fv1z2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 15:29:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749792588;
	bh=o+ZXJK5vabVpIbj4thHc31K5dbmHYYZH1fC2DzTsqBo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N9MssL99BFu955VaFR1nkL3xaUvn26A3cCWyDm62uEGpqkx1vySP1F20rcycQXUTW
	 C3h2aiWfBMTAVnAiYTzmm69r/fFhc+oyh6X2lEKQqmCFyyjkIN4vgVde9cWkpwcbTg
	 UtYCrdl/gEYRPNb7mm09wWg1aO56GKqYSi0TWK91uB+DrwzxoMDwm51hOd8aKJoNzL
	 maC+IuhtEB4uQsMHZpx22saMCLYYuyw9aODFECe6Qy534RqU2XS8iZqcxi1CqCCPxT
	 F8cp4Maxs7BCyZOL8TMUkdYFG5bw/hlkF3LR+/u60Y6p5rkfqMvWYcK9KHDRv1JuVB
	 sDfDKwY2bN9ZA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BDC42680F3;
	Fri, 13 Jun 2025 13:29:44 +0800 (AWST)
Message-ID: <7b3be5c104b1fe1033570f2f3e2391991b6d9d42.camel@codeconstruct.com.au>
Subject: Re: [PATCH v0 0/5] Add initial AST2700 SoC support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, soc@lists.linux.dev, Mo Elbadry
 <elbadrym@google.com>,  Arnd Bergmann <arnd@arndb.de>, William Kennington
 <wak@google.com>, Taniya Das <quic_tdas@quicinc.com>,
 linux-kernel@vger.kernel.org, spuranik@nvidia.com,  Eric Biggers
 <ebiggers@google.com>, Joel Stanley <joel@jms.id.au>,
 linux-aspeed@lists.ozlabs.org, Will Deacon <will@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 nfraprado@collabora.com,  linux-arm-kernel@lists.infradead.org, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>, Rom Lemarchand
 <romlem@google.com>,  devicetree@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>,  leohu@nvidia.com, Bjorn Andersson
 <bjorn.andersson@oss.qualcomm.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
 dkodihalli@nvidia.com, wthai@nvidia.com
Date: Fri, 13 Jun 2025 14:59:43 +0930
In-Reply-To: <174975871838.2916138.1953670783794758715.robh@kernel.org>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
	 <174975871838.2916138.1953670783794758715.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Thu, 2025-06-12 at 15:12 -0500, Rob Herring (Arm) wrote:
>=20
> On Thu, 12 Jun 2025 18:09:28 +0800, Ryan Chen wrote:
> > This patch series introduces initial support for the Aspeed AST2700 SoC
> > and the AST2700 Evaluation Board (EVB) to the Linux kernel. The AST2700
> > is the 7th generation Baseboard Management Controller (BMC) SoC from As=
peed,
> > featuring improved performance, enhanced security, and expanded I/O
> > capabilities compared to previous generations.
> >=20
> > The patchset includes the following changes:
> > - Device tree bindings for AST2700 boards.
> > - Addition of the AST2700 platform to the Kconfig menu.
> > - Basic device tree for the AST2700 SoC.
> > - Device tree for the AST2700-EVB.
> > - Updated defconfig to enable essential options for AST2700.
> >=20
> > Ryan Chen (5):
> > =C2=A0 dt-bindings: arm: aspeed: Add AST2700 board compatible
> > =C2=A0 arm64: Kconfig: Add Aspeed SoC family (ast2700) platform option
> > =C2=A0 arm64: dts: aspeed: Add initial AST2700 SoC device tree
> > =C2=A0 arm64: dts: aspeed: Add AST2700 EVB device tree
> > =C2=A0 arm64: configs: Update defconfig for AST2700 platform support
> >=20
> > =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A0arch/arm64/Kconfig.platforms=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +
> > =C2=A0arch/arm64/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> > =C2=A0arch/arm64/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
 | 380 ++++++++++++++++++
> > =C2=A0arch/arm64/boot/dts/aspeed/ast2700-evb.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 54 +++
> > =C2=A0arch/arm64/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> > =C2=A07 files changed, 451 insertions(+)
> > =C2=A0create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
> > =C2=A0create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> > =C2=A0create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> >=20
> > --
> > 2.34.1
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
> =C2=A0Base: attempting to guess base-commit...
> =C2=A0Base: tags/v6.16-rc1 (exact match)
>=20
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/aspeed/=
' for 20250612100933.3007673-1-ryan_chen@aspeedtech.com:
>=20
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: serial@14c33b00 (ns16550a): '=
pinctrl-0' is a dependency of 'pinctrl-names'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@100 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 0, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@110 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 1, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@120 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 2, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@130 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 3, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@140 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 4, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@150 (asp=
eed,ast2700-intc-ic): interrupts-extended: [[6, 5, 3844]] is too short
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
>=20

To draw a line in the sand here: while the existing Aspeed devicetrees
(AST2600 and below) produce warnings, I won't accept devicetree patches
for the AST2700 and related boards unless they are warning-free.

Please make sure to test with the dt_binding_check and dtbs_check
targets (or equivalent) before sending your patches.

Andrew

