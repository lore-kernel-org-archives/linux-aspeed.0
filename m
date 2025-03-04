Return-Path: <linux-aspeed+bounces-920-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E7C021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 08:04:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Ss50bZnz30Vw;
	Tue,  4 Mar 2025 19:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741075496;
	cv=none; b=gghmO8mwqBxlKRNL7qY4g43N8ophRhjutczvZpZ5r7azrJdwiNiHtApVwnylpjkUdkTgGjSXR0ztAchAXoRykDO3N+Ksf3nhWONtQmpg25HpDbumddek2zv4XZgvCjKQUtVFlT0icnWCOA0klfJk4qMXRx7N9dqyyKnVkqzc4iIP9UKGuc23gPiXWQbR4ktq6D6fUKHE2GU6kp5sNmd4qohx8UbhiFw4ykl6AIALEjwhzr3C5M6C5BkehOeskldB2mD60fypQtpeuVlNBWT3ewYrLa4yW+xU9scGWh8an2dLdfWtJ87MLU13BG0UbSL6IjgNSGvzvqEhEy67ptZrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741075496; c=relaxed/relaxed;
	bh=TfhW4dwpgrUF8A3XTnsZo52SIIqBepXuTOwv8Zqk2Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+WI4WCmrRZwtlIKdXD3Voc15EtZNFFLkny1psQA/TJk9iH3/XIYKo50FWdxgs5O8OnLrjVoR7Fnj4/NbTb3vhHYJR8PEF3vQHTjI+sqH6+p9smM1dqb3IogjAoui+ncdFADtt+tu5YfCgRbiwZaq49agYB83/zCBo09PtlxAmTUFochc4PTs3OUE2As1IiehPMQSF1yoRFD/wrC2OghfAhd1dBJC6DGE7MNMt5ckdLVtQd0zKYQgVOYa4g5T/kYAkxq8TL4StNfW6PNpTg2eWW6HGOMQJ579tiUgbI3ECWnG5HJLYC2tNVy7UjOV/0KyecUQjiRX8idqV+NnZ9BdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MTMooLPO; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MTMooLPO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6Ss40Kqfz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 19:04:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 52D5EA45302;
	Tue,  4 Mar 2025 07:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCBEC4CEE5;
	Tue,  4 Mar 2025 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741075492;
	bh=vIjLPcUzgSKENXMFoyq8MSR3rL6XCeonIPvrarBTHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTMooLPO8Bbb2GKqdM1BuZCtLRVMLpPUiZewyqhTUOANTZEdA7zKLpNVpc2b4+pde
	 qLxD1GPfTrr2crKHjmFBRkbsQhLcZE/wIdMSn7xP+K7vJd7ZRJEAH9qDQUxuZcs5kx
	 PTy2NgT0nWNSVjrgvdi0A9uofQ0NxTbml1X58f1jrN3deGiad5mCcW/u5Oh/f1kNxH
	 WkgVk5ns/TvPqpAEbTVtWOTQmUYqzcBtq42vbowT/RyyDgHhCJdC0cKAvbzxnmEotI
	 4k4ylvc9gwaqMoZC+TRzV16b9VRVTbQY41zF+zC/l+py0e6GMwaWsk+QqwNP9zvG1O
	 WP0yWgzyy+/YA==
Date: Tue, 4 Mar 2025 09:04:50 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Joel Stanley <joel@jms.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
	Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Alexey Brodkin <abrodkin@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, linux-aspeed@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND 07/12] drm/sti: move to
 devm_platform_ioremap_resource() usage
Message-ID: <20250304-astute-curvy-ladybug-f9ff15@houat>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
 <20250225-memory-drm-misc-next-v1-7-9d0e8761107a@redhat.com>
 <24958ae8-6153-4798-abeb-e770d66ca8e4@foss.st.com>
 <CAN9Xe3Q8=_Tz51i6gxNM6445p-rhNiK7B5Ljcga8g_Nn676dCQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="3cvx2hh6lak7gb3g"
Content-Disposition: inline
In-Reply-To: <CAN9Xe3Q8=_Tz51i6gxNM6445p-rhNiK7B5Ljcga8g_Nn676dCQ@mail.gmail.com>


--3cvx2hh6lak7gb3g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 07/12] drm/sti: move to
 devm_platform_ioremap_resource() usage
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 12:29:19PM -0500, Anusha Srivatsa wrote:
> On Wed, Feb 26, 2025 at 5:19=E2=80=AFAM Raphael Gallais-Pou <
> raphael.gallais-pou@foss.st.com> wrote:
>=20
> >
> > On 2/25/25 23:20, Anusha Srivatsa wrote:
> > > Replace platform_get_resource/_byname + devm_ioremap
> > > with just devm_platform_ioremap_resource()
> > >
> > > Used Coccinelle to do this change. SmPl patch:
> > >
> > > @rule@
> > > identifier res;
> > > expression ioremap;
> > > identifier pdev;
> > > constant mem;
> > > expression name;
> > > @@
> > > -struct resource *res;
> > > ...
> > > -res =3D platform_get_resource_byname(pdev,mem,name);
> > > <...
> > > -if (!res) {
> > > -...
> > > -}
> > > ...>
> > > -ioremap =3D devm_ioremap(...);
> > > +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
> > >
> > > and
> > > @rule_2@
> > > identifier res;
> > > expression ioremap;
> > > identifier pdev;
> > > @@
> > > -struct resource *res;
> > > ...
> > > -res =3D platform_get_resource(pdev,...);
> > > <...
> > > -if (!res) {
> > > -...
> > > -}
> > > ...>
> > > -ioremap =3D devm_ioremap(...);
> > > +ioremap =3D devm_platform_ioremap_resource(pdev,0);
> > >
> > > v2: Fix compilation error.
> >
> >
> > Hi Anusha,
> >
> >
> > You did not take into account my comment regarding the changelog. :-)
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
commentary
> >
> > While the commit summary do not specify the version, this changelog
> > suggests
> > that the version of your series as been incremented.
> > If this is a v2, then a version descriptor should be applied to the
> > patchset.
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
subject-line
> >
> > Hi  Raphael,
>=20
> That is correct. While this patch is a v2, there is another patch or two =
in
> the same series that is on v4 when it got acked and reviewed. Having
> patches belonging to the same series with different version prefixes seem=
ed
> odd when I sent the series. Hence added what exactly changed in the commit
> log.

This breaks a lot of tools though. If your series changes, you need to
increase the version number, no matter how small or insignificant it
changed compared to the previous one. resend is only meant to be used
when you send the exact same series.

Maxime

--3cvx2hh6lak7gb3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8a0GwAKCRAnX84Zoj2+
dvPAAX0T6CB5j6he9IlacsjKLYZXt0M1IhAKVugJHAC1WHuswlCAJSgEyELEpzS1
ddcuQ7kBf3wXscEAe3lhr3vk0F2KVEj4r8JtBnUwxNM0o1E63auMQV7dNPG5Z5Ku
4gxKbq/wJQ==
=hPVI
-----END PGP SIGNATURE-----

--3cvx2hh6lak7gb3g--

