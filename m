Return-Path: <linux-aspeed+bounces-3506-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3F2EF06FF
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 06:50:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8b1m5qvyz2yFm;
	Mon, 09 Feb 2026 17:50:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770619852;
	cv=none; b=ClRCsRqlVP/S3woGEa23p1gYd2G0zU6elZ02nxHdkPes6d+qWsiCM/XVh1qHB1s5QgzluvPhJCjQW2mALapHkY9pegz3jcPhx4s3QVsEedQPKEZMUlnXtDTg5+Gg82dds0Pk56ooL6f6W0GD3EzIpPZG8Ui0CbiJBEVR0iUlpkNPjCkBZC/lmuRLTI0em0n+yThC3Y7ZJ/zO4PlHjy1aFw2vMzFox4YCODE1Ob6h8wCHDB7jhBfTqZg9Tjx06qOs4WFVvV/J3k2eKtTwn8wFkwksoGSiSqV/ivD+BNBaIFecn5iyxR5Uj2VWUekTH7WW83Sfe2DLDpImLbTLRtDb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770619852; c=relaxed/relaxed;
	bh=poCMUc6ncGDkSxtBbaNgSNy0CoVls03/5wrD6+V4Erw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q8GhtK5rxsdKPzUju4qEjkOHnRJAyvCyWF789cKgi8KpjfjgCISNz6yO8hYnB2o4Co6M7cIyTZdOTfMUWOYTTKRU1J3/N6GGGngculval+9QGnOSwPr7HbtK6Rk/PM8dYqqG9oq+pfHuIeieWHzmZ+gSl2jtNWKfhhHFurypB/sl5T8OFBqPQQHSUuWQmx6DI0kjt8fwGaxrdJncFUyQcnrkJXm0yruCNS0aCNHfvdHKJvgj1d8VVlRjk6m6TnOpKJQAY7VOMWQI/avZc4+WAB2y2rTXern8ZzRg6gvp6yGbAxXDODs5bshV1iqdHCJvZaieFB+Stsr4D/LbyGOltw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O54HLMzR; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O54HLMzR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8b1m2MVBz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 17:50:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770619851;
	bh=poCMUc6ncGDkSxtBbaNgSNy0CoVls03/5wrD6+V4Erw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O54HLMzRquZ8qKT0tjg0p5jbTItro6bjE/LGtpFHgxUinpjAojCiHCcFlJfOnyG3s
	 96MRyX51rypqhITZbn0jgNmKHsLCvEIyKEGAwLyMiG3IpqtP2pMQhrAeOa/VDSfaTe
	 Zsc8rlnnKE1Vl2Ua9AdSr1P0BOrltYHCisHca1BldzxM+KMVVqa6ZVjnzMTaBFNcos
	 2aJ6AKRUSVMa6m3gjvQr2tUQTI1e4TrURYzrkiTe+2r820MwXSN64YQ26+JHp8TjcQ
	 08tWfAg7FnZYmLoxTWiyKsVtTzXTxfMNyMGC8J3e30OuL8T1y7cxJSfsLCZi+ja1Cc
	 r4gkrU3gdHeag==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5E95B602DE;
	Mon,  9 Feb 2026 14:50:51 +0800 (AWST)
Message-ID: <324adcf0cbf87ef1186c70f09ab0e0ee2e29017c.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: dirkchen@amd.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Feb 2026 17:20:51 +1030
In-Reply-To: <20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com>
References: <20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com>
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

On Mon, 2026-02-02 at 10:29 +0800, Dirk Chen via B4 Relay wrote:
> From: Dirk Chen <dirkchen@amd.com>
>=20
> Add Atmel 24C2048 EEPROMs on i2c0 and i2c1 to support retimer
> configuration. Follow the same compatible string usage as the
> Facebook Harma platform to maintain consistency across Meta boards.

This description seems surprising.

Does the change reflect the hardware or not? What's the significance of
the consistency comment if so?

Andrew

>=20
> Signed-off-by: Dirk Chen <dirkchen@amd.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12
> ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 221af858cb6b..b8d248d99d7c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -328,6 +328,12 @@ i2c0mux0ch3: i2c@3 {
> =C2=A0			#size-cells =3D <0>;
> =C2=A0		};
> =C2=A0	};
> +
> +	eeprom@50 {
> +		compatible =3D "atmel,24c2048";
> +		reg =3D <0x50>;
> +		pagesize =3D <128>;
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0// R Bridge Board
> @@ -362,6 +368,12 @@ i2c1mux0ch3: i2c@3 {
> =C2=A0			#size-cells =3D <0>;
> =C2=A0		};
> =C2=A0	};
> +
> +	eeprom@50 {
> +		compatible =3D "atmel,24c2048";
> +		reg =3D <0x50>;
> +		pagesize =3D <128>;
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0// MB - E1.S
>=20
> ---
> base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
> change-id: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c
>=20
> Best regards,

