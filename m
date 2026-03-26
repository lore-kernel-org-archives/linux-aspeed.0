Return-Path: <linux-aspeed+bounces-3783-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E94D109E557
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDKr6cyQz2xlM;
	Thu, 26 Mar 2026 17:25:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506336;
	cv=none; b=ZqiOgl9QVmiiIlxOejHOWr9bpDRnXgGdW3P/WKQKTXDF/fN8YldcE5aeFLrlWhzAI8GUzPIq5RU9JpTSKy0zP9xNn8EW1/vunvrCOgKBVn4TB88T/LnllTkJe+h0vk5E5tjBxYlKohyyWw3V9pl6IIoSC/G7lvYCXD7NeuMLGiBMLQm8JvjfAEueJVRcSJk7I0TA/NXoXR+c8xv6iznEMwT7wElhrH6Yts7Mogo5LAF6vmMT6TlvhuhcZ5ImzlAna+wZPQv0kAyhI3IrYsbp33uyW8m/VZVCNhdNAK7ot/F2/3Jnh6a1dHUFf/7d42duewjYAsInQDoOa7lxmZvfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506336; c=relaxed/relaxed;
	bh=qyl2tRm9hwQuxiJfS+7z0mBBb4tN3hi0dNEI5cPRQeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/B/2j69VTxRiPS6m6wF1zgNOm80Lwui8axii7RDthW8SDfyz+q924drdmBl70jR+W0QoBf+4xTMLtJRyDBO80ThYd9+h3do3l28KPK20rV4Rb+N1Akua5SO5OPKdWTNBetGr4QDBUhvgmwbLlMzYyTKUQ/rYrnRlkxOoVHV0pL5Hsn+Orn6es1mEHY76UVHd7wnZIisrZ8yfchzK+I6KtlfP8iT9n3jfkeuePgn3x5UJ0rWzsRdU1R+wV2S0ONrBeNwzm7oSn3+2fdJMmZxJBBwWBjmwLt6deyDmaGiVO5toXoCECcVaOTWH6azdAMUmh7oYAMwG8/8PtAeQK+z5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m2F1VRLu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m2F1VRLu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDKr1gJMz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:25:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774506335;
	bh=qyl2tRm9hwQuxiJfS+7z0mBBb4tN3hi0dNEI5cPRQeU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m2F1VRLu/z3h8YIiv7trbgAiAAm6P5Qmqlm2K8m0WMAkklBjdOHKK2qH+3jKOg808
	 87SnMIqU08U0frdGWu0lwmFPUhoe/efmKqSOtLbUtzQkqL3r8jrjZv1lPf+wLPqoFl
	 l+7v57m9JyoPSY8k0pua4Gz3vbWGjN92YBBw7Y8V6jqjNilu/9b5AJsLFetf3X3qqq
	 ABSANVeY/39ywVNSZb/QZxqE8zKty2pJ7Kxb03mXUy9sDhCND2xX8nw6cmQZgesXBz
	 zstN6KwZaLRvPieyfHtF7oQvWXP+3exgqvkPZAXUKgGuUVdMkQ21H2VoxdXfukWxqA
	 KunTFnm1d75WQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1AF006597C;
	Thu, 26 Mar 2026 14:25:35 +0800 (AWST)
Message-ID: <eacfdc8637a7e59457c3c7d29e1044426d5c7f75.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: anacapa: Add eeprom device node
 for NFC adaptor board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: carl.lee@amd.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org,
 peter.shen@amd.com, colin.huang2@amd.com
Date: Thu, 26 Mar 2026 16:55:34 +1030
In-Reply-To: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v2-1-91c7dde4b79d@amd.com>
References: 
	<20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v2-1-91c7dde4b79d@amd.com>
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

Hi Carl,

Sorry for the delayed in review.

On Mon, 2026-03-09 at 11:46 +0800, Carl Lee via B4 Relay wrote:
> From: Carl Lee <carl.lee@amd.com>
>=20
> Add eeprom device node for NFC adaptor board FRU.
>=20
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---
> Add eeprom device nodes used to store FRU data for the PRoT
> module and NFC adapter board on Anacapa platform.

This patch note seems inaccurate for the purpose of v2?

Doesn't matter too much in this instance, but should be fixed for any
subsequent revision. Which, speaking of ...

> ---
> Changes in v2:
> - Remove PRoT module eeprom commit since it is already included in anothe=
r series under review.
> - Only include NFC adapter board eeprom node.
> - Link to v1: https://lore.kernel.org/r/20260309-arm-dts-aspeed-anacapa-a=
dd-eeprom-device-v1-0-45092310e0e6@amd.com
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 2cb7bd128d24..69c41532fdfb 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -815,6 +815,11 @@ i2c13mux0ch7: i2c@7 {
> =C2=A0			#address-cells =3D <1>;
> =C2=A0			#size-cells =3D <0>;
> =C2=A0
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> =C2=A0			nfc@28 {

... these nodes are out of order.

Can you please order them by ascending unit address, as per the DTS
coding style?

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-=
nodes

Andrew

> =C2=A0				compatible =3D "nxp,nxp-nci-i2c";
> =C2=A0				reg =3D <0x28>;
>=20
> ---
> base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
> change-id: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b
>=20
> Best regards,

