Return-Path: <linux-aspeed+bounces-2980-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19318CFA466
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 04:42:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFCqJ5TMTz2yvN;
	Mon, 24 Nov 2025 15:42:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763959356;
	cv=none; b=L7IjdIqjNtye8pQL0xWoBeqLBzPZZTIX6WNf2tne8cDqWm00HWQ/8Q0m6n7m1IlGpDxzZUdZk0DIWQy1f5UyhA0JWmWGYhVtOmy+G5ZpkP8gMTBXASNuaWhyJ1JrzCzglP4kghZ2+3y2Ix3V2kigw12LT8jhVXiSLj53dPatzbvSXPWWatw8AQFGhrcAs+WqCHniA5FJdyWFyZ48K9ogP1VGb9vg5+VecPKxSQ4jj+mlQoaw63QY6T++0oUkXGpy7kuyZghSYfS81Eo12simL0UzdNMx6yeszZUUbfB+jM5flyhGR88a2eFVk4no+PeneptYQNA/o6qJBWC2T218BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763959356; c=relaxed/relaxed;
	bh=eBpV//B5/NrI5cFXQWjvu27goLCCU45mxVcrKziYGBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1DpUGLKdnGEBb+ug9XAHL6e9Jvg1UG2f9lVqaA/lW44oUOlxSJrLXcJ5p5Nnwb73RGy5gvUN4Yg4mL9fNXAX4vUkNhW/mlyF8yw/91kfSTBv13BYrpLUMhutXEb/Kf7XicJvYeMFvGAR73fxrw2VGr7MOKBAazzvS7kJMCs9BpBVnpfmKKO4WZDNHr+g1hB2LTjMal8ikHiux4WnrXiNXEms9BqkSlPM+UeVRiDB3ipKEnv6UrmLBVbVq7nfoKkpR5eyil0eyg93MlY7jqUnuRoF9x59Dbs34mfDwsq0EbicgGrRrPX/MWN/Ev8mZoFFeiAyLl2e1iBDSU8vWWLXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WcGG1lFw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WcGG1lFw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFCqJ1qdZz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 15:42:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763959355;
	bh=eBpV//B5/NrI5cFXQWjvu27goLCCU45mxVcrKziYGBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WcGG1lFwZTg1XdJb1dOLwR4NR8V2lH/fJ58owDwziziZw13fHygM/1kn3ovsQk/OF
	 MDocDJ/mWGRIOGURhH4ApGj/0TgfrHwGX17ps3IYchCAy+nUYlyxMSnvzmUZask61t
	 gT5jDzGlHsMhswidYWeCt2qX7uG+HzRuubOOk+PLJ2kQ/CE3B+FwlPldU8A75KMnHG
	 xSvbOssgQEtqSEjYJ29Jz/Kxm5Z09nKs4TpiOnB0gNuYFT1C91NXTlbsrujvVOuHNi
	 rVa046rC6YeVw8Ql3eVx2fxV4QH8cRuNDGNAvSu1ogfdgElDc7ZwkFAwLCDT//KfLM
	 ScnP3d7BQBf8w==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C1BB77BE0E;
	Mon, 24 Nov 2025 12:42:34 +0800 (AWST)
Message-ID: <ad11cd30eddc1b7c496cc92eef129eb5c0f2d604.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: yosemite5: Update sensor
 configuration
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Mon, 24 Nov 2025 15:12:34 +1030
In-Reply-To: <20251118-yv5_revise_dts-v1-2-fcd6b44b4497@gmail.com>
References: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
	 <20251118-yv5_revise_dts-v1-2-fcd6b44b4497@gmail.com>
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

On Tue, 2025-11-18 at 18:53 +0800, Kevin Tung wrote:
> Remove sensors 10-0040 and 10-0045 to align with the latest
> hardware design changes.

Can you please elaborate on this commit message? I'd like this
description to be much more specific about revisions of the hardware
design, and why you expect all instances of the previous design to
suddenly stop existing.

I can't imagine this is the only hardware change that occurred. What
other changes are lurking?

Andrew

>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 ---=
-----------
> =C2=A01 file changed, 14 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> index 7991e9360847532cff9aad4ad4ed57d4c30668a0..45b8ac2e8c65a4f672e645716=
31b7f6944f26213 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -674,20 +674,6 @@ gpio-expander@22 {
> =C2=A0			"PWRGD_P3V3_AUX","ALERT_TEMP";
> =C2=A0	};
> =C2=A0
> -	power-sensor@40 {
> -		compatible =3D "ti,ina233";
> -		reg =3D <0x40>;
> -		shunt-resistor =3D <2000>;
> -		ti,maximum-expected-current-microamp =3D <32768000>;
> -	};
> -
> -	power-sensor@45 {
> -		compatible =3D "ti,ina233";
> -		reg =3D <0x45>;
> -		shunt-resistor =3D <2000>;
> -		ti,maximum-expected-current-microamp =3D <32768000>;
> -	};
> -
> =C2=A0	adc@48 {
> =C2=A0		compatible =3D "ti,ads7830";
> =C2=A0		reg =3D <0x48>;

