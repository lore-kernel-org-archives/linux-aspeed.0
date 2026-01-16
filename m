Return-Path: <linux-aspeed+bounces-3361-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A678D4899E
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 12:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt08X2wFNz2xnj;
	Fri, 16 Jan 2026 23:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768567868;
	cv=none; b=BTl67SjTOPr0v3klfZjIcSy2FyK0V2LJeRrtfuQB2u9Xac6lm0zjbagC5J/G/c1lV5wF2zkxlPTMj/p0QYj8hsbeas5ryeeSusfSLfIUcT3DgNB8HFan/lqMBBgYSlklQssJsaInto33Zd5o6dZDLc0dx5zNVB6EWmSQhuZ0/fRMe77Germ0e/S1UlV/KFY7rS4q9UFZYhIqOffNvf6ipyA5UBI3XTcJMTJ74bX2/owFqvUm4lYJLzI9VIYXvxgp7YsiJbIvfqE9ekkwz919s0cP0RQN/NBqyzK+xrAVRuwIO2JdaHm0qTQqksZ4GEwY4LwrD4reMHUWOFX9y8xQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768567868; c=relaxed/relaxed;
	bh=zTkxHu8mh7w4aqi9Nu456ezpUXh108CX0ltHIeT0yH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmg2G3hTPMTr0q4PxcISWHuWs180m0SEoPu+2UpRidtkfz5wrQrGrIpKsCUf26N6jrfIdhqRfc7Wi/y8nHQmXmvRvUMOMLFcVP63/H3rC2CN2cBHlBQTyZj5skX8kq8+7EJszzerkeJmG9UsbLC7zXBPNskWxl7ub4BCjgDuW59eEZQ/lTl/l4z11ZP3eAPSgK9a7idHpBZF1k4K45ycDGLkHIeFy59Uadu/3qg7L9zu/9OHi0H4OaHsKaTx0pKw/uW+/45/tpZDvzxJfOu/z0f3I6PP/phtAmhFSLflROmwM/RHIk53UtbAtc4xs/w+JOQZ0FwGCIu5q/ELqLSglA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kF/+dBNp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kF/+dBNp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt08V5HQtz2xm3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 23:51:06 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so19247675e9.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768567862; x=1769172662; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTkxHu8mh7w4aqi9Nu456ezpUXh108CX0ltHIeT0yH8=;
        b=kF/+dBNpqBdTzgiUzJzwfRDDubDv8uQDKX2vvRK1TJQI7ZbQkXAQheMOaM6ZgidZ3C
         J9RlXg40fFX6xeuwqas4FDM2qIssiad8a4BTbWgChSjP0CYgGKUGAs3ZjtLsSAkHz1Kb
         xzww3Mb+j6uH5JqUFQZMRKN+zlmtjZgi1enCn3iXz/VqpcFm9x+Gg6frl8SWd/XJImhV
         ulljeDYHqPXdNUy+4bwF3l/ETnikPyFrIjU3rGVrAU42vnZ4wLoHigpDh3/yRvHEWHkA
         DTp9zRNkh3ps1bykxE6H0/ZIc3nNz2tiwpTRmBa/S4ASHr8kQ4TCQHztjS6HHgkb4sDR
         EEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768567862; x=1769172662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTkxHu8mh7w4aqi9Nu456ezpUXh108CX0ltHIeT0yH8=;
        b=A3l+gCy/iljPfDF+as1Qz68eECcAVbz4mlsQjzSwY3OeXH8l7XhNmYdGqB9ozTHm07
         8OCeFTjPmgU3F0SrrEs2FPgo3idS69cCQzYHI02WcqG60lCe4ZtN1cMfbNo1Z8cbrQoi
         KwKSbXzCQvStIxCAl+I/SvXK1UYY+XLHPUaXpPLZimmcG/Td64Vi4ky6dQ+XCOCK5B3s
         IF6rpPceBV2GRVHgZDX0hD8tVKWIYRh0dVpmEa6uDMpHtBCOCNfvEKQjdsKDjJiDfpeG
         Am3XbDAlUv5NUsBYak2KCUBtZo26iDolhEQNWuHfScZtRjve7Uh0DSF4epYgryYZRBRb
         ftzg==
X-Forwarded-Encrypted: i=1; AJvYcCUtGDFHd9muqeLrBRO43llgcRvt4bN1x6nPiFMObVqocnj1PRBF+9l1QpAB1ipn1m6QVgXyeIO4KpMTIUU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+cyiVpvlP2clDi6OnPv/m4mz9dnWuL6m8vh9DsRF6pilSQHqf
	bGKcBTJ5l+J++ciSqxt1vzRClTsdPqAWoixPSPgpvbnxbqm3r5tuPsCU
