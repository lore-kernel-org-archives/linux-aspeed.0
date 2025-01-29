Return-Path: <linux-aspeed+bounces-570-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0337AC02190
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 14:41:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjlGb4l2Wz2ytm;
	Thu, 30 Jan 2025 01:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738161703;
	cv=none; b=kz+wQ7n+HHn0bGPM31BrLUJaPHOF3IsRYfwqbJ/wFoJzjVD7DpQJBQICoU5AO92sd8d9zs5HO3vuQTDzNAJXwcBQiA6BQ7MONev0b1YydseASKRwqTgqb+c9EjN1QnKu/rTw8DrnmfiDGZ0LKhHNBJYMji1Qxz5n6W5efZTGzsAT9B2P3voV6qEqCdY+m7k4VCVueRRvOJXmJrmfZWJayG4AGmlSlVeTNH2JDxMAh+5yQhAGeB0ljdOS02AZpX12bG6iMDLzoVLDEh/YmwpyQwX0W94QBqMOsQ1X9k+2Z1c/8pkHWyPAW/QyZ7gOOwxwpX/cpUod7szHCqobmRwsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738161703; c=relaxed/relaxed;
	bh=zSEV+em0N0SfQE1alVhrq6tX6ofwmLyBx4bRZxI20Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf6V1LbW28eRbtTI2aSLimXFJD5B4rr3vNaXyTSvYU/dIxsyXFB+g+ukxdXorz6THe7fPXtFLyQ+NyB1CvwZBCwWwl8yeIezfGxiDHqsBTABwy6MgYfpfKPuyMGhF+zDNy9zBkxkHD0mUVRrp9s96tKU1E0dVhBTJ8q7ZCZsm7XiTi4pAYNEmky/hTMuwVE70XMPnGKquiQK/A4IUINr1L0KHS1MEUIrSASHVv/6jNdRdHgrWnc30XZcIGQ1rZ/J+KeXmgXJaXEsub1cCBND4Vrtq1YvlW3flZVr2JaKVwWZPt1mkkEvZl8Q8D2Uqbi50cpUY3GNzNv9deeEymy9sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMR5b0Wb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMR5b0Wb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=thierry.reding@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjlGZ1JPjz2y92
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 01:41:41 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4361f796586so77347525e9.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161698; x=1738766498; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSEV+em0N0SfQE1alVhrq6tX6ofwmLyBx4bRZxI20Mc=;
        b=FMR5b0Wbp4auYnnsek1w1eYUVokoICvBl7g/pzUS7lEAJ1bt5H3tQ7QI2SQ0qks/pr
         yMPWRxhkcXfCgoHh5WFCkZ8D8tjHkFpzcFXeLXZNC97mbL2DxbRaXrDuse23A7CX3LWy
         DCuqN7gzMPh01SFsB9TIK0a5aY5ibUK+57gyDY6tRqt/Syq/Ha0hhIFbdcsDUsIuQvWL
         bg6UcuPiov5aTrJO70sRjZ2k6yTL3tl/g3q7ZKqLFIQfPbhcN0NClTUSQAobwUevD5l6
         7QI5kA2RZ3hFGDk/Knh/FLVmbaiDjCS8UU3Zc1C7SRH55p29cF5U8dfHyalHWELMcKNl
         VKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161698; x=1738766498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSEV+em0N0SfQE1alVhrq6tX6ofwmLyBx4bRZxI20Mc=;
        b=EZ0OuswDkR6wjxtk+gfZtXukU/I0Gj9vyLbCb0Y+MerFDMdLWeql5JwiwEbhUTqXFH
         c9RtHYx0PuXZk7Ns6u+VOpzW+D7GzUXvyORaV6lXdS4OHESnmIVHq3hK9c8U82Omhfj9
         w2pfrAiNgQgZp5XqOKOdTcdlIEW9oWRZYsWrfcwX0kaUejo4xWUc3qdKzuFgWf4ebtzB
         cBC/KlpRm5Bgn6Xigtl3OUy8HJCMj6dzaPyecBj3m1K8KyPjEsMhOekZt0v1yJ7Fj6Iw
         wOrpM/Hujtxy4zblDrz3p+6CYjm72Q2SRrK+hF6SXIX0GX7ZPQg7o8KMkiAOU+Gnc5aD
         2U8g==
X-Forwarded-Encrypted: i=1; AJvYcCX8VPM5Xbk2gv0EKlN0V2NQ7//Adv7+gdqIT6zxB+FjLaVt21s5a9+1Lp0SxG/rUGNoR5ypKgkxTJQ52Cc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbP5FjgjfqyhQjE5Ny53eZeFqwkmNqjkxFdlfMd/C9d3FY67pm
	jkl0pbNsc8dU78Sy5pkWHx3N5uykWXYmLHHcwqtTHTxkFztiLehc
