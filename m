Return-Path: <linux-aspeed+bounces-716-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0DAC02198
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 09:44:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvRvw1H8Zz30WY;
	Fri, 14 Feb 2025 20:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739526252;
	cv=none; b=L/PKsfNJgNIDRNf/gF1Lq16gBLZzGmoFo3UIufhcs52frIYHSinCXDQxd2SPo3Kvg3Drvw+5pg5nlAzHjK5QcVAwNGe/zogHFbvWhWr0GxccX82zgZc9kOTIS//S0xvdt3M0gyHcM9tjLz+XkWICL5GcfX6gKDaS0DIZ+w3HTIEbzhlA4uHTbknbEvz2l/bK6rlUDAZfYlpTSrzd8HLUHkGmtNKemiZwrYm+IfMkO1T5B8nlf58EDYud5DuSeT8ye9iAWAK+WPi5+ApIhwQdvN8BYKCYnhnWrZVH5ZfcBGGdxuAWGcFLl30ntLXUtbkRpIqvqgXElZ1eN29sruHW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739526252; c=relaxed/relaxed;
	bh=21tqIdPM7MMDZGQ0+y3MH3C18hS595+a3Ckf07v6s8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qur1uDhia9LXUWSdFcGKOI9eTf9e/3UqXKJaE6X3+Vu6KL++4yXsMwxPhSOL9t5tJeZ7QTvuUoBLiyg1DGHdq78KZ/EaZcr7SVhoMbHBMHFMgDqHY1y9Sal88LnZmu8pYthb92l3fmrKyhzTWJv0YaRhxSoc7zc9rrl/bS5xVoPOYGVwsFN3SzO9yeDvvDHBmqbcoavmx4BU4/bgwTCPnUOetnyJADEZz45a6u+d15GLdUgiL2JEq6aDLU3tFNiKQTPdLIs5tzXYxrK3cDekNQDC79Ey0dMlATcjisX2NabMWQ5ZzHQS5XLLaABFg7dMDKue8kZ8BwlTMs6cj+R08g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QKgThIZQ; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QKgThIZQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvRvv2JVGz30W0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 20:44:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 334F5A42555;
	Fri, 14 Feb 2025 09:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C057C4CED1;
	Fri, 14 Feb 2025 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739526247;
	bh=euxH5xTB3npndNEOhGf9KR+p/1GlHm5dq8S6R5vtFvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKgThIZQsDXvHi250nXVACftNulY+hDA56lG4gV0mWDqpQmEI/IeByxEkZ30VumCF
	 L+r2W1g/8OTElc/khx4mIaSFrKtauo7k7wzOS5jT9SBbtUlYjgOkI86coP9+s3NYwT
	 y3Pkf0q3FPGmXw9gDN2jBCwdfFjlwHIM6NMKxRNfAHvOj6MfdWa4J64sZrCZ+2mWp8
	 rvLAPOGA4lz6JczHmcz0aTOHczOZk73pBCHAN90DCEiXiuHnMIe8lrWw5JBzcFdPvS
	 NBKHdwztH01NncybK/yA9xE55/oALEeW+VtQObpTVt07tlkncpFvbP/wa1DsJj+6au
	 giWDWVolgoUpA==
Date: Fri, 14 Feb 2025 10:44:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Joel Stanley <joel@jms.id.au>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Alexey Brodkin <abrodkin@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, linux-aspeed@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 11/12] drm/vc4: move to devm_platform_ioremap_resource()
 usage
Message-ID: <20250214-quixotic-fossa-of-art-b8bb9f@houat>
References: <20250205-mem-cocci-newapi-v1-0-aebf2b0e2300@redhat.com>
 <20250205-mem-cocci-newapi-v1-11-aebf2b0e2300@redhat.com>
 <20250206-hallowed-ultra-tiger-cfec8e@houat>
 <CAN9Xe3SpTG7r2UkN7_pH0uMXhU5u+dkWhaM9+w5VyOQZp9byNg@mail.gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="tmymxs4x7znmvcxa"
