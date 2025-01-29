Return-Path: <linux-aspeed+bounces-579-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37902C02193
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:43:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmdY6kSfz307C;
	Thu, 30 Jan 2025 02:43:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738165393;
	cv=none; b=UVVBflXaDWvaWdQMgaJ2UxSmKT5CKOKcBhJ7NMS9uAewa1uVqCNkXgut//CaZgfbuGt702hfYXyC7rkAnQ4iCVD9vO78BldbDrxFf+dqbzIPFLiOI1VlzFjiJaL4/qhC7DXBj/afLBTbPVLbBsdjdx9U+nSvuTFTpFTPOc2lr3/bBhDAt4q7v2TDN7t2/PBQDDwLhWhEdIVWR0ajLweMTJK2TplxNMuhvgfNH5QZhU923b4bbmBqJRrtoTEcvzF/WjFYqLLet9pEQqdsuKINtRjJIRf7uHLXWC8nxywSlYKL2oHDGA5adNgeASFCFHQYcbkpBhY/UkPg9nX4YFVtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738165393; c=relaxed/relaxed;
	bh=L+LdrRhCjvS0JAqpjHmxZqRSlO8lZQPof0rDUZpJ/3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqwCfH8HYWf7t+Ho+azn9ta7qmlYB5Bp0/gJ3rNoA88JeBy+Vgfa/2AttJ+tEXrGhRHqoI+JFGkgi/omAY4zfOB8T2Ru0lQZjVIZD/PKSFB9vGotkgcGQoUiHHxmqkSLKuAG5f5tktcyrhNrGq7zgjxoiQPbvdB+ho1SM0i1YvVZocsutxVz7bFuqryy0CHEZl6ANvjINcr2sFQsajxleguLiDfHNOvFfoenHKJmfF6Y3VTgm7xCrgry0/oBK7xy8Tuxm1iXU7hlU07+XhQBA6MCY+7ftxidzB1hwT2DcSh7wG8ZKqkoCBWRr3uXLQHyg7LFaXziRwEsPJxMMQeJyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cOVdq/fw; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cOVdq/fw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmdY13xdz305Y
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:43:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 14D915C5DE6;
	Wed, 29 Jan 2025 15:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A633AC4CED1;
	Wed, 29 Jan 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738165390;
	bh=L+LdrRhCjvS0JAqpjHmxZqRSlO8lZQPof0rDUZpJ/3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOVdq/fwIMuFmCG3dwznLhjpCXSjCANL10wAYwaWtJIqzzA5mYbhK5QXNL48E4mi6
	 ca1pkO14kl5vJsyaC/DtiTS9M8ewjKsUWc2GJpDfGb4Ul4UiSENKBQNvj616FBNMqY
	 RwN4e+O912JSLA6CvrCegVAuCXw4Oc3RhvRPfEvBRxBi7kByhe6Eq5WNpNqeAeMnZG
	 4nqkcCE09DCnEoPKrf28SvSbU9+JgWPzV3b2h3lXSUatcrpZY9lftsVXMKdf3XJ/Eo
	 Ri9n7RQZWmg2dISyJgTqgLaet+A8KhsBhZYFQFH5xKl7UEb1qDkjaGvkxV3MCNL2Os
	 hUzzX2L93dmCA==
Date: Wed, 29 Jan 2025 16:43:07 +0100
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
Subject: Re: [PATCH 11/14] drm/tegra: move to
 devm_platform_ioremap_resource() usage
Message-ID: <gebnr7fqi4vjf7ah65kbegio3kegvywtwpeqg2nmrbyvr75cd5@gtc3q2fqbmmk>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-11-0d1609a29587@redhat.com>
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
	protocol="application/pgp-signature"; boundary="p2f63gspytwxh3p2"
Content-Disposition: inline
In-Reply-To: <20250128-cocci-memory-api-v1-11-0d1609a29587@redhat.com>


--p2f63gspytwxh3p2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 11/14] drm/tegra: move to
 devm_platform_ioremap_resource() usage
MIME-Version: 1.0

On Tue, Jan 28, 2025 at 05:29:35PM -0500, Anusha Srivatsa wrote:
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
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--p2f63gspytwxh3p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5pMigAKCRAnX84Zoj2+
dqzQAYDuiHmk1X6f2Np/A3NbMjhmQEj5ZkcyY0qnwfeFEeNM59hx5iZPW1yTPtKm
V2IiMl0BgJWdgMjq9Y2WXbz7PRIN/h41jfy/OtQ0u89olAAjJ/Sb4dplYcM9Y/n/
DRpSqT5XcQ==
=rZxA
-----END PGP SIGNATURE-----

--p2f63gspytwxh3p2--

