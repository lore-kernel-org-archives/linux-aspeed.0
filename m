Return-Path: <linux-aspeed+bounces-581-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277EC0218D
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 16:30:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yjngq237Kz307C;
	Thu, 30 Jan 2025 03:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738168215;
	cv=none; b=hVtQPUWGVpNNqnvt5mgJDRRpvgrzI1YhUjEYoLTiqAipXd3bggQlvawx0W0wCFO7Rw/TTRi/H00DG2stcjeCXEFC6UrftKCNP/fPvRp472hU/cJd2Qr7hkTsrE4O288o8rJ1HTszjqZV1JRU/Q0eAj6KSmpm5uCLbSJPZFVnffuFb2xeM++40GiXIPXFEb1VxnLdE+NnrypOHAQI58FZezfMPqZF1Er6UrKOPat6D+zdZarKMObZ+cQ2KoPh6yuZif+whAi88EI9JRgaCJySWL1S+OAVF0ydGb0O++hlhm/t9SekHVbbA7QnX7azlupci7rWACZuVInqew0jtW2M2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738168215; c=relaxed/relaxed;
	bh=kncPR1x+HrgO/UNoa6XCUy62lvyXubVaayCMa0/G3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe9G8qxOhW0H3RDqZi5vwzhvhofOTG/OIIINl7Fok0s4tTQMea2XuKpm0AEiqOqOkXI+DKm1pbb8kcejmXatcu2nzWAGT07nTQsVMCxTB79bKd24E33EKLUpsB3Yaz7KvFnBJV0qwMbWU1hkDMkhdOPGsHBYIZVZYQVpZrOSdpnKIKjC2ST3F15D1PD6RN4CnwM6npOB8pam+cGs/AmPDzx5X1SGONyNja304+Um6jWEOtN0S+vlqi3RzbvdkePbaIRzVLsZ+m8BvlHAnbOolI6hX/nRaXVOJWhS9qm6s55mhoPF+cSbgpsBRW7XgmvVurQzHi+Nn1sNpXwS/gDZOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dmmfmjtc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dmmfmjtc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yjngn5cqhz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 03:30:13 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-436a39e4891so48168425e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738168210; x=1738773010; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kncPR1x+HrgO/UNoa6XCUy62lvyXubVaayCMa0/G3/c=;
        b=dmmfmjtcRjbOB8iTEKm4C4cx0C7tJdqBzFaFX7knk+RxPTho4fAnRdJ/8gbzW7Ubqr
         z7Xbj+jqLaf3lrdwCmxLVFCiqYoxplNTiLTPLCaFBvxylEDJSf/5miK1XS0yRsWu+iVP
         yctPH9lvyVee2C+pF6+SdxnjV9UrfInIqW4mLbISw6GvZow4r+YFfHSkH29W0FO2asTT
         RTrtj2lxMPZ9nrlC1AepRBDryfPl9yxq9V/Xe0k0ZyzrNzS9qBZ635hz3Wh9puDunZEJ
         pQnuXmUcP4XhhoT2nkMggOJ2PKSEB+a2yTuerT59GBxf0AqJqOiQnJlGWmMjyMuiC8jP
         YGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168210; x=1738773010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kncPR1x+HrgO/UNoa6XCUy62lvyXubVaayCMa0/G3/c=;
        b=lGYzzxvf4dG7w4Pt1s/aFgsRoEMT8ldHBqPOjAxJ7vaaa1Q0KRaHNbo56gzho3EhKQ
         rnFWW5sJ4V/i18YOro14mtUvz2y5jmAnI3CLkzBGtk31K1+tdOQdG2cxUpJ68UI5Z4qh
         pr0kSRvYdBfGQU9Iqia52R0tBS5dSQAh8SvoqSs4bDf/zhrsrdgBjGUdSBMeKOn+Jib9
         COjRpSWs6ujYVubDCo5tV/HcjzlZKeiv3LBN9DRaBYCWMilu+8zQAUyWIH+SUaTUL9uI
         jjcBTWxUEBb33BQqZSBFNyXtEDlSM3IoooXQ5C6v6m7RK2asV6Fdw357GJAMPMKDjyxO
         tsOA==
X-Forwarded-Encrypted: i=1; AJvYcCUN5OvIJYQnMLvZur2MQq5J3lLeSds3+jkMycy2WSsIGLyZGp9jVmc6gT2nAYMuQ3xsIhHNd4fahCqCINg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxtn6pbnze3j2qjGSiUnbFjHD8IAL645MwmxZQdJlJacfOP3lhF
	2JEzL1DAdAKJnQWu6eqLi7BJkHiP/Yl+f56DuQth3jvtoQtwTrwx
X-Gm-Gg: ASbGncvo2+x0oyQRaKhM90fYxrgN4o5I2xGGsTeAkbczD5NCTZGJVGVhk0soKXOL8jn
	2fco5vFFct8XoSWwI7UGNbsfXNqvqwoxbJeuD8OcsaocnA06m0cED6fdNHIwN36xsYLOF58IMEc
	6KqT906niyOw7ZR15LbBT9u37BEEm+148ECuWr4F1NGSnkPW9gnb3DhKVb9NETXrrb/T3DXj8QG
	vNW1cfgNBq8S6mgHgCBTThbzwUxFYHwEr3b8Y1l8vyaGBsdwH1Z8z5B6+Yi4d84I+NtBhOdB1Km
	zSgVvIhnz/8lQePUhbHwfAROZPrp91Lmzt7/kezWuWKRQWnHmGhzuO6Qo0MSpn0PcphY53LsycT
	W8Q==
