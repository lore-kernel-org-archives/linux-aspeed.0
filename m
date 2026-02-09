Return-Path: <linux-aspeed+bounces-3500-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA461EF070B
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 05:45:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8YZr5tmLz2yFm;
	Mon, 09 Feb 2026 16:45:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770615956;
	cv=none; b=of7GbU3PHWjsARxVDaPHYg+eNUj/mTV1sNsRPKYwEZFciIVOxk+acSEB0/75ssvuwpcfgWvHLaPYyAiQDUa+w0stf7wbIGvp9H0gNqbRgjyxXyDU+bmDdiKp4Tv2Porp5rj9KqUuNVk/x7JtudLkmovp8kly4dKdZUYIlNg5HJTTEukNxeHMtUzN1FwwECWg48LHzKwJ20We3BAje7inS7zcuQlYdTAGBTf3eyEiNcauHTcQ7vMyoj30y2eX9mjobWjrEWnP7jtIGj10OTAvonJ3OQKvrbQgZUphLZtEWXJMWt0rwU8bnJwlOB5SVlKBUNwn3lHhL1or10hs+8IyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770615956; c=relaxed/relaxed;
	bh=dnth1D2JhNyrTS1K8rbSc9KWM9EP1WSLD2zMCtx/c3c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxJdSgKpEpvHBaO/nHWvnLLVIK259LzTkk/4ZRQZFy1qvyt8T8ch3XGX1EvmOhKk0F0vYWQ8G0ZcfvKwQ9f+Ioo/8EvWK7N2iAYkbA2SBe+yoxIBwl2FjS4U4G+3GZC95fBFlHjLionJNVZObeOojnwRmAv8moBh9vhHXfRDdPdAGnEkaPXtD1s7ZNYyFj3bcpoZpeCzY9hg24zFSMrfFQJ+hbgtN8anVvo7cSaGwGTjDGHTptRg1KBaYI2gPbe4I3bGCUeHID3mcpRCJrGCDV4KpE8upqm7iaia8knSUoOPGSfa7n3yvUP2988rsXzBkupypmJ7Jl/vuSTMPDem+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AR5ZxWSB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AR5ZxWSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8YZq3CVXz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 16:45:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770615954;
	bh=dnth1D2JhNyrTS1K8rbSc9KWM9EP1WSLD2zMCtx/c3c=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=AR5ZxWSB35SlYy/pXbKX2GRwoqq4wqalLnZpTotUz3VQK/FZmbBP1ykAYMDHPRwhX
	 ul8evizpvDVPNDXdoq2igN0n8vWRUdQi7QwbxTsCe0UYi+1rljAjfuc+xMeihjNoqB
	 HC7z+thhCgg9jWZccNUdsu7mN1ki0rKrgxKkvE8J6nPXXUzvK5hBAQcGym6k5PGDQk
	 wKwekbEW/wQHuofbk+R+UVpCTOy8b/Ts/PM4m7cofq96QjlqaG29K4i7NvBNWy+X/U
	 ut6MUlRU356ueoxIbWAIAI1D+s+BsLlG1s35MSV1k3SOLw1i5JFfJkcJ8aelAATTFo
	 LFHjYTvExRfgw==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5FB9D603F0;
	Mon,  9 Feb 2026 13:45:52 +0800 (AWST)
Message-ID: <212de4074664dc0507b6ed174443b37cf7bf5053.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: santabarbara: Add swb cpld io expander
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Feb 2026 16:15:51 +1030
In-Reply-To: <20260129073749.3155383-1-fredchen.openbmc@gmail.com>
References: <20260129073749.3155383-1-fredchen.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Thu, 2026-01-29 at 15:37 +0800, Fred Chen wrote:
> Add CPLD-simulated IO expanders
>=20

If these are not genuine PCA9555 parts then I expect you should define
your own compatible string for the implementation which allows
nxp,pca9555 as a fallback. That way you can account for bugs in the
implementation either way (either in the kernel if updating the CPLD
firmware is not feasible in some situations, or by updating the
firmware when it is).

Andrew

>  for cable presence detection and 4 SPI
> flash control. To resolve sideband pin shortages, one IO expander is
> utilized to aggregate interrupt signals.
>=20
> Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
> ---
> =C2=A0.../aspeed-bmc-facebook-santabarbara.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 48 +++++++++++++++++++
> =C2=A01 file changed, 48 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dt=
s b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
> index 0a3e2e241063..39f7fade8ff7 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
> @@ -1335,6 +1335,39 @@ eeprom@50 {
> =C2=A0&i2c12 {
> =C2=A0	status =3D "okay";
> =C2=A0
> +	ioexp0: gpio@20 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x20>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <148 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =3D
> +			"IOEXP_21h_INT_N","","","",
> +			"","","","",
> +			"","","","",
> +			"","","","";
> +	};
> +
> +	gpio@21 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x21>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&ioexp0>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =3D
> +			"PDB_PRSNT_J1_N","PDB_PRSNT_J2_N",
> +			"PRSNT_NIC1_N","PRSNT_NIC2_N",
> +			"PRSNT_NIC3_N","PRSNT_NIC4_N",
> +			"SWB_PWR_FAULT_STATUS","",
> +			"CBL_PRSNT_MCIO_0_N","CBL_PRSNT_MCIO_1_N",
> +			"CBL_PRSNT_MCIO_2_N","CBL_PRSNT_MCIO_3_N",
> +			"","","","";
> +	};
> +
> =C2=A0	gpio@27 {
> =C2=A0		compatible =3D "nxp,pca9555";
> =C2=A0		reg =3D <0x27>;
> @@ -1349,6 +1382,21 @@ gpio@27 {
> =C2=A0			"SPI_MUX_SEL","","","";
> =C2=A0	};
> =C2=A0
> +	gpio@28 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x28>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		gpio-line-names =3D
> +			"SCO_UART_MUX_SEL0","SCO_UART_MUX_SEL1",
> +			"SPI_PROG_PL12_SEL","SPI_PROG_PL34_SEL",
> +			"","","","",
> +			"I3C_HUB_3_MUX_SEL_PLD","",
> +			"SPI_PROG_PL12_EN_N","SPI_PROG_PL34_EN_N",
> +			"SCO1_SPI_SEL","SCO2_SPI_SEL",
> +			"SCO3_SPI_SEL","SCO4_SPI_SEL";
> +	};
> +
> =C2=A0	// SWB FRU
> =C2=A0	eeprom@52 {
> =C2=A0		compatible =3D "atmel,24c64";

