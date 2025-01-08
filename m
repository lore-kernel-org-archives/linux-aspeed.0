Return-Path: <linux-aspeed+bounces-364-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47AE77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 16:38:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSts71ZlJz30T2;
	Thu,  9 Jan 2025 03:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736354315;
	cv=none; b=CxMUb5+yukWlrdWDqk7FDazgBg5+tE8bTeViMcYky/obbvHDmflT87yjxQy7wllybhbIN2dS8omGqCv0emTwVrq6LCDeg/MxEgMd9Agsl47811toPgQieRoAM9E+YOOhfrsFEy0VDSh1xKeLnWBLYKhzmlodfyfutK99NsixaIvcnizAKHIXz2nFgN0W85eOUmZy48Tf4EZQrn1AhRnJbAniGm/HJZC9g8IFasrU9ttMf0rN8U9zJ3BmdR8XvUEsDiW5Ur+NA5Ppz3GbqQnlSYVDFJnxvW0BAn6DbmO+OCYqS9xLf0stpwbrJYDlGgbr8BKoWkwIbtt1DGvngSYqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736354315; c=relaxed/relaxed;
	bh=4cuSrltjvkzxAoQOtMu4WRHfXq6bp8x92iDHnihbR3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIhZliiZIcziu/Jdfi8TEcyFqk4uEOqEy8HRZ53b6rRZx40dIYzc9qTqGDDdzQ7oidRvmTQ6uqGi746/D+VSD9hGKxiDR5rmXOHpgz8akhhVwWA4F+xtCWlBsjhwOR5zbNu85DMKhtC0KGyrP5W1jngaD8ajz+D+TByAxA1LzTslIzumnwlEbtcCnF2pC1xEnYe6xGAqAvArU7ydmjUW1V+iMJqGF39xxQqLBqP8FJ2kQXvOuv1iVXAJXS3V/03aDUr85wSP9Bi1LUbIfVH/QGvx0+HPOFDvbdOTbT1ZV7/pWXORv27hT4uUZrHHipRCE48S31kUZfTVUII8dcjc3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JfMlJLcm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JfMlJLcm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSts52MtXz2yNs
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 03:38:32 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-386329da1d9so8030540f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jan 2025 08:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736354304; x=1736959104; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cuSrltjvkzxAoQOtMu4WRHfXq6bp8x92iDHnihbR3k=;
        b=JfMlJLcmWObjqGzsDvb8I0FM9100GJw4JbFKJ3p+dl3Zd7bT1QwP8K2/FlTc2nD53M
         X09WcUEaMFx8sVKizfPdMBGidpMuqSl605M1xZaucBpLwNf1HIf6btcO+kMd5B8bXIMM
         rriXDd3xEQKGKNbvyrJb2WsJzzUekhG4zXB5MBfSXrcSGZ8V9yRcyT0Y6la6sYLizGfg
         Gd1bY/sg0zIXKG4wgawqioVOZxDYf9wE9aBlOQeVuT9e7nEp3K65Xz5MldSGCAIOvifZ
         FsL9/Z18FyKCdUT2dMP6RFanNcmepsvPSdKNIC8bAxgnovTzZcJSbjZ6FVOFFbYn5IGJ
         iBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354304; x=1736959104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cuSrltjvkzxAoQOtMu4WRHfXq6bp8x92iDHnihbR3k=;
        b=Xe3d57mnqf8WNrT+44eBIqYH75+LaUWIqeobnn6FsC2y8Cl/LqiurNMiEe9SRqcP9P
         iaFWUTUYP6T7xNGp7qzcVAQUqUVdvzEi8WWM709iexDWm5mwCk1SPxJOpDarrmLHotwZ
         qMmc6FjFwWbJEiFOMsGpcv95y522LwfhfQBpVJ2yg5SAtjBAQcV9KMTOJ2X94NsuS4pM
         LP0l2xr4TTB4rQjhFLA02SWsTJgXPGSe8v1qKjvjmeFYA8PahGsvXDo8XTverzV9D7+B
         gXGdfXN5u4BNqOz4JC2pXm9GW5XamQqdaH4YN87waJmz79WvkXXFzEY46Az+xjB7jIBT
         +TmA==
X-Forwarded-Encrypted: i=1; AJvYcCXvICbxueffhxIMihQasx2z0n8OObUPS9qeBpR0qpbeNIjxefhuyBKHfVWkzrVmIYaA65PXJO2e5ad5r+8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXFD7mzZcaLaKfksTb3Jqtlxlh/GiPK+lS4D0e+UCakbpB8SoW
	V25KJRNBVyxuk7S0Bx4BfWkCYRjkLa9Ong4L6ZjbOmghc8oVvcSL
