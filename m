Return-Path: <linux-aspeed+bounces-2353-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81185CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Sep 2025 03:00:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZmCb67Vmz30MY;
	Mon, 29 Sep 2025 13:00:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759114843;
	cv=none; b=OSdirL9FxL63bzj7N0Q4gp2MCQqom7R9rbPuuGSnDhJc0If32mq34quLAJqpJmElLLvwoXVKt0wrv5m8OQtSmC6b4v1hXkTb+WYSMeVwdW9QY7P0+xzi3UcMCEU20OhX9yLZolDA0k4W+s+PhsViXjTrUqQpid5fuyr/fRwzxbaro9gzHpsdGRdspIntVVtoTpMTRKJ6z+3nsAHc8fsOJ6ARZBgByubnY5ddmKNYMLbJOZ6LuT04+jvKleXRF3Zle08JaVoyPySWOarXgMvhzMTVc3M02sDf26CQ3r9Oj/06lKOjALYtoqNSn8E/Q+ysovCslX4+RqtG8DKdGrQyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759114843; c=relaxed/relaxed;
	bh=3o5g8tvyc3D5BhQU0C72eF73whM2PpU8XTbC1Wbal6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InCoA/r220B+0Wcz8rFosI8a68rhyDs9rE5/OP19ySwVRSjyLamd4GVeyvR5V/ZQcfKi1yLvl+kTIeFgLOsEXJdALYnTHQNeQbzbXrZPZ4kaeR2ht+1JQDJOw7yY/fdl3IksyDu1xWeO10jz0cm3jwfMecBWWMvpgqr9mrM1C6I0YjtbaGYufJrcoj9/sfBHkBOPf7FYdq+4XilSw4YfWmjp9zb98KAT5mF8hDfvTYSEn86yIELoX365uYlmzX0d8h3q0HwUt4c556yCd4x4qiZPf/8KZvKvXUX8QiDpOzF2rbYHLvDGbxipCOUaByMi7OvTVoHKYmI8/NdCicxo7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HRLst9SK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HRLst9SK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZmCb2S3rz304x
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Sep 2025 13:00:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759114842;
	bh=3o5g8tvyc3D5BhQU0C72eF73whM2PpU8XTbC1Wbal6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HRLst9SKQFYHPBDXalgv2GH3AOBfYn5FtMoqylSFlM5xLd60OVnv2uYzoWw1eJWe1
	 3FC9W6TKr/wesqHqxt/JqmNJCgKAAzfXplAGDtStVKHvGn3KSe/mxQ13whXLUqAn+1
	 mBW7yxhnH9DkJxBmuEgjr3youMIAwnlpP4RbZh7BWmVfEEUvNKRawh5pqhebs1mP4m
	 qPUWq7H52YhYtewqIJzcTWDMC0C+dZcxglDyJ9EyOwgN9CSwudNN6CithFZ5FhK/lt
	 qn2DnrmVeyAiknzT873AhjSeWDyAlyvFfSCfaxCCXnfQeU4yobhhJWnU3h9SgfyfdO
	 SBOsRdItzNdbQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D51C964782;
	Mon, 29 Sep 2025 11:00:41 +0800 (AWST)
Message-ID: <deb2dda58b923f2ae362dc19164dc845c4757e12.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: Add HDD LED GPIO
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Mon, 29 Sep 2025 12:30:41 +0930
In-Reply-To: <20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
References: 
	<20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
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

Hi Leo,

On Fri, 2025-09-26 at 17:37 +0800, Leo Wang wrote:
> Define a GPIO expander pin for the HDD LED and expose it via the
> LED subsystem. This allows the BMC to control the front panel
> HDD activity LED.
>=20
> Changes include:
> =C2=A0- Add `led-hdd` node under the LED definitions
> =C2=A0- Name the expander pin "HDD_LED_N" in io_expander13

Can you please drop this "Changes include" section? What you've written
here is plain to see from the diff below. The commit message should
explain motivations, concerns and trade-offs, and not be a wrote
description of the change. The documentation on submitting patches
explores what's required:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

Cheers,

Andrew

>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 +++++=
+-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cd=
e44280468990c7a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> @@ -95,6 +95,11 @@ led-3 {
> =C2=A0			label =3D "bmc_ready_cpld_noled";
> =C2=A0			gpios =3D <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANS=
ITORY)>;
> =C2=A0		};
> +
> +		led-hdd {
> +			label =3D "hdd_led";
> +			gpios =3D <&io_expander13 1 GPIO_ACTIVE_LOW>;
> +		};
> =C2=A0	};
> =C2=A0
> =C2=A0	memory@80000000 {
> @@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
> =C2=A0		#gpio-cells =3D <2>;
> =C2=A0		gpio-line-names =3D
> =C2=A0			"rmc_en_dc_pwr_on",
> -			"",
> +			"HDD_LED_N",
> =C2=A0			"",
> =C2=A0			"",
> =C2=A0			"",
>=20
> ---
> base-commit: c65261717599d419e9c683d85f515d3ca2261549
> change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
>=20
> Best regards,

