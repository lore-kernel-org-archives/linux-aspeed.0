Return-Path: <linux-aspeed+bounces-569-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299E2C0218D
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 14:32:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yjl3N1wxvz2xfR;
	Thu, 30 Jan 2025 01:32:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738161120;
	cv=none; b=nADJOaQpEmKjIFyk9D71wIdokXMqJoGtTCIThq/ODEhBm6MwqMosNE7z14h6PU/6JKbPQfP+v1OARnQIKGrDw9S7F0BZ7/5Ib2k6Ti40l9xyr0oIoPdQ03K6ndwBiMh5PQq5uJOaa3aw+8W7yVPtMDD9iwVTSPyulIKsrPD3U3K8xpXYEG2evhqZfCC6tYqEqTnZJxBHms+rQRhcwsgYt4yGKlFg8mrFV+2VUoyvmOwwCZlFFYXx9u90vROmiTtSseLM7g2fdCK8dBT2PNaluaxrwjAvMBk9HKWk6Y3/yilJd3VfCO/Dg9E89xgvVE1Iw7taM7+fO5UGJ6sgAwAdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738161120; c=relaxed/relaxed;
	bh=/NQivZatFy6ozbG8cW4E7SYCaO/iSD4IT71wGW8bA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chEUHvXwnnzlBsyBtcdzCWOlNnWB2PbsYXGMkb7sOZDazemPQLd6LUeoBFe5y56kd2REuu8BHgfWDBWKH+m+sqMcMiUa0oevjmOK+lQJOXzNrcL/j8aVGPM0J4e7HGot03yoxoPLcidY2gN0mB1WFGQAb6vrnPy1lNfVW9pZ0BRPySN8SGKzb0iQi7yJgRjcJdKgYYT/skBp55CV9X2oC9gM81BMkZj6b+pSNb35Q0N/5ob+HScImymSJ80VOkfxfWUn3CMRun6AAvvS/iRu9ROLheWLw98GsbopIw9OW8pMzcFre8tBg58lz7xTIpsMEGLsDMizl6cL0sCuCk0TRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XwkYLReR; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XwkYLReR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yjl3M1kc0z2xX3
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 01:31:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15ABF5C5D05;
	Wed, 29 Jan 2025 14:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EADC4CED1;
	Wed, 29 Jan 2025 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738161114;
	bh=/NQivZatFy6ozbG8cW4E7SYCaO/iSD4IT71wGW8bA+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwkYLReRA45QF3dUHy2a5jJCxEh/8q0TL3kVXAa2fw4Ahf/WYOfr4xtttIKeBbyc/
	 mDRVGqF1sIyPmUPXVpRTEiqvANTBSxwkyCn+KVXDefWJKRT8MP2GRekoCahVd007Ih
	 CP918gN8Tg+65uWncO6AC8DjiTwETGtUNBziEih0x09caA2bAX82v/m1vlrsGUyf8w
	 B/ZP77LhzZG7Q/azQWEd5JmWQ4v+3nu1JaI/q0aIuyHWZgFsQKPoFEaNYaSOdWiRwO
	 EQ/Ichf24+ZgBpu6lFjVGCimVGm4SrC+Wkf8jGVRniARB0uLj5/lcma9JiP2TTeCAW
	 ICPsEs4ALdTeQ==
Date: Wed, 29 Jan 2025 15:31:50 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Anusha Srivatsa <asrivats@redhat.com>, Joel Stanley <joel@jms.id.au>, 
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
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Alexey Brodkin <abrodkin@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, linux-aspeed@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 14/14] Documentation: Update the todo
Message-ID: <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-14-0d1609a29587@redhat.com>
 <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>
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
	protocol="application/pgp-signature"; boundary="4zgjoi5tasqxwp35"
Content-Disposition: inline
In-Reply-To: <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>


--4zgjoi5tasqxwp35
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/14] Documentation: Update the todo
MIME-Version: 1.0

Hi Thomas,

On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:
> Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:
> > Remove the TODO now that this series addresses
> > the changes needed.
>=20
> While your series is fine, this TODO item is unrelated. It's about various
> ancient fbdev drivers that do not reserve their memory regions correctly.=
 So
> please drop patch 14 form the series.

Is it? Could we rephrase the entry then? I'm the one that suggested
Anusha to work on this, and it's still not clear to me what it means
exactly if it's not what she worked on :)

Maxime

--4zgjoi5tasqxwp35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5o71gAKCRAnX84Zoj2+
dlIiAYCuZ4LfnornQ6HBeGeodgAvHyP2JHHAH32UgOwV9w+vt/5RwFWlygqXx5nv
ggyszhgBgJuXAJdx+hiY88mf0JptAOibew6TT8wLX6WV4WS6/NXT4CzBcrvJArwN
C91xDc/bTg==
=wEcd
-----END PGP SIGNATURE-----

--4zgjoi5tasqxwp35--

