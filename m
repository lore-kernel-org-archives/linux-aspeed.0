Return-Path: <linux-aspeed+bounces-3502-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F34EF070F
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 06:25:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8ZSG2Rq9z2yFm;
	Mon, 09 Feb 2026 17:25:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770618318;
	cv=none; b=eJ2FpFForOiQEs00hNhVMg604cf2lvxmD+kuzvfharMHwzljrleGW5UQP4LiK7ufIg28UCXKMtQAIJbSgMjCcNOBHzvy349r2dlC2Puv+xAHdjHAcHuUw+ULf1ZTkhgErVecwc9sVcECG1fbgTRiP7RHn4AoitNieN7tH+hc5W//Q1CqP4sI3SIsdKGW9fSWXDJdNYjioRiKXToHSGK8gciI2qq9FZdd5OgJ3rRBk/oiWdeC7Fe1xbj3S6TVGW1SoIy8MQoZXmV2i/ksKXVv2dUvMh9i37P6lz25CKG4rinvswyyoPAjcmUkJ7xNqrPkMT8kqhI8koCHOWs4IOVetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770618318; c=relaxed/relaxed;
	bh=ar3F1SrcFnyPVG6bOtSIkfRJ2etxte/LoL65GWVjh94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJxL94tdQm9YZ2n5/Do9RZFdb9Feragtrl1bqb8yVR08MIV9xhEEMKmpMO2cVLSnLdS3FBZO9WDtWTJ+1aKG8ZdwMvckXASX6YdskQ43WdowAgoRIe7CVgktkWZ6AYM3nzvnFg9QM5xnyXjiA+Lx8iUBy/1ojwDQB4eXG2fxlzywMML3i7TQeGan1pTt0bEoT7ImEzPPebch76OlNPGROhVya88DdLna1lWOgJcWUBzQ5h2/Tg2azot2l1eRiTZKyO1CWXR/PENS57Y7DFA66DbfPfrFiQ3CUEruavb4HbaQjtnX1BGDVpwJUWsSu19oySr9WuIgkiDAMVy9q9nTpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MXWof2kq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MXWof2kq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8ZSF69Wcz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 17:25:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770618317;
	bh=ar3F1SrcFnyPVG6bOtSIkfRJ2etxte/LoL65GWVjh94=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MXWof2kqJdIPkCMc8mZqPulb9S9JC1cV/ocb9l1kp9btkGnEmlD+Nz3gC1ndKB2Cq
	 M2+I/vK2aHNX4mob/8BnKf6AC+joemHdoj8HHO5AKLxfK5VLU2EJIG/r3dSABGfz5/
	 LtvmOuHZeyFrRh963yLUjfbQpVqGqRzot0Ef5UsFAH8mPzNjd2HKspBuL0i/G9N8W6
	 jZjdFGwZU+WQUR/TC2+yjOIwAoMkhWOTTuDNr5q6bMMk6EFZyKSiKUTHWvsxnuvmSg
	 QTrCp50w3hLEf2C84BhnAtrbG84RmY0QREFLKW2OHnP85SDSh9aKikYHTKTfrMEZAj
	 qymy2AyvFNOXQ==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B3A84602DE;
	Mon,  9 Feb 2026 14:25:16 +0800 (AWST)
Message-ID: <963194a5e7e88ae8ae1fe367d34d2fcdc329d814.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 4/7] ARM: dts: aspeed: yosemite5: Add ipmb node for
 OCP debug card
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Jackson
 Liu	 <Jackson.Liu@quantatw.com>
Date: Mon, 09 Feb 2026 16:55:16 +1030
In-Reply-To: <20260130-yv5_revise_dts-v4-4-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
	 <20260130-yv5_revise_dts-v4-4-4d924455f3a7@gmail.com>
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

On Fri, 2026-01-30 at 16:20 +0800, Kevin Tung wrote:
> Add the device tree node to enable the IPMB interface used by

Here in the patch description you use (capitalised) "IPMB" but in the
patch subject you've used (uncapitalised) "ipmb". Can you please be
consistent and use capitalisation for acronyms.

I wouldn't normally mind and would just fix it up, but I've other
feedback on this series and have fixed the same problem a few patches
already today, so it's a growing source of irritation :)

Andrew

> the OCP debug card.
>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 7 ++++=
+++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> index 983aebc394d9159c7e3db2e7c39e963f7b64c855..84d3731b17f7c7c87338672bb=
cc859de2b89b722 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -365,7 +365,14 @@ i2c6mux0ch3: i2c@3 {
> =C2=A0
> =C2=A0/* SCM CPLD I2C */
> =C2=A0&i2c7 {
> +	multi-master;
> =C2=A0	status =3D "okay";
> +
> +	ipmb@10 {
> +		compatible =3D "ipmb-dev";
> +		reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0&i2c8 {

