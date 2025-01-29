Return-Path: <linux-aspeed+bounces-577-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF416C02190
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmZm1xmwz305Y;
	Thu, 30 Jan 2025 02:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738165248;
	cv=none; b=W7ska7nmToEQu/0JD3MpnEk6D+y92FroB3zGvxU4vivmUCpry+0Rd0AKMZHbU2U6Cp1v3xP6xSVBGBcYYTjHwrhdn37sUrhlN5FVZdxRwFo9ic0drbpiqQRZNiche0vV8JL6Uc0qmD+j3viJZvLb5XicXcEyrNGqvDlh587QXuwC8a3Z6DYMh/b0+FjBcglB29xau3/KQ0cUGGL0K10LlZgUGDW8EfCOHas/QxuxEJbQvS8Z9Pk87635mYIx54WXcW10oKhETfEkGVBQtBdmEWt5bC3K4Rys4SQNaGhg0rnQsSepd4r/3YqyjJsYLPXH4zINJuEd+5wvkWK25fW3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738165248; c=relaxed/relaxed;
	bh=/AvahXWJRMBWciBbBtJICPqqj28PRPJYyii/s9JYaw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auXFXYdGzuXAjbuSLxMr/aiDw+ahe11bm1h+w9ANtOaLsHpE6vKQR688yF+UugC4hdLD5oGSXOdcbDq+tPjlkSdyflU1AMf9hUEEFNAelD43tBqg4DWWQx3Ja+vChu4W0GRr4XDpp2g275/Szr/89g8nVm+w7JNRtwKNOwEGyL9kt91OV42VOVBfslRQ4TeCLzroKamuhnbDcr5NEXijOdqUvSfDK1c9D3+Q39Z+Zmt0Yf8MokYBRuzbfdo+ydIEUFstKkt2VE2Fsdyx+IgqKGXwphBIgkbeD38gXOOP+C0XV385I3YHAF+M3TEWg2Xpw7Wr2ur7PpNV+Z5DlyTUGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZM+cZRti; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZM+cZRti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmZl3dd2z303K
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:40:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9309E5C5DD2;
	Wed, 29 Jan 2025 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770ABC4CED3;
	Wed, 29 Jan 2025 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738165245;
	bh=rtnZjFO/UfiH1j0rluxhcjeVmz12h1zDXZJJ3+0MvRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZM+cZRtiXnmi0hHc4n40eYcHanFML/aIc6MX0XZhPdogHoKUulxVjPXm6RULnPVkC
	 iX8Qospo0x/ND4+0f525c7Zu8xxc7Daz/PjoUL8HDbN4/QMLPeR65aHCueaEp1uWIU
	 DurPDhK4SIaKCpip8GwEy8LkumP3/EdZeVc0QSWZOObMvQAc45nvMv2WpqBGHp6RxU
	 EYpA95fiVbOw32agYO2Sfqvb3U5f/ACokeGKatfzJ+LRaXLQdUYJ/gCmPWhPOAFOAp
	 Zr7OInp3vF/BKz0JLCt0vxcL0M2B+OHTkOofX3sauEdMMjc3170klpqg28aRYRHFvC
	 +wc9LrlSw92yQ==
Date: Wed, 29 Jan 2025 16:40:41 +0100
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
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
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 05/14] drm/meson: move to
 devm_platform_ioremap_resource() usage
Message-ID: <ieknc4dm5ntnqaqz6zdlinphocm2omsn4ll34vlbrohqcddl43@kg35irldnkuw>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-5-0d1609a29587@redhat.com>
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
	protocol="application/pgp-signature"; boundary="wmuf2lutfjid5aqu"
Content-Disposition: inline
In-Reply-To: <20250128-cocci-memory-api-v1-5-0d1609a29587@redhat.com>


--wmuf2lutfjid5aqu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/14] drm/meson: move to
 devm_platform_ioremap_resource() usage
MIME-Version: 1.0

On Tue, Jan 28, 2025 at 05:29:29PM -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource_byname + devm_ioremap
> with just devm_platform_ioremap_resource()
>=20
> Used Coccinelle to do this change. SmPl patch:
> @rule_3@
> identifier res;
> expression ioremap;
> identifier pdev;
> constant mem;
> expression name;
> @@
> -struct resource *res;
> ...
> -res =3D platform_get_resource_byname(pdev,mem,name);
> <...
> -if (!res) {
> -...
> -}
> ...>
> -ioremap =3D devm_ioremap(...);
> +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
>=20
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index 81d2ee37e7732dca89d02347b9c972300b38771a..6c805805b7a7f675f8bb03944=
318972eb4df864e 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -184,7 +184,6 @@ static int meson_drv_bind_master(struct device *dev, =
bool has_components)
>  	const struct meson_drm_match_data *match;
>  	struct meson_drm *priv;
>  	struct drm_device *drm;
> -	struct resource *res;
>  	void __iomem *regs;
>  	int ret, i;
> =20
> @@ -220,14 +219,8 @@ static int meson_drv_bind_master(struct device *dev,=
 bool has_components)
>  	}
> =20
>  	priv->io_base =3D regs;
> -
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
> -	if (!res) {
> -		ret =3D -EINVAL;
> -		goto free_drm;
> -	}
>  	/* Simply ioremap since it may be a shared register zone */
> -	regs =3D devm_ioremap(dev, res->start, resource_size(res));
> +	regs =3D devm_platform_ioremap_resource_byname(pdev, "hhi");

Given the comment, this one should probably be skipped.

Maxime

--wmuf2lutfjid5aqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5pL+QAKCRAnX84Zoj2+
dpWQAYDuVxaraj2eKojNueyW+NChDy3YtnstWS0E/hE4JNegqss7vQXSWOthuO4R
73qWnq0BfRFtK3i2Os+sXuDOS+LkWHx5AsRtEcQCCeX0wT3sQVfWN3Edu+Ky/NDa
3DmrzReHUw==
=Tstn
-----END PGP SIGNATURE-----

--wmuf2lutfjid5aqu--