Content-Disposition: inline
In-Reply-To: <CAN9Xe3SpTG7r2UkN7_pH0uMXhU5u+dkWhaM9+w5VyOQZp9byNg@mail.gmail.com>


--tmymxs4x7znmvcxa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 11/12] drm/vc4: move to devm_platform_ioremap_resource()
 usage
MIME-Version: 1.0

On Tue, Feb 11, 2025 at 12:08:57PM -0500, Anusha Srivatsa wrote:
> On Thu, Feb 6, 2025 at 11:13=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
>=20
> > On Wed, Feb 05, 2025 at 03:08:07PM -0500, Anusha Srivatsa wrote:
> > > Replace platform_get_resource_byname + devm_ioremap_resource
> > > with just devm_platform_ioremap_resource()
> > >
> > > Used Coccinelle to do this change. SmPl patch:
> > > //rule s/(devm_)platform_get_resource_byname +
> > > //(devm_)ioremap/devm_platform_ioremap_resource.
> > > @rule_3@
> > > identifier res;
> > > expression ioremap;
> > > identifier pdev;
> > > constant mem;
> > > expression name;
> > > @@
> > > -struct resource *res;
> > > <+...
> > > -res =3D platform_get_resource_byname(pdev,mem,name);
> > > <...
> > > -if (!res) {
> > > -...
> > > -}
> > > ...>
> > > -ioremap =3D devm_ioremap(...);
> > > +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
> > > ...+>
> > >
> > > v2: Change the SmPl patch to work on multiple occurences of
> > > the pattern. This also fixes the compilation error.
> > >
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Cc: Ma=C3=ADra Canal <mcanal@igalia.com>
> > > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 55
> > +++++++++++-------------------------------
> > >  1 file changed, 14 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > index
> > 47d9ada98430634cfd8c1e21c2a4d00d501bab7e..066f1246dab420ee889845b0c573d=
80ce7c88595
> > 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > @@ -2951,71 +2951,44 @@ static int vc5_hdmi_init_resources(struct
> > drm_device *drm,
> > >  {
> > >       struct platform_device *pdev =3D vc4_hdmi->pdev;
> > >       struct device *dev =3D &pdev->dev;
> > > -     struct resource *res;
> > >       int ret;
> > >
> > > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdm=
i");
> > > -     if (!res)
> > > -             return -ENODEV;
> > > -
> > > -     vc4_hdmi->hdmicore_regs =3D devm_ioremap(dev, res->start,
> > > -                                            resource_size(res));
> > > +     vc4_hdmi->hdmicore_regs =3D
> > devm_platform_ioremap_resource_byname(pdev,
> > > +
> >  "hdmi");
> > >       if (!vc4_hdmi->hdmicore_regs)
> > >               return -ENOMEM;
> > >
> > > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hd"=
);
> > > -     if (!res)
> > > -             return -ENODEV;
> > > -
> > > -     vc4_hdmi->hd_regs =3D devm_ioremap(dev, res->start,
> > resource_size(res));
> > > +     vc4_hdmi->hd_regs =3D devm_platform_ioremap_resource_byname(pde=
v,
> > "hd");
> > >       if (!vc4_hdmi->hd_regs)
> > >               return -ENOMEM;
> >
> > I *think* that one is shared between both HDMI controllers on the
> > RaspberryPi4, so we can't claim them from both instances. We should add
> > a comment there to document that it's on purpose.
>
> How about vc4_hdmi->hdmicore_regs? It also has another instance
> vc4_hdmi_init_resources(). Looks like that also doesnt need any converting
> and shold be left as is.

No, each controller will have its own set of registers there, so it can
be converted.

Maxime

--tmymxs4x7znmvcxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ68QXwAKCRAnX84Zoj2+
dnJFAX44qxSqH4/9r1lPWe6YsBKR9clH1sZQRZaWBdRICp0iE+/MJiNA/tJghQgy
Xb2262kBgMGvJFpuBmHvz9HJegWf00i39I2+ctkME/qrOcHQhoIwF07ezVrQyZOZ
z9Q+kadHOg==
=d/Gf
-----END PGP SIGNATURE-----

--tmymxs4x7znmvcxa--