X-Gm-Gg: AY/fxX6yn7U/zeZMOfRXbFfvUM3GdIX843hJ/gp7XdKpC0UwDBb+8h++0s8Qk7t0eZ4
	ZVRvMBfZpsrp2AFCvnhAzYaJcjbG+lFETEGVDt/nC8BOA0kcEkYt70euT7qWGFb7w3yi3ZFyg4w
	2caidwPWwZz3lJC+oprFQEQnuSKjiPhK3roFQKgIshIE0atEX8F0ACmo40oWNgIIdoYFp/1FM5s
	+fLfYjw2aBZkjlt4WzEaK6Gw8NMGycHiRtWKtnPwOz8d3BM7UX4lyinAyHrC6ZrD2Tx48e8c4SY
	sE17hqVUMuQtQmccRgJactel18sEtekevWf78NdXdcDOuoPR4DSLJZI38d0r6ZkPSs3/DUTADKs
	XoNeqoc7Kg0EpSbGBYD92Y+RmInONHzCQ837DYXZFea1+446vvKc4bS/2HGWz8uHJWsuGXVLU1t
	8SKJ0gFgqytliEfOIVQftn5OqGfqGOhSCejVFmTVtsR/jPPmQqwIEUVYEnsTlT+c7970v7LcXM1
	g==
X-Received: by 2002:a05:6000:2004:b0:433:2f55:7cab with SMTP id ffacd0b85a97d-43569bbafd6mr3570766f8f.37.1768567861918;
        Fri, 16 Jan 2026 04:51:01 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb0bsm5012584f8f.34.2026.01.16.04.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:51:00 -0800 (PST)
Date: Fri, 16 Jan 2026 13:50:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jonathan Hunter <jonathanh@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 08/11] pinctrl: tegra-xusb: Return void in padctl
 enable/disable functions
Message-ID: <aWo0LESc5bIs1kHi@orome>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
 <20260114-pinctrl-cleanup-guard-v1-8-a14572685cd3@oss.qualcomm.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhhiv6s43avuu3l7"
Content-Disposition: inline
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-8-a14572685cd3@oss.qualcomm.com>


--bhhiv6s43avuu3l7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/11] pinctrl: tegra-xusb: Return void in padctl
 enable/disable functions
MIME-Version: 1.0

On Wed, Jan 14, 2026 at 04:30:09PM +0100, Krzysztof Kozlowski wrote:
> Make the padctl functions a bit simpler by returning void instead of
> always '0'.  The callers - phy init/exit - still need to return 0, but
> these are smaller function without if/branching.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bhhiv6s43avuu3l7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqNDIACgkQ3SOs138+
s6HKVA//WbWB3AVvEbOYpT8fr129RiWvQ5lRtQceA8fb/1Ep4k0qX0M5cVujq72g
OFie2IcJyCzuci1ZmKEf7fTaR/cjlzExIrXvmox2TLmtKm5kBAFTu2UcHzvAbRcs
VbasfUeQ/Wi7dlT6+I6JeNLYaXbstuH2RQV3NQ2BC3zPUsJk27p7DARdqBLUSNTJ
7jX2sBu0xKu5n0hrBhesTMi/zBLMI3pZvqmMlhGzTU01GSlmPz72GMI5J6YmeeF0
Midhy4ZCbs40l7nJPghjxdtQoKLhUPG6z+NzTyp9Hfelr7q/cYZ1avlAGkJ/39fI
ugJEOfjl0ed/HMarlvwrRPSTjF6f2BUKH1Ub2xGxErbhGaGvOsKGJizbjsK0CGzl
jdVsdFUF/wmzPeX27RIel8DxTdTYnhpUyZoylg7l9thjdhYGceKGJHeHb1DaOOZ+
OhsSUZlejccTbalvk7OeBxtnujGfE56nEXsSByA0C6kaDRxPZmsH9WWtp4mwIzXg
rvw2hOERLedWoFTjFynl0+3hazgw2hh21iH/uE+uOEiVwHNhPiEXeb+lJMGQbH/9
Bm2mL/1gvDYA3KxeFZbTTyNwEiGkZyPFLvwZ4hpapk8AvhFdEu/60sMZWsTRlSgx
H7CJIWp6MSs4e2ErCXbhjjucu3eJo1lFTm/bGVBosixPjjSZ720=
=VB+5
-----END PGP SIGNATURE-----

--bhhiv6s43avuu3l7--

