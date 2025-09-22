Return-Path: <linux-aspeed+bounces-2309-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC23CAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 03:36:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVTKq3vQKz301K;
	Mon, 22 Sep 2025 13:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758512175;
	cv=none; b=lpPY9iLuUc+xsL7QXqpKk7daVHRiMbvFaa0d7769tDvIN9RGe6Ng57RnFJS/f1AWHaQhg96qeiaZPPJT45uXVpJToZ0zZqou+tbyjCQIINxDuoUI93Nl75T0XzuKlmqAgrJCqHRE9yrp3JsxljhYq3coVZZ+1ZNQlx9v02taHTsCARtc6q+vRcI5rgqgiMp/Cf+uCgqLKDSdsXC8f0ddlUXyEd+suPaxmE8B0KiXpQFUpm/05gCmICE3QDIDx/SqGKqGHTpiUveQfx4y/le1IqKPFL6SxxEr5jqcdSRJ0maBAyd63zXDPxU5mzv5200i9UteLusEm6PcwNTN0m6gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758512175; c=relaxed/relaxed;
	bh=C/MA4CH24q3vH1Fg6NkJo5567qQeBbiW70Nn6q7iLP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyCptCPfIc+XzmUgCF1jHyIhgCT/5rwn2ogI/0vCF5qoGZ1s6tavB7gLnWkoa03rYih5JZgcr3gMJL6DLLgi1z0lCvGsO+PDLql8Hs/jYGzvQFrnZpKyBoYnVFOYhIOK+ikl74VCxp0JaCiE6BbprqOju3V+Kw9i4Lcq0j2RGWSg5p7vXla7hTJCdMRT/+lIby/+Gq9pS7bu44GquPvKEa2HOPn55lM+EMmcviQvuluLhg35d4/z+1/J8JByoWkuRLz0YH7gBK4rxAyVthhA3cShPb7AJI1qpLmkMkr5fUygEAtrYI8zmUzLCaQJQKY5pXmaXXeYY2M1Bn4IaKB8lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PhyVxSFc; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PhyVxSFc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVTKp6H4Gz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 13:36:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758512174;
	bh=C/MA4CH24q3vH1Fg6NkJo5567qQeBbiW70Nn6q7iLP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PhyVxSFcTfc9Oo8dueczD60UiCANixn9E8qDfta9Ku/liDAwjXHVuX3vQnnsTrXJW
	 5ERAGjnfO5QiF0Jp+/d+0eK7IkwlFFCLbVlmAH4ahig3H73iQNgxAh67w+RG7UXo5M
	 3/9PtKiRLZiMgLKMCL9hnaEpr24Lf0eAZ41/oNFvHbezOxv9CFcTXWa5sU0jFQZqJc
	 L7XeCPEYyCbS6BDYCU63Sz662dbCACkN/l2TF0WT7KCCbVN8o8OsJCpTlyvdHG3zCU
	 us2wfYniNkbasR1sd6zDXKfcGK5+X/Od9nSaaB/AFZukn6uuE4jLfAtm0OoccZYxkS
	 89Hsty8AkIDBQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B4D2364755;
	Mon, 22 Sep 2025 11:36:13 +0800 (AWST)
Message-ID: <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power
 monitor device
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 13:06:12 +0930
In-Reply-To: <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
	 <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> Add the SQ52206 power monitor device and reorder the sequence.
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-harma.dts=C2=A0 | 28 +++++++++++=
------
> --
> =C2=A01 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index bcef91e6eb54..fe72d47a7632 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -353,14 +353,15 @@ eeprom@52 {
> =C2=A0		reg =3D <0x52>;
> =C2=A0	};
> =C2=A0
> -	power-monitor@69 {
> -		compatible =3D "pmbus";
> -		reg =3D <0x69>;
> +	power-monitor@40 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x40>;
> =C2=A0	};
> =C2=A0
> -	temperature-sensor@49 {
> -		compatible =3D "ti,tmp75";
> -		reg =3D <0x49>;
> +	power-monitor@41 {
> +		compatible =3D "silergy,sq52206";
> +		reg =3D <0x41>;
> +		shunt-resistor =3D <500>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-monitor@44 {
> @@ -369,16 +370,21 @@ power-monitor@44 {
> =C2=A0		shunt-resistor-micro-ohms =3D <250>;
> =C2=A0	};
> =C2=A0
> -	power-monitor@40 {
> -		compatible =3D "infineon,xdp710";
> -		reg =3D <0x40>;
> -	};
> -
> =C2=A0	power-monitor@45 {
> =C2=A0		compatible =3D "ti,ina238";
> =C2=A0		reg =3D <0x45>;
> =C2=A0		shunt-resistor =3D <500>;
> =C2=A0	};
> +
> +	power-monitor@69 {
> +		compatible =3D "pmbus";

I realise you're just moving this node, but I'm surprised it hasn't
caused trouble otherwise. This happens to work due to a quirk of I2C
device IDs in the kernel but it's not a documented compatible.

Compatible strings need to represent the physical device. Can you
please split out a patch either dropping this node, or replacing the
compatible string with something appropriate?

Andrew