X-Gm-Gg: ASbGnctAqfpWhqE3vewcpOHrG3Et9meurPYzrRhEVlNxoTjuBcrLt9CGmHcfxJu13mM
	7rjJzGZhibsIqB5d70YUdzP7iRL7PzkG1OP6IXJIIvO/Z0udIB72pK2wLwTXEhKcP5K7wqCjEbe
	PfK1O+k7Un5H1ORyvzWb+8eLtuMjevfHR5N9+QGNvvGRAO6ximSm95zpROiDXUKmEK6H4zWjdU1
	I6fWLqYKDprkKAFRaDDwofqw82mIAsN0ECsNNC1nakoeWzSvr5jYkXYsfahgotaoVQYAwJ+Nea1
	YcOgwWNtIcsjn4k2ngLHvZUdrdtdKOo63nsYF0Jg4UU=
X-Google-Smtp-Source: AGHT+IGp1cgCy8Xm3K9YW0ye3mjPWJQZ9C81gUBXymA3f6FFEe37p3slvzHvRuRGSFy39baH4a7Gig==
X-Received: by 2002:a05:6000:184e:b0:385:f560:7911 with SMTP id ffacd0b85a97d-38a872c93e3mr2679293f8f.10.1736354303999;
        Wed, 08 Jan 2025 08:38:23 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e22767sm25890945e9.39.2025.01.08.08.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:38:23 -0800 (PST)
Date: Wed, 8 Jan 2025 17:38:20 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Justin Chen <justin.chen@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Benjamin Bara <benjamin.bara@skidata.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Del Regno <angelogioacchino.delregno@collabora.com>, 
	Tianping Fang <tianping.fang@mediatek.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
Message-ID: <uyld4j6frger6oe332c4i32lkk5ue7ifrhu3565lrcn2xwc5xc@hgfyaryobqz2>
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5borij4dhzmoodud"
Content-Disposition: inline
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>


--5borij4dhzmoodud
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
MIME-Version: 1.0

On Tue, Jan 07, 2025 at 02:10:13PM +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 40 +++++++++----------
>  .../devicetree/bindings/usb/brcm,bdc.yaml     | 14 +++----
>  .../devicetree/bindings/usb/cypress,hx3.yaml  | 24 +++++------
>  .../devicetree/bindings/usb/dwc2.yaml         |  4 +-
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 20 +++++-----
>  .../bindings/usb/intel,keembay-dwc3.yaml      | 30 +++++++-------
>  .../devicetree/bindings/usb/ite,it5205.yaml   | 18 ++++-----
>  .../bindings/usb/maxim,max3420-udc.yaml       | 28 ++++++-------
>  .../bindings/usb/nvidia,tegra210-xusb.yaml    |  4 +-
>  .../bindings/usb/renesas,rzv2m-usb3drd.yaml   | 36 ++++++++---------
>  .../bindings/usb/renesas,usb3-peri.yaml       | 24 +++++------
>  .../devicetree/bindings/usb/ti,hd3ss3220.yaml | 38 +++++++++---------
>  .../bindings/usb/ti,tusb73x0-pci.yaml         |  6 +--
>  .../devicetree/bindings/usb/ti,usb8020b.yaml  | 20 +++++-----
>  .../devicetree/bindings/usb/ti,usb8041.yaml   | 16 ++++----
>  15 files changed, 161 insertions(+), 161 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--5borij4dhzmoodud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmd+qfwACgkQ3SOs138+
s6Er4Q//VZl8qzubU2vGD+vYdws9AIeAPkYgq0YF3ngrrr5mGTubUKQ7Zz8JK///
i/3WJevwDy2USeH86kJMNE9iNo4IreDdz2QsYaZzAb8lArTFezDCTHJrqyBDniQM
OCCNB7QNsWqaUe9H6g4NpfD75Bwmhe114ywlB7hj3WzOVa/KTYF3TtE/Ktp4JdQg
MSVpkv9wmN3RIY09OVtpmgIjbJ+te1tQHALu405trlrtG6HtjSmcVGAdrA1U+A8Q
x+miGhfUBdnoXQehPW7PVLzMCqo92ToQPmsjhRgKVMNixRqDJlLHhTICIuaNgtFB
KnO3meD4Z9Tz5H+ZXdRwIL6/HkCr5ofoqKll8Q0ihoDsq02auv7O50m078coyQv5
kyLOjhVr8e1BxNv/gQ1msux6UH3R7oOeB2Dz+tkzgheVbE4sbgsrxc0qA9smcB7X
G57z8Kau0/nZiUEKKsnleEhEtyNMfOFE+Jw1evYNp24D4OzykGpuaJfzOlG1Lse2
jGaqgnw5EqRNF85hVVOHXqVzZVVFQzw5gRoBBbbcsXnC9iYXdvmRWSMZzdBUEVto
vwTMpeMD4fFfQbxub/u81Q8800zwF8jow8+ivNd8cPJrzWznKDQRubvPOoTl+HZU
ODkzlPRv8vnNYUHt+Ug3/L00O6fTOdZ/+MtCX7hFZNA4Rde2Ewk=
=DdZu
-----END PGP SIGNATURE-----

--5borij4dhzmoodud--

