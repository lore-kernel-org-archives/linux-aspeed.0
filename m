Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2907606A31D
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HnGZA54m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDm890NHFz3bdW;
	Wed, 28 Oct 2026 09:56:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793094126;
	cv=none; b=W2WtvqumkQ4GabfUT0s6lg72bytC7SU7njK/eI+NJML84VOximel9FNqbDTJ8LsPVUQsOqDyezK/Da+x8hV8qxvQpPCcdfSKj4o57yYuN6gi7Y/xr1P4KtHg7aA9a4ULWArNOXTzzGe2mOEJiet4h36Th9SYOklLljaRPw9oPK3gWTkyN/Ireog3ygqx0HiqrTNDeRGAsuV0mB3Fr0MiZ097UuKdtB3vvtvJfjPwM6xqY0UvbIhd02mXy4Q8SjIyZgcYQtakKQu9viBiz6f3O/rvLFVWT8tsyEuxDgVfu5IucsS92M2yMDr3BlpQXmTscnZUAFxSb/noRxFrSv3qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793094126; c=relaxed/relaxed;
	bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBaQoYizr2PwcI22uawuR0Ewc8pRV68i3QTw9mbSNU0DaP15QGetJ9WZBeRSQAcZk1JH+gxqiRjLLsGKAudukVntEUdJqTeV+nWrjUtKjEHYTh1kQ4B+lYrnzrmRcomYa1i14SWfEhOrdDtIQ1hNZizJFAckSKB27JGPo9ykCOJXcCd116lPj8mk8NZxISfhEfoddYcQcfWkLJI5aY8vU3fwPCWfo+ffAUgAuIt8PVQc8XbleX9OGRPhJqwnJ6g7V6CwCCgN4BKOXVSOWMqVCqgHWJEbrvodpGuR9pEVkxh0OP01Lp7lvkjej91TFs6pc2OjWWsQHBhx/tUshYYTeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HnGZA54m; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HnGZA54m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDQWJ6xWTz2ySC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 20:42:02 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so18163645e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793094114; x=1793698914; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
        b=HnGZA54mOq0usXqgoyJStXK6VhhTM3RAElW41qlSedCq9Eivuwx2SJ7ch3G6quvaSn
         oFotE8YtoJ9BQkpF0Fti2ZOT4KOVKWCdaR6ozu+aGu9MIx4xYgC5D7rJ5tUDSSZOyAfx
         HTJ0ZF9DfRPbXqrISWoUTB4zXxaDdLVa7G/MiyCCw3BFwDmjn4Pr/rTHlTNZQ2WJZ4la
         kdl9y92q0XOAkqT+8ZH1HFzfarSC05nNXcOHD3+w44+N8BIsCVEYQjLzbapJP8cHfI4I
         sa5P4kYLqobysZRm6Nia6LaTMlGacHNnr1qSfbJUwnrMG8SG6qF+iRIZFpfjcD1E8nMG
         2DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094115; x=1793698915;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0G5Gh9P2KO0+5GGiKNPkOdO6AKt1oHHc652uqXaZcqY=;
        b=bBcX012FMS5xvzG19OzOxl8Rn+Hj1oBW65bR8KDIjejr3yE4FA0kgaKZn4jvYrFDMC
         VVIcRZQ/sVS4PVSYmI70DPQW3Q/6vo8IgzkeXYy2l2P+J2ijG2hRT0bVo3o8bCfAyxnZ
         1ZjlvPsTrJJetvU/Wxaebn9Qjuyjh+2lwMuyClNzFZ6rD6lWWWmiDfyZmxSMr0ygg5nU
         8pegOGtNAvTEZGBx0K0QA6gXf2pqUDpDIDp75zbR50TvolGWzksIHImpQqYAaMdZ27/T
         rSwTzKxakOWUfX0ANqkGsqX8IdzkvHZkrqWwVH+9BaDmYeMs9Jb01ueJWSVJ/8FKPf3W
         isAw==
X-Forwarded-Encrypted: i=1; AKwUvByNTocZGTkbZYVtNooWnQyjey0Am+gnBlKQuNzEHjwkhgX3IfL9dAUdo6OdVwYh0iYFGAtI122oc1tQNU0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKzKbsfjZxzuvQjkAuy66DGh3Bcvc2e8RHfB0ZlviUfbw03TAfe
	7QF5en8Tf5ectfCXk2aiXxmHiJiFaLvQ6wIkjrrS5wXI/K/2cDCkcfNeQh2fYnjy9xk=
