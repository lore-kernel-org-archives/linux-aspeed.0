Return-Path: <linux-aspeed+bounces-571-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E674EC02190
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 15:28:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjmK51xHwz305Y;
	Thu, 30 Jan 2025 02:28:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738164537;
	cv=none; b=V+n04g07b1NCi9dEjLYcSKHpGOAKxvAy5UDsCQkc7ANFx8u87dEBSfts5nd1OHOazFZvc/3FopySPrKEHOVsVVL9PsFnrq7YgJwkcjRnyNIwFxBIvsQVc7J8xul6rEQVC0ieYV1Q5gGtCkNaR18caT7jtQJsemHN6pkRVG6caM6GXMsix80Ux45C8NVlnu+Buat24+KwhqGwpujjZp5TYHS6JIJ8NfqDV1c/cKrs7xt1mjS+gviWbE8vO0d5dP2nJieWtwsSVQgxzvZdnXFmutDrr7XWIsdpy58MHPh0TM85JPs0/sQUoNF89JtyNiO0R3mnknszxLrG3KQwI0C0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738164537; c=relaxed/relaxed;
	bh=bok9TVvjjQCymMYvMKlNAI5VH8lxZtesRpd8zGC0hcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Kba3jM+mX6ByT8gtgZ/FYR1E0NvlOZMhM10eiYyTYfdGHcRjUI1Ij12KZlfeRIKGuRPFi7HrWe5YHJEruE6/NsvX1g0hdRzWOh5QgLR6xiTLF2jWdrsSeFUCj5NqDLkipOzUCuco2LKaeRoTZnhL10nRrLEMgcvRSE49yPZSmK1DQTMsIsa563P7WDtpXAv9ywWcbGLy3K+07VLJHwQQRI0t6N9BXsjH4aIO2HKX05RZRH3uHQqxQbjv5fLyIuxxoXVho1H3olDBbvqVx3jtS/ATSx+lCm21/kfvI49Ns8BeJDXLkv/ixEdYQqlAWU0asPXeVyl9zUL9wa2KkfXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NOyxzPTq; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NOyxzPTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjmK43F0Lz303K
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 02:28:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 70E7EA4148F;
	Wed, 29 Jan 2025 15:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB6C4CED1;
	Wed, 29 Jan 2025 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164532;
	bh=bok9TVvjjQCymMYvMKlNAI5VH8lxZtesRpd8zGC0hcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOyxzPTqxCIMDXiltBFL33XgRz5+HmhF0fqEkvxsOMQ+6Wzc56dBN6SyjzMqltBb3
	 6NHtoBcd65EsJ8oCbYGGJvz7/v567MFrM9a76OkdnsX647Ow/whbk9IojguGxowzk/
	 vbgmUGA5QVu9G7m22EiF1kv31X4aNiRWdytIs030qtfGVFcGpnPSqX2oZnwdYQILpm
	 Pjpn1K1oNLt3gHaVCozxK5+ncmcRqK8/EMM9cl/FWKOpIv1Co7UcwDOnuN5Jv9Df4M
	 APJZcGw1WrNChwRUMgJfEVxBXmfA2Yi8igsZSjP24OyJBaMR3b9+I6o4BEWoNaXNbL
	 K/PKTztalZRiQ==
Date: Wed, 29 Jan 2025 16:28:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Anusha Srivatsa <asrivats@redhat.com>, Joel Stanley <joel@jms.id.au>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
	Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 14/14] Documentation: Update the todo
Message-ID: <4jn3dfea3eb5yuqobjwvbzfxhwatpvvhtpxbmt6npyrypkyruw@mgtmxignyvt5>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-14-0d1609a29587@redhat.com>
 <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>
 <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u>
 <2y3lwycrggmktamu3j3gj65uco7quvtu7tlc3724e4mpokhjz2@icedc3kervme>
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
	protocol="application/pgp-signature"; boundary="ntiwixuo22akqcub"
Content-Disposition: inline
In-Reply-To: <2y3lwycrggmktamu3j3gj65uco7quvtu7tlc3724e4mpokhjz2@icedc3kervme>


--ntiwixuo22akqcub
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/14] Documentation: Update the todo
MIME-Version: 1.0

On Wed, Jan 29, 2025 at 03:41:32PM +0100, Thierry Reding wrote:
> On Wed, Jan 29, 2025 at 03:31:50PM +0100, Maxime Ripard wrote:
> > Hi Thomas,
> >=20
> > On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:
> > > Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:
> > > > Remove the TODO now that this series addresses
> > > > the changes needed.
> > >=20
> > > While your series is fine, this TODO item is unrelated. It's about va=
rious
> > > ancient fbdev drivers that do not reserve their memory regions correc=
tly. So
> > > please drop patch 14 form the series.
> >=20
> > Is it? Could we rephrase the entry then? I'm the one that suggested
> > Anusha to work on this, and it's still not clear to me what it means
> > exactly if it's not what she worked on :)
>=20
> The text in the TODO sounds pretty clear to me.

The title is "Request memory regions in all drivers", and the first
sentence is "Go through all drivers and add code to request the memory
regions that the driver uses". It's definitely ambiguous if only fbdev
drivers should be considered, even more so in the DRM documentation.

> It says that not all drivers request the memory that they are going to
> use, and suggests to add those missing calls.

Right.

> But all of the drivers in this series already do that

Nope.

> and the only change here is to convert them to use some of the newer
> helpers.

For some, yes. For others, it actually adds request_mem_region.

Maxime

--ntiwixuo22akqcub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5pJLAAKCRAnX84Zoj2+
djXJAX42QJuv9ldBu+AhSOcaGHTmHduDMEY8V8Vl9SA1LQwXd1eGjPx3kK6JEffx
SuWaI7oBgKL15NjVE6UaWuMksj7yMDft9JYcv/qLSoYx2TpAp/7FYElajo0cqE0S
btsWT+helA==
=K+FR
-----END PGP SIGNATURE-----

--ntiwixuo22akqcub--