X-Google-Smtp-Source: AGHT+IFm5Jm3zy7mcGZVwWe1YgDmOIk+BMdUjzsviFL4g+X0VoNE5WMhP+abocamyyaYUsUSJGXvKA==
X-Received: by 2002:a05:6000:2ce:b0:38a:8e2e:9fcc with SMTP id ffacd0b85a97d-38c520b7692mr3030462f8f.45.1738168209834;
        Wed, 29 Jan 2025 08:30:09 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0besm17773109f8f.79.2025.01.29.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:30:08 -0800 (PST)
Date: Wed, 29 Jan 2025 17:30:05 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
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
Message-ID: <54mqpk7elbn3y4o4w5skiwbx6kpkpbsg45l7tfzuphf6rzziej@laywqtj7tfpw>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-14-0d1609a29587@redhat.com>
 <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>
 <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u>
 <2y3lwycrggmktamu3j3gj65uco7quvtu7tlc3724e4mpokhjz2@icedc3kervme>
 <4jn3dfea3eb5yuqobjwvbzfxhwatpvvhtpxbmt6npyrypkyruw@mgtmxignyvt5>
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
	protocol="application/pgp-signature"; boundary="vlfdakvgoj7a5bm2"
Content-Disposition: inline
In-Reply-To: <4jn3dfea3eb5yuqobjwvbzfxhwatpvvhtpxbmt6npyrypkyruw@mgtmxignyvt5>


--vlfdakvgoj7a5bm2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/14] Documentation: Update the todo
MIME-Version: 1.0

On Wed, Jan 29, 2025 at 04:28:49PM +0100, Maxime Ripard wrote:
> On Wed, Jan 29, 2025 at 03:41:32PM +0100, Thierry Reding wrote:
> > On Wed, Jan 29, 2025 at 03:31:50PM +0100, Maxime Ripard wrote:
> > > Hi Thomas,
> > >=20
> > > On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:
> > > > Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:
> > > > > Remove the TODO now that this series addresses
> > > > > the changes needed.
> > > >=20
> > > > While your series is fine, this TODO item is unrelated. It's about =
various
> > > > ancient fbdev drivers that do not reserve their memory regions corr=
ectly. So
> > > > please drop patch 14 form the series.
> > >=20
> > > Is it? Could we rephrase the entry then? I'm the one that suggested
> > > Anusha to work on this, and it's still not clear to me what it means
> > > exactly if it's not what she worked on :)
> >=20
> > The text in the TODO sounds pretty clear to me.
>=20
> The title is "Request memory regions in all drivers", and the first
> sentence is "Go through all drivers and add code to request the memory
> regions that the driver uses". It's definitely ambiguous if only fbdev
> drivers should be considered, even more so in the DRM documentation.
>=20
> > It says that not all drivers request the memory that they are going to
> > use, and suggests to add those missing calls.
>=20
> Right.
>=20
> > But all of the drivers in this series already do that
>=20
> Nope.
>=20
> > and the only change here is to convert them to use some of the newer
> > helpers.
>=20
> For some, yes. For others, it actually adds request_mem_region.

Ah... indeed. Well, on the face of it this looks like just another mass-
conversion to the devm_platform_ioremap_resource() helper, so that's
also confusing.

Maybe the right way to do this would be to split this into two series,
one that actually does what the TODO suggests (and maybe updates the
TODO to make it more obvious that after this only fbdev drivers are
left) and another series that does the helper conversion.

Thierry

--vlfdakvgoj7a5bm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeaV4kACgkQ3SOs138+
s6Fc5g//QZiZGAOOwS/HvsPWCl3EAnXTtEOaH4XXTZswARVZDGZdl3jYwiZim7x3
Odn69X6NAQl5pFytjbexpzii+zH/UQZVz5kndydjXtK/JWz5VeXlKUrxYKMU+GEM
+9dEecjXOqKAtLPF/QyA387/Xp6qIIsQDHM5/akoAifYOd3TbuCl4AqBU/LYuGt6
F86Eaa7n8kChb6BpZ3Km6NfzkhJhTIw9/VZXxp21Y9izQUZuHAVvyt3e2hLr9L9W
S0XFv1mPAYUcBAao+vvEF3kJvrnVXjXDZnjVPpiKuJe4e0l2aDMNW9TEr7are4m5
8JlrAMkbGTKEKzTQlHIgKuFJYcmTyvqs4KBrxmX1bEqm2gsRqnNXl/7yvbY+s/s5
QSM9otV5y60e0IZkmuJjoEklKJ8SmyPgbrnb04ua2KQXrRvnDO+BQSWerziVyz84
6RNfGTuacRhr5C2KlI7MdELGzweRPD6TA8Qa3k71gpCXKg9063+1aRanPLWbpwue
vIBmrFZZcJRMxftEjPMRJj7IcBvIZY12Zij2eu7fWDaeXujcre4Apg3rClGnYxOq
RT0DHxbnFi9msAWdCAFZTUiyzyFZ0Vq/op7JUugsAq/nYKK9lXSyOdVvLd1Ojgm5
CBtQAEdJXMKCwmB5yb7bRv2ag/y/oiQtUsnkgViwm1FTPUFD+gY=
=XiY9
-----END PGP SIGNATURE-----

--vlfdakvgoj7a5bm2--