X-Gm-Gg: AYBFou15QyaDws7Yg5TjNrFpL5j2i5y8flOyVxEQpXzU9xf4v+oZWNPvvBSffxm/N2K
	uCFlVoKFVkf9KxWVPNyHuqfCP8UQ5chdoo6kcMlL9cuasXArHoFDQ1lnxG5unkkV2vIkSFvkPmI
	tSbqdE4kd64J+H20+/fEPAeMoFuRqe5FAEY2B93IU2uSag23sS/A620uEQcezCfJkxhGQo3Tw+N
	JCN8DuPY+j0pdgEw8ipt0pJyDdhmhFGZxSeYIpXDgjVMJuGSMiPaWpG1e/VPC0LhNwVKMpZusWU
	rIzVTBQT6OgdRh2C0wmloHxQzHAMimtdf5jzm4B2HADWpBe7gkU/z9LJ3XG4reDgXK/ibRJsHt8
	SbGsRm3froK37SV14+UxaAqNM/imiXVECiRgtPUru84iMclTHxIscBuL0HZqJ5cqwAfjSRtqXjN
	0OzSjMBd2p7VQkiddHTTDzrj2hyKmS81hpBMuTOdAUtsGypTL98z7LhFksWrSjn2NEarSEpKWEp
	FB7BxB5KXyJP0cw+SBMFZD3IuqBJgVFSG8F4BEHSWeOA29FaTIml0NDfwkRIDw1oEbPwJOc8udj
	jKViX9GwXBVDmKpH+eeTVGs3hB8/xzkgz7hsUeVsFhI=
X-Received: by 2002:a05:600c:8a08:b0:4a4:7a8d:c736 with SMTP id 5b1f17b1804b1-4a47a8dc93bmr110335135e9.9.1793094114509;
        Tue, 27 Oct 2026 02:41:54 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a35a59d998sm263939065e9.15.2026.10.27.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:41:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:41:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/22] gpio: Improvements around device-id arrays
Message-ID: <auBxfVzkveb7KlEk@monoceros>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
 <at-CGVq5jVsMQief@SMW015318>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlk6jmpzfns64bdk"
Content-Disposition: inline
In-Reply-To: <at-CGVq5jVsMQief@SMW015318>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--qlk6jmpzfns64bdk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/22] gpio: Improvements around device-id arrays
MIME-Version: 1.0

Hello,

On Mon, Oct 26, 2026 at 11:38:49AM -0500, Frank Li wrote:
> On Mon, Oct 26, 2026 at 05:28:11PM +0100, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > [...]
> >  drivers/gpio/gpio-imx-scu.c         |  1 +
> > [...]
> >  drivers/gpio/gpio-mxc.c             |  2 +-
> >  drivers/gpio/gpio-mxs.c             |  4 ++--
>=20
> For all imx part:
>=20
> Acked-by: Frank Li <Frank.Li@nxp.com>

I'll apply this to all patches touching the three files left in my
quote.

Best regards
Uwe

--qlk6jmpzfns64bdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrgcd0ACgkQj4D7WH0S
/k4RSwf+IK0Zg4d+0uYc5szRXc18DV2GOQKuWytvc6Mb7rb8wBUlhLcCzHXfHJw5
GKyFFUIrW1GHu/p4aSlsaOLm8RjGYbgR1RTnxQySdf79td9IxG/EXqQcp6FcxSH5
30Ema9IFNIy1Z1fLQlqcQWR4FaujBuohFx12psbgjzkhMn3OY0x3w6FsZddRxBu6
hjb1B8M89jP2R7VcM2CC+KYKqlxNoQYiS/XOiE7oyKj9CqBRDIrGPNwKtLxUelaD
kKhTCJUSL4uTa26RZDC42xIr79ip8u0RW/+hzEwjtlicpsH0uFemsO1TO74xS/ol
PbKbBRoQJlRhoDMBJ7sTb6K4gJHPEA==
=KSfn
-----END PGP SIGNATURE-----

--qlk6jmpzfns64bdk--

