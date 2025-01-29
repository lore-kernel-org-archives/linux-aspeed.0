Return-Path: <linux-aspeed+bounces-573-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20062C02193
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmMh5Bn2z305Y;
	Thu, 30 Jan 2025 02:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738164672;
	cv=none; b=PRtUXUfqql/EZoW4rTLnbPKPML3oHeuP2vYpsHuMNiqvf2ULHoy+W7AjSPurS2QEkegb5ICdx4eQdrHqeNhLKmWlxvCuewDfg70DAjet6mPxkNlkghMQksuOcVHVO5qTQvpdaa1KGjCdweDHGxvrOWP/0NqZbBsPL8mM9lVypJd9KfPjlPmC8YlOIM4FTggMSo9H1vtME3/q6Tk0eKy2+dp3jEDyvMBXq7ZovOz4XZ2cBwkCl07r+7shl9m5tKlYLWWOwFSq3AAhew04sofwkVPPm+VZu/YQ2CCDmuH5hNOUgP2Yn+z24JNHOFPt4QHrqS81/yYEU4L67xQHYugCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738164672; c=relaxed/relaxed;
	bh=2bHyTajC4mwqOH3jd7tPC1C66TdJNJC1XudzRdu7F+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1I4KCfF1M1VfMZSpfNlr1ayUipvTwKjtWG1enZATvfEAnY8ZA4qbS2uTrSdTsakpJwh5m/FKUueBYueaD+/aD8hD8NM9gRq0OYN+b8dimgodzfH0PGp5n8oavX9Fky0uS6mvDHoI3vMcjTgPRgvEdoa8xAnvcU8as/jbisDA53Lqih1ZakqPQSswnjp/v9kO/ovAPd+odB+YeaEIC2TCpWd0uqcDbuu7wtbUFhUO61pJnEg956tZ7FuJemsyZAix3VKXQRdlkiNGiHE0Bg1tunxJqQ0+vFmZkH+GvhBVYqd+vnHlIKaglnK6gWm72C7DcGZ3wkc5zJu6Ua048CCLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hg08j7Ur; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hg08j7Ur;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmMg6hcxz303K
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:31:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 573EC5C5DD4;
	Wed, 29 Jan 2025 15:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33696C4CED1;
	Wed, 29 Jan 2025 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164669;
	bh=2bHyTajC4mwqOH3jd7tPC1C66TdJNJC1XudzRdu7F+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hg08j7Ur3nGyM5zBmp03uHV1XYf0M9UupChK0iMx27cfi1AFnnDVYU10CwoPhaSqV
	 pFliZLawazhqzZL2gvKgk0WFxEKM8YIomrdInbcERXTMpbQAkUyXO4gpEvPAxigyBI
	 bnwWi1epktQ/GfI51R1Nuqub6TT4FhtlpsSuWEy13hpSgsZ41Nx+s1ZGnqji8K8MdE
	 yXMqmjWRXKP8JovcEpIG9+lK4foCpaZc24O908abNAWS+wCFHv9iu0DvwPruDZgBUR
	 PzIIZXu44Puh95x9FUSniZuA52zdtdC/OpNWRjdnTsjriLVzbrwUPnib2OQGvSZ4zR
	 ydYnSW7KKZ5Sg==
Date: Wed, 29 Jan 2025 16:31:05 +0100
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
Subject: Re: [PATCH 01/14] drm/aspeed: move to
 devm_platform_ioremap_resource() usage
Message-ID: <quo4lit26u7b4xjhc23o7y6npyeh44uywddti2vb7mjv325ymr@rk3bb2wq2gok>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-1-0d1609a29587@redhat.com>
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
	protocol="application/pgp-signature"; boundary="feetlxquiqryfdkp"
Content-Disposition: inline
In-Reply-To: <20250128-cocci-memory-api-v1-1-0d1609a29587@redhat.com>


--feetlxquiqryfdkp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/14] drm/aspeed: move to
 devm_platform_ioremap_resource() usage
MIME-Version: 1.0

On Tue, Jan 28, 2025 at 05:29:25PM -0500, Anusha Srivatsa wrote:
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
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--feetlxquiqryfdkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5pJuAAKCRAnX84Zoj2+
dol7AX9FewsZOX9vP+EVK4qeoWf32JdhX+9xPUxub7t3hZMZVyjaJ6JgOFU6IUge
eZR6Dc4BgLc6zLKxiOmAsFpEg32IZBmVbKZ5J8gvcbJ7pFhcd4DjotbJ9cJDXfKk
y8YQlkhvhA==
=Yi1X
-----END PGP SIGNATURE-----

--feetlxquiqryfdkp--

