Return-Path: <linux-aspeed+bounces-4070-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCB6CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 13:09:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJynJ0D4Nz2xpn;
	Mon, 18 May 2026 23:09:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779109763;
	cv=none; b=STABkj/IBDyhEcsn/xTYPLT+m3uW0/Torkk+TXJ6IbkboYN6YR5kN0KUsNYlJmnOhNICZHN0KURFKwtYWHNegn2L5vlgQYz0YP5wl02kdVv+KqkoHeP8TprRkp/S1R08iJtpl3txRqPhUFaluD6X3QOK9PF0Osx40fkSuOCqXWEaIKIL9XUAz4VmLfgv6MTHHMjPGfmnA5WwWN2aCAnCFkCpjAUy8gOXM70oUIpC+yJRRHHk5PVyvy6uAU5V1FltWe0BzudIGC+8LNxQoq73s89+VcSWsybfgs8WJdhY2ZbFUfQifspA5nkGFb0tTUk8WRVv4goBmjSrTKyulNzy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779109763; c=relaxed/relaxed;
	bh=wk4N9ie3hEmSMwAYk9HPUXBeGpJpagkJEfLUPb7keEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHlMZFp/n2Cif4l7XjMaHAfppzX/+udQzTimrDFMiO5FWNGlTpAtgIPufH7eVnz5VmtD5LGLvz82mYQoZewxSYmbem2uJRFWcozFMZwV77aeY+IJdrxNQEvfQGl1fRYzyCuNQRw5ocQeUOhX7pO8J/5FRMX8xqJ7Out+8sFu5JofEdvqkiyjDP0DV64/HcvZHdng7HO8CdRXqIgWVdfpsCxu7wZznzitJiQvzZAjd1WLQPPUMmlbc1nkI5TXChINUqbpLazFdcvjC3D9ntZRp6vJjRJQV+41VussdWRqtpSIlRGkLK8zOM+Co5l5UKs0HoemKH5wEX8jjy038cT8mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Em6xs+oe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Em6xs+oe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJynH1hgzz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 23:09:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779109761;
	bh=wk4N9ie3hEmSMwAYk9HPUXBeGpJpagkJEfLUPb7keEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Em6xs+oeJOjqD4rk3pYZnRmeO3EJQ9djpAWpdLfGk96Vrx6oeBoV+RjvFKhZyaB+j
	 6xoxiwM4wg2f5ng9FU95wGM2FkU5dl17l101i2kRrjoBrcxD+Rfxt473MazS68tqgL
	 CaWi8oyrTTMzd4ffwY6HlwrjGI7ZGRQbEqmSDhIfwNi3/sHX+CiidyHJ0EBBFkz/MO
	 RZ8o2MoTNpobGxacJfUJsVDTcxnaXymFKvWowjbEY3eAj+H9nmL8F4vAj+e1Psl/3f
	 2rP6qMhYSYjuIpCMtHdGW9Wy2wMAazIRtOt11bv8FSk+E2wcgE+d9t/aI+WxA4G6Gc
	 L1I3w0z0CEnWg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DD3256025D;
	Mon, 18 May 2026 21:09:20 +0800 (AWST)
Message-ID: <a27e89c927016d1cdd87d76474b680f74b519b29.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: Enable MCTP and FRU for NIC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andy.Chung@amd.com, Colin Huang <u8813345@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 22:39:20 +0930
In-Reply-To: <20260327-dts_enable_nic_mctp-v1-1-5b5c05f4442c@amd.com>
References: <20260327-dts_enable_nic_mctp-v1-1-5b5c05f4442c@amd.com>
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

Hi Andy,

Sorry for the delay.

On Fri, 2026-03-27 at 14:59 +0800, Andy Chung via B4 Relay wrote:
> From: Andy Chung <Andy.Chung@amd.com>
>=20
> Add the mctp-controller property to enable frontend NIC management
> via PLDM over MCTP.
> Also add EEPROM device for NIC FRU.
>=20
> Signed-off-by: Andy Chung <Andy.Chung@amd.com>
> ---
> Add the mctp-controller property to enable frontend NIC management
> via PLDM over MCTP.
> Also add EEPROM device for NIC FRU.
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-anacapa.dts=C2=A0=C2=A0=C2=A0=C2=
=A0 | 67 +++++++++++++++++++++-
> =C2=A01 file changed, 65 insertions(+), 2 deletions(-)

Do you mind coordinating with Colin on this one, as he's rearranging
the Anacapa devicetrees.

Cheers,

Andrew

>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 221af858cb6b..138b081be049 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -584,38 +584,67 @@ eeprom@56 {
> =C2=A0// R Bridge Board
> =C2=A0&i2c10 {
> =C2=A0	status =3D "okay";
> +	multi-master;
> +	mctp@10 {
> +		compatible =3D "mctp-i2c-controller";
> +		reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +	};
> =C2=A0
> =C2=A0	i2c-mux@71 {
> =C2=A0		compatible =3D "nxp,pca9548";
> =C2=A0		reg =3D <0x71>;
> =C2=A0		#address-cells =3D <1>;
> =C2=A0		#size-cells =3D <0>;
> -		i2c-mux-idle-disconnect;
> =C2=A0
> =C2=A0		i2c10mux0ch0: i2c@0 {
> =C2=A0			reg =3D <0>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> =C2=A0		};
> =C2=A0		i2c10mux0ch1: i2c@1 {
> =C2=A0			reg =3D <1>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c10mux0ch2: i2c@2 {
> =C2=A0			reg =3D <2>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c10mux0ch3: i2c@3 {
> =C2=A0			reg =3D <3>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c10mux0ch4: i2c@4 {
> =C2=A0			reg =3D <4>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c10mux0ch5: i2c@5 {
> =C2=A0			reg =3D <5>;
> @@ -661,38 +690,72 @@ i2c10mux0ch7: i2c@7 {
> =C2=A0// L Bridge Board
> =C2=A0&i2c11 {
> =C2=A0	status =3D "okay";
> +	multi-master;
> +	mctp@10 {
> +		compatible =3D "mctp-i2c-controller";
> +		reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +	};
> =C2=A0
> =C2=A0	i2c-mux@71 {
> =C2=A0		compatible =3D "nxp,pca9548";
> =C2=A0		reg =3D <0x71>;
> =C2=A0		#address-cells =3D <1>;
> =C2=A0		#size-cells =3D <0>;
> -		i2c-mux-idle-disconnect;
> =C2=A0
> =C2=A0		i2c11mux0ch0: i2c@0 {
> =C2=A0			reg =3D <0>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// FE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c11mux0ch1: i2c@1 {
> =C2=A0			reg =3D <1>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c11mux0ch2: i2c@2 {
> =C2=A0			reg =3D <2>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c11mux0ch3: i2c@3 {
> =C2=A0			reg =3D <3>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c11mux0ch4: i2c@4 {
> =C2=A0			reg =3D <4>;
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> +			mctp-controller;
> +			// BE NIC FRU
> +			eeprom@50 {
> +				compatible =3D "atmel,24c32";
> +				reg =3D <0x50>;
> +			};
> =C2=A0		};
> =C2=A0		i2c11mux0ch5: i2c@5 {
> =C2=A0			reg =3D <5>;
>=20
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260327-dts_enable_nic_mctp-e35a5765b176
>=20
> Best regards,
> --=C2=A0=20
> Andy Chung <Andy.Chung@amd.com>
>=20

