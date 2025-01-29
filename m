Return-Path: <linux-aspeed+bounces-572-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE15BC02194
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:30:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmLP1lBNz303K;
	Thu, 30 Jan 2025 02:30:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738164605;
	cv=none; b=Fc3QETe3KdxbbSIe45CQBPk4WaF5slT248k1N0PC/2/LbuXvTnFAc08q0GHzYdRu/WGGed5COxXQeStPC067odzX99z9nczlPyz7LYWumMqwKjnFFYupJTJ5L9TusuV5BKVI0M4fBeasKZx4fTsfsh2WbwN0f0NOuIObfoMk8pAhIwSo9P8bM1DKdWphfOjEIrTAsZdIGDcqimcWItOgAxhGxxdV4CKYzoU4tPlMCFoyEqDR3oKKS214Znte/yHYNX67mN0xczlBhRJnWR4s9adrIBH3Ztt+fzsckk0R2TOm8Mm6+fqr0dbpQ5kxc4rbiwq6XJXlOXKs9gMRvn2NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738164605; c=relaxed/relaxed;
	bh=rSSIXzLCaiADVUkkOTt5OUgOQZho3MH1Ysx1NFVUke8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPLh1FVRpeBqwHc/ko+4RvDbmknh273OvkhxX+dgzTXKyxregm17IKVWInxDunWbEkx2GehHh9GBeXl/fCiYou4ntqWUsHQg7+6ehl1Mjlj+VImkxIp1PgwhCooJ21wHgsfHMLTChr/7oFmH+tKWNf6xJvliunYW8ZkywgxRGPtiDXlqK6+3p5x33Dt2D1frNUZEGHqtdJ2uvvOWVjY3QTX1LXuuTNftZUyuVg7NOIxP/h2B16RfuLNv/5qEeiC48D9rBaX73amP1p2WIxmF/bDuPPqEjaLHQaW4MxeBQJ1KX3NdcfHWNFx/ITY/ARMRvA8CJoPBdSdXl6mBngp8KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XzT2K/g8; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XzT2K/g8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmLN2hsbz305Y
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:30:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5EF89A41A34;
	Wed, 29 Jan 2025 15:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DA3C4CED1;
	Wed, 29 Jan 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164601;
	bh=rSSIXzLCaiADVUkkOTt5OUgOQZho3MH1Ysx1NFVUke8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzT2K/g8mcDm3hCeWI4Q2UbKvBUf5BvMAS0H+n39mStjDIozbzjBeClkUBoUCUjg1
	 JE0OfeQDO9hyJ0r35YtcpxarhuNj2tGwZB1XErhIVBr9pME7nA8QicTf0Bao3XVpdQ
	 oK11pcV2bDb8QFZwoSGZVwWwo8vhAj57gHcGk+VE6LC432XAqe+xY+MeM5dH15y3AO
	 dv/bKGj04dpsoOrGhEjE6GmzGIUGJ/fyWj5EnN8HbobSsIcsn9fkFrk5rpjdtRULfu
	 WjTu/K6OPIxmKgCwEGDnkMJ7Vhq87xBRqr1K11VkljKXlqp2LjGRiZ4tMLz4k0Tkeg
	 ADEWJX5TSyl1w==
Date: Wed, 29 Jan 2025 16:29:58 +0100
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
Subject: Re: [PATCH 12/14] drm/tiny: move to devm_platform_ioremap_resource()
 usage
Message-ID: <ghya5qojfjbjtqei2l5ild6jop3n2hj4rojvil254caho64myf@qiqbt2pg5r5g>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-12-0d1609a29587@redhat.com>
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
	protocol="application/pgp-signature"; boundary="gczjr6ysiil4ewb7"
Content-Disposition: inline
In-Reply-To: <20250128-cocci-memory-api-v1-12-0d1609a29587@redhat.com>


--gczjr6ysiil4ewb7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 12/14] drm/tiny: move to devm_platform_ioremap_resource()
 usage
MIME-Version: 1.0

On Tue, Jan 28, 2025 at 05:29:36PM -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource + devm_ioremap_resource
> with just devm_platform_ioremap_resource()
>=20
> Used Coccinelle to do this change. SmPl patch:
> @rule_1@
> identifier res;
> expression ioremap_res;
> identifier pdev;
> @@
> -struct resource *res;
> ...
> -res =3D platform_get_resource(pdev,...);
> -ioremap_res =3D devm_ioremap_resource(...);
> +ioremap_res =3D devm_platform_ioremap_resource(pdev,0);
>=20
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--gczjr6ysiil4ewb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5pJdQAKCRAnX84Zoj2+
dmbVAX4qY+feoCB5MZiIvdr/daFlFmBP+Qrzjy3YpdN0hZGySyuYlXpb18XqNc/9
WRQXKC8BgPMXqn+rOB5wrBDoOe4CNLunweJzpdB+DVoUvzJhD2lAGQkzkbZC9LMa
8QvQY+8R6A==
=5YsP
-----END PGP SIGNATURE-----

--gczjr6ysiil4ewb7--

