Return-Path: <linux-aspeed+bounces-3501-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1D4EF070F
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 06:21:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8ZMM4WVnz2yFm;
	Mon, 09 Feb 2026 17:21:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770618063;
	cv=none; b=m8QvwScfIz2w6wd5OC6HOVix4q11uT/i3lnabSw6xbVygWKOQzBFzxSCs2kB+ZbETNin9GuuQC6JV5svHP8bz7yv0U6qyqDhyHNMcWI5otUai7WvZ3Cl38DHW18e6tVY3fwvJq8p3I28mpPullA3+K6EDKdnHMIraD8G0Dxn8M3d0+E20hUFlpR+1SOkRptsB9/I+4nLEaLtAlmTg+iI0kX86fxx4OXQhlbKXOjQCRIDc09k1kTPZkONThiSCT0awSAwKrZq0/wbSK4p0atty0wxIbHcgREOIeW3NgSujy1X+ZmsudUMyh1fDTOKRcP1BfloeAfxkmDLa1olINd7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770618063; c=relaxed/relaxed;
	bh=y1YXR4/Tyv9LUkuxa8hny85fia7ireYDpMIuGkyTJqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jo0TmTrCF38NsiEvwTrrzYjdaFqy1tAUyQO/hKsaMT7CYFMo82/282uD/RYNAy2WTr0gO1+PdkGE+As2pIqgHSz8cB+EPLl4UikeqBu+ZnwZLEM93RTNP5uUtexo98DQUiV+7iKXtlGEQtIkfuWJFZb5dHzFZSBJrkc1q23D4WaHU784F9IHvuoRIaGCvK3jxO047Xhmq1D8A1u7Km7vYN/gsbU5JdMVECRNsaNtNdOqkUs8X5WoijLVxm8gV69g1hBK9Y/2JcGArEqOWNIxdKc6EyPvcQ+SpLeBi+BazM741hj9vqRNMX/WURHMLEEtZHH/tPCpSo28P5UKMwcENA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bMcV/fEZ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bMcV/fEZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8ZML2mCXz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 17:21:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770618061;
	bh=y1YXR4/Tyv9LUkuxa8hny85fia7ireYDpMIuGkyTJqA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bMcV/fEZkzK7rGBH/FYv8Y0leVnfLwAoi4PIVFj+oNgOgyq9TVRwGUSwbe1V7Ruwf
	 einFWiOE/WXcWYyuDnJXLbqXH6nMUAq2DNakHJZZIzCtgUn9I7qEDq8YmpIso9VVt6
	 ddWSmTMEKtJ2S6bpOfuGE/ummOa236s06qQrQRUR36GxZmRiNAHzunqx9wzc0onDsq
	 +zxuUjOEUzdz2VGmytqSGeenN6rEPINEmVzDa43X8X3UyGHJrm2bCShaAjPkqWfNtm
	 0n8qZBXTHHWc+CQVu7mnw0wrK2F8ReiMQs/Gnjql4CWjsV5Bzu2srl1a5h4CnmBsgi
	 uWrYSuG/TM1lg==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 109B06024E;
	Mon,  9 Feb 2026 14:21:01 +0800 (AWST)
Message-ID: <73c63bc2f5eaae2c931a4ced1462024bd5a24237.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 5/7] ARM: dts: aspeed: yosemite5: Correct power
 monitor shunt resistor
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Jackson
 Liu	 <Jackson.Liu@quantatw.com>
Date: Mon, 09 Feb 2026 16:51:00 +1030
In-Reply-To: <20260130-yv5_revise_dts-v4-5-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
	 <20260130-yv5_revise_dts-v4-5-4d924455f3a7@gmail.com>
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

Hi Kevin,

On Fri, 2026-01-30 at 16:20 +0800, Kevin Tung wrote:
> The shunt resistor value defined in the DTS was incorrect and did not
> reflect the resistor value populated on the board. As a result, power
> and current readings derived from this value were inaccurate.

Okay, but how did it come to be incorrect in the devicetree? Was the
documentation wrong and so someone entered the wrong value? Was the
documentation correct but there was a misunderstanding? Did the
hardware design change and the devicetree is now just inappropriate for
your needs?

Essentially, what's preventing this from happening again?

>=20
> This change=C2=A0
>=20

I'd rather you rephrase this to avoid using "This change ...".
Hopefully the commit message always refers to its change.

Generally, please write in the imperative mood (see [1])

[1]: https://docs.kernel.org/process/submitting-patches.html#describe-your-=
changes

> updates the DTS to use the correct shunt resistor value
> according to the hardware design, restoring accurate power and current
> measurements.
>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 +++=
++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> index 84d3731b17f7c7c87338672bbcc859de2b89b722..524597a81365ef10cd03b67d3=
5eeb88a965cbe0a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -415,7 +415,7 @@ power-sensor@42 {
> =C2=A0	power-monitor@43 {
> =C2=A0		compatible =3D "lltc,ltc4287";
> =C2=A0		reg =3D <0x43>;
> -		shunt-resistor-micro-ohms =3D <250>;
> +		shunt-resistor-micro-ohms =3D <100>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-sensor@44 {
> @@ -461,25 +461,25 @@ eeprom@57 {
> =C2=A0	power-monitor@58 {
> =C2=A0		compatible =3D "renesas,isl28022";
> =C2=A0		reg =3D <0x58>;
> -		shunt-resistor-micro-ohms =3D <1000>;
> +		shunt-resistor-micro-ohms =3D <10000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-monitor@59 {
> =C2=A0		compatible =3D "renesas,isl28022";
> =C2=A0		reg =3D <0x59>;
> -		shunt-resistor-micro-ohms =3D <1000>;
> +		shunt-resistor-micro-ohms =3D <10000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-monitor@5a {
> =C2=A0		compatible =3D "renesas,isl28022";
> =C2=A0		reg =3D <0x5a>;
> -		shunt-resistor-micro-ohms =3D <1000>;
> +		shunt-resistor-micro-ohms =3D <10000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-monitor@5b {
> =C2=A0		compatible =3D "renesas,isl28022";
> =C2=A0		reg =3D <0x5b>;
> -		shunt-resistor-micro-ohms =3D <1000>;
> +		shunt-resistor-micro-ohms =3D <10000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	psu@5c {
> @@ -723,13 +723,13 @@ gpio-expander@21 {
> =C2=A0	power-sensor@40 {
> =C2=A0		compatible =3D "ti,ina230";
> =C2=A0		reg =3D <0x40>;
> -		shunt-resistor =3D <2000>;
> +		shunt-resistor =3D <1000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-sensor@41 {
> =C2=A0		compatible =3D "ti,ina230";
> =C2=A0		reg =3D <0x41>;
> -		shunt-resistor =3D <2000>;
> +		shunt-resistor =3D <1000>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-sensor@42 {

The way the commit message is written suggests it was just one shunt
resistor, but that's clearly not the case.

Andrew

