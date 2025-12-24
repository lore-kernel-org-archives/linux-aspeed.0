Return-Path: <linux-aspeed+bounces-3208-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274A7E75453
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Dec 2025 13:40:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbtKt2MN5z2yN1;
	Thu, 25 Dec 2025 00:40:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766583618;
	cv=none; b=AHQCp/oVYDWCbvNbjPlrYHr2A1XxTKn4VF5klhTkOSI8hurnQY8HEXGntFZOCgQsEe+vazZ3JzdfqHxd6UtSEvx1LMIs2VXHsSPFs/5erZR/A/0JXI34hOPCrFyz7fmeCHoIZ2Pt0XeaywprhsnMTw54pUI8TWokRev8h66v/ZexIjIbinfnsnHVKrgCH94B+Nungt+Q++Gj6zxhkQfY7dp6x0NKJQuPfsj+SbW/TB2H6W9iEHY/Wvz2O0mUvgDIM5pkWAsgNUGIKSD52e+Hti0fGQhKBlDJQz4tp6Nl46cS+oS1Gi/L2Zr+5VZAzJBziGkAZoJmXvuodE2Hx5LJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766583618; c=relaxed/relaxed;
	bh=xbu83KDb8EzV5fBCpVF9Ofv9QvuINTQfWgSaYI2v7SA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuZriQSuTbh6w6ScIAsYxPzSrnVy9zwvaqgNpeRjrL80Ty5c2CFkfI9cPh4FClmesGlPuNIdME9s4BWIbZadrLCkXCRlVigNfNJtHStSdQbAooP+MhlkBt7YD5c0oMajXphLQQxzP0uUQeY4kxhHCOxOgr2vah5lGKHG4DqbmO/XM2Li1uVEUDM2PfWmy9ntBgkuueRhNWYRVOX6PaDQET6y/SUSETO9pzrNG9WL20t0u9xCSiU2ZgkF1EFOOkk/w82G8xj0OsNMoRO5CUfBjjYM6RGsDDRGxaLyx9s+b7RtqzQmfc1xXRGF23Q5Ap5d/eda56L5ghhx52iOVe1bTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.a=rsa-sha256 header.s=mail header.b=DEHZIvg4; dkim-atps=neutral; spf=pass (client-ip=185.119.170.32; helo=aposti.net; envelope-from=paul@crapouillou.net; receiver=lists.ozlabs.org) smtp.mailfrom=crapouillou.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.a=rsa-sha256 header.s=mail header.b=DEHZIvg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=crapouillou.net (client-ip=185.119.170.32; helo=aposti.net; envelope-from=paul@crapouillou.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 487 seconds by postgrey-1.37 at boromir; Thu, 25 Dec 2025 00:40:17 AEDT
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbtKs300jz2yHB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Dec 2025 00:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1766583118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xbu83KDb8EzV5fBCpVF9Ofv9QvuINTQfWgSaYI2v7SA=;
	b=DEHZIvg4Ki+CGC9dPeVP65atqr2lD/HbbCKx2IgDAZyJ++LHBm6mGdJpLvqm1yVa6wvdCo
	e33UpVsAOyw6MNZnD9cFpL+K1heqU7rD5VAIJijN9F4mwjYwoixKdfDqpvXni9X7q/WsRp
	D55qOu5YZ0UXQidG7niJggEcy9NMSOc=
Message-ID: <e661a947f0cefb1651dcd3f7f57855313ad9fd7a.camel@crapouillou.net>
Subject: Re: [PATCH 3/4] mmc: jz4740: Fix Wvoid-pointer-to-enum-cast warning
From: Paul Cercueil <paul@crapouillou.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Aubin
 Constans <aubin.constans@microchip.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Nicolas Ferre	 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Robert Richter <rric@kernel.org>, Andrew
 Jeffery	 <andrew@codeconstruct.com.au>, Adrian Hunter
 <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-mmc@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	linux-mips@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, 	openbmc@lists.ozlabs.org,
 llvm@lists.linux.dev
Date: Wed, 24 Dec 2025 14:30:56 +0100
In-Reply-To: <20251224124431.208434-7-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
	 <20251224124431.208434-7-krzysztof.kozlowski@oss.qualcomm.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Krzysztof,

Le mercredi 24 d=C3=A9cembre 2025 =C3=A0 13:44 +0100, Krzysztof Kozlowski a
=C3=A9crit=C2=A0:
> "jz4740" is an enum, thus cast of pointer on 64-bit compile test with
> clang W=3D1 causes:
>=20
> =C2=A0 jz4740_mmc.c:1055:18: error: cast to smaller integer type 'enum
> jz4740_mmc_version' from 'const void *' [-Werror,-Wvoid-pointer-to-
> enum-cast]
>=20
> Signed-off-by: Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/mmc/host/jz4740_mmc.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/jz4740_mmc.c
> b/drivers/mmc/host/jz4740_mmc.c
> index 6a0d0250d47b..6a3c26b7c82d 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1052,7 +1052,7 @@ static int jz4740_mmc_probe(struct
> platform_device* pdev)
> =C2=A0	host =3D mmc_priv(mmc);
> =C2=A0
> =C2=A0	/* Default if no match is JZ4740 */
> -	host->version =3D (enum
> jz4740_mmc_version)device_get_match_data(&pdev->dev);
> +	host->version =3D (unsigned long)device_get_match_data(&pdev-
> >dev);
> =C2=A0
> =C2=A0	ret =3D mmc_of_parse(mmc);
> =C2=A0	if (ret)