X-Gm-Gg: ASbGncttPe4eSDB4TeyavlyVcsBBPDWtwzTbHcW8iEy6PA6RBiFBn4gxOgTKBqqSSFN
	TNGCBxLDpjwixZsrYFIfo8UosGAZcLwmbcRUybsDffL+fV4ut2LMAnVAOH6b1PLK+p6PyoTI3YB
	mvlbjbdPtAD7T7z7bsunB9/r9r72WNGBw6HDZxxoF2PdD3w2CRs/pgA5iDzgJno1BARXICbYj7d
	YO4QAy97skVl3xICgVF0H1bNId7WLllaEGWv5qPsUUiszSczTC3qTJF/EUd/QKsqIeeRBlEHAAl
	DCK0HX4HM1NQz2eMKIcihF8wClGrDl7pw4WI0IkKbA1YrAC5YOQ5acAauQwuyBphF6a1w6XDipB
	/5g==
X-Google-Smtp-Source: AGHT+IGdWBqWeiv+jbIoBfzm7k0/2DrarU7EXB90OvgtRbMeVkAoe8ODcFAhL4eNP6mW3P0r12bwJA==
X-Received: by 2002:a05:600c:4e07:b0:436:e86e:e4ab with SMTP id 5b1f17b1804b1-438dc4353e7mr35398335e9.30.1738161698102;
        Wed, 29 Jan 2025 06:41:38 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2b1d9sm24718285e9.21.2025.01.29.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:41:36 -0800 (PST)
Date: Wed, 29 Jan 2025 15:41:32 +0100
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
Message-ID: <2y3lwycrggmktamu3j3gj65uco7quvtu7tlc3724e4mpokhjz2@icedc3kervme>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-14-0d1609a29587@redhat.com>
 <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>
 <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u>
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
	protocol="application/pgp-signature"; boundary="cigenp6alv7pkbet"
Content-Disposition: inline
In-Reply-To: <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u>


--cigenp6alv7pkbet
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/14] Documentation: Update the todo
MIME-Version: 1.0

On Wed, Jan 29, 2025 at 03:31:50PM +0100, Maxime Ripard wrote:
> Hi Thomas,
>=20
> On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:
> > Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:
> > > Remove the TODO now that this series addresses
> > > the changes needed.
> >=20
> > While your series is fine, this TODO item is unrelated. It's about vari=
ous
> > ancient fbdev drivers that do not reserve their memory regions correctl=
y. So
> > please drop patch 14 form the series.
>=20
> Is it? Could we rephrase the entry then? I'm the one that suggested
> Anusha to work on this, and it's still not clear to me what it means
> exactly if it's not what she worked on :)

The text in the TODO sounds pretty clear to me. It says that not all
drivers request the memory that they are going to use, and suggests to
add those missing calls. But all of the drivers in this series already
do that and the only change here is to convert them to use some of the
newer helpers.

Thierry

--cigenp6alv7pkbet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeaPhkACgkQ3SOs138+
s6H45hAAkHi6OubObNKNwO2CYc2mT8gjjY3iZP3UvxqouoU05ylZ0uUIxHOz8K8T
vXb+tkMFtsqIZZTJZGti+67m/YYOCtZsvXO79IMZy7WUab/bKWX7x2vy3WjN5lyG
yqlo8kp85y69za3sJHjRrUvr4acQSDyDejrwBdWN2xMCnDgzG5lzXkXhibhyOaMd
p0wyLE4EkS0pdxCg2FGGjiFOAnWmHd3+DPW3wRSMVsiXpVgWxEAQ6aGmNMtl0Y7F
KM7UDu0umziZxMyR2/4SFn7Q772BDa1dwInJhSBF3ugkGdQ3mSPpBeDPjf+cI2Mj
69Z5AA1KQOhvGcKM9WOW/kXV9/CeXD1dv6Z5c4ho4gnOWA9Sjj0PUVRIJy7oDtm5
4SdccVE1EPL/+IzByDQFxbG6/UFTJroG0+N9mpx9p2tZ0fJDGiQepxQ6XqLKlbZg
olV21Xytohgotp2SlQ8tk2PIln70QKzEanmMVBl2WEkxAByKbu/XK+4A9+3/Hy9l
+RdZ/r1pHfzlW7nzFGKpNeNaH3uMkupcb4PsceavHYDmabcKJtyK4J2/xp218nwA
EopzxkwqOiYMAHl1/tBeNlt4bEIhph/3ldgBr6fgUWSbddKQxr6YjU/Lyvp5KOFH
qkb1aCLDg6nKqceZe1QQeEDsVyZJA2a3ACyQ5rpyrniazDRDlU8=
=VcN2
-----END PGP SIGNATURE-----

--cigenp6alv7pkbet--

