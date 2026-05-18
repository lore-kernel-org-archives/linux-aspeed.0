Return-Path: <linux-aspeed+bounces-4068-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75CCD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 12:44:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJyDr5t2Hz2xpn;
	Mon, 18 May 2026 22:44:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779108284;
	cv=none; b=bdTlwkldKHv5ux6g3wPSOhjp3Pwn3nAlRtxfMRwPqph5N+ibSdqQ9z2LO/T8zDORUa+U6Cf6Jqni4ymE7ReOdS/tt14XJR0Qcsyg7OnOId+QSBbTB+ma1Xv6gGTZtdMT+vy0D8OUysT8byLblWYAYNn4wcdl+HHHfwMQVaiow7GEDIroWeH7d561EIEM+eVTWIrt+HbPJ6WLhZ/lSo7jTOAMEaPeJVedEwS5FNPf/r8X/nZZmu7Qz/IqRC2BhaM4dB/dUh7EclOm6XZTIcjhg1NkCVUSDkQttc8vtj0E4mUv0KUcUT4EzeSP9ciAD3I4mk3aKw2kcWHtNcjPkdA0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779108284; c=relaxed/relaxed;
	bh=4IF51GdbnS/AbW4GBneN2UV/oYwSAiI9JfLmhOXBoDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RonPcXXAxqkQxPcMWABch5lPVcF5I3NlVM3+6sthtX9soUtgthohJeDIFdj58ESFbA0P/pdDKOUX9YvOF+LR5wnTsMEYRFgPqsvt8FcOLXLMNkcBebvTxH6yCMLw4j81SPbTQzDPNv/Xm2mkncUkfqQRN+o7kOtZlMsn6RGmrQrY1p5Vicp62lEg7+EV+yMcMV5LcnUnFHqAgVHf4RVBNr7A02wR4SL0p+VT1oEf8ljlJCrn0R5SXa0i5Jd+p1rqMcfa3WCb5hlf0DzTMXxXSR3Sj9FFzwU+NzQ6eGxI3GIWBrCID2kcD1KV4UTSiZtqjT4S2F0W3FmQLZ6No2JhTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BDt8C0Ok; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BDt8C0Ok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJyDq3wLHz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 22:44:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779108282;
	bh=4IF51GdbnS/AbW4GBneN2UV/oYwSAiI9JfLmhOXBoDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BDt8C0OkBSQcnW7/1xvJxhotX3+2n13X9/gHnD8iePUW5e8BDgq81Zdm6eMVPKCzx
	 2VP2XstaaU9gPDQjOGSoYRaVkiBdKqvM2sCiTja6tpkG2pxgFfe723f08OKT77mr5o
	 SPZZo2Unl4aF1PF3y/ZrgpmeFxeTEh3Q8/yEmY58IUYTtp9DrM6oXbnmkUOmH3yucC
	 FO03HryBi27TwBpJAMmfEytSz5Cc92qtC/+wpPaqiCiG+If1uK0rkfHaCrPqU1bv81
	 crWRZ9S6uf61g6pGVlNcYh6Tm8OqgBZDXI8M1nC9arzCQC6EubuffZFuOKmjLFIc7/
	 /Uc53lejPZH5A==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 638D36025D;
	Mon, 18 May 2026 20:44:42 +0800 (AWST)
Message-ID: <64ab943e8874bd5ef22c0f1a19b7d89daea83a9e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemite5: Add MP5998 power monitor
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Daniel Hsu <d486250@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joel@jms.id.au, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Daniel Hsu	 <Daniel-Hsu@quantatw.com>
Date: Mon, 18 May 2026 22:14:42 +0930
In-Reply-To: <20260331120734.39260-1-Daniel-Hsu@quantatw.com>
References: <20260331120734.39260-1-Daniel-Hsu@quantatw.com>
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

Hi Daniel,

On Tue, 2026-03-31 at 20:07 +0800, Daniel Hsu wrote:
> Add an MP5998 power monitor used to monitor the power consumption
> of the Paddle_P12V_HSC rail on the Yosemite5 paddle board.
>=20
> [v2]
> - Describe the purpose of the power monitor
> - Remove software/driver related description
>=20
> Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>

I've applied this to the BMC tree. However, in the future, the
changelog for the series should go underneath '---' below, so it's not
included in the commit message when the patch is applied.

Andrew

> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 5 ++++=
+
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> index 2486981f3d6b..6287f80d70d9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -422,6 +422,11 @@ power-sensor@45 {
> =C2=A0		shunt-resistor =3D <1000>;
> =C2=A0	};
> =C2=A0
> +	power-monitor@46 {
> +		compatible =3D "mps,mp5998";
> +		reg =3D <0x46>;
> +	};
> +
> =C2=A0	power-monitor@47 {
> =C2=A0		compatible =3D "ti,tps25990";
> =C2=A0		reg =3D <0x47>;

