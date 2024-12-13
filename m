Return-Path: <linux-aspeed+bounces-214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56756E7717D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 05:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8cmN5H8mz30gL;
	Fri, 13 Dec 2024 16:08:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734066484;
	cv=none; b=Y9GIccCpPPUN3QGhoeVX2XD3KJB4/CqJ7vFIQrRt+ya07sdZvdnZmy+JwPfVr0CVMs6VqSWG26secBwiK5OxbPh8ZW99kf5JOO6FaH6nC+p6Mka++x5mZ3vUq8Wl77K2NKb10ehlu/ApgvtEaVmgNZ/1ymw0x+qyqT1jJHxIyM/am/5VNtXxSqKs7i3yNVpUrSPn72BZRFLsoE24Zf9ztGRqW6qqedPYZC68gL8aKORZUqrOUqJmHW1pwbMAwIHYlYN+46VbCiO3CsEjB/m+BTBqlogRoM6u1QU0FlrrOvgvBokTef2/V8jBpMQvxJs/5g+giJYvUImw+kev760oPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734066484; c=relaxed/relaxed;
	bh=Ob6gfCfTJHcT1k8fkHYM0XMpgJYwAe0EV0uca1nDr9I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khk/NhnFwBChkHqi7iedfstDzreqNRHY/XgrU16MniGW5w+pELmV2dT3MG/O9D4wJSpgx7OGKFR9KdJQfXi44oYadQiLXSa98uKo/dEgdN7hahlAKCAlKoNQ02S4CCHmAYjaiLaf+JjnmS2Qfs8dSZfR93oPLNb+ntaAvfTWsUqx0b5ZmpJcpymrBgSZ05JHc0Qbhw6XOEEM65gcNSduDMF+ZmbGSZfRL5eFXzCqhg4yZbEnQL8h3BxfdVIYjPA/TMYQIcFSx5+IIecD92jXm0T10+W4yLFOjCZVNvcWPCk/W4sBRZlKo6/x3oLdXfwUOZtp8fOcBJGzvNuS0w+QCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C86JtZ1z; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=C86JtZ1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8cmM2S0pz30g6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 16:08:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734066479;
	bh=Ob6gfCfTJHcT1k8fkHYM0XMpgJYwAe0EV0uca1nDr9I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=C86JtZ1z9ScLdE1lNtMuIngcOj/VqRvKOHDmgo896hr3259jdBQvgCmOjjv884YfA
	 xAKjpd0m+DxSyccXXYzrkjQwe9L5cTwm+0F8hSoMyCQVtMV2I2e1mXWWbyawdizg/6
	 a7qJyp73jmuPa7/ow/rx0Eh+W3D5DGKqh4Y+X/fpeEuZxfmRmX424WCai3N8oudT2a
	 hW0hQAIxJiDgt+gv8OlIDTbIR3cqXI3k9m1qCPXHp3GCCWh4HsKYCzQbrrvN4yzbTW
	 B3B6qG1Zsc8BEaI1gAecV+2VIE66oIGPX3VP7YRviJXYiCkdVJWRRw3jZ1xmekqMCg
	 QuPaKtwScp9UA==
Received: from [192.168.68.112] (203-173-6-153.dyn.iinet.net.au [203.173.6.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9893B6E54C;
	Fri, 13 Dec 2024 13:07:53 +0800 (AWST)
Message-ID: <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 tglx@linutronix.de, catalin.marinas@arm.com,  will@kernel.org,
 arnd@arndb.de, olof@lixom.net, quic_bjorande@quicinc.com, 
 geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org,  neil.armstrong@linaro.org,
 johan+linaro@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, soc@lists.linux.dev
Date: Fri, 13 Dec 2024 15:37:52 +1030
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0

Hi Kevin,

On Thu, 2024-12-12 at 23:52 +0800, Kevin Chen wrote:
> ---
> v3:
> =C2=A0 - Split clk and reset driver to other commits, which are in series
> of
> =C2=A0=C2=A0=C2=A0 "Add support for AST2700 clk driver".
> =C2=A0 - For BMC console by UART12, add uart12 using ASPEED INTC
> architecture.
>=20
> aspeed,ast2700-intc.yaml
> =C2=A0 - Add minItems to 1 to fix the warning by "make dtbs_check W=3D1".
> =C2=A0 - Add intc1 into example.
>=20
> Kconfig.platforms
> =C2=A0 - Remove MACH_ASPEED_G7.
>=20
> Kevin Chen (6):
> =C2=A0 dt-bindings: interrupt-controller: Refine size/interrupt-cell
> usage.
> =C2=A0 dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
> =C2=A0 arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
> =C2=A0 arm64: dts: aspeed: Add initial AST27XX device tree
> =C2=A0 arm64: dts: aspeed: Add initial AST2700 EVB device tree
> =C2=A0 arm64: defconfig: Add ASPEED AST2700 family support

Do you mind sending a v4, because I received a confusing arrangement of
patches:

[PATCH v3 1/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
[PATCH v3 1/6] dt-bindings: interrupt-controller: Refine size/interrupt-cel=
l usage.
[PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
[PATCH v3 2/6] dt-bindings: interrupt-controller: Fix the size-cells in ast=
2700-intc
...

Where the content of=20

   [PATCH v3 1/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  =20
and

   [PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  =20
Differs, as does the content of

   [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine size/interrupt-=
cell usage.
  =20
and

   [PATCH v3 2/6] dt-bindings: interrupt-controller: Fix the size-cells in =
ast2700-intc

Despite sounding like they might have the same intent

Andrew

